import sqlite3
from multiprocessing import Pool
import pandas as pd
from tqdm import tqdm
from Bio.SeqUtils.ProtParam import ProteinAnalysis
import time
import sys

amino_acid_dict = {
    "A":{
        "side_chain_class":"aliphatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":1.8,
        "molecular_weight":89.094
    },
    "R":{
        "side_chain_class":"basic",
        "side_chain_polarity":"basic polar",
        "side_chain_charge":"positive",
        "hydropathy_index":-4.5,
        "molecular_weight":174.203
    },
    "N":{
        "side_chain_class":"amide",
        "side_chain_polarity":"polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-3.5,
        "molecular_weight":132.119
    },
    "D":{
        "side_chain_class":"acid",
        "side_chain_polarity":"acidic polar",
        "side_chain_charge":"negative",
        "hydropathy_index":-3.5,
        "molecular_weight":133.104
    },
    "C":{
        "side_chain_class":"sulfur-containing",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":2.5,
        "molecular_weight":121.154
    },
    "E":{
        "side_chain_class":"acid",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-3.5,
        "molecular_weight":147.131
    },
    "Q":{
        "side_chain_class":"amide",
        "side_chain_polarity":"polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-3.5,
        "molecular_weight":146.146
    },
    "G":{
        "side_chain_class":"aliphatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-0.4,
        "molecular_weight":75.067
    },
    "H":{
        "side_chain_class":"basic aromatic",
        "side_chain_polarity":"basic polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-3.2,
        "molecular_weight":155.156
    },
    "I":{
        "side_chain_class":"aliphatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":4.5,
        "molecular_weight":131.175
    },
    "L":{
        "side_chain_class":"aliphatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":3.8,
        "molecular_weight":131.175
    },
    "K":{
        "side_chain_class":"basic",
        "side_chain_polarity":"basic polar",
        "side_chain_charge":"positive",
        "hydropathy_index":-3.9,
        "molecular_weight":146.189
    },
    "M":{
        "side_chain_class":"sulfur-containing",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":1.9,
        "molecular_weight":149.208
    },
    "F":{
        "side_chain_class":"aromatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":2.8,
        "molecular_weight":165.192
    },
    "P":{
        "side_chain_class":"cyclic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-1.6,
        "molecular_weight":115.132
    },
    "S":{
        "side_chain_class":"hydroxyl-containing",
        "side_chain_polarity":"polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-0.8,
        "molecular_weight":105.093
    },
    "T":{
        "side_chain_class":"hydroxyl-containing",
        "side_chain_polarity":"polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-0.7,
        "molecular_weight":119.119
    },
    "W":{
        "side_chain_class":"aromatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-0.9,
        "molecular_weight":204.228
    },
    "Y":{
        "side_chain_class":"aromatic",
        "side_chain_polarity":"polar",
        "side_chain_charge":"neutral",
        "hydropathy_index":-1.3,
        "molecular_weight":181.191
    },
    "V":{
        "side_chain_class":"aliphatic",
        "side_chain_polarity":"nonpolar",
        "side_chain_charge":"neutral",
        "hydropathy_index":4.2,
        "molecular_weight":117.148
    }
}

gram_val_cols = []

for i in range(1,6):
    base = "gram_"+str(i)+"_"
    gram_val_cols.extend(
        [
            base+"side_class",
            base+"side_polarity",
            base+"side_charge",
            base+"hydropathy_index",
            base+"mol_weight"
        ]
    )
    
def ngramMapper(grams):
    return_arr = []
    for gram in grams:
        if gram == "U":
            gram = "C"
        gram_vals = list(amino_acid_dict[gram].values())
        return_arr.extend(gram_vals)
    return return_arr

def write_to_dbase(ngram_slice):        
    chunk_vals = ngram_slice.apply(
        lambda row: ngramMapper(
            row[['gram_1','gram_2','gram_3','gram_4','gram_5']].values
        ),
        axis=1
    ).values.tolist()
    
    chunk_df = pd.DataFrame(chunk_vals, columns=gram_val_cols, index=ngram_slice.index)
        
    write_df = pd.concat(
        [ngram_slice[['protein','gram_num']], chunk_df],
        axis=1,
        sort=False
    )
    
    return write_df

if __name__ == "__main__":  
    chunk_size = int(sys.argv[1])
    print("Chunk size selected as: ", str(chunk_size))
    
    print("Loading data...")
    conn = sqlite3.connect("training_final.db")
    ngrams_df = pd.read_sql(
        'SELECT protein, gram_num, gram_1, gram_2, gram_3, gram_4, gram_5 \
        FROM protein_ngram',
        con=conn)
    conn.close()
    print("Data loaded!")
    
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
    conn = sqlite3.connect("training_final.db")
    
    c = conn.cursor()
    c.execute("DROP TABLE IF EXISTS protein_subngram_features")
    
    for result in tqdm(p.map(write_to_dbase, chunks), total=len(chunk_pairs)):
        result.to_sql("protein_subngram_features", con=conn, index=False,
                    if_exists="append")
    
    conn.close() 
    p.close()
    p.join()
    print("Processing done!")