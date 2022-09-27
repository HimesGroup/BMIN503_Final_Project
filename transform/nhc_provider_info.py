"""
1. Pull cols from nhc files
2. Deduplicate
3. Concat to a single data series

TODO
Address fields that are optional vs. must haves...
What format changed in 2022? Why the failure?
"""

import csv
import json
from zipfile import ZipFile
import glob
import os
import shutil

CWD = os.getcwd()
RAW_DATA_LST = glob.glob(os.path.join(CWD, "data", "raw", "open_source", "nursing_home_compare", "*.zip"))
FILE_OUT = os.path.join("data", "interim", "provider_info_tmp.csv")
COL_MAPPING = json.load(open(os.path.join(CWD, "transform", "mappings", "nhc_provider_info.json")))
COL_MAPPING = {k.lower().replace(" ", "_"): val.lower().replace(" ", "_") for k, val in COL_MAPPING.items()}
ALL_COLS = set(COL_MAPPING.keys()).union(set(COL_MAPPING.values()))
COL_COUNT = 35
FINAL_COL_LST = list(COL_MAPPING.values())[0:COL_COUNT]
COL_MAPPING.update({v: v for v in COL_MAPPING.values()})
ALLOWED_OMMISSIONS = {
    # not present in 2022-07 data, replaced by turnover?
    'rn_staffing_rating_footnote',
    'rn_staffing_rating'
}

def extract_zips():
    with open(FILE_OUT, "w", newline='') as f:
        writer = csv.writer(f, delimiter='|')
        writer.writerow(FINAL_COL_LST + ["source_file"])
    for archive in RAW_DATA_LST:
        with ZipFile(archive, 'r') as zip1:
            file_lst = zip1.namelist()
            for f in file_lst:
                zip1.extract(f, "_tmp")
                new_file = os.path.join("_tmp", f)
                with ZipFile(new_file, 'r') as zip2:
                    lst = [d for d in zip2.namelist() if "ProviderInfo" in d]
                    assert len(lst) == 1
                    file_name = lst[0]
                    zip2.extract(file_name, "_tmp")
                with open(os.path.join("_tmp", file_name), "r", encoding='latin-1') as fi:
                    missing_cols = {}
                    reader = csv.reader(fi)
                    header = [h.lower().replace(" ", "_") for h in next(reader)]
                    mapped_cols = {}
                    for i, col in enumerate(header):
                        mapped_col = COL_MAPPING.get(col, None)                         
                        if mapped_col:
                            mapped_cols[mapped_col] = i
                    if len(mapped_cols) != COL_COUNT:
                        print([col for col in header if col not in ALL_COLS])
                        print(len(mapped_cols))
                        missing_cols = set(FINAL_COL_LST) - set(mapped_cols.keys())
                        print(missing_cols)
                        if len(missing_cols - ALLOWED_OMMISSIONS) > 0:
                            raise(Exception)
                        for col in missing_cols:
                            mapped_cols[col] = None
                    with open(FILE_OUT, "a", encoding='latin-1', newline='') as fo:
                        writer = csv.writer(fo, delimiter='|')
                        count = 0
                        for row in reader:
                            if len(row) == 0:
                                break
                            row_to_write = []
                            for col in FINAL_COL_LST:
                                idx = mapped_cols.get(col, None)
                                if idx is not None:
                                    row_to_write.append(row[idx])
                                else:
                                    row_to_write.append("")
                            row_to_write += [f]
                            writer.writerow(row_to_write)
                            count+=1
                        print(f"{f}.{file_name}: {count} rows written")
                shutil.rmtree("_tmp")

if __name__ == '__main__':
    extract_zips()
    
