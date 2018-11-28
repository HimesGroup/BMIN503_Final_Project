import sqlite3
import pandas as pd
from tqdm import tqdm
from functools import reduce
import time
import sys

def train_chunker_mult_query(protein_chunk):
    conn = sqlite3.connect("training_final.db")
    
    prot_list = "("+", ".join(["'"+x+"'" for x in protein_chunk.protein.values.tolist()])+")"
    
    ngram_chunk = pd.read_sql(
        "SELECT protein, gram_num, gram_1, gram_2, gram_3, gram_4, gram_5, \
            amyloid_1, amyloid_2, amyloid_3, amyloid_4, amyloid_5 \
            FROM protein_ngram WHERE protein IN "+prot_list,
        con=conn
    )
    
    ngram_feat_chunk = pd.read_sql(
        "SELECT * FROM protein_ngram_features WHERE protein IN "+prot_list, 
        con=conn
    )
    
    ngram_sub_feat_chunk = pd.read_sql(
        "SELECT * FROM protein_subngram_features WHERE protein IN "+prot_list, 
        con=conn
    )
    
    frames = [ngram_chunk, ngram_feat_chunk, ngram_sub_feat_chunk]
    
    train_chunk = reduce(
        lambda left,right: pd.merge(
            left,right,on=['protein','gram_num'],
            how='left'
        ),
        frames
    )
    
    protein_chunk = pd.read_sql(
        "SELECT * FROM protein_seq_features WHERE protein IN "+prot_list,
        con=conn
    )
    
    conn.close()
    
    train_chunk = train_chunk.merge(protein_chunk, on=["protein"], how="left")
    
    return train_chunk

if __name__ == "__main__":
    chunk_size = int(sys.argv[1])
    print("Chunk size set to: ",str(chunk_size))
    
    print("Getting proteins...")
    conn = sqlite3.connect("training_final.db")

    proteins_df = pd.read_sql("SELECT DISTINCT protein FROM protein_ngram", con=conn)

    conn.close()
    
    chunk_list = list(range(0, proteins_df.shape[0],chunk_size))
    chunk_pairs = [[chunk_list[i-1], chunk_list[i]] for i, x in enumerate(chunk_list) if i != 0]
    chunk_pairs.append([chunk_pairs[-1][-1], None])
    print(chunk_pairs[:5],"...",chunk_pairs[-5:])

    process_chunks = []
    
    print("Chunking protein list...")
    for chunk in chunk_pairs:
        start = chunk[0]
        end = chunk[1]

        if end != None:
            protein_chunk = proteins_df.iloc[start:end, :]
        else:
            protein_chunk = proteins_df.iloc[start:, :]

        process_chunks.append(protein_chunk)
        
    print("Dropping train table...")
    conn = sqlite3.connect("training_final.db")
    c = conn.cursor()
    c.execute("DROP TABLE IF EXISTS train")
    conn.close()
    
    print("Building new train table...")
    for chunk in tqdm(process_chunks):
        train_chunk = train_chunker_mult_query(chunk)
        conn = sqlite3.connect("training_final.db")
        train_chunk.to_sql("train", con=conn, index=False, if_exists="append")
        conn.close()
        
    print("Done!")