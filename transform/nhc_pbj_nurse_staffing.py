"""
1. Pull cols from nhc files
2. Deduplicate
3. Concat to a single data series

Address fields that are optional vs. must haves...
What format changed in 2022? Why the failure?
"""

import csv
import json
from zipfile import ZipFile
import glob
import os
import shutil
from .aco_beneficiaries_by_county import ssa_mappings

CWD = os.getcwd()
RAW_DATA_LST = glob.glob(os.path.join(CWD, "data", "raw", "open_source", "nursing_home_compare", "*.zip"))
FILE_OUT = os.path.join("data", "interim", "provider_info_tmp.csv")
COL_MAPPING = json.load(open(os.path.join(CWD, "transform", "mappings", "nhc_provider_info.json")))
COL_MAPPING = {k.lower().replace(" ", "_"): val.lower().replace(" ", "_") for k, val in COL_MAPPING.items()}
ALL_COLS = set(COL_MAPPING.keys()).union(set(COL_MAPPING.values()))
COL_COUNT = 35
YEARS = [
    2017,
    2018,
    2019,
    2020,
    2021
]

FINAL_COL_LST = [
    "SSA_Code",
    "FIPS_Code",
    "StateAbbrev",
    "StdCountyName"
    ] + list(COL_MAPPING.values())[0:COL_COUNT] + ["source_file"]
COL_MAPPING.update({v: v for v in COL_MAPPING.values()})
ALLOWED_OMMISSIONS = {
    # not present in 2022-07 data, replaced by turnover?
    'rn_staffing_rating_footnote',
    'rn_staffing_rating'
}

def extract_zips():
    ssa_idx, _, state_ssa = ssa_mappings()
    with open(FILE_OUT, "w", newline='') as f:
        writer = csv.writer(f, delimiter='|')
        writer.writerow(FINAL_COL_LST)
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
                        missing_cols = set(FINAL_COL_LST[4:-1]) - set(mapped_cols.keys())
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
                            for col in FINAL_COL_LST[4:-1]:
                                idx = mapped_cols.get(col, None)
                                if idx is not None:
                                    row_to_write.append(row[idx])
                                else:
                                    row_to_write.append("")
                            state_cd = state_ssa.get(row[4], None)
                            ssa_cd = state_cd + row[7].zfill(3) if state_cd else "Unknown"
                            county_mappings = [
                                ssa_cd,
                                ssa_idx[ssa_cd]["FIPS County Code"] if ssa_idx.get(ssa_cd, None) else "Unknown",
                                ssa_idx[ssa_cd]["State"] if ssa_idx.get(ssa_cd, None) else "Unknown",
                                ssa_idx[ssa_cd]["County Name"] if ssa_idx.get(ssa_cd, None) else "Unknown"
                            ]
                            row_to_write = county_mappings + row_to_write + [f]
                            writer.writerow(row_to_write)
                            count+=1
                        print(f"{f}.{file_name}: {count} rows written")
                shutil.rmtree("_tmp")

if __name__ == '__main__':
    extract_zips()
    


"""
https://data.cms.gov/resources/payroll-based-journal-methodology
Facility Exclusion Criteria
A nursing home is excluded from the PBJ PUFs if the nursing home had aggregate PBJ nurse staffing levels for the quarter that are considered aberrant, based on rules previously applied for the exclusion of Certification and Survey Provider Enhanced Reports (CASPER)-based staffing measures reported on Nursing Home Care Compare and used in the Five-Star Quality Rating System.  Specifically, nursing homes are excluded from the PBJ PUFs if;

Total nurse staffing = 0 hours per resident per day2; or
Total nurse staffing > 12 hours per resident per day; or
Nurse aide staffing > 5.25 hours per resident per day.
Total nurse staffing on weekends = 0 hours per resident per day3
Total nurse staffing on weekends >12 hours per resident per day3
Total nurse aide staffing on weekends > 5.25 hours per resident per day3
For this purpose, total nurse staffing includes the following specific job categories: Registered Nurse (RN) Director of Nursing (DON), RN with administrative duties, RN, Licensed Practical Nurse (LPN) with administrative duties, LPN, Certified Nursing Assistant (CNA), Medication Aide/Technician, and Nurse Aide in Training.  Aggregate staffing for the quarter is calculated by summing all relevant staffing hours across the quarter and dividing this by the sum of the daily MDS census across the quarter.  For weekend staffing, both staffing hours and census are aggregated across all weekend days (Saturdays and Sundays) in the quarter. These aggregates include only days for which there was a non-zero census. Note also that if a nursing home is excluded due to aberrant weekend staffing (i.e., exclusions 4, 5 or 6 above), no data for this provider will be included in the PUFs, regardless of staffing levels on other days in the quarter. In other words, the PUFs will include all days in the quarter for a nursing home or the nursing home will be excluded entirely.

2 Beginning with 2021Q3 data (posted in January 2022), the low staffing exclusion criteria was changed from ‘Total Nurse Staffing < 1.5 hours per resident day’ to ‘Total Nurse Staffing = 0 hours per resident day’.

3 The exclusion criteria related to weekend staffing were added beginning with the 2021Q3 data (posted in January 2022).

Ransomware attack corrupted data for 2021Q4 for 900 facilities.
Data for December of that year is totally absent for affected facilities.
"""