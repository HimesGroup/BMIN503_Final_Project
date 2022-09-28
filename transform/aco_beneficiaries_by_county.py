"""
Pull ACO data, concat to a single file
Filter records where there are <10 members in a county
"""

import csv
import glob
import os
import shutil
from unicodedata import numeric

CWD = os.getcwd()
RAW_DATA_LST = glob.glob(os.path.join(CWD, "data", "raw", "open_source", "Number_Of_ACO_Assigned_Beneficiaries_by_County_PUF_*.csv"))
FILE_OUT = os.path.join("data", "interim", "aco_enrollment.csv")
FINAL_COL_LST = [
    "Year",
    "ACO_ID",
    "State_Name",
    "County_Name",
    "State_ID",
    "County_ID",
    "AB_Psn_Yrs_ESRD",
    "AB_Psn_Yrs_DIS",
    "AB_Psn_Yrs_AGDU",
    "AB_Psn_Yrs_AGND",
    "Tot_AB_Psn_Yrs",
    "Tot_AB"
]
NUMERIC_COLS = [
    "AB_Psn_Yrs_ESRD",
    "AB_Psn_Yrs_DIS",
    "AB_Psn_Yrs_AGDU",
    "AB_Psn_Yrs_AGND",
    "Tot_AB_Psn_Yrs",
    "Tot_AB"
]

def main():
    with open(FILE_OUT, "w", newline='') as f:
        writer = csv.writer(f, delimiter='|')
        writer.writerow(FINAL_COL_LST + ["source_file"])
    for file_path in RAW_DATA_LST:
        file_name = os.path.basename(file_path)
        with open(file_path, "r", encoding='latin-1') as fi:        
            reader = csv.reader(fi)
            next(reader)
            with open(FILE_OUT, "a", encoding='latin-1', newline='') as fo:
                writer = csv.writer(fo, delimiter='|')
                count=0
                for row in reader:
                    numeric_data = row[6:]
                    #if len(row) == 0:
                    #    break
                    if not any(s.replace(".", "").isnumeric() for s in numeric_data):
                        continue
                    row_to_write = row[0:6] + [
                        obs if obs.replace(".", "").isnumeric() else "" for obs in numeric_data
                    ] + [file_name]
                    writer.writerow(row_to_write)
                    count+=1
                print(f"{file_name}: {count} rows written")
if __name__ == '__main__':
    main()
