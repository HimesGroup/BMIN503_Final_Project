import sqlite3
from multiprocessing import Pool
import pandas as pd
from tqdm import tqdm
from Bio.SeqUtils.ProtParam import ProteinAnalysis
import time
import sys

ngram_feat_cols = [
    "gram_frac","gram_mol_weight","gram_arom","gram_insta",
    "gram_gravy","gram_isoel","gram_helix_perc","gram_turn_perc","gram_sheet_perc",
    "gram_reduced_cys_num","gram_disulfide_num"]

def ngramFeatureArrayizer(protein, gram_num, prot_total_grams, seq):
    """Analyze the ngram sequence as a whole"""
    feat_array = []
    gram_frac = round(gram_num / prot_total_grams, 3)
    object_ = ProteinAnalysis(seq)
    object_no_u = ProteinAnalysis(seq.replace("U","C"))
    # Mol Weight
    mol_weight = object_.molecular_weight()
    # Aromaticiy
    arom = object_.aromaticity()
    # Instability index
    try:
        insta_in = object_.instability_index()
    except:
        insta_in = object_no_u.instability_index()
    # No flexibility because the size has to be 9 amino acids at the very least
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
        gram_frac, mol_weight, arom, insta_in, gravy_, iso_el, hel_perc, 
        sheet_perc, turn_perc, red_cys, oxi_cys]
    )
    return feat_array

def write_to_dbase(ngram_slice):        
    ngram_slice_vals = ngram_slice.apply(
        lambda row: ngramFeatureArrayizer(
            row['protein'],
            row['gram_num'],
            row['gram_total'],
            row['seq'], 
        ), axis=1).values.tolist()
    
    ngram_slice_df = pd.DataFrame(ngram_slice_vals, index=ngram_slice.index, columns=ngram_feat_cols)
    
    ngram_feat_full_df = pd.concat(
        [ngram_slice[["protein","gram_num"]], ngram_slice_df],
        axis=1
    )
    
    return ngram_feat_full_df

def get_gram_num(protein):
    return protein_gram_num[protein_gram_num['protein']==protein]['gram_total'].values[0]

if __name__ == "__main__":  
    chunk_size = int(sys.argv[1])
    print("Chunk size selected as: ", str(chunk_size))
    
    print("Loading data...")
    conn = sqlite3.connect("protein_training.db")
    ngrams_df = pd.read_sql('SELECT * from protein_ngram',con=conn)
    protein_gram_num = pd.read_sql("SELECT DISTINCT protein, COUNT(gram_num) as gram_total FROM protein_ngram GROUP BY protein", con=conn)
    conn.close()
    print("Data loaded!")
    
    ngrams_df.drop("accession",axis=1,inplace=True)
    print("Building 'seq' feature...")
    ngrams_df.loc[:,'seq'] = ngrams_df['gram_1'] + ngrams_df['gram_2'] + ngrams_df['gram_3'] + ngrams_df['gram_4'] + ngrams_df['gram_5']
    print("Mapping 'gram_total'...")
    ngrams_df = ngrams_df.merge(protein_gram_num, on=["protein"], how="left")
    
    # Lets chunk this
    chunk_list = list(range(0, ngrams_df.shape[0],chunk_size))
    chunk_pairs = [[chunk_list[i-1], chunk_list[i]] for i, x in enumerate(chunk_list) if i != 0]
    chunk_pairs.append([chunk_pairs[-1][-1], None])
    print("Splitting up the dataframe...")
    chunks = []
    for pair in tqdm(chunk_pairs, total=len(chunk_pairs)):
        start = pair[0]
        end = pair[1]
    
        if end != None:
            ngram_slice = ngrams_df.iloc[start:end, :]
        else:
            ngram_slice = ngrams_df.iloc[start:, :]
        chunks.append(ngram_slice)
        
    print("Processing chunks...")
    p = Pool(processes = 7)
    for result in tqdm(p.imap_unordered(write_to_dbase, chunks), total=len(chunk_pairs)):
        conn = sqlite3.connect("protein_training.db")
        result.to_sql("protein_ngram_features", index=False, con=conn, if_exists="append")
        conn.close()
        
    p.close()
    p.join()
    print("Processing done!")