
----------Restrict to only COVID PCR + for earliest lab--------------
-- Variations used to determine PCR or Ag pos or all labs
create table g823429.sns_covpos_earliestpcrorag_0916 as (
SELECT dateGrabber.ptid, MIN(dateGrabber.labDate) as labDate, min(dateGrabber.test_name) as testName, min(dateGrabber.test_result) as testResult
FROM (
SELECT ptid, labs.test_name, labs.test_result, 
	CASE
		WHEN order_date IS NOT NULL THEN order_date
		WHEN collected_date IS NOT NULL THEN collected_date
		ELSE result_date
	END AS labDate
--	lab_date
FROM opt_20210916.lab labs
WHERE (
	(( --valid test code for PCR only!!!
		test_code = '94534-5' OR test_code = '94500-6'
		OR test_code = '94509-7' OR test_code = '94510-5' OR test_code = '94308-4'
		OR test_code = '94309-2' OR test_code = '94311-8' OR test_code = '94312-6' OR test_code = '94314-2'
		OR test_code = '94315-9' OR test_code = '94316-7' OR test_code = '94533-7' OR test_code = '94531-1'
		OR test_code = '94565-9' OR test_code = '94307-6' OR test_code = '94559-2' OR test_code = '94306-8'
		OR test_code = '94511-3' or test_code = '94558-4'  ----Ag only
	)
	or 
	( --valid test name
--		test_name = '2019 coronavirus sars-cov-2 aa' OR
		test_name = '2019 coronavirus sars-cov-2 rapid' OR----
--		test_name = '2019 coronavirus sars-cov-2 so [amg-]' OR
		test_name = '2019 novel coronavirus by pcr' OR
--		test_name = '2019 novel coronavirus pcr source' OR
		test_name = '2019 novel coronavirus rna' OR
--		test_name = 'SARS coronavirus 2 Ab' OR
--		test_name = 'SARS coronavirus 2 Ab.IgA' OR
--		test_name = 'SARS coronavirus 2 Ab.IgG' OR
--		test_name = 'SARS coronavirus 2 Ab.IgM' OR
		test_name = 'SARS coronavirus 2 RNA' OR
		test_name = 'SARS coronavirus 2 RNA (COVID-19).oral' OR
		test_name = 'SARS coronavirus 2 RNA (COVID-19).respiratory' OR
		test_name = 'SARS coronavirus 2 RNA (COVID-19).unspecified specimen' OR
		test_name = 'SARS coronavirus 2 RdRp gene' OR
--		test_name = 'SARS coronavirus 2 antibody (COVID-19)' OR
--		test_name = 'SARS coronavirus 2 antibody.IgA (COVID-19)' OR
--		test_name = 'SARS coronavirus 2 antibody.IgG (COVID-19)' OR
--		test_name = 'SARS coronavirus 2 antibody.IgG + IgM (COVID-19)' OR
--		test_name = 'SARS coronavirus 2 antibody.IgM (COVID-19)' OR
		test_name = 'SARS coronavirus 2 antigen (COVID-19).respiratory' OR----
--		test_name = 'amb influenza a by rapid immunoassay (sof covid/flu)' OR
--		test_name = 'amb influenza b by rapid immunoassay (sof covid/flu)' OR
		test_name = 'amb molecular covid' OR----
		test_name = 'amb sars-cov-2 ag by rapid immunoassay (binax covid)' OR----
		test_name = 'amb sars-cov-2 ag by rapid immunoassay (sof covid)' OR----
--		test_name = 'anti-cov-2 interpretation igm' OR
--		test_name = 'anti-sars-cov-2 coi' OR
--		test_name = 'anti-sars-cov-2 igg' OR
--		test_name = 'anti-sars-cov-2 interp' OR
		test_name = 'ccirh rapid covid-19' OR----
		test_name = 'coronavirus' OR
		test_name = 'coronavirus (covid-19) iu health' OR
		test_name = 'coronavirus (covid19) csh-nrl' OR
		test_name = 'coronavirus (seasonal)' OR
		test_name = 'coronavirus by pcr mmc' OR
		test_name = 'coronavirus sars-cov2 pcr ql' OR
		test_name = 'coronavirus sars-cov2 pcr ql iu' OR
		test_name = 'coronavirus sars-cov2 rapid' OR----
		test_name = 'coronavirus(bal)' OR
		test_name = 'coronavirus(sputum)' OR
		test_name = 'coronavirus.' OR
		test_name = 'cov 2 specimen type' OR
--		test_name = 'cov-2 antibody; igm' OR
--		test_name = 'cov19 source' OR
--		test_name = 'cov2 control valid?' OR
		test_name = 'covid' OR
		test_name = 'covid (sars) antigen fia' OR----
		test_name = 'covid - 19' OR
		test_name = 'covid 19' OR
--		test_name = 'covid 19 antibodies' OR
		test_name = 'covid 19 by pcr' OR
		test_name = 'covid 19 iu' OR
		test_name = 'covid 19 rapid test' OR----
		test_name = 'covid 19 result' OR
		test_name = 'covid 19 result ext' OR
		test_name = 'covid 19 result np ext' OR
		test_name = 'covid 19 sars cov-2' OR
		test_name = 'covid 19 screening test' OR----
--		test_name = 'covid 19 source iu' OR
--		test_name = 'covid 19 source np' OR
--		test_name = 'covid 19 source op' OR
		test_name = 'covid 19 spec source-iuh' OR
		test_name = 'covid 19 specimen source' OR
		test_name = 'covid 19 test request' OR
		test_name = 'covid ag binax now' OR----
--		test_name = 'covid antibody' OR
		test_name = 'covid comment' OR
--		test_name = 'covid convalescent plasma (products)' OR
		test_name = 'covid criteria' OR
		test_name = 'covid cut off index' OR
--		test_name = 'covid ethnicity' OR
		test_name = 'covid ffp ready' OR
--		test_name = 'covid igg' OR
--		test_name = 'covid method summary' OR
		test_name = 'covid nasal swab' OR
--		test_name = 'covid race' OR
		test_name = 'covid rapid antigen' OR----
		test_name = 'covid sars' OR
		test_name = 'covid source' OR
		test_name = 'covid test' OR
		test_name = 'covid total' OR
		test_name = 'covid-19' OR
		test_name = 'covid-19 (sars-cov-2) by rt-pcr (luminex)' OR
		test_name = 'covid-19 (sars-cov-2) by rt-pcr - sendout' OR
		test_name = 'covid-19 - shl' OR
		test_name = 'covid-19 adm asymptomatic' OR
--		test_name = 'covid-19 antibodies; total (serum) - imh' OR
		test_name = 'covid-19 antigen-milford' OR----
		test_name = 'covid-19 antigen-milford-covag' OR----
		test_name = 'covid-19 antigen-milford-covid19ag' OR----
		test_name = 'covid-19 antigen; poc' OR----
--		test_name = 'covid-19 convalescent plasma' OR
--		test_name = 'covid-19 convalescent plasma donor - immunity screening (doh)' OR
		test_name = 'covid-19 coronavirus (sars-cov-2)' OR
--		test_name = 'covid-19 hyer' OR
--		test_name = 'covid-19 igg' OR
--		test_name = 'covid-19 igg ab' OR
--		test_name = 'covid-19 igg; qualitative' OR
--		test_name = 'covid-19 igm qualitative' OR
		test_name = 'covid-19 mich dept community health' OR
		test_name = 'covid-19 misc (outside organization) ext' OR
		test_name = 'covid-19 naa ref lab' OR
		test_name = 'covid-19 outside labs (enter/edit)' OR
		test_name = 'covid-19 part of combo' OR
		test_name = 'covid-19 part of combo 3' OR
		test_name = 'covid-19 pat' OR
		test_name = 'covid-19 pcr' OR
		test_name = 'covid-19 pcr; nasopharynx' OR
		test_name = 'covid-19 pt. symptomatic (outside organization) ext' OR
		test_name = 'covid-19 rapid ag' OR----
		test_name = 'covid-19 rapid pcr-milford' OR
		test_name = 'covid-19 rna (sars-cov-2)' OR
		test_name = 'covid-19 rna (sars-cov-2); ql; rrt-pcr; respiratory specimen' OR
		test_name = 'covid-19 rna (sars-cov-2); ql; rrt-pcr; respiratory specimen_results' OR
		test_name = 'covid-19 rt' OR
		test_name = 'covid-19 rt-pcr' OR
		test_name = 'covid-19 rt-pcr sars-cov-2' OR
		test_name = 'covid-19 sars' OR
		test_name = 'covid-19 sars-cov-2' OR
		test_name = 'covid-19 sars-cov2 tma' OR
		test_name = 'covid-19 sars-cov2/rt pcr' OR
		test_name = 'covid-19 sars-vov-2-rt-pct (state lab)' OR
		test_name = 'covid-19 scanned report' OR
--		test_name = 'covid-19 source' OR
--		test_name = 'covid-19 source (outside organization) ext' OR
--		test_name = 'covid-19 specimen source' OR
		test_name = 'covid-19 test' OR
--		test_name = 'covid-19 total antibodies suboptimal' OR
		test_name = 'covid-19;influenza a/b comment' OR
		test_name = 'covid-19;influenza a/b rsv comment' OR
		test_name = 'covid19' OR
		test_name = 'covid19 (sars-cov-2 rna)poc' OR
--		test_name = 'covid19 igg ab' OR
--		test_name = 'covid19 patient symptomatic?' OR
		test_name = 'covid19 poc uc 2' OR
		test_name = 'covid19-rml' OR
--		test_name = 'covid19-source' OR
		test_name = 'covid19; sars-cov-2 (id now)' OR
		test_name = 'covid19rna (sars rna)' OR
--		test_name = 'diasorin sars cov-2 (covid-19) igg ab lc' OR
--		test_name = 'diasorin sars-cov-2 ab; igg' OR
--		test_name = 'euroimmun sars-cov-2 ab; igg' OR
--		test_name = 'euroimmun sars-cov-2; igg' OR
--		test_name = 'ext - sars cov 2 antibody igg' OR
--		test_name = 'ext-sars cov-2 source' OR
		test_name = 'external coronavirus sars-cov-2' OR
--		test_name = 'external lab sars-cov-2 ab igg' OR
--		test_name = 'external lab sars-cov-2 source' OR
		test_name = 'external poct sars cov 2 veritor' OR
		test_name = 'external sars cov 2' OR
--		test_name = 'first test for covid-19?' OR
--		test_name = 'florida access med covid billing' OR
--		test_name = 'hospitalized due to covid-19' OR
--		test_name = 'hospitalized due to covid-19?' OR
--		test_name = 'hospitalized for covid-19?' OR
--		test_name = 'hrh sars-cov-2 igg' OR
--		test_name = 'hrh sars-cov-2 total ab' OR
--		test_name = 'icu for covid?' OR
--		test_name = 'icu patient for covid-19?' OR
		test_name = 'id now covid' OR----
		test_name = 'lab sars-cov-2 assay result' OR
--		test_name = 'lab52213 first test for covid-19?' OR
--		test_name = 'lab52213 hospitalized for covid-19?' OR
--		test_name = 'lab52213 icu patient for covid-19?' OR
--		test_name = 'lab5491 first test for covid-19?' OR
--		test_name = 'lab5491 hospitalized for covid-19?' OR
--		test_name = 'lab5491 icu patient for covid-19?' OR
--		test_name = 'lab5493 first test for covid-19?' OR
--		test_name = 'lab5493 hospitalized for covid-19?' OR
--		test_name = 'lab5493 icu patient for covid-19?' OR
--		test_name = 'lab5494 first test for covid-19?' OR
--		test_name = 'lab5494 hospitalized for covid-19?' OR
--		test_name = 'lab5494 icu patient for covid-19?' OR
		test_name = 'lumiradix sars-cov-2 ag test' OR----
		test_name = 'me-sars coronavirus 2 ag' OR----
--		test_name = 'me-sars-cov-2 ag' OR
		test_name = 'novel coronavirus result' OR
--		test_name = 'other reaction to covid-19 vaccination' OR
--		test_name = 'other sars-cov-2 source' OR
		test_name = 'panel sars - cov-2' OR
--		test_name = 'pco2 ; temp corrected ; arterial' OR
--		test_name = 'poc covid source' OR
		test_name = 'poc covid-19 (sars cov-2) virus' OR
--		test_name = 'poc covid-19 external control' OR
--		test_name = 'poc covid-19 internal control acceptable' OR
--		test_name = 'poc covid-19 lot number' OR
		test_name = 'poc covid-19 pcr' OR
		test_name = 'poc rapid covid-19 result' OR
--		test_name = 'poc rapid covid-19 test performed by' OR
		test_name = 'poc sars-cov-2' OR
--		test_name = 'poc sars-cov-2 lot#' OR
		test_name = 'poc sars-cov-2 rna' OR
--		test_name = 'poc sars-cov-2 run ok' OR
		test_name = 'poct coronavirus' OR
--		test_name = 'previously tested for covid-19?' OR
		test_name = 'rapid covid-19 naa' OR
		test_name = 'rapid influenza virus a + b and sars cov + sars cov 2 ag panel; ia; upper respiratory specimen' OR----
		test_name = 'rapid sars cov 2 ag; ql ia; respiratory specimen_control' OR----
		test_name = 'rapid sars cov 2 ag; ql ia; respiratory specimen_coronavirus 2 (sars-cov-2)nasal swab' OR----
		test_name = 'rapid sars cov 2 ag; ql ia; respiratory specimen_result' OR----
		test_name = 'rapid sars cov2 antigen fia' OR----
		test_name = 'sar cov-2' OR
		test_name = 'sar- cov-2 rna' OR
		test_name = 'sars - cov-2' OR
		test_name = 'sars coronavirus 2 ag' OR----
		test_name = 'sars coronavirus 2 ag  ext' OR----
		test_name = 'sars coronavirus ag' OR----
		test_name = 'sars cov 2' OR
--		test_name = 'sars cov 2 ab (igg) spike; semi qn' OR
--		test_name = 'sars cov 2 ab igg' OR
		test_name = 'sars cov 2 antigen' OR----
		test_name = 'sars cov 2 antigen test' OR----
		test_name = 'sars cov 2 by naa' OR
		test_name = 'sars cov 2 by pcr' OR
--		test_name = 'sars cov 2 igg' OR
--		test_name = 'sars cov 2 igg ab interpretation' OR
--		test_name = 'sars cov 2 igm' OR
		test_name = 'sars cov 2 patient' OR
		test_name = 'sars cov 2 pcr' OR
		test_name = 'sars cov 2 result' OR
		test_name = 'sars cov 2 rna' OR
		test_name = 'sars cov 2 rna (covid-19); ql; rrt-pcr; respiratory specimen_results' OR
		test_name = 'sars cov 2 rna pcr-cobas liat-bfh' OR
		test_name = 'sars cov 2 rna(covid 19); qualitative naat - quest' OR
		test_name = 'sars cov 2 rna; rt pcr ext' OR
--		test_name = 'sars cov 2 source' OR
--		test_name = 'sars cov 2 source (crona2)' OR
--		test_name = 'sars cov 2 source (crona2) ext' OR
--		test_name = 'sars cov 2 source ext' OR
		test_name = 'sars cov cov2 ag' OR----
		test_name = 'sars cov-2' OR
		test_name = 'sars cov-2 (back office)' OR
--		test_name = 'sars cov-2 igm/igg total ab' OR
		test_name = 'sars cov-2 rna' OR
		test_name = 'sars cov-2 rna naa-milford' OR
		test_name = 'sars cov-2; sample type' OR
		test_name = 'sars covid' OR
		test_name = 'sars covid 2' OR
--		test_name = 'sars covid 2 antibodies' OR
		test_name = 'sars covid-19' OR
		test_name = 'sars covid2' OR
		test_name = 'sars specimen type' OR
--		test_name = 'sars-cov 2 igg' OR
		test_name = 'sars-cov-2' OR
--		test_name = 'sars-cov-2 (covid-19) ag' OR
--		test_name = 'sars-cov-2 (covid-19) anti-spike; interp' OR
--		test_name = 'sars-cov-2 (covid-19) anti-spike; tot ab' OR
--		test_name = 'sars-cov-2 (covid-19) igg abs' OR
		test_name = 'sars-cov-2 (covid-19) interpretation' OR
		test_name = 'sars-cov-2 (covid-19) interpretation  ext' OR
		test_name = 'sars-cov-2 (covid-19) pcr routine covid' OR
		test_name = 'sars-cov-2 (covid-19)ag(bd veritor) poct' OR----
		test_name = 'sars-cov-2 (rt-pcr)' OR
--		test_name = 'sars-cov-2 abs semi-quant' OR
		test_name = 'sars-cov-2 ag' OR----
		test_name = 'sars-cov-2 ag by rapid immunoassay' OR----
--		test_name = 'sars-cov-2 anti-nucleocapsid interp' OR
--		test_name = 'sars-cov-2 antibodies' OR
--		test_name = 'sars-cov-2 antibodies; spike' OR
--		test_name = 'sars-cov-2 antibody; iga ext' OR
--		test_name = 'sars-cov-2 antibody; igg' OR
--		test_name = 'sars-cov-2 antibody; igm' OR
		test_name = 'sars-cov-2 antigen' OR----
		test_name = 'sars-cov-2 by naa' OR
		test_name = 'sars-cov-2 by naa-arp-3002640' OR
		test_name = 'sars-cov-2 by naat (pcr;tma)' OR
		test_name = 'sars-cov-2 by pcr' OR
		test_name = 'sars-cov-2 by pcr  ext' OR
		test_name = 'sars-cov-2 by pcr ext' OR
		test_name = 'sars-cov-2 comment' OR
		test_name = 'sars-cov-2 ext' OR
--		test_name = 'sars-cov-2 igg' OR
--		test_name = 'sars-cov-2 igm' OR
--		test_name = 'sars-cov-2 igm qual ext' OR
		test_name = 'sars-cov-2 interp' OR
		test_name = 'sars-cov-2 interp  ext' OR
		test_name = 'sars-cov-2 method summary' OR
		test_name = 'sars-cov-2 naa (covid19)' OR
		test_name = 'sars-cov-2 nucleic acid' OR
		test_name = 'sars-cov-2 pcr' OR
		test_name = 'sars-cov-2 pcr  ext' OR
		test_name = 'sars-cov-2 pcr (cvs) ext' OR
		test_name = 'sars-cov-2 pcr ext' OR
		test_name = 'sars-cov-2 pcr nasopharyngeal swab' OR
		test_name = 'sars-cov-2 pcrl' OR
		test_name = 'sars-cov-2 rna' OR
		test_name = 'sars-cov-2 rna (covid-19); qualitative naat' OR
		test_name = 'sars-cov-2 rna (taqpath)' OR
		test_name = 'sars-cov-2 rna;  ext' OR
		test_name = 'sars-cov-2 rna; (tempus) ext' OR
		test_name = 'sars-cov-2 rna; rt-pcr  ext' OR
		test_name = 'sars-cov-2 rna; rt-pcr (quest) ext' OR
		test_name = 'sars-cov-2 rt-pcr' OR
--		test_name = 'sars-cov-2 semi-quant total ab' OR
--		test_name = 'sars-cov-2 source' OR
--		test_name = 'sars-cov-2 source  ext' OR
--		test_name = 'sars-cov-2 source ext' OR
--		test_name = 'sars-cov-2 source-arp-3002639' OR
--		test_name = 'sars-cov-2 specimen source' OR
--		test_name = 'sars-cov-2 specimen source (aspirus)ext' OR
--		test_name = 'sars-cov-2 specimen source (osf) ext' OR
--		test_name = 'sars-cov-2 specimen source ext' OR
--		test_name = 'sars-cov-2 spike (s) abs interp.' OR
		test_name = 'sars-cov-2 target 1 cycle threshold' OR
		test_name = 'sars-cov-2 target 2 cycle threshold' OR
--		test_name = 'sars-cov-2 total antibody' OR
		test_name = 'sars-cov-2 xpress' OR
		test_name = 'sars-cov-2; naa' OR
		test_name = 'sars-cov-2; naa  ext' OR
		test_name = 'sars-cov-2; naa (covid-19) lc' OR
		test_name = 'sars-cov-2; naa (quest) ext' OR
		test_name = 'sars-cov-2; naa ext' OR
		test_name = 'sars-cov-2; naa lab site' OR
		test_name = 'sars-cov-2; naa sb' OR
		test_name = 'sars-cov-2; naa source' OR
		test_name = 'sars-cov-2; naa source sb' OR
		test_name = 'sars-cov-2; naa; source-lcp' OR
		test_name = 'sars-cov-2; pcr' OR
		test_name = 'sars-cov-2; tma  ext' OR
		test_name = 'sars-cov-2;naa ext' OR
		test_name = 'sars-cov2' OR
		test_name = 'sars-cov2 (covid-19) qualitative pcr ext' OR
		test_name = 'sars-cov2 antigen' OR----
		test_name = 'sars-cov2/covid-19' OR
		test_name = 'sars-cov2; naa' OR
		test_name = 'sars-covid ag (bkr)' OR----
		test_name = 'sarscov2' OR
		test_name = 'sarscov2 ic result' OR
		test_name = 'sarscov2 interp' OR
--		test_name = 'sarscov2 source' OR
--		test_name = 'source sars-cov-2' OR
--		test_name = 'spec type covid-19' OR
--		test_name = 'spec.source(covid)' OR
--		test_name = 'viracor - sars-cov-2 igg' OR
--		test_name = 'viracor - sars-cov-2 igm' OR
		test_name = 'weland sars-cov 2 rna' OR
		test_name = 'zsarscov2-milford'
	)
	) 
	AND ( --valid test result
	(test_result ~ '^([0-9]*(\.)[0-9]+|[0-9]+)$' AND test_result != '0') OR
		test_result = '+' OR
		test_result = '/+' OR
		test_result = 'all target results were valid. result for sars-cov-2 rna is detected.' OR
		test_result = 'antibody test positive' OR
		test_result = 'c dectected' OR
		test_result = 'c detected' OR
		test_result = 'children receiving care in and staff working in childcare homes and childcare centers with fever or respiratory symptoms (e.g.; cough; difficulty breathing) without alternative diagnosis' OR
		test_result = 'colvid' OR
		test_result = 'coronavirus detected by pcr' OR
		test_result = 'cov19rapid positive' OR
		test_result = 'covid' OR
		test_result = 'covid detected' OR
		test_result = 'covid presumptive positive' OR
		test_result = 'covid-19' OR
		test_result = 'covid-19 pos' OR
		test_result = 'covid-19 posit' OR
		test_result = 'covid-19 recovered: this result indicates that more than 28 days have passed since a positive test and aligns with state guidelines regarding tracking recovered patients.' OR
		test_result = 'covid19' OR
		test_result = 'covid2019' OR
		test_result = 'cp' OR
		test_result = 'dectected' OR
		test_result = 'dected' OR
		test_result = 'detected' OR
		test_result = 'detected - see scanned report' OR
		test_result = 'detected abnormal' OR
		test_result = 'detected or positive' OR
		test_result = 'detected*' OR
		test_result = 'detected..' OR
		test_result = 'detected: see scanned report for more information' OR
		test_result = 'detected; see scanned rep' OR
		test_result = 'detected; see scanned report' OR
		test_result = 'detected^^^^' OR
		test_result = 'detected^detected' OR
		test_result = 'detecteda' OR
		test_result = 'p' OR
		test_result = 'pos' OR
		test_result = 'positive' OR
		test_result = 'positive (a)' OR
		test_result = 'positive / detected' OR
		test_result = 'positive 2019-ncov' OR
		test_result = 'positive a' OR
		test_result = 'positive abnormal' OR
		test_result = 'positive by single pan sars-cov target. sars-cov-1 cannot be excluded; but it is not currently circulating in north america.' OR
		test_result = 'positive for 2019-ncov' OR
		test_result = 'positive for covid-19' OR
		test_result = 'positive for covid-19 (sars cov2) by pcr' OR
		test_result = 'positive for covid-19 (sars-cov2) by pcr' OR
		test_result = 'positive for covid19 (sars cov2) by pcr' OR
		test_result = 'positive for covid19 (sars cov2) by pcr.' OR
		test_result = 'positive for covid19 (sars cov2) by pcr.(*)' OR
		test_result = 'positive/reactive' OR
		test_result = 'positivef' OR
		test_result = 'postive' OR
		test_result = 'preliminary positive' OR
		test_result = 'preschool / k12 students and staff with fever or respiratory symptoms (e.g.; cough; difficulty breathing) without alternative diagnosis' OR
		test_result = 'present' OR
		test_result = 'presum pos' OR
		test_result = 'presumptive pos' OR
		test_result = 'presumptive pos. for 2019-ncov' OR
		test_result = 'presumptive positive' OR
		test_result = 'presumptive positive for 2019-ncov' OR
		test_result = 'presumptive positive; see scanned report' OR
		test_result = 'quest covid19' OR
		test_result = 'reactive' OR
		test_result = 'rn rbv covid pos 041620 @ 2321' OR
		test_result = 'sar' OR
		test_result = 'sars' OR
		test_result = 'sars-cov-2 (agent of covid-19) detected by pcr' OR
		test_result = 'sars-cov-2 (agent of covid-19) detected by pcr.' OR
		test_result = 'sars-cov-2 detected' OR
		test_result = 'sars-cov-2 interp' OR
		test_result = 'sars-cov-2 positive' OR
		test_result = 'sars-cov-2 rna detected' OR
		test_result = 'sars-cov-2 target nucleic acids are detected.' OR
		test_result = 'sarscov2 interp' OR
		test_result = 'see scanned document- detected' OR
		test_result = 'suspect' OR
		test_result = 'suspectr' OR
		test_result = 'symptomatic or suspected covid; 19' OR
		test_result = 'university / college students and staff with fever or respiratory symptoms (e.g.; cough; difficulty breathing) without alternative diagnosis' OR
		test_result = 'warning: while a reactive result suggest possible recent or prior infection with sars-cov-2:' OR
		test_result = 'y' OR
		test_result = 'yes' OR
		test_result = 'yes.' 
	)
	and labs.result_date > '2020-12-10'
--	and labs.result_date <= '2021-03-01'
)
) AS dateGrabber 
GROUP BY dateGrabber.ptid
)distributed by (ptid);

/** Get all the ptids of people who had a covid positive diagnosis. Requires a self-join**/
/** Count: 547,344 **/
create table g823429.sns_ptids_covposdiag_0916 as(
SELECT DISTINCT(ptid) FROM ( 
	SELECT DISTINCT a.ptid, a.diagnosis_cd AS codeOne, b.diagnosis_cd AS codeTwo, a.diag_date, b.diag_date
	FROM opt_20210916.diag a 
	LEFT JOIN opt_20210916.diag b 
	ON a.ptid = b.ptid
	WHERE
	--double diagnosis
	(a.diag_date >= '2/20/20'::date AND b.diag_date >= '2/20/20'::date AND 
		(a.diagnosis_cd = 'B9729' AND
			(b.diagnosis_cd = 'J1289' OR b.diagnosis_cd = 'J208' 
			OR b.diagnosis_cd = 'J22' OR b.diagnosis_cd = 'J40' OR
			b.diagnosis_cd = 'J988' OR b.diagnosis_cd ='J80')
		)
	)
	OR --or, single diagnosis
	(a.diag_date >= '2/1/20'::date AND a.diagnosis_cd = 'U071')
) AS innerquery)
distributed by (ptid);

--Earliest COVID Diagnosis--
create table g823429.sns_covpos_earliestdiag_0916 as (
SELECT d.ptid, MIN(d.diag_date) as earliestdiag
FROM opt_20210916.diag d 
JOIN g823429.sns_ptids_covposdiag_0916 cov_d
ON d.ptid = cov_d.ptid
WHERE 
	--d.ptid = 'PT201619087' AND --dont worry about comorbidities.
	(	
		( d.diag_date >= '2/1/20'::date AND d.diagnosis_cd = 'U071') 
		OR
		( d.diag_date >= '2/20/20'::date AND d.diagnosis_cd = 'B9729')
	)
GROUP BY (d.ptid))
distributed by (ptid);


-- Earliest COVID lab or diagnosis--
create table g823429.sns_covpos_earliest_0916 as (
SELECT effectiveptid, earliestpos FROM (
	SELECT --find earliest cov+ date -- count: 644,562 (correct)
		CASE
			WHEN lab.ptid IS NULL THEN diag.ptid
			ELSE lab.ptid
		END AS effectivePTID,
		CASE
			WHEN diag.earliestdiag < lab.labdate THEN diag.earliestdiag
			WHEN lab.labdate <= diag.earliestdiag THEN lab.labdate
			WHEN lab.labdate IS NULL THEN diag.earliestdiag
			WHEN diag.earliestdiag IS NULL THEN lab.labdate
		END AS earliestPos, *
	FROM g823429.sns_covpos_earliestdiag_0916 diag 
	FULL OUTER JOIN g823429.covpos_earliestpcrorag_0916 lab
	ON diag.ptid = lab.ptid
) AS inner_table)
distributed by (ptid);

grant all on table g823429.sns_covpos_earliest_0916 to g823429;
grant all on table g823429.sns_covpos_earliestdiag_0916 to g823429;
grant all on table g823429.sns_covpos_earliestpcrorag_0916 to g823429;
