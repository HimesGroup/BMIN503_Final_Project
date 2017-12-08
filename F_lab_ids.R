## Query to find RSLT_COMP values for a PROC_ID
# SELECT 
# rc.RSLT_COMP_ID, 
# rc.BASE_NM,
# MAX(por.RSLT_DT),
# MIN(po.RSLT_DT),
# COUNT(por.PROC_ORD_KEY)
# FROM CDWPRD.CDW.PROCEDURE_ORDER po
# INNER JOIN CDWPRD.CDW.PROCEDURE_ORDER_RESULT por ON por.PROC_ORD_KEY = po.PROC_ORD_KEY
# INNER JOIN CDWPRD.CDW.RESULT_COMPONENT rc ON rc.RSLT_COMP_KEY = por.RSLT_COMP_KEY
# INNER JOIN CDWPRD.CDW."PROCEDURE" p ON po.PROC_KEY = p.PROC_KEY 
# WHERE p.PROC_ID IN (5939)

# Main data structure of lab values / procedures / result ids
lab.ids <- data.frame(base = c('hgb','hgb',
                               'wbc','wbc',
                               'plt','plt',
                               'na','na',
                               'k','k',
                               'cl','cl',
                               'bicarb','bicarb',
                               'bun','bun',
                               'creat','creat',
                               'gluc','gluc',
                               'na', 
                               'na','k',
                               'ca','ca',
                               'na','na','na','na','na',
                               'k','k','k','k','k',
                               'hgb','hgb','hgb','hgb','hgb','hgb','hgb',
                               'pH','pH','pH','pH','pH','pH','pH','pH',
                               'pO2','pO2','pO2','pO2','pO2','pO2','pO2','pO2',
                               'pCO2','pCO2','pCO2','pCO2','pCO2','pCO2','pCO2','pCO2',
                               'bicarb','bicarb','bicarb','bicarb','bicarb','bicarb','bicarb','bicarb',
                               'be','be','be','be','be','be','be','be',
                               'lactate','lactate',
                               'svO2','svO2','svO2',
                               'PTT','PTT Post Hept',
                               'PT','INR',
                               'fibrinogen',
                               'gluc','gluc','gluc','gluc',
                               'fiO2','fiO2','fiO2','fiO2','fiO2','fiO2','fiO2','fiO2',
                               'istat type','istat type',
                               'istat time','istat time',
                               'istat date','istat date',
                               'gluc',
                               'hgb'
                               ),
                      proc.name = c('CBC w Diff','CBC wo Diff',
                                    'CBC w Diff','CBC wo Diff',
                                    'CBC w Diff','CBC wo Diff',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'BMP','CMP',
                                    'Sodium',
                                    'Sod Potass','Sod Potass',
                                    'BMP','CMP',
                                    'sABG','ABG-L','sVBG','VBG-L','iStat7',
                                    'sABG','ABG-L','sVBG','VBG-L','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'ABG-L','VBG-L',
                                    'sVBG','VBG-L','VBG',
                                    'PTT','PTT',
                                    'PT INR','PT INR',
                                    'Fibrinogen',
                                    'sABG','ABG-L','sVBG','VBG-L',
                                    'sABG','ABG-L','ABG','sVBG','VBG-L','VBG','iStat3','iStat7',
                                    'iStat3','iStat7',
                                    'iStat3','iStat7',
                                    'iStat3','iStat7',
                                    'POC GLUC',
                                    'iStat7'
                                    ),
                      proc.id = c('6164','13181',
                                  '6164','13181',
                                  '6164','13181',
                                  '11193','11194',
                                  '11193','11194',
                                  '11193','11194',
                                  '11193','11194',
                                  '11193','11194',
                                  '11193','11194',
                                  '11193','11194',
                                  '13145',
                                  '12982','12982',
                                  '11193','11194',
                                  '13506','13516','16183','16184','82439',
                                  '13506','13516','16183','16184','82439',
                                  '13506','13516','13488','16183','16184','16182','82439',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '13516','16184',
                                  '16183','16184','16182',
                                  '15768','15768',
                                  '13216','13216',
                                  '6213',
                                  '13506','13516','16183','16184',
                                  '13506','13516','13488','16183','16184','16182','12983','82439',
                                  '12983','82439',
                                  '12983','82439',
                                  '12983','82439',
                                  '5939',
                                  '82439'
                                  ),
                      rslt.id = c('5','5',
                                  '51','51',
                                  '58','58',
                                  '79','79',
                                  '80','80',
                                  '81','81',
                                  '82','82',
                                  '83','83',
                                  '84','84',
                                  '6','6',
                                  '79',
                                  '79','80',
                                  '85','85',
                                  '127','127','127','127','127',
                                  '128','128','128','128','128',
                                  '34','34','34','34','34','34','34',
                                  '27','27','27','4110','4110','4110','27','27',
                                  '29','29','29','4112','4112','4112','29','29',
                                  '28','28','28','4111','4111','4111','28','28',
                                  '30','30','30','4113','4113','4113','30','30',
                                  '31','31','31','4114','4114','4114','31','31',
                                  '3722','4117',
                                  '4115','4115','4115',
                                  '76','3285',
                                  '75','174',
                                  '178',
                                  '122','122','122','122',
                                  '25','25','25','25','25','25','29','29',
                                  '500611','500611',
                                  '139','139',
                                  '138','138',
                                  '193',
                                  '502549'
                                  ),
                      stringsAsFactors = FALSE)

# Creates a data.frame with two columns, 'query' and 'md5', with 
# all rows of the lab.ids data structure
makeQuery <- function (ids = lab.ids)
{
  library(digest)
  
  allQueries <- vector(length = nrow(ids))
  allMD5 <- vector(length = nrow(ids))
  allJoins <- vector(length = nrow(ids))
  
  for (i in 1 : nrow(lab.ids)) {
    allQueries[i] <- makeQueryByIndex(i,ids)
    
    allMD5[i] <- digest(allQueries[i], algo='md5')
    
    substituteJoin <- strwrap("
        SELECT lab_table.*, 
                fc.dept AS DEPT_GRP,
                fc.IN_DT,
                DATE(lab_table.RSLT_DT) AS RSLT_Date
          FROM tbl_%s AS lab_table 
                INNER JOIN final_cohort fc ON lab_table.VISIT_KEY = fc.VISIT_KEY 
                    AND lab_table.RSLT_DT BETWEEN fc.IN_DT AND fc.OUT_DT
          ", width=10000)
    
    allJoins[i] <- sprintf(substituteJoin,allMD5[i])
  }
  
  return(data.frame(query = allQueries, 
                    md5 = allMD5, 
                    joinTable = allJoins,
                    stringsAsFactors = FALSE))
}

# Generate a single query from a single line in the labs.ids data structure
makeQueryByIndex <- function (index, ids = lab.ids)
{
  substituteString <- strwrap("
                SELECT 
                    proc_ord.VISIT_KEY,
                    proc_ord.PAT_KEY,
                    proc_ord.PROC_ORD_KEY,
                    dept.DEPT_NM AS LAB_DEPT,
                    proc_ord.RSLT_DT, 
                    proc_ord.SPECIMEN_TAKEN_DT,
                    po_rslt.RSLT_NUM_VAL AS VALUE,
                    '%s' AS PROC_NM,
                    '%s' AS BASE_NM
                FROM 
                    CDW.PROCEDURE_ORDER proc_ord 
                    LEFT JOIN CDW.\"PROCEDURE\" proc ON proc.PROC_KEY = proc_ord.PROC_KEY 
                    LEFT JOIN CDW.DEPARTMENT dept ON dept.DEPT_KEY = proc_ord.PAT_LOC_DEPT_KEY
                    LEFT JOIN CDW.PROCEDURE_ORDER_RESULT po_rslt ON po_rslt.PROC_ORD_KEY = proc_ord.PROC_ORD_KEY 
                WHERE 
                    proc.PROC_ID IN (%s)
                    AND po_rslt.RSLT_COMP_KEY = 
                    (SELECT rslt.RSLT_COMP_KEY FROM CDW.RESULT_COMPONENT rslt WHERE rslt.RSLT_COMP_ID IN (%s))
                    AND proc_ord.RSLT_DT IS NOT NULL
                    ", width=10000)
  
  fullStr <- sprintf(substituteString,
                     lab.ids[index,'proc.name'],
                     lab.ids[index,'base'],
                     lab.ids[index,'proc.id'],
                     lab.ids[index,'rslt.id'])
  
  return(fullStr)
}
