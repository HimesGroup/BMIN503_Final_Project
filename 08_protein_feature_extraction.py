import sqlite3
import pandas as pd
import numpy as np
from tqdm import tqdm
from Bio.SeqUtils.ProtParam import ProteinAnalysis
import math
from multiprocessing import Pool

def getProteinFeatureArrays(seq_series):
    all_vals = []
    for seq in seq_series:
        seq_vals = proteinFeatureArrayizer(seq)
        all_vals.append(seq_vals)
    return all_vals

def proteinFeatureArrayizer(seq):
    amino_acids = ['R','H','K','D','E','S','T','N','Q','C','U','G',
                   'P','A','V','I','L','M','F','Y','W']
    
    object_ = ProteinAnalysis(seq)
    object_no_u = ProteinAnalysis(seq.replace("U","C"))
    
    count_dict = object_.count_amino_acids()
    perc_dict = object_.get_amino_acids_percent()
    
    percs = []
    counts = []
    
    for aa in amino_acids:
        aa_perc = perc_dict.get(aa, 0)
        aa_count = count_dict.get(aa, 0)
        if aa_perc > 100:
            print("WHAT", aa_perc)
        percs.append(aa_perc)
        counts.append(aa_count)
        
    feat_array = percs[:]
    feat_array.extend(counts)
    # Mol Weight
    mol_weight = object_.molecular_weight()
    # Aromaticiy
    arom = object_.aromaticity()
    # Instability index
    try:
        insta_in = object_.instability_index()
    except:
        insta_in = object_no_u.instability_index()
    # Flexibility
    try:
        flex = object_.flexibility()
    except:
        flex = object_no_u.flexibility()
    # Gravy
    try:
        gravy_ = object_.gravy()
    except:
        gravy_ = object_no_u.gravy()
    # Isoelectric point
    try:
        iso_el = object_.isoelectric_point()
    except:
        iso_el = object_no_u.isoelectric_point()
    # Helix percentage
    sec_stru = object_.secondary_structure_fraction()
    hel_perc = sec_stru[0]
    # Turn Percentage
    turn_perc = sec_stru[1]
    # Sheet Percentage
    sheet_perc = sec_stru[2]
    # Reduced Cys Num
    mol_extinc_coeff = object_.molar_extinction_coefficient()
    red_cys = mol_extinc_coeff[0]
    # Disulfide Bridge Num
    oxi_cys = mol_extinc_coeff[1]
    feat_array.extend([
        mol_weight, arom, insta_in, flex, gravy_, iso_el, hel_perc, 
         sheet_perc, turn_perc, red_cys, oxi_cys]
    )
    return feat_array

def backfill(size, flex_array):
    flex_arr_size = len(flex_array)
    if size % flex_arr_size == 0 and flex_arr_size!=1:
        sizer = size / flex_arr_size
        return list(np.concatenate([list(np.repeat(x, sizer)) for x in flex_array]))
    elif flex_arr_size == 1:
        return list(np.repeat(flex_array[0], size))
    # If the size of the array fits into the bigger num
    else:
        counter_arr = list(np.repeat(0, flex_arr_size))
        counter = 0
        for i in range(size):
            if counter >= flex_arr_size:
                counter = 0
            counter_arr[counter] += 1
            counter += 1
        return_arr = []
        for i, repeat in enumerate(counter_arr):
            return_arr.extend(list(np.repeat(flex_array[i], repeat)))
        return return_arr
    
def chunker(arr, n):
    for i in range(0, len(arr), n):
        n_arr = arr[i:i + n]
        yield [n_arr[0],n_arr[-1]]
    
def getFlexVals(size, flex_array):
    """Given size, return N-mean, median and range.
    If the array is less than the size, backfill the array."""
    flex_arr_size = len(flex_array)
    if flex_arr_size==0:
        return list(np.full(size*3, 0))
    if flex_arr_size < size:
        flex_arr = backfill(size, flex_array)
        #print(flex_arr_size,flex_arr)
    # Get the chunk size
    chunk_size = math.ceil(flex_arr_size / size)
    # Get the chunk indexes
    chunks_arr = list(chunker(list(range(flex_arr_size)), chunk_size))
    # Get the chunked values
    chunked_flex = [flex_array[x[0]:x[1]+1] for x in chunks_arr]

    return_flex = []
    for chunk_ in chunked_flex:
        return_flex.extend(
            [np.mean(chunk_), np.median(chunk_), np.max(chunk_)-np.min(chunk_)]
        )
    
    return return_flex

def makeFlexCols(n):
    """Flexibility of the protein is interesting to model. The metric
    is calculated using windows of 9 amino acids over the whole protein.
    Similar to n-grams.
    
    For each n-flexibility entrants, I will calculate mean, median and
    range.
    
    This function produces the column names for this."""
    col_list = []
    
    for i in range(1,n+1):
        col_list.extend([
            'prot_flex_mean_'+str(i), 'prot_flex_median_'+str(i), 'prot_flex_range_'+str(i)
        ])
    return col_list

if __name__ == "__main__":
    print("Getting the data...")
    conn = sqlite3.connect("training_final.db")
    proteins_to_work_on = pd.read_sql('SELECT DISTINCT protein from protein_ngram',con=conn)
    conn.close()
    
    conn = sqlite3.connect("human_protein.db")
    sequences = pd.read_sql('SELECT DISTINCT protein, sequence from protein',con=conn)
    conn.close()
    
    proteins_merge = proteins_to_work_on.merge(sequences, on='protein',how='outer')
    
    # Counts, then percs
    amino_acids = ['R','H','K','D','E','S','T','N','Q','C','U','G',
                   'P','A','V','I','L','M','F','Y','W']
    count_cols = ["prot_"+x+'_num' for x in amino_acids]
    perc_cols = ["prot_"+x+'_perc' for x in amino_acids]

    prot_feat_cols = perc_cols + count_cols + [
        "prot_mol_weight","prot_arom","prot_insta","prot_flex","prot_gravy","prot_isoel",
        "prot_helix_perc","prot_turn_perc","prot_sheet_perc",
        "prot_reduced_cys_num","prot_disulfide_num"]

    # chunk the protein analysis bit
    chunk_size = 1000
    chunk_list = list(range(0, proteins_merge.shape[0],chunk_size))
    chunk_pairs = [[chunk_list[i-1], chunk_list[i]] for i, x in enumerate(chunk_list) if i != 0]
    chunk_pairs.append([chunk_pairs[-1][-1], None])
    print("Splitting up the dataframe...")
    
    chunks = []
    for pair in chunk_pairs:
        start = pair[0]
        end = pair[1]
    
        if end != None:
            ngram_slice = proteins_merge.iloc[start:end, :]
        else:
            ngram_slice = proteins_merge.iloc[start:, :]
        chunks.append(ngram_slice.sequence)
    
    feat_array_all = []
    
    print("Processing sequence chunks...")
    p = Pool(processes = 7)
    for result in tqdm(p.map(getProteinFeatureArrays, chunks), total=len(chunk_pairs)):
        feat_array_all.extend(result)
    
    p.close()
    p.join()
    
    feat_df = pd.DataFrame(feat_array_all, columns=prot_feat_cols)
    
    n = 10
    flex_cols = makeFlexCols(n)

    flex_processed = feat_df.iloc[:,:].prot_flex.apply(lambda x: getFlexVals(n, x)).values.tolist()
    
    flex_processed_df = pd.DataFrame(flex_processed,columns=flex_cols)

    sequence_feat_df = pd.concat([proteins_merge.drop('sequence',axis=1),feat_df],axis=1)
    sequence_feat_flex_df = pd.concat([sequence_feat_df.drop('prot_flex',axis=1), flex_processed_df],axis=1)
    sequence_feat_flex_df.set_index('protein',inplace=True)
    
    conn = sqlite3.connect("training_final.db")
    c = conn.cursor()
    c.execute("DROP TABLE IF EXISTS protein_seq_features")
    sequence_feat_flex_df.to_sql('protein_seq_features',con=conn, if_exists='replace')
    conn.close()
    
    print("Done!")