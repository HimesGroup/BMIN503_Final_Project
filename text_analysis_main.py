# This file is for the Python NLP analysis of the text documents
# within R terminal, run as:
# system("python3 nlp_workflow/text_analysis_main.py"

# import relevant modules
import nltk, os, re, sys
#import numpy as np
import pandas as pd
from nltk.corpus.reader.plaintext import PlaintextCorpusReader
from nltk.corpus import stopwords
#from nltk.collocations import *
from nltk import ngrams
from collections import Counter
import string
import numpy
from sklearn.feature_extraction.text import CountVectorizer
from six.moves import cPickle
from joblib import Parallel, delayed

# make sure we are working:
print ('hello! we are in:', os.getcwd())
print (sys.version)

# -------------------- word search
# this function takes a word and a corpus
# and a returns a list of 0/1 for each
# element in the corpus if it contains the word
# is this pass by reference? dunno.
def find_term_incorp(term, corp):
  # if corp is a true corpus
  term_yn = []
  findex = corp.fileids()
  for i in findex:
    result = re.findall('\\b'+term+'\\b', corp.raw(i))
    term_yn.append(1 if len(result) > 0 else 0)
  return term_yn

def find_term_intext(term, text, verbose = False):
    # if corp is a nltk TEXT object
  term_yn = []
  jobs = len(text)
  inc = round(jobs / 50)
  for j,s in enumerate(text):
    result = re.search('\\b'+term+'\\b', s)
    term_yn.append(1 if result else 0)
    if (verbose and j%inc==0): print('Progress:',j,'/',jobs)
  return term_yn

def ngrams_freq_intext(n, text, count = -1):
  ngrams = []
  for t in text:
    temp_grams = nltk.ngrams(t.split(), n)
    ngrams = ngrams + [g for g in temp_grams]
  return(Counter(ngrams).most_common()) if count == -1 else return(Counter(ngrams).most_common(count))
  
# prepocessing stuff here
# from example: https://gist.github.com/ameyavilankar/10347201
def preprocess(t):
  rem_chars = "[!\"#$%&\'()*+,:;./<=>?@-[\\]^_`{|}~0123456789]"
#  rem_chars = "[!\"#$%&\'()*+,:;<=>?@[\\]^_`{|}~0123456789]"
#  rep_chars = "[-./]"
#  t_strip_lower = re.sub(rep_chars, " ", re.sub(rem_chars, "", t.lower()))
  t_strip_lower = re.sub(rem_chars, "", t.lower())
  t_strip_lower_filt = [w for w in t_strip_lower.split() if not w in stopwords.words('english')]
  return " ".join(t_strip_lower_filt)

# load the data
corpusdir = 'corpus_txt/' # Directory of corpus.
mycorp_raw = PlaintextCorpusReader(corpusdir, '.*')
file_index = mycorp_raw.fileids()

# look at a few words from the first couple of admits
for i in file_index[:10]:
  print(mycorp_raw.words(i))
  
# preprocess the text (slow)
#mycorp_proc = nltk.Text([preprocess(mycorp_raw.raw(f)) for f in file_index])
mycorp_proc = Parallel(n_jobs=6,verbose=True)(delayed(preprocess)(mycorp_raw.raw(f)) for f in file_index)
# doesn't work: NB consider turning this into a nltk.TextCollection??? nice for concordance...


# save to file because this takes a long time
f = open('mycorp_proc-obj.save', 'wb')
cPickle.dump(mycorp_proc, f, protocol=cPickle.HIGHEST_PROTOCOL)
f.close()
# can reload later with:
# f = open('mycorp_proc-obj.save', 'rb')
# mycorp_proc = cPickle.load(f)
# f.close()
  
# choose our list of terms of interest
# when we were doing LOLST:
#some_terms = ['comfort care', 'wishes', 'goals of care', 'family', "wouldn't want", 
#                "doesn't want", 'poor prognosis', 'high risk']
# but now instead we're doing long hospital stay or death
some_terms = ['comfort care', 'wishes', 'goals of care', 'family', "wouldn't want", 
                "doesn't want", 'poor prognosis', 'high risk', 'code status',
                'family meeting', 'hospice', 'palliative', 'palliation', 'palliative care',
                'pall care', 'death', 'die', 'survival', 'mortal', 'mortality', 'comfortable']

# now make a data frame so we can export these findings
df_results = pd.DataFrame.from_items([('HADM_ID', [i[:-4] for i in file_index])])
# now loop through terms and build results
for tt in some_terms:
  df_results[tt] = find_term_intext(preprocess(tt), mycorp_proc)
# save results to file so we can analyze back in R
df_results.to_csv('text_results_keyterms.csv', index = False)

# see great examples here:
# http://scikit-learn.org/stable/modules/feature_extraction.html
# and possibly for future LDA:
# http://scikit-learn.org/stable/auto_examples/applications/topics_extraction_with_nmf_lda.html#sphx-glr-auto-examples-applications-topics-extraction-with-nmf-lda-py

# get frequencies of unigrams and bigrams using sklean -- much faster!!!
vectorizer = CountVectorizer(min_df=0.05)
X = vectorizer.fit_transform(mycorp_proc)
# save to file
#numpy.savetxt('n1_dtm.csv',X.A,delimiter=',')
n1_df = pd.DataFrame(data = X.A,
              columns = vectorizer.get_feature_names())
n1_df['HADM_ID'] = [i[:-4] for i in file_index]
n1_df.to_csv('n1_dtm.csv', index = False)

# now bigrams
vectorizer_n2 = CountVectorizer(min_df = 0.05, ngram_range=(2, 2))
X2 = vectorizer_n2.fit_transform(mycorp_proc)
n2_df = pd.DataFrame(data = X2.A,
              columns = vectorizer_n2.get_feature_names())
n2_df['HADM_ID'] = [i[:-4] for i in file_index]
n2_df.to_csv('n2_dtm.csv', index = False)

# and trigrams
vectorizer_n3 = CountVectorizer(min_df = 0.05, ngram_range=(3, 3))
X3 = vectorizer_n3.fit_transform(mycorp_proc)
n3_df = pd.DataFrame(data = X3.A,
              columns = vectorizer_n3.get_feature_names())
n3_df['HADM_ID'] = [i[:-4] for i in file_index]
n3_df.to_csv('n3_dtm.csv', index = False)

#unigrams_proc = Counter(" ".join(mycorp_proc).split()).most_common()
#bigrams_proc = ngrams_freq_intext(2,mycorp_proc)
#trigrams_proc = ngrams_freq_intext(3,mycorp_proc)

# now get dtm
#n1_dtm = pd.DataFrame.from_items([('HADM_ID', [i[:-4] for i in file_index])])
#n2_dtm = pd.DataFrame.from_items([('HADM_ID', [i[:-4] for i in file_index])])
#n3_dtm = pd.DataFrame.from_items([('HADM_ID', [i[:-4] for i in file_index])])

# This may take 2 hours...
#for w in unigrams_proc:
# for i, w in enumerate(pruned_words[:2000]):
  # print (i, '::', w[0]) # progress checking...
#  n1_dtm[w[0]] = find_term_intext(w[0], mycorp_proc)

#for w in bigrams_proc:
#  bg = ' '.join(w[0])
#  n2_dtm[bg] = find_term_intext(bg, mycorp_proc)

#for w in trigrams_proc:
#  tg = ' '.join(w[0])
#  n3_dtm[bg] = find_term_intext(tg, mycorp_proc)

# now filter by document-level prevalence in some way... top 2000, etc.

# indicate end
print('script completed!')
