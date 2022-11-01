"""
Process detail level nursing home compare staffing data
"""

#from zipfile import ZipFile
import os
import pandas
import glob
from zipfile import ZipFile

CWD = os.getcwd()
FILE_IN = r"E:/NHC/PBJ_Nurse_2021_Q4/Payroll_Based_Journal_Daily_Nurse_Staffing_2021_Q4.csv"
RAW_DATA_LIST = glob.glob(
    r"E:/NHC/*.zip"
)
print(RAW_DATA_LIST)
DIR_OUT = "E:/NHC"
FILE_OUT = os.path.join("data", "interim", "admin_intensity.xlsx")
# RAW_DATA_LST = glob.glob(os.path.join(CWD, "data", "raw", "open_source", "nursing_home_compare", "*.zip"))
# FILE_OUT = os.path.join("data", "interim", "provider_info_tmp.csv")
# COL_MAPPING = json.load(open(os.path.join(CWD, "transform", "mappings", "nhc_provider_info.json")))
# COL_MAPPING = {k.lower().replace(" ", "_"): val.lower().replace(" ", "_") for k, val in COL_MAPPING.items()}
# ALL_COLS = set(COL_MAPPING.keys()).union(set(COL_MAPPING.values()))

def extract_all():
    for file in RAW_DATA_LIST:
        print("Extracting", file)
        with ZipFile(file, 'r') as zipObj:
            zipObj.extractall(DIR_OUT)

def calc_admin_intensity():
    df = pandas.read_csv(FILE_IN, encoding='latin-1', dtype={'PROVNUM': str})
    df["Hrs_Admin"] = df["Hrs_RNDON"] + df["Hrs_RNadmin"] + df["Hrs_LPNadmin"]
    df["Hrs_NonAdmin"] = df["Hrs_RN"] + df["Hrs_LPN"] + df["Hrs_CNA"] + df["Hrs_NAtrn"] + df["Hrs_MedAide"]
    initial_shape = print(df.shape[0])
    df = df.loc[df["incomplete"] == 0]
    final = print(df.shape[0])
    print("Dropped", initial_shape - final, "rows due to incomplete data")
    grouped = df.groupby("PROVNUM", as_index=False).agg({"MDScensus": "sum", "Hrs_Admin":"sum", "Hrs_NonAdmin":"sum", "ObsDays": "count"})
    grouped["Hrs_Admin_prpd"] = grouped["Hrs_Admin"] / grouped["MDScensus"]
    grouped["Hrs_NonAdmin_prpd"] = grouped["Hrs_NonAdmin"] / grouped["MDScensus"]
    grouped["AdminIntensity"] =grouped["Hrs_Admin_prpd"] / (grouped["Hrs_NonAdmin_prpd"] + grouped["Hrs_Admin_prpd"])
    grouped.to_excel(FILE_OUT, index=False)

if __name__ == "__main__":
    extract_all()
    # calc_admin_intensity()
