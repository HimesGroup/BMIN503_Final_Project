/*** NOTE: THIS SQL WAS OBTAINED FROM OPTUM AND TWEAKED TO USE THE UPDATED TABLES. */
/** AUTHOR != Madison Pickering */

/** charlson ddl; @author Sameh Saleh **/
CREATE TABLE g823429.sns_charlson_icd_codes_0916 (
	ptid VARCHAR(11),
	COMORBITIES VARCHAR(80),
	severity INT
)
DISTRIBUTED BY (ptid);
grant all on table g823429.sns_charlson_icd_codes_0916  to g823429;
--grant all on table g823429.charlson_scores to g823429;

---ICD codes
drop table g823429.sns_charlson_icd_codes_0916;

CREATE TABLE g823429.sns_charlson_icd_codes_0916 AS (
SELECT distinct ptid, COMORBIDITIES,severity
INTO g823429.sns_charlson_icd_codes_0916 
from (
select distinct ptid, 'MYOCARDIAL_INFARCTION' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'I21%' and 'I22999%') 
or (diagnosis_cd = 'I252')) 
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'CONGESTIVE_HEART_FAILURE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'I425' and 'I42999') or
(diagnosis_cd like 'I43%') or
(diagnosis_cd like 'I50%') or
(diagnosis_cd in ('I099', 'I110', 'I130', 'I132', 'I255', 'I420', 'P290')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'PERIPHERAL_VASCULAR_DISEASE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'I70' and 'I71999') or
(diagnosis_cd in ('I731', 'I738', 'I739', 'I771', 'I790', 'I792', 'K551', 'K558', 'K559', 'Z958', 'Z959')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'CEREBROVASCULAR_DISEASE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'G45%' and 'G46999%') or
(diagnosis_cd between 'I60%' and 'I69999%' or diagnosis_cd = 'H340'))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'DEMENTIA' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'F00%' and 'F03999%') or
(diagnosis_cd like 'G30%' or diagnosis_cd in ('F051', 'G311')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'COPD' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'J40%' and 'J47999%') or
(diagnosis_cd between 'J60%' and 'J67999%') or
(diagnosis_cd in ('I278', 'I279', 'J684', 'J701', 'J703')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'RHEUMATIC_DISEASE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'M05' and 'M06999') or
(diagnosis_cd between 'M32' and 'M34999') or
(diagnosis_cd in ('M315', 'M351', 'M353', 'M360')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'PEPTIC_ULCER_DISEASE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd between 'K25' and 'K28999'
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'MILD_LIVER_DISEASE' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd like 'B18%') or
(diagnosis_cd between 'K70' and 'K70399') or
(diagnosis_cd between 'K73' and 'K74999') or
(diagnosis_cd between 'K713' and 'K71599') or
(diagnosis_cd between 'K762' and 'K76499') or
(diagnosis_cd in ('K709', 'K717', 'K760',  'K768', 'K769', 'Z944')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'DIABETES_MELLITUS_UNCOMPLICATED' as COMORBIDITIES, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd IN ('E100','E101','E106','E108','E109',
				'E110','E111','E116','E118','E119',
				'E120','E121','E126','E128','E129',
				'E130','E131','E136','E138','E139',
				'E140','E141','E146','E148','E149')
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'DIABETES_MELLITUS_CHRONIC_COMPLICATED' as COMORBIDITIES, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd IN ('E107','E117','E127','E137','E147')) or
(diagnosis_cd between 'E102' and 'E10599') or
(diagnosis_cd between 'E112' and 'E11599') or
(diagnosis_cd between 'E122' and 'E12599') or
(diagnosis_cd between 'E132' and 'E13599') or
(diagnosis_cd between 'E142' and 'E14599'))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'HEMIPLEGIA_PARAPLEGIA' as COMORBIDITIES, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'G81' and 'G82999') or
(diagnosis_cd between 'G830' and 'G83499') or
(diagnosis_cd in ('G041', 'G114', 'G801', 'G802', 'G839')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'KIDNEY_DISEASE' as COMORBIDITIES, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd like 'N18%') or 
(diagnosis_cd like 'N19%') or 
(diagnosis_cd between 'N032' and 'N03799') or 
(diagnosis_cd between 'N052' and 'N05799') or
(diagnosis_cd in ('I120','I131','N250','Z490','Z492','Z940','Z992')))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'MALIGNANCY' as COMORBIDITIES, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'C00' and 'C26999') or
(diagnosis_cd between 'C30' and 'C34999') or
(diagnosis_cd between 'C37' and 'C41999') or
(diagnosis_cd like 'C43%') or
(diagnosis_cd between 'C45' and 'C58999') or
(diagnosis_cd between 'C60' and 'C76999') or
(diagnosis_cd between 'C81' and 'C85999') or
(diagnosis_cd between 'C90' and 'C97999') or
(diagnosis_cd like 'C88%'))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'SEVERE_LIVER_DISEASE' as COMORBIDITIES, 3 as severity
FROM opt_20210916.diag d
where diagnosis_cd in ('I850','I859','I864', 'I982', 'K704', 'K711','K721','K729', 'K765', 'K766', 'K767')
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'METASTATIC_SOLID_TUMOR' as COMORBIDITIES, 6 as severity
FROM opt_20210916.diag d
where diagnosis_cd between 'C77' and 'C80999'
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'AIDS' as COMORBIDITIES, 6 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between 'B20' and 'B22999') OR
(diagnosis_cd like 'B24%'))
and diagnosis_cd_type='ICD10'
union
select distinct ptid, 'MYOCARDIAL_INFARCTION' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd like '410%') or 
(diagnosis_cd like '412%')) 
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'CONGESTIVE_HEART_FAILURE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd like '428%'
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'PERIPHERAL_VASCULAR_DISEASE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd in ('4439', '7854', 'V434')) OR
(diagnosis_cd like '441%'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'CEREBROVASCULAR_DISEASE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd between '430' and '43899' 
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'DEMENTIA' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd like '290%' 
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'COPD' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd = '5064') or 
(diagnosis_cd between '490' and '50599')) 
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'RHEUMATIC_DISEASE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd in ('7100', '7101', '7104', '71481')) or 
(diagnosis_cd like '725') OR
(diagnosis_cd between '714%' and '71429')) 
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'PEPTIC_ULCER_DISEASE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where diagnosis_cd between '531' and '53499'
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'MILD_LIVER_DISEASE' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd = '5712') or 
(diagnosis_cd between '5714' and '57169'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'DIABETES_MELLITUS_UNCOMPLICATED' as comorbidities, 1 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd = '2507') OR
(diagnosis_cd between '2500' and '25039'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'DIABETES_MELLITUS_CHRONIC_COMPLICATED' as comorbidities, 2 as severity
FROM opt_20210916.diag d
where diagnosis_cd between '2504' and '25069'
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'HEMIPLEGIA_PARAPLEGIA' as comorbidities, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd = '3441') OR
(diagnosis_cd like '342%'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'KIDNEY_DISEASE' as comorbidities, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd like '582%') OR
(diagnosis_cd between '583' and '58379') or 
(diagnosis_cd like '585%') or 
(diagnosis_cd like '586%') OR
(diagnosis_cd like '588%'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'MALIGNANCY' as comorbidities, 2 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between '140' and '17299') OR
(diagnosis_cd between '174' and '19589') OR
(diagnosis_cd between '200' and '20899'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'SEVERE_LIVER_DISEASE' as comorbidities, 3 as severity
FROM opt_20210916.diag d
where ((diagnosis_cd between '4560' and '45621') or 
(diagnosis_cd between '5722' and '57289'))
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'METASTATIC_SOLID_TUMOR' as comorbidities, 6 as severity
FROM opt_20210916.diag d
where diagnosis_cd between '196' and '19919'
and diagnosis_cd_type='ICD9'
union
select distinct ptid, 'AIDS' as comorbidities, 6 as severity
FROM opt_20210916.diag d
where diagnosis_cd between '042' and '04499'
and diagnosis_cd_type='ICD9') cc) DISTRIBUTED BY ptid;

--scores
drop table g823429.sns_charlson_scores_0916;
CREATE TABLE g823429.sns_charlson_scores_0916 AS (
SELECT ptid,SUM(severity) as cci_score
into g823429.charlson_scores
from g823429.charlson_icd_codes
group by ptid) distributed BY (ptid);

--stats for use with covid+/covid-
/*
SELECT comorbidities,COUNT(distinct c.ptid) as count_patients
from shared.charlson_icd_codes c
join shared.covid_positives_20201015 p on p.ptid=c.ptid
group by comorbidities
ORDER BY count_patients DESC;

SELECT comorbidities,COUNT(distinct c.ptid) as count_patients
from shared.charlson_icd_codes c
join shared.covid_negatives_20201015 p on p.ptid=c.ptid
group by comorbidities
ORDER BY count_patients DESC;

select case when cci_score is null then 0 else cci_score end
FROM shared.charlson_scores c
right join shared.covid_positives_20201015 p on p.ptid=c.ptid;

select case when cci_score is null then 0 else cci_score end
FROM shared.charlson_scores c
right join shared.covid_negatives_20201015 p on p.ptid=c.ptid;

SELECT comorbidities,COUNT(distinct c.ptid) as count_patients
from shared.charlson_icd_codes c
join shared.pt_age_dod_1015 p on p.ptid=c.ptid
where pos_neg='pos'
and dod is not null
group by comorbidities
ORDER BY count_patients DESC;

select case when cci_score is null then 0 else cci_score end
FROM shared.charlson_scores c
right join shared.pt_age_dod_1015 p on p.ptid=c.ptid
where pos_neg='neg'
and dod is not null;
*/

