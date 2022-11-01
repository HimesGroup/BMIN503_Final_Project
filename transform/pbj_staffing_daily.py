"""
Process detail level nursing home compare staffing data
"""

#from zipfile import ZipFile
import os
import pandas
import glob

CWD = os.getcwd()
RAW_DATA_LST = glob.glob(os.path.join(CWD, "data", "raw", "open_source", "PBJ*.csv"))
print(RAW_DATA_LST)
FILE_OUT = os.path.join(CWD, "data", "interim", "pbj_facility_level.csv")
COLS = [
    "PROVNUM","PROVNAME","CITY","STATE","COUNTY_NAME","COUNTY_FIPS","CY_Qtr","WorkDate","MDScensus","Hrs_RNDON","Hrs_RNDON_emp","Hrs_RNDON_ctr","Hrs_RNadmin","Hrs_RNadmin_emp","Hrs_RNadmin_ctr","Hrs_RN","Hrs_RN_emp","Hrs_RN_ctr","Hrs_LPNadmin","Hrs_LPNadmin_emp","Hrs_LPNadmin_ctr","Hrs_LPN","Hrs_LPN_emp","Hrs_LPN_ctr","Hrs_CNA","Hrs_CNA_emp","Hrs_CNA_ctr","Hrs_NAtrn","Hrs_NAtrn_emp","Hrs_NAtrn_ctr","Hrs_MedAide","Hrs_MedAide_emp","Hrs_MedAide_ctr"
]


# def extract_all():
#     for file in RAW_DATA_LST:
#         print("Extracting", file)
#         with ZipFile(file, 'r') as zipObj:
#             zipObj.extractall(FILE_OUT)


def main():
    for i, f in enumerate(RAW_DATA_LST):
        print("Processing", f)
        df = pandas.read_csv(f, encoding='latin-1', skiprows=0, dtype={i:str for i in range(8)})#, dtype={'PROVNUM': str})
        qtr = df.iloc[0,6]
        if qtr == "2021Q4":
            start = df.shape[0]
            df = df.loc[df["incomplete"] == 0]
            end = df.shape[0]
            print("Dropped", start - end, "rows due to incomplete data")
            df.drop(columns=["incomplete"], inplace=True)
        df.columns = COLS
        df = calc_admin_intensity(df)
        if i == 0:
            df_final = df.copy()
        else:
            df_final = pandas.concat([df_final, df], ignore_index=True)
    df_final.to_csv(FILE_OUT, index=False)


def calc_admin_intensity(df):
    print(df.shape)
    df["Hrs_Admin"] = df["Hrs_RNDON"] + df["Hrs_RNadmin"] + df["Hrs_LPNadmin"]
    df["Hrs_NonAdmin"] = df["Hrs_RN"] + df["Hrs_LPN"] + df["Hrs_CNA"] + df["Hrs_NAtrn"] + df["Hrs_MedAide"]
    grouped = df.groupby(["PROVNUM", "CY_Qtr"], as_index=False).agg({"MDScensus": "sum", "Hrs_Admin":"sum", "Hrs_NonAdmin":"sum", "WorkDate": "count"})
    grouped["Hrs_Admin_prpd"] = (grouped["Hrs_Admin"] / grouped["MDScensus"]).round(4)
    grouped["Hrs_NonAdmin_prpd"] = (grouped["Hrs_NonAdmin"] / grouped["MDScensus"]).round(4)
    grouped["AdminIntensity"] = (grouped["Hrs_Admin_prpd"] / (grouped["Hrs_NonAdmin_prpd"] + grouped["Hrs_Admin_prpd"])).round(4)
    grouped["EstResidentsPerDay"] = (grouped["MDScensus"] / grouped["WorkDate"]).round(4)
    print(grouped.shape)
    return grouped

if __name__ == "__main__":
    main()
