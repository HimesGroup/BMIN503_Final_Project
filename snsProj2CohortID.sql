/********************** Outcomes for COVID-19 after mRNA Vaccination ************************/

----------Simple Exploration--------------
select count(distinct scvbp.ptid)
from g823429.sns_proj2_coh1 scvbp

--limit 100
--where scvbp.covid_pos_date <= '2021-08-16'
--where c.ptid = 'PT226048269'
--limit 100

----------Helper Tables--------------------
--Defines table with first and last encounter for a patient
create table g823429.cov_20210916_enc_first_last as (
select ptid, min(interaction_date) first_enc_date , 
max(interaction_date) last_enc_date
from opt_20210916.enc e
group by ptid);

----------Cohort 1 definition--------------
--Cohort 1: age >= 18, cov+, vacc_date < cov+ date. Count: 1750
--1A Partial – defined as covid + between 1st and 2nd dose if both exist OR after 1st dose if no 2nd dose and brand Pfizer or Moderna or Astra Zeneca
--1B Full – defined as covid + after 2nd dose if exists OR after 1st dose if brand J&J

create table g823429.sns_proj2_coh1_0916 as 
/*INSERT INTO g823429.sns_proj2_coh1*/ (
SELECT (innerquery.ptid), innerquery.earliestpos as covid_pos_date, vacc.first_dose_date AS first_imm_date
, (innerquery.earliestpos - vacc.first_dose_date) as days_first_imm_to_infxn, vacc.first_dose_desc as first_imm_desc 
, vacc.second_dose_date as second_imm_date, (innerquery.earliestpos - vacc.second_dose_date) as days_second_imm_to_infxn
, vacc.second_dose_desc as second_imm_desc 
FROM (
	SELECT p.ptid, --grab ptid, age, cov+ date
		CASE
			WHEN birth_yr ~ '[0-9]+$' THEN (2021 - TO_NUMBER(birth_yr , '9999'))
			WHEN birth_yr = '1932 and Earlier' THEN 89
			ELSE NULL
		END AS age, cov.earliestpos
	FROM opt_20210916.pt p, g823429.sns_covpos_earliest_0916 cov
	WHERE p.ptid = cov.effectiveptid and cov.earliestpos <= '2021-08-16'
) AS innerquery
inner JOIN g823429.sns_cov_vacc_by_pt_0916 vacc
ON vacc.ptid = innerquery.ptid
WHERE
	innerquery.age >= 18 AND
	vacc.first_dose_date < innerquery.earliestpos AND
	not ( (vacc.first_dose_desc ~ '.*(U|u)(N|n)(S|s)(P|p)(E|e)(C|c)(I|i)(F|f)(I|i)(E|e)(D|d)*' OR vacc.first_dose_desc = 'COVID-19 VACCINE, PHASE II')
			and vacc.second_dose_desc is null) and
	vacc.first_dose_desc !~ '.*JANSSEN|J&J.*'
	and vacc.second_dose_desc !~ '.*JANSSEN|J&J.*'
) DISTRIBUTED BY (ptid);
	
--COHORT 1A
create table g823429.sns_proj2_coh1a_0916 as (
SELECT *
FROM g823429.sns_proj2_coh1_0916 coh1
WHERE
	coh1.days_second_imm_to_infxn <= 0 or
	coh1.days_second_imm_to_infxn is null
) DISTRIBUTED BY (ptid);

--COHORT 1B
create table g823429.sns_proj2_coh1b_0916 as (
SELECT *
FROM g823429.sns_proj2_coh1_0916 coh1
WHERE
	coh1.days_second_imm_to_infxn > 0
) DISTRIBUTED BY (ptid);

create table g823429.sns_proj2_coh1b_1_0916 as (
SELECT *
FROM g823429.sns_proj2_coh1b_0916 coh1b
WHERE
	coh1b.days_second_imm_to_infxn <= 14
) DISTRIBUTED BY (ptid);

create table g823429.sns_proj2_coh1b_2_0916 as (
SELECT *
FROM g823429.sns_proj2_coh1b_0916 coh1b
WHERE
	coh1b.days_second_imm_to_infxn > 14
) DISTRIBUTED BY (ptid);


grant all on table g823429.sns_proj2_coh1b_2_0916 to g823429;


----------Cohort 2 definition--------------

--Cohort 2: age >= 18, cov+, !(vacc_date < cov+ date). (not vaccinated before cov+). Count: 595,528
--ptid | date of covid + | date of 1st vaccination |
--2A Vacc – defined as cov+ date < vacc_date
--2B No Vacc – defined as cov+ date but NO vacc_date

create table g823429.sns_proj2_coh2_0916 as (
SELECT innerquery.ptid, innerquery.earliestpos as covid_pos_date, vacc.first_dose_date as first_imm_date--DISTINCT(innerquery.ptid)/*, **/ 
FROM (
	SELECT p.ptid, --grab ptid, age, cov+ date
		CASE
			WHEN birth_yr ~ '[0-9]+$' THEN (2021 - TO_NUMBER(birth_yr , '9999'))
			WHEN birth_yr = '1932 and Earlier' THEN 89
			ELSE NULL
		END AS age, cov.earliestpos
	FROM opt_20210916.pt p, g823429.sns_covpos_earliest_0916 cov
	WHERE p.ptid = cov.effectiveptid and cov.earliestpos <= '2021-08-16' and cov.earliestpos  >= '2020-08-16'
) AS innerquery
left outer JOIN g823429.sns_cov_vacc_by_pt_0916 vacc
ON vacc.ptid = innerquery.ptid
WHERE
	innerquery.age >= 18 AND (
		vacc.first_dose_date IS NULL OR
		vacc.first_dose_date >= innerquery.earliestpos
		)
) DISTRIBUTED BY (ptid);


--COHORT 2A
create table g823429.sns_proj2_coh2a_0916 as (
SELECT *
FROM g823429.sns_proj2_coh2_0916 coh2
WHERE
	coh2.first_imm_date is not null
) DISTRIBUTED BY (ptid);

--COHORT 2B
create table g823429.sns_proj2_coh2b_0916 as (
SELECT *
FROM g823429.sns_proj2_coh2_0916 coh2
WHERE
	coh2.first_imm_date is null
) DISTRIBUTED BY (ptid);

grant all on table g823429.sns_proj2_coh2_0916 to g823429;
