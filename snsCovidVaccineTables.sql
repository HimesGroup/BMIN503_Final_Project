
----------Table for all COVID Vaccines--------------
create table g823429.sns_cov_vaccines_0916 AS(
SELECT imm.ptid, (imm.immunization_date), imm.immunization_desc,
imm.mapped_name, imm.ndc, imm.ndc_source, imm.pt_reported,
imm.sourceid 
--count(*) as count_combo
FROM opt_20210916.rx_immun imm 
WHERE
(
	imm.immunization_desc ~ '.*(C|c)(O|o)(V|v).*|.*(C|c)(O|o)(R|r)(O|o).*|.*(S|s)(A|a)(R|r)(S|s).*' OR
	imm.mapped_name ~ '.*(C|c)(O|o)(V|v).*|.*(C|c)(O|o)(R|r)(O|o).*|.*(S|s)(A|a)(R|r)(S|s).*' OR
	imm.ndc = '59267100001' OR 
	imm.ndc = '80777027399' OR 
	imm.ndc = '59267100002' OR
	imm.ndc = '59267100003' OR 
	imm.ndc = '80777027310' OR 
	imm.ndc = '59676058015'
)
AND --exclusion criteria
(
	imm.immunization_desc != 'AD26.COV2.S (1 X 10^11 VP) OR PLACEBO (0.9 % NACL) UNIT-DOSE VACCINE'
	AND NOT (imm.immunization_desc ~ '.*LEUCOVORIN.*|.*DESCOVY.*') 
)
and (imm.immunization_date > '2020-12-10'))
DISTRIBUTED BY (ptid);

----------Table for 1st dose by patient--------------
create table g823429.sns_cov_vacc_1st_dose_0916 as(
SELECT 
	imm.ptid, min(imm.immunization_date) as first_dose_date, 1 as dose_num, string_agg(imm.immunization_desc, '||') as first_dose_desc,
	string_agg(imm.mapped_name, '||') as first_dose_mapped_name, min(imm.ndc) as first_dose_ndc,
	min(imm.sourceid) as first_dose_sourceid
FROM g823429.sns_cov_vaccines_0916 imm
	inner join (
		select ptid, min(immunization_date) as first_dose_date
		from g823429.sns_cov_vaccines_0916 
		group by ptid) imm_sub
	on imm_sub.ptid = imm.ptid
	where imm_sub.first_dose_date = imm.immunization_date
group by imm.ptid)
DISTRIBUTED BY (ptid);
		
----------Table to add 2nd Dose--------------
/*Note: Either last vaccine dose OR closest 2nd dose >14d (current choice)
-- select all doses that are >14d from current dose and groupby ptid to get min imm date
--Select from all vaccines and join with 1st vaccine dose on pt id where dose time >14 days from current imm dose and group by ptid taking min 
*/
drop table g823429.sns_cov_vacc_2nd_dose_0916

create table g823429.sns_cov_vacc_2nd_dose_0916 as (
select 
	all_imm.ptid, min(all_imm.immunization_date) as second_dose_date, 2 as dose_num, string_agg(all_imm.immunization_desc, '||') as second_dose_desc,
	string_agg(all_imm.mapped_name, '||') as second_dose_mapped_name, min(all_imm.ndc) as second_dose_ndc,
	min(all_imm.sourceid) as second_dose_sourceid
from g823429.sns_cov_vaccines_0916 all_imm
right outer join g823429.sns_cov_vacc_1st_dose_0916 imm_1st on imm_1st.ptid = all_imm.ptid 
where ((all_imm.immunization_date - imm_1st.first_dose_date) > 14)-- and ((all_imm.immunization_date - imm_1st.first_dose_date) < 40)
group by all_imm.ptid)
DISTRIBUTED BY (ptid);

----------Table for both doses--------------

create table g823429.sns_cov_vacc_by_pt_0916 as(
select vacc_1st.ptid, vacc_1st.first_dose_date, vacc_1st.first_dose_desc, vacc_2nd.second_dose_date, vacc_2nd.dose_num, vacc_2nd.second_dose_desc,
	vacc_1st.first_dose_mapped_name, vacc_1st.first_dose_ndc, vacc_1st.first_dose_sourceid, vacc_2nd.second_dose_mapped_name, vacc_2nd.second_dose_ndc, vacc_2nd.second_dose_sourceid 
from g823429.sns_cov_vacc_1st_dose_0916 vacc_1st
left outer join g823429.sns_cov_vacc_2nd_dose_0916 vacc_2nd on vacc_1st.ptid = vacc_2nd.ptid) DISTRIBUTED BY (ptid);

