"""
Remove
"""

import csv
import os

CWD = os.getcwd()
FILE_IN = os.path.join(CWD, "data", "raw", "open_source", "enroll_052022_sorted.csv")
FILE_OUT = os.path.join("data", "interim", "medicare_enrollment.csv")
FINAL_COL_LST = [
    "YEAR",
    "MONTH",
    "BENE_GEO_LVL",
    "BENE_STATE_ABRVTN",
    "BENE_STATE_DESC",
    "BENE_COUNTY_DESC",
    "BENE_FIPS_CD",
    "TOT_BENES",
    "ORGNL_MDCR_BENES",
    "MA_AND_OTH_BENES",
    "AGED_TOT_BENES",
    "AGED_ESRD_BENES",
    "AGED_NO_ESRD_BENES",
    "DSBLD_TOT_BENES",
    "DSBLD_ESRD_AND_ESRD_ONLY_BENES",
    "DSBLD_NO_ESRD_BENES",
    "A_B_TOT_BENES",
    "A_B_ORGNL_MDCR_BENES",
    "A_B_MA_AND_OTH_BENES",
    "PRSCRPTN_DRUG_TOT_BENES",
    "PRSCRPTN_DRUG_PDP_BENES",
    "PRSCRPTN_DRUG_MAPD_BENES"
]
NUMERIC_COLS = FINAL_COL_LST[7:]

def main():
    with open(FILE_OUT, "w", newline='') as f:
        writer = csv.writer(f, delimiter='|')
        writer.writerow(FINAL_COL_LST + ["source_file"])

    with open(FILE_IN, "r", encoding='latin-1') as fi:        
        file_name = os.path.basename(FILE_IN)
        reader = csv.reader(fi)
        next(reader)
        with open(FILE_OUT, "a", encoding='latin-1', newline='') as fo:
            writer = csv.writer(fo, delimiter='|')
            count=0
            skipped_count=0
            for row in reader:
                numeric_data = row[7:]
                if not (row[1] == "Year" and row[2] == "County"):
                    skipped_count+=1
                    continue
                row_to_write = row[0:7] + [
                    obs if obs.replace(".", "").isnumeric() else "" for obs in numeric_data
                ] + [file_name]
                writer.writerow(row_to_write)
                count+=1
            print(f"{file_name}: {count} rows written")
            print(f"{file_name}: {skipped_count} rows skipped")

if __name__ == '__main__':
    main()
