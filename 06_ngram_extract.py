import sqlite3
import nltk
import pandas as pd
import os
from tqdm import tqdm
from multiprocessing import Pool

def nGrammer(protein, seq, n):
    return [[protein, i+1]+list(x) for i, x in enumerate(nltk.ngrams(seq, n))]

def dfNGrammer(protein_df, num_grams):
    gram_cols = ["protein","gram_num"]+["gram_"+str(i+1) for i in range(num_grams)]
    seq_grams = []
    seq_grams.extend([
        val for sublist in protein_df.apply(
            lambda row: nGrammer(
                row['protein'], row['sequence'], num_grams),
            axis=1
        ) for val in sublist]
    )
    gram_df = pd.DataFrame(seq_grams, columns=gram_cols)
    return gram_df

def amyloidSeqMapper(seq_dict, protein, gram_num, grams, accession, amyloid_ref):
    n = len(grams)
    acc_ids = accession.split(',')
    id_matches = [x for x in acc_ids if x in seq_dict.keys()]
    # If none of the accession keys are in my amyloid annotation dict
    if len(id_matches)==0:
        result = [0]*n
    else:
        # Get the values from the dict to check against
        tag_id = id_matches[0]
        prot_vals = seq_dict[tag_id]
        range_start = gram_num
        range_end = gram_num+n
        gram_range = list(range(range_start,range_end))
        result = [0 if x not in prot_vals else 1 for x in gram_range]
    return pd.Series(result)

def amyMapper(args):
    chunk = args[0]
    amy_df = args[1]
    n = args[2]
    seq_dict = args[3]
    amyloid_cols = args[4]
    
    chunk.loc[:,amyloid_cols] = chunk.apply(
            lambda row: amyloidSeqMapper(
                seq_dict,
                row['protein'], 
                row['gram_num'],
                row[['gram_'+str(i) for i in range(1,n+1)]].values.tolist(),
                row['accession'], 
                amy_df
            ), axis=1).values.tolist()
    
    return chunk

if __name__ == "__main__":
    print("Getting data...")
    conn = sqlite3.connect("human_protein.db")
    prot_df = pd.read_sql('select protein, accession, sequence from protein',con=conn)
    amy_df = pd.read_sql('select * from amyloid_prion_id_mapped', con=conn)
    ignore_prots = pd.read_sql('select protein, uniprot_id from amy_ignore', con=conn)
    conn.close()
    print("Done!")
    
    prot_df = prot_df[
        prot_df['protein'].isin(ignore_prots['protein'].values.tolist())==False
    ]

    amy_df = amy_df[
        amy_df['uniprot_id'].isin(ignore_prots['uniprot_id'].values.tolist())==False
    ]
    
    n = 5
    
    print("N-gramming...")
    ngram_df = dfNGrammer(prot_df,n).merge(
        prot_df[['protein','accession']],on='protein',how='left'
    )
    
    print("Done!")
    seq_dict = dict()

    for prot_id in tqdm(amy_df.uniprot_id.unique()):
        vals = amy_df[amy_df['uniprot_id']==prot_id][['begin','end']].values.tolist()
        range_vals = []
        for val in vals:
            range_vals.extend(range(val[0], val[1]+1))
        seq_dict[prot_id] = range_vals
        
    chunk = 10000
    chunk_list = list(range(0, ngram_df.shape[0],chunk))
    chunk_pairs = [[chunk_list[i-1], chunk_list[i]] for i, x in enumerate(chunk_list) if i != 0]
    # Add last little chunk
    chunk_pairs.append([chunk_pairs[-1][-1], None])
    
    amyloid_cols = ['amyloid_'+str(a) for a in range(1, n+1)]
    for a_col in amyloid_cols:
        ngram_df.loc[:,a_col] = 0
        
    chunks = []
    
    print("Chunking...")
    for i in tqdm(chunk_pairs):
        start = i[0]
        end = i[1]
        
        if end != None:
            ngram_slice = ngram_df.iloc[start:end, :]
        else:
            ngram_slice = ngram_df.iloc[start:, :]

        chunks.append([ngram_slice, amy_df, n, seq_dict, amyloid_cols])

    p = Pool(processes = 7)
    conn = sqlite3.connect("protein_training.db")
    
    c = conn.cursor()
    c.execute("DROP TABLE IF EXISTS protein_ngram")
    
    print("Processing chunks...")
    for result in tqdm(p.imap_unordered(amyMapper, chunks), total=len(chunks)):
        result.to_sql("protein_ngram", index=False, con=conn, if_exists="append")
    
    conn.close() 
    p.close()
    p.join()
    print("Processing done!")