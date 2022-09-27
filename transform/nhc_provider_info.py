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
COL_COUNT = 34

def main():
    with open(FILE_OUT, "w") as f:
        writer = csv.writer(f)
        writer.writerow(list(COL_MAPPING.keys()) + ["source_file"])
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
                with open(os.path.join("_tmp", file_name), "r") as fi:
                    reader = csv.reader(fi)
                    header = [h.lower().replace(" ", "_") for h in next(reader)]
                    indexes = [i for i, col in enumerate(header) if col in ALL_COLS]
                    if len(indexes) != COL_COUNT:
                        print([col for col in header if col not in ALL_COLS])
                        print(len(indexes))
                        raise(Exception)
                    with open(FILE_OUT, "a") as fo:
                        writer = csv.writer(fo)
                        count = 0
                        for row in reader:
                            if len(row) == 0:
                                break
                            writer.writerow([row[i] for i in indexes] + [f])
                            count+=1
                        print(f"{f}.{file_name}: {count} rows written")
                shutil.rmtree("_tmp")

if __name__ == '__main__':
    main()
