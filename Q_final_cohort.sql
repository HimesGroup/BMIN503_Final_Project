WITH 

cohort AS (
SELECT 
  DISTINCT vis_evnt.VISIT_KEY
FROM 
  CDW.VISIT_EVENT vis_evnt  
    INNER JOIN CDW.CDW_DICTIONARY event_type ON vis_evnt.DICT_ADT_EVENT_KEY = event_type.dict_key
        AND event_type.src_id IN (1,2,3,4,6) 
    INNER JOIN CDW.CDW_DICTIONARY event_sub_type ON vis_evnt.DICT_EVENT_SUBTYPE_KEY = event_sub_type.dict_key
        AND event_sub_type.src_id <> 2 
    INNER JOIN CDW.DEPARTMENT dept ON vis_evnt.DEPT_KEY = dept.DEPT_KEY
WHERE 
  dept.DEPT_ID IN (34, 43, 123, 36) 
  AND vis_evnt.VISIT_KEY NOT IN (-1, 0)
  AND vis_evnt.PAT_KEY NOT IN (0)
  AND vis_evnt.EFF_EVENT_DT BETWEEN DATE('07/01/2012') AND DATE('07/01/2017')
),
  
all_adt AS (
SELECT
  vis_evnt.VISIT_KEY,
  vis_evnt.VISIT_EVENT_KEY,
  pat.DOB AS PAT_DOB,
  pat.SEX AS PAT_SEX,
  vis_evnt.EFF_EVENT_DT as IN_DT,
  event_type.DICT_NM AS EVENT_TYPE,
  CASE WHEN event_type.src_id IN (1,3) THEN 1 
       WHEN event_type.src_id IN (2,4) THEN 0 
	   END AS EVENT_DIR,
  dept.DEPT_NM as d_name,
  dept.DEPT_KEY AS d_key,
  CASE WHEN dept.DEPT_ID IN (34,43,123) THEN 1 
       WHEN dept.DEPT_ID IN (36) THEN 2 
	   WHEN dept.DEPT_ID IN (101001069,58,66) THEN 3 
	   ELSE 0 
	   END AS dept_grp,
  bed.BED_NM AS bed_name,
  vis_evnt.PAT_KEY,
  dict_svc.DICT_NM AS PAT_SVC
FROM 
  cohort
    INNER JOIN CDW.VISIT_EVENT vis_evnt ON cohort.VISIT_KEY = vis_evnt.VISIT_KEY
    INNER JOIN CDW.PATIENT pat ON pat.PAT_KEY = vis_evnt.PAT_KEY
    INNER JOIN CDW.CDW_DICTIONARY event_type ON vis_evnt.DICT_ADT_EVENT_KEY = event_type.dict_key
        AND event_type.src_id IN (1,2,3,4) 
    INNER JOIN CDW.CDW_DICTIONARY event_sub_type ON vis_evnt.DICT_EVENT_SUBTYPE_KEY = event_sub_type.dict_key
        AND event_sub_type.src_id <> 2 
    INNER JOIN CDW.CDW_DICTIONARY dict_svc ON dict_svc.DICT_KEY = vis_evnt.DICT_PAT_SVC_KEY
    INNER JOIN CDW.DEPARTMENT dept ON vis_evnt.DEPT_KEY = dept.DEPT_KEY
    INNER JOIN CDW.MASTER_BED bed ON vis_evnt.BED_KEY = bed.BED_KEY
),

remv_periop AS (
SELECT 
  *,
  FIRST_VALUE(in_dt) OVER (PARTITION BY visit_key ORDER BY in_dt) AS HOSP_ADMIT_DT,
  FIRST_VALUE(in_dt) OVER (PARTITION BY visit_key ORDER BY in_dt DESC) AS HOSP_DC_DT,
  CASE WHEN (LAG(dept_grp) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IN (3) AND 
             dept_grp IN (3) AND
			 LAG(event_type) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IN ('Transfer In') AND
			 event_type IN ('Transfer Out')) OR 
			(LEAD(dept_grp) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IN (3) AND 
             dept_grp IN (3) AND
			 LEAD(event_type) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IN ('Transfer Out') AND
			 event_type IN ('Transfer In')) THEN 'Y' END AS out_periop
FROM all_adt
),

same_dept AS (
SELECT 
  *,
  CASE WHEN LAG(dept_grp) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IN (dept_grp) THEN 'Y' END AS same_dept
FROM remv_periop
WHERE out_periop IS NULL
),

visit_dt_set AS (
SELECT 
  *,
  CASE WHEN SAME_DEPT IS NULL THEN IN_DT END AS VISIT_IN_DT,
  CASE WHEN LEAD(SAME_DEPT) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) IS NULL THEN IN_DT END AS VISIT_OUT_DT
FROM same_dept
WHERE DEPT_GRP IN (1,2)
),

comb_lines AS (
SELECT
  *,
  CASE WHEN VISIT_OUT_DT IS NULL THEN LEAD(VISIT_OUT_DT) OVER (PARTITION BY visit_key ORDER BY in_dt,event_dir) END AS OUT_DT
FROM visit_dt_set
WHERE VISIT_IN_DT IS NOT NULL OR VISIT_OUT_DT IS NOT NULL
),

final_cohort AS (
SELECT 
  VISIT_KEY,
  PAT_KEY,
  PAT_SVC,
  PAT_DOB,
  PAT_SEX,
  CASE WHEN DEPT_GRP = 1 THEN 'PICU'
       WHEN DEPT_GRP = 2 THEN 'CICU' END AS DEPT,
  VISIT_IN_DT AS IN_DT,
  OUT_DT,
  HOSP_ADMIT_DT,
  HOSP_DC_DT
FROM comb_lines
WHERE VISIT_IN_DT IS NOT NULL AND OUT_DT IS NOT NULL
)

SELECT * 
FROM final_cohort;