----start tables creation
/*
a few tables created #Pat_ID_PL, #Pat_ID_PL_2,  #Pat_ID_MH etc.. 
for pulling the diagnosis dated and getting the first noted 
of the disease. Because there are lots of dates, so we need to put together
to get the fist date

*/

Create Table #Epic_Consults
(
	Pat_ID varchar(10),
	Pat_Enc_CSN_ID varchar(10),
	Pat_Name varchar(250),
	[MRN] varchar(10),
	Hosp_Admission_Date datetime,
	Hosp_Discharge_Date datetime,
	EAP_Procedure varchar(250),
	Proc_Code varchar(10),
	Group_Number varchar(10),
	Order_Date_WT Datetime,
	Order_Date Datetime,
	Order_time varchar(50),
	Day_of_Week varchar(50)
	
)


Create  Table #Epic_Consults_2
(
	Pat_ID varchar(10),
	Pat_Enc_CSN_ID varchar(10),
	Pat_Name varchar(250),
	[MRN] varchar(10),
	Hosp_Admission_Date datetime,
	Hosp_Discharge_Date datetime,
	EAP_Procedure varchar(250),
	Proc_Code varchar(10),
	Group_Number varchar(10),
	Order_Date Datetime,
	Day_of_Week varchar(50),
	Team_audit_ID int,
	Provider_team varchar(250),
	Primary_Team_YN char(1),
	Specialty varchar(250),
	Team_Audit_Instant datetime
		
)

Create Table  #Epic_Consults_3
(
	Pat_ID varchar(10),
	Pat_Enc_CSN_ID varchar(10),
	Pat_Name varchar(250),
	[MRN] varchar(10),
	Hosp_Admission_Date datetime,
	Hosp_Discharge_Date datetime,
	EAP_Procedure varchar(250),
	Proc_Code varchar(10),
	Group_Number varchar(10),
	Order_Date Datetime,
	Day_of_Week varchar(50),
	Team_audit_ID int,
	Provider_team varchar(250),
	Primary_Team_YN char(1),
	Specialty varchar(250),
	Team_Audit_Instant datetime
	
)

Create Table #Pat_ID_PL
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[Noted_Date] datetime,
	[Date_of_Entry] datetime,
	[New_Noted_Date] datetime,
)


Create Table #Pat_ID_PL_2
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[New_Noted_Date] datetime

)


Create Table #Pat_ID_MH
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[Contact_Date] datetime,
	[Medical_Hx_Date] varchar(500),
	[Med_Hx_Start_Dt] datetime,
	[New_Medical_Hx_Date] datetime
)

Create Table #Pat_ID_MH_2
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[Med_Hx_Start_Dt] datetime,

)

Create Table #Pat_ID_MH_List
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[New_Medical_Hx_Date] datetime,

)

Create Table #Pat_IDs
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[Noted_Date] datetime
)

Create Table #Pat_ID_First_Date
(
	Pat_ID varchar(18),
	[Dx_Id] varchar(18),
	[Noted_Date] datetime
)

Create  Table #ProblemList
(	
	Pat_Id varchar(18),
	MRN varchar(18),
	[Order_Date] Datetime null,
	Noted_Date datetime,
	dx_id varchar(18),
	current_ICD9_List varchar(100),
	current_ICD10_List varchar(100),
	Disease_Group varchar(500),
	Diagnosis_name varchar(500),
	dtmdiff int

	)

CREATE Table #Comorbidities
(	
	[Pat_Id] varchar(18),
	--[Pat_First_Name] varchar(100),
	--[Pat_Last_Name] varchar(100),
	[Pat_Name] varchar(500),
	[HUP_MRN] varchar(200),
	ACS Char(10),
	AFib Char(10),
	Aortic_Aneurysm Char(10),
	CAD Char(10),
	Dyslipidemia Char(10),
	HF Char(10),
	HTN Char(10),
	Ischemic_Stroke Char(10),
	MI Char(10),
	PAD Char(10),
	Sec_Cardiomyopathy Char(10),
	Stable_Angina Char(10),
	Stroke Char(10),
	TIA Char(10),
	Unstable_Angina Char(10)

)

Create  Table #ED_Hosp_Visits
(	
	Pat_Id varchar(18),
	Pat_First_Name varchar(100),
	Pat_Last_Name varchar(100),
	[HUP_MRN] varchar(200),
	[Order_Date] Datetime null,
	Pat_Enc_CSN_ID varchar(200),
	HOSP_ADMSN_TIME datetime,
	HOSP_DISCH_TIME datetime,
	Enc_type varchar(500),
	dx_id varchar(18),
	current_ICD9_List varchar(100),
	current_ICD10_List varchar(100),
	contact_date datetime,
	Diagnosis_name varchar(500),
	PRIMARY_DX_YN char(1),
	dtmdiff int

	)


--pull the consult data into Temp table
INSERT into #Epic_Consults(Pat_ID,Pat_Enc_CSN_ID,Hosp_Admission_Date,Hosp_Discharge_Date,
							Proc_Code,EAP_Procedure,Order_Date_WT,Order_Date,Order_time,Day_of_Week)
select  
distinct
O.Pat_ID,
O.Pat_Enc_CSN_ID,
E.HOSP_ADMSN_TIME,
E.HOSP_DISCH_Time,
O.Proc_Code,
case when O.Proc_Code in ('Con509') then 'General Consults'
when O.Proc_Code in ('Con538') then 'Consultative Attendings'
when O.Proc_Code ='Con511' then 'Oncology Consults'
when O.Proc_Code ='Con540' then 'Carver Consults'
when O.Proc_Code ='Con541' then 'Ferrari Consults'
when O.Proc_Code ='Con542' then 'Jagasia Consults'
when O.Proc_Code ='Con543' then 'Silvestry Consults'
when O.Proc_Code ='Con544' then 'Simson Consults'
else 'unknown'
end as 'EAP_Procedure',
O.ORDER_TIME as Order_Date_WT,
CONVERT(varchar(10), O.ORDER_TIME, 101) as Order_Date, -- get date only,
Format(O.ORDER_TIME,'hh:mm:ss tt') as Order_Time,
DATENAME(dw,O.ORDER_TIME) as Day_of_the_Week -- day of the week
from PAT_ENC_HSP E inner join
Order_Proc O on (E.PAT_ID = O.PAT_ID and E.PAT_ENC_CSN_ID = O.PAT_ENC_CSN_ID)
where
O.PROC_CODE in ('Con509','Con538','Con511', 'Con540','Con541', 'Con542','Con543','Con544')
order by O.Pat_ID

--end consult data query 

Update  C
SET C.Pat_Name = P.Pat_Name
FROM #Epic_Consults  C INNER JOIN Patient P on C.Pat_Id = P.PAT_ID

Update  C
SET C.MRN = I.IDENTITY_ID
FROM #Epic_Consults  C INNER JOIN Identity_ID I on C.Pat_ID = I.PAT_ID
where I.IDENTITY_TYPE_ID = '100'
 
--Group Number
Update  E
SET E.Group_Number = 'Group 1'
from #Epic_Consults E 
where E.Proc_Code = 'CON509'

Update  E
SET E.Group_Number = 'Group 2'
from #Epic_Consults E 
where E.Proc_Code = 'CON538'

Update  E
SET E.Group_Number = 'Group 3'
from #Epic_Consults E 
where E.Proc_Code in ('CON511', 'CON540')

Update  E
SET E.Group_Number = 'Group 4'
from #Epic_Consults E 
where E.Proc_Code in ('CON541','CON542','CON543','CON544')


-- Get the Team info for those consults into a Temp table
INSERT INTO #Epic_Consults_2  (Pat_ID ,Pat_Enc_CSN_ID, Pat_Name,MRN,Hosp_Admission_Date,
Hosp_Discharge_Date ,EAP_Procedure ,Proc_Code ,Group_Number,
Order_Date,Day_of_Week,Team_audit_ID,Provider_team, 
Primary_Team_YN ,Specialty,Team_Audit_Instant)
select  distinct con.pat_ID, con.pat_enc_csn_ID,con.Pat_Name,
con.MRN,con.hosp_admission_Date,con.hosp_discharge_Date,
con.EAP_Procedure,con.Proc_Code,con.Group_number,
con.order_date,con.day_of_week,
aud.team_audit_id, 
--aud.line,
prov.display_name,aud.primaryteam_audi_YN,
spe.name, aud.Team_Audit_Instant
from EPT_team_Audit aud
inner join #Epic_Consults con on con.Pat_ID = aud.Pat_ID and con.Pat_Enc_CSN_ID = aud.Pat_Enc_CSN_ID  
inner join PROVTEAM_REC_INFO Rec on aud.team_audit_ID = Rec.ID
inner join ProviderTeam_Info Prov on prov.id = rec.id
inner join ZC_Specialty spe on Prov.team_specialty_C = spe.specialty_C
where rec.record_type_c = 1 -- 1 for provider team
and aud.team_action_c = 1 -- 1 for entry into the table
and Prov.Active_to_TM is null -- if the team is inactive then not considering it

--Final consult and team data by removing duplication of the same rows becuase of joining multiple tables
INSERT INTO #Epic_Consults_3  (Pat_ID ,Pat_Enc_CSN_ID, Pat_Name,MRN,Hosp_Admission_Date,
Hosp_Discharge_Date ,EAP_Procedure ,Proc_Code ,Group_Number,
Order_Date,Day_of_Week,Team_audit_ID,Provider_team, 
Primary_Team_YN ,Specialty,Team_Audit_Instant)
Select Pat_ID ,Pat_Enc_CSN_ID, Pat_Name,MRN,Hosp_Admission_Date,
Hosp_Discharge_Date ,EAP_Procedure ,Proc_Code ,Group_Number,
Order_Date ,Day_of_Week,Team_audit_ID,Provider_team, 
Primary_Team_YN ,Specialty,Team_Audit_Instant
from 
(
select T.Pat_ID ,T.Pat_Enc_CSN_ID, T.Pat_Name,T.MRN,T.Hosp_Admission_Date,
		T.Hosp_Discharge_Date,T.EAP_Procedure ,T.Proc_Code ,T.Group_Number,
		T.Order_Date ,T.Day_of_Week,T.Team_audit_ID,T.Provider_team, 
		T.Primary_Team_YN ,T.Specialty,T.Team_Audit_Instant,
		ROW_NUMBER() OVER (PARTITION BY T.PAT_ID, T.Team_audit_ID ORDER BY T.Team_Audit_Instant DESC) AS ROW_NUM
	from #Epic_Consults_2 T )Last_consult_date --where T.Noted_Date is not null
	where row_num = 1


  -- insert data from #Epic_Consults to Comorbidities table
INSERT INTO #Comorbidities(
	Pat_Id,
	Pat_Name,
	HUP_MRN
	)
select distinct
	Pat_Id,
	Pat_Name,
	MRN
from #Epic_Consults



--we need to do this for all comorbidities

--Start HF *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
		(
		 E.current_ICD9_List in
		  ('398.91','402.01','402.11','402.91','404.01','404.03','404.11','404.13','404.91','404.93','425.4',
		'425.5','425.7','425.8','425.9','428.0','428.1','428.2','428.21','428.22','428.23','428.3','428.31',
		'428.32','428.33','428.4','428.41','428.42','428.43','428.90')
		or 
		E.current_ICD10_List in
		('I50.9','I50.20','I50.40','I50.30','I50.32','I50.33','I50.810',
		'I50.31','I50.42','I50.81','I50.812','I50.82','I50.84','I50.1','I11.0',
		'I50.21','I50.23','I50.811','I50.22','I50.41','I50.43','I50.813',
		'I50.8','I50.814','I50.83','I50.90','II50.32','I50.2','I50.4',
		'I50','I51.7','I50.3','I50.89')

		)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
		 E.current_ICD9_List in
		  ('398.91','402.01','402.11','402.91','404.01','404.03','404.11','404.13','404.91','404.93','425.4',
		'425.5','425.7','425.8','425.9','428.0','428.1','428.2','428.21','428.22','428.23','428.3','428.31',
		'428.32','428.33','428.4','428.41','428.42','428.43','428.90')
		or 
		E.current_ICD10_List in
		('I50.9','I50.20','I50.40','I50.30','I50.32','I50.33','I50.810',
		'I50.31','I50.42','I50.81','I50.812','I50.82','I50.84','I50.1','I11.0',
		'I50.21','I50.23','I50.811','I50.22','I50.41','I50.43','I50.813',
		'I50.8','I50.814','I50.83','I50.90','II50.32','I50.2','I50.4',
		'I50','I51.7','I50.3','I50.89')

		)
		
		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
	
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('398.91','402.01','402.11','402.91','404.01','404.03','404.11','404.13','404.91','404.93','425.4',
		'425.5','425.7','425.8','425.9','428.0','428.1','428.2','428.21','428.22','428.23','428.3','428.31',
		'428.32','428.33','428.4','428.41','428.42','428.43','428.90')
		or 
		T.current_ICD10_List in
		('I50.9','I50.20','I50.40','I50.30','I50.32','I50.33','I50.810',
		'I50.31','I50.42','I50.81','I50.812','I50.82','I50.84','I50.1','I11.0',
		'I50.21','I50.23','I50.811','I50.22','I50.41','I50.43','I50.813',
		'I50.8','I50.814','I50.83','I50.90','II50.32','I50.2','I50.4',
		'I50','I51.7','I50.3','I50.89')

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('398.91','402.01','402.11','402.91','404.01','404.03','404.11','404.13','404.91','404.93','425.4',
		'425.5','425.7','425.8','425.9','428.0','428.1','428.2','428.21','428.22','428.23','428.3','428.31',
		'428.32','428.33','428.4','428.41','428.42','428.43','428.90')
		or 
		T.current_ICD10_List in
		('I50.9','I50.20','I50.40','I50.30','I50.32','I50.33','I50.810',
		'I50.31','I50.42','I50.81','I50.812','I50.82','I50.84','I50.1','I11.0',
		'I50.21','I50.23','I50.811','I50.22','I50.41','I50.43','I50.813',
		'I50.8','I50.814','I50.83','I50.90','II50.32','I50.2','I50.4',
		'I50','I51.7','I50.3','I50.89')

		)

--End Step 5

--End HF **************************


--Start CAD *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
		(
		 E.current_ICD9_List in
		('410.0','410.00','410.01','410.02','410.1','410.10','410.11','410.11','410.12','410.20','410.21','410.22',
		'410.30','410.31','410.32','410.40','410.41','410.42','410.50','410.51','410.52','410.60','410.61','410.62',
		'410.70','410.71','410.72','410.80','410.81','410.82','410.90','410.91','410.92','411.0','411.1','411.89',
		'412','413','413.0','413.1','413.9','414','414.01','414.02','414.03','414.04','414.05','414.06','414.07',
		'414.10','414.11','414.12','414.19','414.2','414.3','414.4','414.8','414.9' )
		or 
		E.current_ICD10_List in
		('I20.9','I20','I20.0','I20.1','I20.8','I21','I21.0','I21.01','I21.02','I21.09',
		'I21.29','I21.1','I21.11','I21.19','I21.2','I21.21','I23.6','I21.3','I21.4',
		'I21.9','I21.A','I21.A1','I21.A9','I23.8','I25.9','I25.9 ','I51.3','I22',
		'I22.0','I22.1','I22.2','I22.8','I22.9','I23','I23.0','I23.1','I23.2','I23.3','I23.4','I23.5',
		'I23.7','I24.1','I25.810','I25','I25.1','I25.10','I25.10 ','I25.2','I25.82','I25.83',
		'I25.84','I25.11','I25.110','I25.111','I25.118','I25.119','I25.3','I25.4','I25.41',
		'I25.42','I25.5','I25.6','I25.7','I25.70','I25.700','I25.701','I25.708','I25.709''I25.71',
		'I25.710','I25.711','I25.718','I25.719','I25.72','I25.720','I25.721','I25.728','I25.729',
		'I25.73','I25.730','I25.731','I25.738','I25.739','I25.75','I25.750','I25.751','I25.758',
		'I25.759','I25.76','I25.760','I25.761','I25.768','I25.769','I25.79','I25.790','I25.791',
		'I25.798','I25.799','I25.8','I25.81','I25.811','I25.812','I25.89','I50.32','I50.33')
		)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
		(
		 E.current_ICD9_List in
		('410.0','410.00','410.01','410.02','410.1','410.10','410.11','410.11','410.12','410.20','410.21','410.22',
		'410.30','410.31','410.32','410.40','410.41','410.42','410.50','410.51','410.52','410.60','410.61','410.62',
		'410.70','410.71','410.72','410.80','410.81','410.82','410.90','410.91','410.92','411.0','411.1','411.89',
		'412','413','413.0','413.1','413.9','414','414.01','414.02','414.03','414.04','414.05','414.06','414.07',
		'414.10','414.11','414.12','414.19','414.2','414.3','414.4','414.8','414.9' )
		or 
		E.current_ICD10_List in
		('I20.9','I20','I20.0','I20.1','I20.8','I21','I21.0','I21.01','I21.02','I21.09',
		'I21.29','I21.1','I21.11','I21.19','I21.2','I21.21','I23.6','I21.3','I21.4',
		'I21.9','I21.A','I21.A1','I21.A9','I23.8','I25.9','I25.9 ','I51.3','I22',
		'I22.0','I22.1','I22.2','I22.8','I22.9','I23','I23.0','I23.1','I23.2','I23.3','I23.4','I23.5',
		'I23.7','I24.1','I25.810','I25','I25.1','I25.10','I25.10 ','I25.2','I25.82','I25.83',
		'I25.84','I25.11','I25.110','I25.111','I25.118','I25.119','I25.3','I25.4','I25.41',
		'I25.42','I25.5','I25.6','I25.7','I25.70','I25.700','I25.701','I25.708','I25.709''I25.71',
		'I25.710','I25.711','I25.718','I25.719','I25.72','I25.720','I25.721','I25.728','I25.729',
		'I25.73','I25.730','I25.731','I25.738','I25.739','I25.75','I25.750','I25.751','I25.758',
		'I25.759','I25.76','I25.760','I25.761','I25.768','I25.769','I25.79','I25.790','I25.791',
		'I25.798','I25.799','I25.8','I25.81','I25.811','I25.812','I25.89','I50.32','I50.33')
		) 

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('410.0','410.00','410.01','410.02','410.1','410.10','410.11','410.11','410.12','410.20','410.21','410.22',
		'410.30','410.31','410.32','410.40','410.41','410.42','410.50','410.51','410.52','410.60','410.61','410.62',
		'410.70','410.71','410.72','410.80','410.81','410.82','410.90','410.91','410.92','411.0','411.1','411.89',
		'412','413','413.0','413.1','413.9','414','414.01','414.02','414.03','414.04','414.05','414.06','414.07',
		'414.10','414.11','414.12','414.19','414.2','414.3','414.4','414.8','414.9')--insert iCD9
		or 
		T.current_ICD10_List in
		('I20.9','I20','I20.0','I20.1','I20.8','I21','I21.0','I21.01','I21.02','I21.09',
		'I21.29','I21.1','I21.11','I21.19','I21.2','I21.21','I23.6','I21.3','I21.4',
		'I21.9','I21.A','I21.A1','I21.A9','I23.8','I25.9','I25.9 ','I51.3','I22',
		'I22.0','I22.1','I22.2','I22.8','I22.9','I23','I23.0','I23.1','I23.2','I23.3','I23.4','I23.5',
		'I23.7','I24.1','I25.810','I25','I25.1','I25.10','I25.10 ','I25.2','I25.82','I25.83',
		'I25.84','I25.11','I25.110','I25.111','I25.118','I25.119','I25.3','I25.4','I25.41',
		'I25.42','I25.5','I25.6','I25.7','I25.70','I25.700','I25.701','I25.708','I25.709''I25.71',
		'I25.710','I25.711','I25.718','I25.719','I25.72','I25.720','I25.721','I25.728','I25.729',
		'I25.73','I25.730','I25.731','I25.738','I25.739','I25.75','I25.750','I25.751','I25.758',
		'I25.759','I25.76','I25.760','I25.761','I25.768','I25.769','I25.79','I25.790','I25.791',
		'I25.798','I25.799','I25.8','I25.81','I25.811','I25.812','I25.89','I50.32','I50.33')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('410.0','410.00','410.01','410.02','410.1','410.10','410.11','410.11','410.12','410.20','410.21','410.22',
		'410.30','410.31','410.32','410.40','410.41','410.42','410.50','410.51','410.52','410.60','410.61','410.62',
		'410.70','410.71','410.72','410.80','410.81','410.82','410.90','410.91','410.92','411.0','411.1','411.89',
		'412','413','413.0','413.1','413.9','414','414.01','414.02','414.03','414.04','414.05','414.06','414.07',
		'414.10','414.11','414.12','414.19','414.2','414.3','414.4','414.8','414.9') --insert icd9
		or 
		T.current_ICD10_List in
		('I20.9','I20','I20.0','I20.1','I20.8','I21','I21.0','I21.01','I21.02','I21.09',
		'I21.29','I21.1','I21.11','I21.19','I21.2','I21.21','I23.6','I21.3','I21.4',
		'I21.9','I21.A','I21.A1','I21.A9','I23.8','I25.9','I25.9 ','I51.3','I22',
		'I22.0','I22.1','I22.2','I22.8','I22.9','I23','I23.0','I23.1','I23.2','I23.3','I23.4','I23.5',
		'I23.7','I24.1','I25.810','I25','I25.1','I25.10','I25.10 ','I25.2','I25.82','I25.83',
		'I25.84','I25.11','I25.110','I25.111','I25.118','I25.119','I25.3','I25.4','I25.41',
		'I25.42','I25.5','I25.6','I25.7','I25.70','I25.700','I25.701','I25.708','I25.709''I25.71',
		'I25.710','I25.711','I25.718','I25.719','I25.72','I25.720','I25.721','I25.728','I25.729',
		'I25.73','I25.730','I25.731','I25.738','I25.739','I25.75','I25.750','I25.751','I25.758',
		'I25.759','I25.76','I25.760','I25.761','I25.768','I25.769','I25.79','I25.790','I25.791',
		'I25.798','I25.799','I25.8','I25.81','I25.811','I25.812','I25.89','I50.32','I50.33') --insert ic10

		)

--End Step 5


--End CAD **************************



--Start HTN *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
			  E.current_ICD9_List in
	 ('401','401.0','401.1','401.9','402','402.0','402.01','402.1','402.10','402.11','402.90','402.91',
	'403','403.00','403.01','403.10','403.11','403.90','403.91','404','404.0','404.01','404.02','404.03',
	'404.10','404.11','404.12','404.13','404.90','404.91','404.92','404.93','405','405.0','405.01','405.09',
	'405.1','405.11','405.19','405.9','405.91','405.99')

	or 
	E.current_ICD10_List in
	('I10','I11','I11.0','I11.9','I13','I13.0','I13.1',
	'I13.10','I13.11','I13.2','I15','I15.1','I15.2','I15.8','I15.9')
	)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
				  E.current_ICD9_List in
		 ('401','401.0','401.1','401.9','402','402.0','402.01','402.1','402.10','402.11','402.90','402.91',
		'403','403.00','403.01','403.10','403.11','403.90','403.91','404','404.0','404.01','404.02','404.03',
		'404.10','404.11','404.12','404.13','404.90','404.91','404.92','404.93','405','405.0','405.01','405.09',
		'405.1','405.11','405.19','405.9','405.91','405.99')

		or 
		E.current_ICD10_List in
		('I10','I11','I11.0','I11.9','I13','I13.0','I13.1',
		'I13.10','I13.11','I13.2','I15','I15.1','I15.2','I15.8','I15.9')
		)
	

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('401','401.0','401.1','401.9','402','402.0','402.01','402.1','402.10','402.11','402.90','402.91',
		'403','403.00','403.01','403.10','403.11','403.90','403.91','404','404.0','404.01','404.02','404.03',
		'404.10','404.11','404.12','404.13','404.90','404.91','404.92','404.93','405','405.0','405.01','405.09',
		'405.1','405.11','405.19','405.9','405.91','405.99')--insert iCD9
		or 
		T.current_ICD10_List in
		('I10','I11','I11.0','I11.9','I13','I13.0','I13.1',
		'I13.10','I13.11','I13.2','I15','I15.1','I15.2','I15.8','I15.9')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('401','401.0','401.1','401.9','402','402.0','402.01','402.1','402.10','402.11','402.90','402.91',
		'403','403.00','403.01','403.10','403.11','403.90','403.91','404','404.0','404.01','404.02','404.03',
		'404.10','404.11','404.12','404.13','404.90','404.91','404.92','404.93','405','405.0','405.01','405.09',
		'405.1','405.11','405.19','405.9','405.91','405.99') --insert icd9
		or 
		T.current_ICD10_List in
		('I10','I11','I11.0','I11.9','I13','I13.0','I13.1',
		'I13.10','I13.11','I13.2','I15','I15.1','I15.2','I15.8','I15.9') --insert ic10

		)

--End Step 5

--End HTN **************************



--Start Dyslipidemia *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
			  E.current_ICD9_List in
		 ('272','272.0','272.1','272.2','272.3','272.4','272.5','272.6','272.7','272.8','272.9',
			'272','272.2','272.4','249.8','272.3','272.5'
		,'250.8','250.81','272.1')
		or 
		E.current_ICD10_List in
		 ('E78.0','E78.00','E78.01','E.78.2','E.78.4','E78.5',
			'E10.69','E78.2','E78.01','E78.49','E09.69'
		,'E78.5','E11.69','E13.69','E78.3','E78.1'
		,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4')
		)
	 
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
						  E.current_ICD9_List in
		 ('272','272.0','272.1','272.2','272.3','272.4','272.5','272.6','272.7','272.8','272.9',
			'272','272.2','272.4','249.8','272.3','272.5'
		,'250.8','250.81','272.1')
		or 
		E.current_ICD10_List in
		 ('E78.0','E78.00','E78.01','E.78.2','E.78.4','E78.5',
			'E10.69','E78.2','E78.01','E78.49','E09.69'
		,'E78.5','E11.69','E13.69','E78.3','E78.1'
		,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4')
		)
		
		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('272','272.0','272.1','272.2','272.3','272.4','272.5','272.6','272.7','272.8','272.9',
			'272','272.2','272.4','249.8','272.3','272.5'
		,'250.8','250.81','272.1')--insert iCD9
		or 
		T.current_ICD10_List in
		('E78.0','E78.00','E78.01','E.78.2','E.78.4','E78.5',
			'E10.69','E78.2','E78.01','E78.49','E09.69'
		,'E78.5','E11.69','E13.69','E78.3','E78.1'
		,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('272','272.0','272.1','272.2','272.3','272.4','272.5','272.6','272.7','272.8','272.9',
			'272','272.2','272.4','249.8','272.3','272.5'
		,'250.8','250.81','272.1') --insert icd9
		or 
		T.current_ICD10_List in
		('E78.0','E78.00','E78.01','E.78.2','E.78.4','E78.5',
			'E10.69','E78.2','E78.01','E78.49','E09.69'
		,'E78.5','E11.69','E13.69','E78.3','E78.1'
		,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4') --insert ic10

		)

--End Step 5

--End Dyslipidemia **************************


--Start Secondary cardiomyopathy *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
		 E.current_ICD9_List = '425.9'

		or 
		E.current_ICD10_List ='I42.9'
		)
		and P.noted_DATE is not null 

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
					 E.current_ICD9_List = '425.9'

					or 
					E.current_ICD10_List ='I42.9'
					)
		

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('425.9')--insert iCD9
		or 
		T.current_ICD10_List in
		('I42.9')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('425.9') --insert icd9
		or 
		T.current_ICD10_List in
		('I42.9') --insert ic10

		)

--End Step 5

--End Secondary cardiomyopathy **************************


--Start Aortic_Aneurysm *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
			 E.current_ICD9_List in
			 ('93','93.9','420','441','441.01',
			'441.02','441.03','441.1','441.2',
			'441.3','441.4','441.5','441.6','441.7',
			'441.9','909.3','442.1')
			or 
			E.current_ICD10_List in
			('A52.01','I71','I71.00','I71.01','I71.02','I71.03'
			,'I71.1','I32','I71.2','I71.3','I71.4','I71.5','I71.6','I71.8'
			,'I71.9 ','Q25.43','Z13.6','Z82.49','Z86.79','Z98.890','Z95.828')

			)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
					 E.current_ICD9_List in
					 ('93','93.9','420','441','441.01',
					'441.02','441.03','441.1','441.2',
					'441.3','441.4','441.5','441.6','441.7',
					'441.9','909.3','442.1')
					or 
					E.current_ICD10_List in
					('A52.01','I71','I71.00','I71.01','I71.02','I71.03'
					,'I71.1','I32','I71.2','I71.3','I71.4','I71.5','I71.6','I71.8'
					,'I71.9 ','Q25.43','Z13.6','Z82.49','Z86.79','Z98.890','Z95.828')

					)
	
		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('93','93.9','420','441','441.01',
					'441.02','441.03','441.1','441.2',
					'441.3','441.4','441.5','441.6','441.7',
					'441.9','909.3','442.1')--insert iCD9
		or 
		T.current_ICD10_List in
		('A52.01','I71','I71.00','I71.01','I71.02','I71.03'
					,'I71.1','I32','I71.2','I71.3','I71.4','I71.5','I71.6','I71.8'
					,'I71.9 ','Q25.43','Z13.6','Z82.49','Z86.79','Z98.890','Z95.828')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('93','93.9','420','441','441.01',
					'441.02','441.03','441.1','441.2',
					'441.3','441.4','441.5','441.6','441.7',
					'441.9','909.3','442.1') --insert icd9
		or 
		T.current_ICD10_List in
		('A52.01','I71','I71.00','I71.01','I71.02','I71.03'
					,'I71.1','I32','I71.2','I71.3','I71.4','I71.5','I71.6','I71.8'
					,'I71.9 ','Q25.43','Z13.6','Z82.49','Z86.79','Z98.890','Z95.828') --insert ic10

		)

--End Step 5

--End Aortic_Aneurysm **************************

--Start ACS *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
			 E.current_ICD9_List in
			 ('411.1','786.50','790.6')
			or 
			E.current_ICD10_List in
			('I24.9','R07.9','R79.89','Z09')
			)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
				 E.current_ICD9_List in
				 ('411.1','786.50','790.6')
				or 
				E.current_ICD10_List in
				('I24.9','R07.9','R79.89','Z09')
				)

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('411.1','786.50','790.6')--insert iCD9
		or 
		T.current_ICD10_List in
		('I24.9','R07.9','R79.89','Z09')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('411.1','786.50','790.6') --insert icd9
		or 
		T.current_ICD10_List in
		('I24.9','R07.9','R79.89','Z09') --insert ic10

		)

--End Step 5

--End ACS **************************

--Start Afib *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
			(
			E.current_ICD9_List in
		 ('427.3','427.31','427.32')
		or 
		E.current_ICD10_List in
		('I48.0','I48.1','I48.2','I48.3','I48.4','I48.9','I48.91','I48.92')
		)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
				 E.current_ICD9_List in
		 ('427.3','427.31','427.32')
		or 
		E.current_ICD10_List in
		('I48.0','I48.1','I48.2','I48.3','I48.4','I48.9','I48.91','I48.92')
		)
		

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('427.3','427.31','427.32')--insert iCD9
		or 
		T.current_ICD10_List in
		('I48.0','I48.1','I48.2','I48.3','I48.4','I48.9','I48.91','I48.92')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('427.3','427.31','427.32') --insert icd9
		or 
		T.current_ICD10_List in
		('I48.0','I48.1','I48.2','I48.3','I48.4','I48.9','I48.91','I48.92') --insert ic10

		)

--End Step 5

--End Afib **************************



--Start MI *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  P.NOTED_DATE is not null and
			(
			 E.current_ICD9_List like '410%'
			or 
			E.current_ICD10_List in
			('I21.01','I21.11','I24.9','I21.A1','I22.8','I21.09',
			'I21.9','Z51.89','I21.A9','I22.0','I23.8','I51.89',
			'I21.4','I23.3','T50.905A','I21.3','I32','I22.9',
			'I25.9','I22.1','I21.02','I21.09 ','I21.29','I21.19','I21.21',
			'I51.3','Z09, ','I25.2','I22.2','I24.0')
			)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
				  E.current_ICD9_List like '410%'
			or 
				E.current_ICD10_List in
				('I21.01','I21.11','I24.9','I21.A1','I22.8','I21.09',
				'I21.9','Z51.89','I21.A9','I22.0','I23.8','I51.89',
				'I21.4','I23.3','T50.905A','I21.3','I32','I22.9',
				'I25.9','I22.1','I21.02','I21.09 ','I21.29','I21.19','I21.21',
				'I51.3','Z09, ','I25.2','I22.2','I24.0')
				)
		

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List like '410%'
		  --insert iCD9
		or 
		T.current_ICD10_List in
		('I21.01','I21.11','I24.9','I21.A1','I22.8','I21.09',
				'I21.9','Z51.89','I21.A9','I22.0','I23.8','I51.89',
				'I21.4','I23.3','T50.905A','I21.3','I32','I22.9',
				'I25.9','I22.1','I21.02','I21.09 ','I21.29','I21.19','I21.21',
				'I51.3','Z09, ','I25.2','I22.2','I24.0')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List like '410%'
		  --insert icd9
		or 
		T.current_ICD10_List in
		('I21.01','I21.11','I24.9','I21.A1','I22.8','I21.09',
				'I21.9','Z51.89','I21.A9','I22.0','I23.8','I51.89',
				'I21.4','I23.3','T50.905A','I21.3','I32','I22.9',
				'I25.9','I22.1','I21.02','I21.09 ','I21.29','I21.19','I21.21',
				'I51.3','Z09, ','I25.2','I22.2','I24.0') --insert ic10

		)

--End Step 5

--End MI **************************



--Start PAD *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where 
			(
					  E.current_ICD9_List in
		 ('093.0','437.3','440.1','440.2','440.3','440.4','440.5','440.6','440.7','440.8','440.9',
		'441.1','441.2','441.3','441.4','441.5','441.6','441.7','441.8','441.9',
		'443.1','443.2','443.3','443.4','443.5','443.6','443.7','443.8','443.9',
		'47.1','557.1','557.9','V43.4')
		or 
		E.current_ICD10_List in
		('I70.438','I70.448','I70.439','I70.449','I70.44','I70.45','I70.46',
		'I70.461','I70.462','I70.463','I70.468','I70.469','I70.49','I70.491','I70.492',
		'I70.493','I70.498','I70.499','I70.5','I70.50','I70.501','I70.502','I70.503','I70.508',
		'I70.509','I70.51','I70.511',
		'I70.512','I70.513','I70.518','I70.519','I70.52','I70.521',
		'I70.522','I70.523','I70.528','I70.529','I70.53','I70.531','I70.531 ',
		'I70.541','I70.532','I70.542','I70.533','I70.533 ','I70.543','I70.534','I70.544',
		'I70.535','I70.545','I70.538','I70.538','I70.548','I70.539','I70.539 ',
		'I70.549','I70.54','I70.55','I70.56','I70.561','I70.562','I70.563','I70.568',
		'I70.569','I70.59','I70.591','I70.592','I70.593','I70.598','I70.599','I70.6',
		'I70.60','I70.601','I70.602','I70.603','I70.608','I70.609','I70.61',
		'I70.611','I70.612','I70.613','I70.618','I70.619','I70.62','I70.621',
		'I70.622','I70.623','I70.628','I70.629','I70.63','I70.631','I70.631 ',
		'I70.641','I70.632','I70.632 ','I70.642','I70.633','I70.643','I70.634','I70.644',
		'I70.635','I70.645','I70.638','I70.648',
		'I70.639','I70.639 ','I70.649','I70.64','I70.65','I70.66','I70.661','I70.662',
		'I70.663','I70.668','I70.669','I70.69','I70.691','I70.692','I70.693',
		'I70.698','I70.699','I70.7','I70.70','I70.701','I70.702','I70.703','I70.708',
		'I70.709','I70.71','I70.711','I70.712','I70.713','I70.718','I70.719','I70.72',
		'I70.721','I70.722','I70.723','I70.728','I70.729','I70.73','I70.731','I70.741','I70.732',
		'I70.732 ','I70.742','I70.733','I70.743','I70.734','I70.744','I70.735','I70.745',
		'I70.738','I70.738 ','I70.748','I70.739','I70.739 ','I70.749','I70.74','I70.75',
		'I70.76','I70.761','I70.762','I70.763','I70.768','I70.769','I70.79',
		'I70.791','I70.792','I70.793','I70.798','I70.799','I70.9','I70.90',
		'I70.91','I70.92','I71.0','I71.00','I71.01','I71.02','I71.03','I71.1',
		'I71.2','I71.3','I71.4','I71.5','I71.6','I71.8','I71.9','I73.1',
		'I73.8','I73.9','I77.1','I79.0','I79.2','K55.1','K55.8','K55.9','Z95.8','Z95.9'
		)
		)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
				   E.current_ICD9_List in
					 ('093.0','437.3','440.1','440.2','440.3','440.4','440.5','440.6','440.7','440.8','440.9',
					'441.1','441.2','441.3','441.4','441.5','441.6','441.7','441.8','441.9',
					'443.1','443.2','443.3','443.4','443.5','443.6','443.7','443.8','443.9',
					'47.1','557.1','557.9','V43.4')
					or 
					E.current_ICD10_List in
					('I70.438','I70.448','I70.439','I70.449','I70.44','I70.45','I70.46',
					'I70.461','I70.462','I70.463','I70.468','I70.469','I70.49','I70.491','I70.492',
					'I70.493','I70.498','I70.499','I70.5','I70.50','I70.501','I70.502','I70.503','I70.508',
					'I70.509','I70.51','I70.511',
					'I70.512','I70.513','I70.518','I70.519','I70.52','I70.521',
					'I70.522','I70.523','I70.528','I70.529','I70.53','I70.531','I70.531 ',
					'I70.541','I70.532','I70.542','I70.533','I70.533 ','I70.543','I70.534','I70.544',
					'I70.535','I70.545','I70.538','I70.538','I70.548','I70.539','I70.539 ',
					'I70.549','I70.54','I70.55','I70.56','I70.561','I70.562','I70.563','I70.568',
					'I70.569','I70.59','I70.591','I70.592','I70.593','I70.598','I70.599','I70.6',
					'I70.60','I70.601','I70.602','I70.603','I70.608','I70.609','I70.61',
					'I70.611','I70.612','I70.613','I70.618','I70.619','I70.62','I70.621',
					'I70.622','I70.623','I70.628','I70.629','I70.63','I70.631','I70.631 ',
					'I70.641','I70.632','I70.632 ','I70.642','I70.633','I70.643','I70.634','I70.644',
					'I70.635','I70.645','I70.638','I70.648',
					'I70.639','I70.639 ','I70.649','I70.64','I70.65','I70.66','I70.661','I70.662',
					'I70.663','I70.668','I70.669','I70.69','I70.691','I70.692','I70.693',
					'I70.698','I70.699','I70.7','I70.70','I70.701','I70.702','I70.703','I70.708',
					'I70.709','I70.71','I70.711','I70.712','I70.713','I70.718','I70.719','I70.72',
					'I70.721','I70.722','I70.723','I70.728','I70.729','I70.73','I70.731','I70.741','I70.732',
					'I70.732 ','I70.742','I70.733','I70.743','I70.734','I70.744','I70.735','I70.745',
					'I70.738','I70.738 ','I70.748','I70.739','I70.739 ','I70.749','I70.74','I70.75',
					'I70.76','I70.761','I70.762','I70.763','I70.768','I70.769','I70.79',
					'I70.791','I70.792','I70.793','I70.798','I70.799','I70.9','I70.90',
					'I70.91','I70.92','I71.0','I71.00','I71.01','I71.02','I71.03','I71.1',
					'I71.2','I71.3','I71.4','I71.5','I71.6','I71.8','I71.9','I73.1',
					'I73.8','I73.9','I77.1','I79.0','I79.2','K55.1','K55.8','K55.9','Z95.8','Z95.9'
					)
					)
		--and P.Contact_Date is not null 

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('093.0','437.3','440.1','440.2','440.3','440.4','440.5','440.6','440.7','440.8','440.9',
					'441.1','441.2','441.3','441.4','441.5','441.6','441.7','441.8','441.9',
					'443.1','443.2','443.3','443.4','443.5','443.6','443.7','443.8','443.9',
					'47.1','557.1','557.9','V43.4')--insert iCD9
		or 
		T.current_ICD10_List in
		('I70.438','I70.448','I70.439','I70.449','I70.44','I70.45','I70.46',
					'I70.461','I70.462','I70.463','I70.468','I70.469','I70.49','I70.491','I70.492',
					'I70.493','I70.498','I70.499','I70.5','I70.50','I70.501','I70.502','I70.503','I70.508',
					'I70.509','I70.51','I70.511',
					'I70.512','I70.513','I70.518','I70.519','I70.52','I70.521',
					'I70.522','I70.523','I70.528','I70.529','I70.53','I70.531','I70.531 ',
					'I70.541','I70.532','I70.542','I70.533','I70.533 ','I70.543','I70.534','I70.544',
					'I70.535','I70.545','I70.538','I70.538','I70.548','I70.539','I70.539 ',
					'I70.549','I70.54','I70.55','I70.56','I70.561','I70.562','I70.563','I70.568',
					'I70.569','I70.59','I70.591','I70.592','I70.593','I70.598','I70.599','I70.6',
					'I70.60','I70.601','I70.602','I70.603','I70.608','I70.609','I70.61',
					'I70.611','I70.612','I70.613','I70.618','I70.619','I70.62','I70.621',
					'I70.622','I70.623','I70.628','I70.629','I70.63','I70.631','I70.631 ',
					'I70.641','I70.632','I70.632 ','I70.642','I70.633','I70.643','I70.634','I70.644',
					'I70.635','I70.645','I70.638','I70.648',
					'I70.639','I70.639 ','I70.649','I70.64','I70.65','I70.66','I70.661','I70.662',
					'I70.663','I70.668','I70.669','I70.69','I70.691','I70.692','I70.693',
					'I70.698','I70.699','I70.7','I70.70','I70.701','I70.702','I70.703','I70.708',
					'I70.709','I70.71','I70.711','I70.712','I70.713','I70.718','I70.719','I70.72',
					'I70.721','I70.722','I70.723','I70.728','I70.729','I70.73','I70.731','I70.741','I70.732',
					'I70.732 ','I70.742','I70.733','I70.743','I70.734','I70.744','I70.735','I70.745',
					'I70.738','I70.738 ','I70.748','I70.739','I70.739 ','I70.749','I70.74','I70.75',
					'I70.76','I70.761','I70.762','I70.763','I70.768','I70.769','I70.79',
					'I70.791','I70.792','I70.793','I70.798','I70.799','I70.9','I70.90',
					'I70.91','I70.92','I71.0','I71.00','I71.01','I71.02','I71.03','I71.1',
					'I71.2','I71.3','I71.4','I71.5','I71.6','I71.8','I71.9','I73.1',
					'I73.8','I73.9','I77.1','I79.0','I79.2','K55.1','K55.8','K55.9','Z95.8','Z95.9')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('093.0','437.3','440.1','440.2','440.3','440.4','440.5','440.6','440.7','440.8','440.9',
					'441.1','441.2','441.3','441.4','441.5','441.6','441.7','441.8','441.9',
					'443.1','443.2','443.3','443.4','443.5','443.6','443.7','443.8','443.9',
					'47.1','557.1','557.9','V43.4') --insert icd9
		or 
		T.current_ICD10_List in
		('I70.438','I70.448','I70.439','I70.449','I70.44','I70.45','I70.46',
					'I70.461','I70.462','I70.463','I70.468','I70.469','I70.49','I70.491','I70.492',
					'I70.493','I70.498','I70.499','I70.5','I70.50','I70.501','I70.502','I70.503','I70.508',
					'I70.509','I70.51','I70.511',
					'I70.512','I70.513','I70.518','I70.519','I70.52','I70.521',
					'I70.522','I70.523','I70.528','I70.529','I70.53','I70.531','I70.531 ',
					'I70.541','I70.532','I70.542','I70.533','I70.533 ','I70.543','I70.534','I70.544',
					'I70.535','I70.545','I70.538','I70.538','I70.548','I70.539','I70.539 ',
					'I70.549','I70.54','I70.55','I70.56','I70.561','I70.562','I70.563','I70.568',
					'I70.569','I70.59','I70.591','I70.592','I70.593','I70.598','I70.599','I70.6',
					'I70.60','I70.601','I70.602','I70.603','I70.608','I70.609','I70.61',
					'I70.611','I70.612','I70.613','I70.618','I70.619','I70.62','I70.621',
					'I70.622','I70.623','I70.628','I70.629','I70.63','I70.631','I70.631 ',
					'I70.641','I70.632','I70.632 ','I70.642','I70.633','I70.643','I70.634','I70.644',
					'I70.635','I70.645','I70.638','I70.648',
					'I70.639','I70.639 ','I70.649','I70.64','I70.65','I70.66','I70.661','I70.662',
					'I70.663','I70.668','I70.669','I70.69','I70.691','I70.692','I70.693',
					'I70.698','I70.699','I70.7','I70.70','I70.701','I70.702','I70.703','I70.708',
					'I70.709','I70.71','I70.711','I70.712','I70.713','I70.718','I70.719','I70.72',
					'I70.721','I70.722','I70.723','I70.728','I70.729','I70.73','I70.731','I70.741','I70.732',
					'I70.732 ','I70.742','I70.733','I70.743','I70.734','I70.744','I70.735','I70.745',
					'I70.738','I70.738 ','I70.748','I70.739','I70.739 ','I70.749','I70.74','I70.75',
					'I70.76','I70.761','I70.762','I70.763','I70.768','I70.769','I70.79',
					'I70.791','I70.792','I70.793','I70.798','I70.799','I70.9','I70.90',
					'I70.91','I70.92','I71.0','I71.00','I71.01','I71.02','I71.03','I71.1',
					'I71.2','I71.3','I71.4','I71.5','I71.6','I71.8','I71.9','I73.1',
					'I73.8','I73.9','I77.1','I79.0','I79.2','K55.1','K55.8','K55.9','Z95.8','Z95.9') --insert ic10

		)

--End Step 5

--End PAD **************************



--Start -- stable angina *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
			(
			E.current_ICD9_List ='413.9'

			or 
			E.current_ICD10_List in ('I20.0','I20.1','I20.8','I20.9')
			)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
				  E.current_ICD9_List ='413.9'

			or 
			E.current_ICD10_List in ('I20.0','I20.1','I20.8','I20.9')
			)
		

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
	
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('413.9')--insert iCD9
		or 
		T.current_ICD10_List in
		('I20.0','I20.1','I20.8','I20.9')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('413.9') --insert icd9
		or 
		T.current_ICD10_List in
		('I20.0','I20.1','I20.8','I20.9') --insert ic10

		)

--End Step 5

--End stable angina **************************



--Start -- unstable angina *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
			(
					E.current_ICD9_List ='411.1'

		or 
		E.current_ICD10_List in ('I20.0','I24.9')

		)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
				 E.current_ICD9_List ='411.1'

				or 
				E.current_ICD10_List in ('I20.0','I24.9')

				)
		--and P.Contact_Date is not null 

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('411.1')--insert iCD9
		or 
		T.current_ICD10_List in
		('I20.0','I24.9')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('411.1') --insert icd9
		or 
		T.current_ICD10_List in
		('I20.0','I24.9') --insert ic10

		)

--End Step 5

--End unstable angina **************************



--Start -- Ischemic_Stroke *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
			(
					(E.current_ICD9_List = '434.11' or E.current_ICD9_List = '434.91' or E.current_ICD9_List like '436%' )
			or 
			E.current_ICD10_List in
			('I63.119','I63.431','I63.433','I63.449','I63.519','Z86.73',
			'G81.90','I63.10','I63.12','I63.139','I63.29','I63.543','I63.549',
			'G46.4','G46.5','I63.112','I63.232','I63.419','I63.429','I63.439',
			'I63.49','I63.513','I63.539','P91.0 ','I61.9','I63.219','I63.22',
			'I63.422','I63.522','I63.542','I63.89','I69.30','P91.0','I63.532',
			'G46.6','I63.19','I63.231','I63.411','I63.413','I63.421','I63.50','I63.531',
			'I63.59','I63.6','I63.81','P91.0, ','I63.511','I63.412','I63.432','I63.523',
			'I63.529','G46.3','I63.131','I63.20','I63.40','I63.442','I63.443','I63.512',
			'I63.533','I63.521','I63.111','I63.132','I63.211','I63.212 ','I63.423',
			'I63.441','I63.541','I63.9','I67.89'
			)
			)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			(
							( E.current_ICD9_List = '434.11' or E.current_ICD9_List = '434.91' or E.current_ICD9_List like '436%' )
			or 
			E.current_ICD10_List in
			('I63.119','I63.431','I63.433','I63.449','I63.519','Z86.73',
			'G81.90','I63.10','I63.12','I63.139','I63.29','I63.543','I63.549',
			'G46.4','G46.5','I63.112','I63.232','I63.419','I63.429','I63.439',
			'I63.49','I63.513','I63.539','P91.0 ','I61.9','I63.219','I63.22',
			'I63.422','I63.522','I63.542','I63.89','I69.30','P91.0','I63.532',
			'G46.6','I63.19','I63.231','I63.411','I63.413','I63.421','I63.50','I63.531',
			'I63.59','I63.6','I63.81','P91.0, ','I63.511','I63.412','I63.432','I63.523',
			'I63.529','G46.3','I63.131','I63.20','I63.40','I63.442','I63.443','I63.512',
			'I63.533','I63.521','I63.111','I63.132','I63.211','I63.212 ','I63.423',
			'I63.441','I63.541','I63.9','I67.89'
			)
			)
		--and P.Contact_Date is not null 

		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		  (T.current_ICD9_List = '434.11' or T.current_ICD9_List = '434.91' or T.current_ICD9_List like '436%')--insert iCD9
		or 
		T.current_ICD10_List in
		('I63.119','I63.431','I63.433','I63.449','I63.519','Z86.73',
			'G81.90','I63.10','I63.12','I63.139','I63.29','I63.543','I63.549',
			'G46.4','G46.5','I63.112','I63.232','I63.419','I63.429','I63.439',
			'I63.49','I63.513','I63.539','P91.0 ','I61.9','I63.219','I63.22',
			'I63.422','I63.522','I63.542','I63.89','I69.30','P91.0','I63.532',
			'G46.6','I63.19','I63.231','I63.411','I63.413','I63.421','I63.50','I63.531',
			'I63.59','I63.6','I63.81','P91.0, ','I63.511','I63.412','I63.432','I63.523',
			'I63.529','G46.3','I63.131','I63.20','I63.40','I63.442','I63.443','I63.512',
			'I63.533','I63.521','I63.111','I63.132','I63.211','I63.212 ','I63.423',
			'I63.441','I63.541','I63.9','I67.89')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		  (T.current_ICD9_List = '434.11' or T.current_ICD9_List = '434.91' or T.current_ICD9_List like '436%') --insert icd9
		or 
		T.current_ICD10_List in
		('I63.119','I63.431','I63.433','I63.449','I63.519','Z86.73',
			'G81.90','I63.10','I63.12','I63.139','I63.29','I63.543','I63.549',
			'G46.4','G46.5','I63.112','I63.232','I63.419','I63.429','I63.439',
			'I63.49','I63.513','I63.539','P91.0 ','I61.9','I63.219','I63.22',
			'I63.422','I63.522','I63.542','I63.89','I69.30','P91.0','I63.532',
			'G46.6','I63.19','I63.231','I63.411','I63.413','I63.421','I63.50','I63.531',
			'I63.59','I63.6','I63.81','P91.0, ','I63.511','I63.412','I63.432','I63.523',
			'I63.529','G46.3','I63.131','I63.20','I63.40','I63.442','I63.443','I63.512',
			'I63.533','I63.521','I63.111','I63.132','I63.211','I63.212 ','I63.423',
			'I63.441','I63.541','I63.9','I67.89') --insert ic10

		)

--End Step 5

--End Ischemic_Stroke **************************




--Start -- Stroke *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
			(
					(E.current_ICD9_List like '430%' or E.current_ICD9_List like '431%' or E.current_ICD9_List like '432%' or
			E.current_ICD9_List like '434%' or E.current_ICD9_List like '435%' or E.current_ICD9_List like '436%' or E.current_ICD9_List like '437%' or 
			E.current_ICD9_List like '438%' )
			or 
			E.current_ICD10_List in
			('D57.00 ','D57.1','D57.01 ','D57.02 ','G23.2','G45.0',
			'G45.0 ','G45.1','G45.4','G45.8','G45.8 ','I97.89',
			'G45.9','G45.9 ','H54.7','I48.91','I74.9','G46.0','G46.1',
			'G46.2','G46.3','G46.4','G46.5','G46.6','G46.7','G46.8',
			'G81.90','G81.94 ','I61.9','I63.9','G83.9','G93.89','G93.9',
			'G95.19','G96.0','H53.40 ','I69.398','I60.00','I60.01','I60.02',
			'I60.10','I60.11','I60.12','I60.2','I60.20','I60.21','I60.22',
			'I60.30','I60.31','I60.32','I60.4','I60.50','I60.51','I60.52',
			'I60.6','I60.7','I60.8','I60.8 ','I67.1','I60.9','I60.9 ','D68.9',
			'G81.10','G81.11','G81.12','G81.13','G81.14','G81.91','G81.92',
			'G81.93','G81.94','H44.819','I10','Q28.3','R40.20','I61.0',
			'I61.1','I61.2','I61.3','I61.4','I61.4 ','I61.8','I61.5',
			'I61.5 ','D69.9','Q28.2','I61.6','I61.9 ','G81.00','G81.02',
			'G81.03','G81.04','R41.89','I62.00','I62.01','I62.01 ','I62.03',
			'I62.02','I62.03 ','F02.80','I62.1','I62.9','I62.9 ','I63.6',
			'I63.10','I63.111','I63.112','I63.119','I63.12','I63.131','I63.132',
			'I63.139','I63.19','I63.20','I63.211 ','I63.22','I63.212 ','I63.219 ',
			'I63.231','I63.232','I63.29','I63.30','I63.311','I63.312','I63.313',
			'I63.319','I63.321','I63.322','I63.323','I63.329','I63.331','I63.332',
			'I63.333','I63.339','I63.341','I63.342','I63.343','I63.349','I63.39',
			'I63.40','I63.411','I63.412','I63.413','I63.419','I63.421','I63.422',
			'I63.423','I63.429','I63.431','I63.432','I63.433','I63.439','I63.441',
			'I63.442','I63.443','I63.449','I63.49','I63.50','I63.511','I63.512',
			'I63.513','I63.519','I63.521','I63.522','I63.523','I63.529','I63.531',
			'I63.532','I63.533','I63.539','I63.541','I63.542','I63.543','I63.549',
			'I63.59','I63.81','I63.89','I63.9 ','D57.00','D57.01','D57.02','F06.30','F06.31','F07.0',
			'G43.909','G51.0','G83.10','G83.20','R20.9','R26.9','R27.9','R29.810','R29.818',
			'R47.01','R47.1','R48.2','R53.1','R56.9','Z53.09','I66.01','I66.02',
			'I66.03','I66.09','I66.11','I66.12','I66.13','I66.19','I66.21','I66.22','I66.23',
			'I66.29','I66.3','I66.8','I66.9','I67.1 ','I67.0','K74.60 ','J43.9 ','Q89.7','I67.2','I67.2 ',
			'L65.9 ','M54.5','Z86.73','I67.4','I67.5','I67.5 ','K22.0',
			'I67.6',
			'I67.7',
			'I67.81',
			'I67.82',
			'I67.82 ',
			'G93.1',
			'I67.841',
			'I67.848',
			'I67.850',
			'I67.858',
			'I67.89',
			'I67.89 ',
			'F05',
			'G81.01',
			'W88.8XXA ',
			'Z77.123',
			'Y84.2',
			'I67.9',
			'I67.9 ',
			'C80.1',
			'H53.9',
			'R27.0',
			'I68.2',
			'I68.8',
			'I69.00',
			'I69.010',
			'I69.014',
			'I69.015',
			'I69.019',
			'I69.020',
			'I69.021',
			'I69.022',
			'I69.023',
			'I69.028',
			'I69.031',
			'I69.032',
			'I69.033',
			'I69.034',
			'I69.039',
			'I69.041',
			'I69.042',
			'I69.043',
			'I69.044',
			'I69.049',
			'I69.051',
			'I69.052',
			'I69.053',
			'I69.054',
			'I69.059',
			'I69.061',
			'I69.062',
			'I69.063',
			'I69.064',
			'I69.065',
			'I69.069',
			'I69.090',
			'I69.091',
			'I69.092',
			'I69.093',
			'I69.098',
			'I69.10',
			'I69.110',
			'I69.112',
			'I69.114',
			'I69.115',
			'I69.119',
			'I69.120',
			'I69.121',
			'I69.122',
			'I69.123',
			'I69.128',
			'I69.131',
			'I69.132',
			'I69.133',
			'I69.134',
			'I69.139',
			'I69.141',
			'I69.142',
			'I69.143',
			'I69.144',
			'I69.149',
			'I69.151',
			'I69.152',
			'I69.153',
			'I69.154',
			'I69.159',
			'I69.161',
			'I69.162',
			'I69.163',
			'I69.164',
			'I69.165',
			'I69.169',
			'I69.190',
			'I69.191',
			'I69.192',
			'I69.193',
			'I69.198',
			'I69.198 ',
			'G91.0',
			'H53.469',
			'M62.81',
			'R42',
			'I69.20',
			'I69.210',
			'I69.212',
			'I69.214',
			'I69.215',
			'I69.219',
			'I69.220',
			'I69.221',
			'I69.222',
			'I69.223',
			'I69.228',
			'I69.231',
			'I69.232',
			'I69.233',
			'I69.234',
			'I69.239',
			'I69.241',
			'I69.242',
			'I69.243',
			'I69.244',
			'I69.249',
			'I69.251',
			'I69.252',
			'I69.253',
			'I69.254',
			'I69.259',
			'I69.261',
			'I69.262',
			'I69.263',
			'I69.264',
			'I69.265',
			'I69.269',
			'I69.290',
			'I69.291',
			'I69.292',
			'I69.293',
			'I69.298',
			'I69.30',
			'I69.310',
			'I69.311',
			'I69.312',
			'I69.313',
			'I69.314',
			'I69.315',
			'I69.319',
			'I69.320',
			'I69.321',
			'I69.322',
			'I69.323',
			'I69.328',
			'I69.331',
			'I69.332',
			'I69.333',
			'I69.334',
			'I69.339',
			'I69.341',
			'I69.342',
			'I69.343',
			'I69.344',
			'I69.349',
			'I69.351',
			'I69.352',
			'I69.353',
			'I69.354',
			'I69.359',
			'I69.359 ',
			'I69.328 ',
			'I69.361',
			'I69.362',
			'I69.363',
			'I69.364',
			'I69.365',
			'I69.369',
			'I69.369 ',
			'I69.390',
			'I69.391',
			'I69.391 ',
			'I69.320 ',
			'I69.392',
			'I69.393',
			'I69.398 ',
			'F09',
			'F91.9',
			'G40.909',
			'G47.37',
			'G82.20',
			'H53.461',
			'H53.462',
			'M79.2',
			'M79.641',
			'M79.642',
			'R25.9',
			'R26.89',
			'R52',
			'I69.80',
			'I69.810',
			'I69.811',
			'I69.812',
			'I69.813',
			'I69.814',
			'I69.815',
			'I69.819',
			'I69.820',
			'I69.821',
			'I69.822',
			'I69.823',
			'I69.828',
			'I69.831',
			'I69.832',
			'I69.833',
			'I69.834',
			'I69.839',
			'I69.841',
			'I69.842',
			'I69.843',
			'I69.844',
			'I69.849',
			'I69.851',
			'I69.852',
			'I69.853',
			'I69.854',
			'I69.859',
			'I69.861',
			'I69.862',
			'I69.863',
			'I69.864',
			'I69.865',
			'I69.869',
			'I69.890',
			'I69.891',
			'I69.892',
			'I69.893',
			'I69.898',
			'I69.898 ',
			'R20.8',
			'I69.90',
			'I69.910',
			'I69.911',
			'I69.912',
			'I69.913',
			'I69.914',
			'I69.915',
			'I69.919',
			'I69.920',
			'I69.921',
			'I69.922',
			'I69.923',
			'I69.928',
			'I69.931',
			'I69.932',
			'I69.933',
			'I69.934',
			'I69.939',
			'I69.941',
			'I69.942',
			'I69.943',
			'I69.944',
			'I69.949',
			'I69.951',
			'I69.952',
			'I69.953',
			'I69.954',
			'I69.959',
			'I69.961',
			'I69.962',
			'I69.963',
			'I69.964',
			'I69.965',
			'I69.969',
			'I69.990',
			'I69.991',
			'I69.992',
			'I69.993',
			'I69.998',
			'I69.998 ',
			'N31.9',
			'R29.898',
			'I70.8',
			'I72.5',
			'I76 ',
			'I77.75',
			'I77.89',
			'I99.8',
			'P52.3',
			'P52.5',
			'P52.8',
			'P52.9',
			'P54.8 ',
			'P91.0 ',
			'S06.2X9A',
			'S06.4X4A',
			'S06.4X9A',
			'S06.5X0A',
			'S06.5X9A',
			'Z86.79')

			)
		

		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
			((E.current_ICD9_List like '430%' or E.current_ICD9_List like '431%' or E.current_ICD9_List like '432%' or
				E.current_ICD9_List like '434%' or E.current_ICD9_List like '435%' or E.current_ICD9_List like '436%' or E.current_ICD9_List like '437%' or 
				E.current_ICD9_List like '438%' )
				or 
				E.current_ICD10_List in
				('D57.00 ','D57.1','D57.01 ','D57.02 ','G23.2','G45.0',
				'G45.0 ','G45.1','G45.4','G45.8','G45.8 ','I97.89',
				'G45.9','G45.9 ','H54.7','I48.91','I74.9','G46.0','G46.1',
				'G46.2','G46.3','G46.4','G46.5','G46.6','G46.7','G46.8',
				'G81.90','G81.94 ','I61.9','I63.9','G83.9','G93.89','G93.9',
				'G95.19','G96.0','H53.40 ','I69.398','I60.00','I60.01','I60.02',
				'I60.10','I60.11','I60.12','I60.2','I60.20','I60.21','I60.22',
				'I60.30','I60.31','I60.32','I60.4','I60.50','I60.51','I60.52',
				'I60.6','I60.7','I60.8','I60.8 ','I67.1','I60.9','I60.9 ','D68.9',
				'G81.10','G81.11','G81.12','G81.13','G81.14','G81.91','G81.92',
				'G81.93','G81.94','H44.819','I10','Q28.3','R40.20','I61.0',
				'I61.1','I61.2','I61.3','I61.4','I61.4 ','I61.8','I61.5',
				'I61.5 ','D69.9','Q28.2','I61.6','I61.9 ','G81.00','G81.02',
				'G81.03','G81.04','R41.89','I62.00','I62.01','I62.01 ','I62.03',
				'I62.02','I62.03 ','F02.80','I62.1','I62.9','I62.9 ','I63.6',
				'I63.10','I63.111','I63.112','I63.119','I63.12','I63.131','I63.132',
				'I63.139','I63.19','I63.20','I63.211 ','I63.22','I63.212 ','I63.219 ',
				'I63.231','I63.232','I63.29','I63.30','I63.311','I63.312','I63.313',
				'I63.319','I63.321','I63.322','I63.323','I63.329','I63.331','I63.332',
				'I63.333','I63.339','I63.341','I63.342','I63.343','I63.349','I63.39',
				'I63.40','I63.411','I63.412','I63.413','I63.419','I63.421','I63.422',
				'I63.423','I63.429','I63.431','I63.432','I63.433','I63.439','I63.441',
				'I63.442','I63.443','I63.449','I63.49','I63.50','I63.511','I63.512',
				'I63.513','I63.519','I63.521','I63.522','I63.523','I63.529','I63.531',
				'I63.532','I63.533','I63.539','I63.541','I63.542','I63.543','I63.549',
				'I63.59','I63.81','I63.89','I63.9 ','D57.00','D57.01','D57.02','F06.30','F06.31','F07.0',
				'G43.909','G51.0','G83.10','G83.20','R20.9','R26.9','R27.9','R29.810','R29.818',
				'R47.01','R47.1','R48.2','R53.1','R56.9','Z53.09','I66.01','I66.02',
				'I66.03','I66.09','I66.11','I66.12','I66.13','I66.19','I66.21','I66.22','I66.23',
				'I66.29','I66.3','I66.8','I66.9','I67.1 ','I67.0','K74.60 ','J43.9 ','Q89.7','I67.2','I67.2 ',
				'L65.9 ','M54.5','Z86.73','I67.4','I67.5','I67.5 ','K22.0',
				'I67.6',
				'I67.7',
				'I67.81',
				'I67.82',
				'I67.82 ',
				'G93.1',
				'I67.841',
				'I67.848',
				'I67.850',
				'I67.858',
				'I67.89',
				'I67.89 ',
				'F05',
				'G81.01',
				'W88.8XXA ',
				'Z77.123',
				'Y84.2',
				'I67.9',
				'I67.9 ',
				'C80.1',
				'H53.9',
				'R27.0',
				'I68.2',
				'I68.8',
				'I69.00',
				'I69.010',
				'I69.014',
				'I69.015',
				'I69.019',
				'I69.020',
				'I69.021',
				'I69.022',
				'I69.023',
				'I69.028',
				'I69.031',
				'I69.032',
				'I69.033',
				'I69.034',
				'I69.039',
				'I69.041',
				'I69.042',
				'I69.043',
				'I69.044',
				'I69.049',
				'I69.051',
				'I69.052',
				'I69.053',
				'I69.054',
				'I69.059',
				'I69.061',
				'I69.062',
				'I69.063',
				'I69.064',
				'I69.065',
				'I69.069',
				'I69.090',
				'I69.091',
				'I69.092',
				'I69.093',
				'I69.098',
				'I69.10',
				'I69.110',
				'I69.112',
				'I69.114',
				'I69.115',
				'I69.119',
				'I69.120',
				'I69.121',
				'I69.122',
				'I69.123',
				'I69.128',
				'I69.131',
				'I69.132',
				'I69.133',
				'I69.134',
				'I69.139',
				'I69.141',
				'I69.142',
				'I69.143',
				'I69.144',
				'I69.149',
				'I69.151',
				'I69.152',
				'I69.153',
				'I69.154',
				'I69.159',
				'I69.161',
				'I69.162',
				'I69.163',
				'I69.164',
				'I69.165',
				'I69.169',
				'I69.190',
				'I69.191',
				'I69.192',
				'I69.193',
				'I69.198',
				'I69.198 ',
				'G91.0',
				'H53.469',
				'M62.81',
				'R42',
				'I69.20',
				'I69.210',
				'I69.212',
				'I69.214',
				'I69.215',
				'I69.219',
				'I69.220',
				'I69.221',
				'I69.222',
				'I69.223',
				'I69.228',
				'I69.231',
				'I69.232',
				'I69.233',
				'I69.234',
				'I69.239',
				'I69.241',
				'I69.242',
				'I69.243',
				'I69.244',
				'I69.249',
				'I69.251',
				'I69.252',
				'I69.253',
				'I69.254',
				'I69.259',
				'I69.261',
				'I69.262',
				'I69.263',
				'I69.264',
				'I69.265',
				'I69.269',
				'I69.290',
				'I69.291',
				'I69.292',
				'I69.293',
				'I69.298',
				'I69.30',
				'I69.310',
				'I69.311',
				'I69.312',
				'I69.313',
				'I69.314',
				'I69.315',
				'I69.319',
				'I69.320',
				'I69.321',
				'I69.322',
				'I69.323',
				'I69.328',
				'I69.331',
				'I69.332',
				'I69.333',
				'I69.334',
				'I69.339',
				'I69.341',
				'I69.342',
				'I69.343',
				'I69.344',
				'I69.349',
				'I69.351',
				'I69.352',
				'I69.353',
				'I69.354',
				'I69.359',
				'I69.359 ',
				'I69.328 ',
				'I69.361',
				'I69.362',
				'I69.363',
				'I69.364',
				'I69.365',
				'I69.369',
				'I69.369 ',
				'I69.390',
				'I69.391',
				'I69.391 ',
				'I69.320 ',
				'I69.392',
				'I69.393',
				'I69.398 ',
				'F09',
				'F91.9',
				'G40.909',
				'G47.37',
				'G82.20',
				'H53.461',
				'H53.462',
				'M79.2',
				'M79.641',
				'M79.642',
				'R25.9',
				'R26.89',
				'R52',
				'I69.80',
				'I69.810',
				'I69.811',
				'I69.812',
				'I69.813',
				'I69.814',
				'I69.815',
				'I69.819',
				'I69.820',
				'I69.821',
				'I69.822',
				'I69.823',
				'I69.828',
				'I69.831',
				'I69.832',
				'I69.833',
				'I69.834',
				'I69.839',
				'I69.841',
				'I69.842',
				'I69.843',
				'I69.844',
				'I69.849',
				'I69.851',
				'I69.852',
				'I69.853',
				'I69.854',
				'I69.859',
				'I69.861',
				'I69.862',
				'I69.863',
				'I69.864',
				'I69.865',
				'I69.869',
				'I69.890',
				'I69.891',
				'I69.892',
				'I69.893',
				'I69.898',
				'I69.898 ',
				'R20.8',
				'I69.90',
				'I69.910',
				'I69.911',
				'I69.912',
				'I69.913',
				'I69.914',
				'I69.915',
				'I69.919',
				'I69.920',
				'I69.921',
				'I69.922',
				'I69.923',
				'I69.928',
				'I69.931',
				'I69.932',
				'I69.933',
				'I69.934',
				'I69.939',
				'I69.941',
				'I69.942',
				'I69.943',
				'I69.944',
				'I69.949',
				'I69.951',
				'I69.952',
				'I69.953',
				'I69.954',
				'I69.959',
				'I69.961',
				'I69.962',
				'I69.963',
				'I69.964',
				'I69.965',
				'I69.969',
				'I69.990',
				'I69.991',
				'I69.992',
				'I69.993',
				'I69.998',
				'I69.998 ',
				'N31.9',
				'R29.898',
				'I70.8',
				'I72.5',
				'I76 ',
				'I77.75',
				'I77.89',
				'I99.8',
				'P52.3',
				'P52.5',
				'P52.8',
				'P52.9',
				'P54.8 ',
				'P91.0 ',
				'S06.2X9A',
				'S06.4X4A',
				'S06.4X9A',
				'S06.5X0A',
				'S06.5X9A',
				'Z86.79')

				)
		
		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
		
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		
		  (T.current_ICD9_List like '430%' or T.current_ICD9_List like '431%' or T.current_ICD9_List like '432%' or
				T.current_ICD9_List like '434%' or T.current_ICD9_List like '435%' or T.current_ICD9_List like '436%' or T.current_ICD9_List like '437%' or 
				T.current_ICD9_List like '438%' )--insert iCD9
		or 
		T.current_ICD10_List in
		('D57.00 ','D57.1','D57.01 ','D57.02 ','G23.2','G45.0',
				'G45.0 ','G45.1','G45.4','G45.8','G45.8 ','I97.89',
				'G45.9','G45.9 ','H54.7','I48.91','I74.9','G46.0','G46.1',
				'G46.2','G46.3','G46.4','G46.5','G46.6','G46.7','G46.8',
				'G81.90','G81.94 ','I61.9','I63.9','G83.9','G93.89','G93.9',
				'G95.19','G96.0','H53.40 ','I69.398','I60.00','I60.01','I60.02',
				'I60.10','I60.11','I60.12','I60.2','I60.20','I60.21','I60.22',
				'I60.30','I60.31','I60.32','I60.4','I60.50','I60.51','I60.52',
				'I60.6','I60.7','I60.8','I60.8 ','I67.1','I60.9','I60.9 ','D68.9',
				'G81.10','G81.11','G81.12','G81.13','G81.14','G81.91','G81.92',
				'G81.93','G81.94','H44.819','I10','Q28.3','R40.20','I61.0',
				'I61.1','I61.2','I61.3','I61.4','I61.4 ','I61.8','I61.5',
				'I61.5 ','D69.9','Q28.2','I61.6','I61.9 ','G81.00','G81.02',
				'G81.03','G81.04','R41.89','I62.00','I62.01','I62.01 ','I62.03',
				'I62.02','I62.03 ','F02.80','I62.1','I62.9','I62.9 ','I63.6',
				'I63.10','I63.111','I63.112','I63.119','I63.12','I63.131','I63.132',
				'I63.139','I63.19','I63.20','I63.211 ','I63.22','I63.212 ','I63.219 ',
				'I63.231','I63.232','I63.29','I63.30','I63.311','I63.312','I63.313',
				'I63.319','I63.321','I63.322','I63.323','I63.329','I63.331','I63.332',
				'I63.333','I63.339','I63.341','I63.342','I63.343','I63.349','I63.39',
				'I63.40','I63.411','I63.412','I63.413','I63.419','I63.421','I63.422',
				'I63.423','I63.429','I63.431','I63.432','I63.433','I63.439','I63.441',
				'I63.442','I63.443','I63.449','I63.49','I63.50','I63.511','I63.512',
				'I63.513','I63.519','I63.521','I63.522','I63.523','I63.529','I63.531',
				'I63.532','I63.533','I63.539','I63.541','I63.542','I63.543','I63.549',
				'I63.59','I63.81','I63.89','I63.9 ','D57.00','D57.01','D57.02','F06.30','F06.31','F07.0',
				'G43.909','G51.0','G83.10','G83.20','R20.9','R26.9','R27.9','R29.810','R29.818',
				'R47.01','R47.1','R48.2','R53.1','R56.9','Z53.09','I66.01','I66.02',
				'I66.03','I66.09','I66.11','I66.12','I66.13','I66.19','I66.21','I66.22','I66.23',
				'I66.29','I66.3','I66.8','I66.9','I67.1 ','I67.0','K74.60 ','J43.9 ','Q89.7','I67.2','I67.2 ',
				'L65.9 ','M54.5','Z86.73','I67.4','I67.5','I67.5 ','K22.0',
				'I67.6',
				'I67.7',
				'I67.81',
				'I67.82',
				'I67.82 ',
				'G93.1',
				'I67.841',
				'I67.848',
				'I67.850',
				'I67.858',
				'I67.89',
				'I67.89 ',
				'F05',
				'G81.01',
				'W88.8XXA ',
				'Z77.123',
				'Y84.2',
				'I67.9',
				'I67.9 ',
				'C80.1',
				'H53.9',
				'R27.0',
				'I68.2',
				'I68.8',
				'I69.00',
				'I69.010',
				'I69.014',
				'I69.015',
				'I69.019',
				'I69.020',
				'I69.021',
				'I69.022',
				'I69.023',
				'I69.028',
				'I69.031',
				'I69.032',
				'I69.033',
				'I69.034',
				'I69.039',
				'I69.041',
				'I69.042',
				'I69.043',
				'I69.044',
				'I69.049',
				'I69.051',
				'I69.052',
				'I69.053',
				'I69.054',
				'I69.059',
				'I69.061',
				'I69.062',
				'I69.063',
				'I69.064',
				'I69.065',
				'I69.069',
				'I69.090',
				'I69.091',
				'I69.092',
				'I69.093',
				'I69.098',
				'I69.10',
				'I69.110',
				'I69.112',
				'I69.114',
				'I69.115',
				'I69.119',
				'I69.120',
				'I69.121',
				'I69.122',
				'I69.123',
				'I69.128',
				'I69.131',
				'I69.132',
				'I69.133',
				'I69.134',
				'I69.139',
				'I69.141',
				'I69.142',
				'I69.143',
				'I69.144',
				'I69.149',
				'I69.151',
				'I69.152',
				'I69.153',
				'I69.154',
				'I69.159',
				'I69.161',
				'I69.162',
				'I69.163',
				'I69.164',
				'I69.165',
				'I69.169',
				'I69.190',
				'I69.191',
				'I69.192',
				'I69.193',
				'I69.198',
				'I69.198 ',
				'G91.0',
				'H53.469',
				'M62.81',
				'R42',
				'I69.20',
				'I69.210',
				'I69.212',
				'I69.214',
				'I69.215',
				'I69.219',
				'I69.220',
				'I69.221',
				'I69.222',
				'I69.223',
				'I69.228',
				'I69.231',
				'I69.232',
				'I69.233',
				'I69.234',
				'I69.239',
				'I69.241',
				'I69.242',
				'I69.243',
				'I69.244',
				'I69.249',
				'I69.251',
				'I69.252',
				'I69.253',
				'I69.254',
				'I69.259',
				'I69.261',
				'I69.262',
				'I69.263',
				'I69.264',
				'I69.265',
				'I69.269',
				'I69.290',
				'I69.291',
				'I69.292',
				'I69.293',
				'I69.298',
				'I69.30',
				'I69.310',
				'I69.311',
				'I69.312',
				'I69.313',
				'I69.314',
				'I69.315',
				'I69.319',
				'I69.320',
				'I69.321',
				'I69.322',
				'I69.323',
				'I69.328',
				'I69.331',
				'I69.332',
				'I69.333',
				'I69.334',
				'I69.339',
				'I69.341',
				'I69.342',
				'I69.343',
				'I69.344',
				'I69.349',
				'I69.351',
				'I69.352',
				'I69.353',
				'I69.354',
				'I69.359',
				'I69.359 ',
				'I69.328 ',
				'I69.361',
				'I69.362',
				'I69.363',
				'I69.364',
				'I69.365',
				'I69.369',
				'I69.369 ',
				'I69.390',
				'I69.391',
				'I69.391 ',
				'I69.320 ',
				'I69.392',
				'I69.393',
				'I69.398 ',
				'F09',
				'F91.9',
				'G40.909',
				'G47.37',
				'G82.20',
				'H53.461',
				'H53.462',
				'M79.2',
				'M79.641',
				'M79.642',
				'R25.9',
				'R26.89',
				'R52',
				'I69.80',
				'I69.810',
				'I69.811',
				'I69.812',
				'I69.813',
				'I69.814',
				'I69.815',
				'I69.819',
				'I69.820',
				'I69.821',
				'I69.822',
				'I69.823',
				'I69.828',
				'I69.831',
				'I69.832',
				'I69.833',
				'I69.834',
				'I69.839',
				'I69.841',
				'I69.842',
				'I69.843',
				'I69.844',
				'I69.849',
				'I69.851',
				'I69.852',
				'I69.853',
				'I69.854',
				'I69.859',
				'I69.861',
				'I69.862',
				'I69.863',
				'I69.864',
				'I69.865',
				'I69.869',
				'I69.890',
				'I69.891',
				'I69.892',
				'I69.893',
				'I69.898',
				'I69.898 ',
				'R20.8',
				'I69.90',
				'I69.910',
				'I69.911',
				'I69.912',
				'I69.913',
				'I69.914',
				'I69.915',
				'I69.919',
				'I69.920',
				'I69.921',
				'I69.922',
				'I69.923',
				'I69.928',
				'I69.931',
				'I69.932',
				'I69.933',
				'I69.934',
				'I69.939',
				'I69.941',
				'I69.942',
				'I69.943',
				'I69.944',
				'I69.949',
				'I69.951',
				'I69.952',
				'I69.953',
				'I69.954',
				'I69.959',
				'I69.961',
				'I69.962',
				'I69.963',
				'I69.964',
				'I69.965',
				'I69.969',
				'I69.990',
				'I69.991',
				'I69.992',
				'I69.993',
				'I69.998',
				'I69.998 ',
				'N31.9',
				'R29.898',
				'I70.8',
				'I72.5',
				'I76 ',
				'I77.75',
				'I77.89',
				'I99.8',
				'P52.3',
				'P52.5',
				'P52.8',
				'P52.9',
				'P54.8 ',
				'P91.0 ',
				'S06.2X9A',
				'S06.4X4A',
				'S06.4X9A',
				'S06.5X0A',
				'S06.5X9A',
				'Z86.79')--Insert ICD10

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		  (T.current_ICD9_List like '430%' or T.current_ICD9_List like '431%' or T.current_ICD9_List like '432%' or
				T.current_ICD9_List like '434%' or T.current_ICD9_List like '435%' or T.current_ICD9_List like '436%' or T.current_ICD9_List like '437%' or 
				T.current_ICD9_List like '438%') --insert icd9
		or 
		T.current_ICD10_List in
		('D57.00 ','D57.1','D57.01 ','D57.02 ','G23.2','G45.0',
				'G45.0 ','G45.1','G45.4','G45.8','G45.8 ','I97.89',
				'G45.9','G45.9 ','H54.7','I48.91','I74.9','G46.0','G46.1',
				'G46.2','G46.3','G46.4','G46.5','G46.6','G46.7','G46.8',
				'G81.90','G81.94 ','I61.9','I63.9','G83.9','G93.89','G93.9',
				'G95.19','G96.0','H53.40 ','I69.398','I60.00','I60.01','I60.02',
				'I60.10','I60.11','I60.12','I60.2','I60.20','I60.21','I60.22',
				'I60.30','I60.31','I60.32','I60.4','I60.50','I60.51','I60.52',
				'I60.6','I60.7','I60.8','I60.8 ','I67.1','I60.9','I60.9 ','D68.9',
				'G81.10','G81.11','G81.12','G81.13','G81.14','G81.91','G81.92',
				'G81.93','G81.94','H44.819','I10','Q28.3','R40.20','I61.0',
				'I61.1','I61.2','I61.3','I61.4','I61.4 ','I61.8','I61.5',
				'I61.5 ','D69.9','Q28.2','I61.6','I61.9 ','G81.00','G81.02',
				'G81.03','G81.04','R41.89','I62.00','I62.01','I62.01 ','I62.03',
				'I62.02','I62.03 ','F02.80','I62.1','I62.9','I62.9 ','I63.6',
				'I63.10','I63.111','I63.112','I63.119','I63.12','I63.131','I63.132',
				'I63.139','I63.19','I63.20','I63.211 ','I63.22','I63.212 ','I63.219 ',
				'I63.231','I63.232','I63.29','I63.30','I63.311','I63.312','I63.313',
				'I63.319','I63.321','I63.322','I63.323','I63.329','I63.331','I63.332',
				'I63.333','I63.339','I63.341','I63.342','I63.343','I63.349','I63.39',
				'I63.40','I63.411','I63.412','I63.413','I63.419','I63.421','I63.422',
				'I63.423','I63.429','I63.431','I63.432','I63.433','I63.439','I63.441',
				'I63.442','I63.443','I63.449','I63.49','I63.50','I63.511','I63.512',
				'I63.513','I63.519','I63.521','I63.522','I63.523','I63.529','I63.531',
				'I63.532','I63.533','I63.539','I63.541','I63.542','I63.543','I63.549',
				'I63.59','I63.81','I63.89','I63.9 ','D57.00','D57.01','D57.02','F06.30','F06.31','F07.0',
				'G43.909','G51.0','G83.10','G83.20','R20.9','R26.9','R27.9','R29.810','R29.818',
				'R47.01','R47.1','R48.2','R53.1','R56.9','Z53.09','I66.01','I66.02',
				'I66.03','I66.09','I66.11','I66.12','I66.13','I66.19','I66.21','I66.22','I66.23',
				'I66.29','I66.3','I66.8','I66.9','I67.1 ','I67.0','K74.60 ','J43.9 ','Q89.7','I67.2','I67.2 ',
				'L65.9 ','M54.5','Z86.73','I67.4','I67.5','I67.5 ','K22.0',
				'I67.6',
				'I67.7',
				'I67.81',
				'I67.82',
				'I67.82 ',
				'G93.1',
				'I67.841',
				'I67.848',
				'I67.850',
				'I67.858',
				'I67.89',
				'I67.89 ',
				'F05',
				'G81.01',
				'W88.8XXA ',
				'Z77.123',
				'Y84.2',
				'I67.9',
				'I67.9 ',
				'C80.1',
				'H53.9',
				'R27.0',
				'I68.2',
				'I68.8',
				'I69.00',
				'I69.010',
				'I69.014',
				'I69.015',
				'I69.019',
				'I69.020',
				'I69.021',
				'I69.022',
				'I69.023',
				'I69.028',
				'I69.031',
				'I69.032',
				'I69.033',
				'I69.034',
				'I69.039',
				'I69.041',
				'I69.042',
				'I69.043',
				'I69.044',
				'I69.049',
				'I69.051',
				'I69.052',
				'I69.053',
				'I69.054',
				'I69.059',
				'I69.061',
				'I69.062',
				'I69.063',
				'I69.064',
				'I69.065',
				'I69.069',
				'I69.090',
				'I69.091',
				'I69.092',
				'I69.093',
				'I69.098',
				'I69.10',
				'I69.110',
				'I69.112',
				'I69.114',
				'I69.115',
				'I69.119',
				'I69.120',
				'I69.121',
				'I69.122',
				'I69.123',
				'I69.128',
				'I69.131',
				'I69.132',
				'I69.133',
				'I69.134',
				'I69.139',
				'I69.141',
				'I69.142',
				'I69.143',
				'I69.144',
				'I69.149',
				'I69.151',
				'I69.152',
				'I69.153',
				'I69.154',
				'I69.159',
				'I69.161',
				'I69.162',
				'I69.163',
				'I69.164',
				'I69.165',
				'I69.169',
				'I69.190',
				'I69.191',
				'I69.192',
				'I69.193',
				'I69.198',
				'I69.198 ',
				'G91.0',
				'H53.469',
				'M62.81',
				'R42',
				'I69.20',
				'I69.210',
				'I69.212',
				'I69.214',
				'I69.215',
				'I69.219',
				'I69.220',
				'I69.221',
				'I69.222',
				'I69.223',
				'I69.228',
				'I69.231',
				'I69.232',
				'I69.233',
				'I69.234',
				'I69.239',
				'I69.241',
				'I69.242',
				'I69.243',
				'I69.244',
				'I69.249',
				'I69.251',
				'I69.252',
				'I69.253',
				'I69.254',
				'I69.259',
				'I69.261',
				'I69.262',
				'I69.263',
				'I69.264',
				'I69.265',
				'I69.269',
				'I69.290',
				'I69.291',
				'I69.292',
				'I69.293',
				'I69.298',
				'I69.30',
				'I69.310',
				'I69.311',
				'I69.312',
				'I69.313',
				'I69.314',
				'I69.315',
				'I69.319',
				'I69.320',
				'I69.321',
				'I69.322',
				'I69.323',
				'I69.328',
				'I69.331',
				'I69.332',
				'I69.333',
				'I69.334',
				'I69.339',
				'I69.341',
				'I69.342',
				'I69.343',
				'I69.344',
				'I69.349',
				'I69.351',
				'I69.352',
				'I69.353',
				'I69.354',
				'I69.359',
				'I69.359 ',
				'I69.328 ',
				'I69.361',
				'I69.362',
				'I69.363',
				'I69.364',
				'I69.365',
				'I69.369',
				'I69.369 ',
				'I69.390',
				'I69.391',
				'I69.391 ',
				'I69.320 ',
				'I69.392',
				'I69.393',
				'I69.398 ',
				'F09',
				'F91.9',
				'G40.909',
				'G47.37',
				'G82.20',
				'H53.461',
				'H53.462',
				'M79.2',
				'M79.641',
				'M79.642',
				'R25.9',
				'R26.89',
				'R52',
				'I69.80',
				'I69.810',
				'I69.811',
				'I69.812',
				'I69.813',
				'I69.814',
				'I69.815',
				'I69.819',
				'I69.820',
				'I69.821',
				'I69.822',
				'I69.823',
				'I69.828',
				'I69.831',
				'I69.832',
				'I69.833',
				'I69.834',
				'I69.839',
				'I69.841',
				'I69.842',
				'I69.843',
				'I69.844',
				'I69.849',
				'I69.851',
				'I69.852',
				'I69.853',
				'I69.854',
				'I69.859',
				'I69.861',
				'I69.862',
				'I69.863',
				'I69.864',
				'I69.865',
				'I69.869',
				'I69.890',
				'I69.891',
				'I69.892',
				'I69.893',
				'I69.898',
				'I69.898 ',
				'R20.8',
				'I69.90',
				'I69.910',
				'I69.911',
				'I69.912',
				'I69.913',
				'I69.914',
				'I69.915',
				'I69.919',
				'I69.920',
				'I69.921',
				'I69.922',
				'I69.923',
				'I69.928',
				'I69.931',
				'I69.932',
				'I69.933',
				'I69.934',
				'I69.939',
				'I69.941',
				'I69.942',
				'I69.943',
				'I69.944',
				'I69.949',
				'I69.951',
				'I69.952',
				'I69.953',
				'I69.954',
				'I69.959',
				'I69.961',
				'I69.962',
				'I69.963',
				'I69.964',
				'I69.965',
				'I69.969',
				'I69.990',
				'I69.991',
				'I69.992',
				'I69.993',
				'I69.998',
				'I69.998 ',
				'N31.9',
				'R29.898',
				'I70.8',
				'I72.5',
				'I76 ',
				'I77.75',
				'I77.89',
				'I99.8',
				'P52.3',
				'P52.5',
				'P52.8',
				'P52.9',
				'P54.8 ',
				'P91.0 ',
				'S06.2X9A',
				'S06.4X4A',
				'S06.4X9A',
				'S06.5X0A',
				'S06.5X9A',
				'Z86.79') --insert ic10

		)

--End Step 5

--End Stroke **************************


--Start TIA *******************
	-- Step 1 Getting all pat ids from the Problem List, Medical Hx

	--from problem list
		INSERT INTO #Pat_ID_PL (Pat_ID,Dx_ID,Noted_Date,Date_of_Entry)
		select distinct C.Pat_ID,P.Dx_ID,P.Noted_Date,P.Date_of_Entry  
		from #Epic_Consults C
			INNER JOIN Problem_List P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where  
		(
		 E.current_ICD9_List in
		  ('434','434.1','434.91','435.9',
			'435','435.1','435.3','435.8',
			'369.9','444.9','997.01')
		or 
		E.current_ICD10_List in
		('G45.0','G45.1','G45.8','I97.89',
			'G45.9','H54.7','I74.9','G97.81',
		'G97.82','I63.9','I66.9','Z82.3','Z86.69','Z86.73')

		)
		
		--Medical Hx

		INSERT INTO #Pat_ID_MH (Pat_ID,Dx_ID,Contact_Date,Medical_Hx_Date,Med_Hx_Start_Dt)
		select distinct P.Pat_ID,P.Dx_ID,P.Contact_Date,P.Medical_Hx_Date,P.Med_Hx_Start_Dt

		from #Epic_Consults C
			INNER JOIN medical_hx P on C.Pat_ID = P.Pat_ID
			inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
		where -- P.NOTED_DATE is not null and
				(
		 E.current_ICD9_List in
		  ('434','434.1','434.91','435.9',
				'435','435.1','435.3','435.8',
			'369.9','444.9','997.01')
		or 
		E.current_ICD10_List in
		('G45.0','G45.1','G45.8','I97.89',
			'G45.9','H54.7','I74.9','G97.81',
			'G97.82','I63.9','I66.9','Z82.3','Z86.69','Z86.73')

		)
		
		--get new noted dates for the Problem List

		INSERT INTO #Pat_ID_PL_2(Pat_ID, Dx_ID,New_Noted_Date)
		 select Pat_ID, Dx_ID,
				case when Noted_Date > Date_of_Entry or Noted_Date is null then Date_of_Entry else Noted_Date
					end as New_Noted_Date
			from #Pat_ID_PL


		-- start Step 2  Get dates from MX
		Update #Pat_ID_MH Set Medical_Hx_Date = null 
		where Isdate(Medical_Hx_Date) = 0

		Update #Pat_ID_MH Set Medical_Hx_Date = '01/01/' +Medical_Hx_Date
		where len(Medical_Hx_Date) <5


		INSERT INTO #Pat_ID_MH_2 (Pat_ID,Dx_ID,Med_Hx_Start_Dt) 
		select distinct Pat_ID,Dx_ID, Med_Hx_Start_Dt from #Pat_ID_MH where Medical_Hx_Date is null and Med_Hx_Start_Dt is not null

		--pull Med_Hx_Start_Dt into Medical_Hx_Date where there is null
		Update C 
		SET C.Medical_Hx_Date = T1.Med_Hx_Start_Dt 
		FROM #Pat_ID_MH C INNER JOIN #Pat_ID_MH_2 T1 on (C.Pat_ID = T1.Pat_ID and C.Dx_ID = T1.Dx_ID)
		where C.Medical_Hx_Date is null


		INSERT INTO #Pat_ID_MH_List(Pat_ID, Dx_ID,New_Medical_Hx_Date)
		 select Pat_ID, Dx_ID,
				case when convert(datetime,Medical_Hx_Date) > Contact_Date or convert(datetime,Medical_Hx_Date) is null then Contact_Date else convert(datetime,Medical_Hx_Date) 
					end as New_Medical_Hx_Date
			from #Pat_ID_MH

		-- Step 2 end Mx

		-- Start Step 3 Insert Problem List and Medical Hx to Pat_IDs table

			--PL
			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Noted_Date from #Pat_ID_PL_2

			INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
				Select Pat_ID, Dx_ID,New_Medical_Hx_Date from #Pat_ID_MH_List

		--end step 3
		
	
--start step 4 Get all ED and Inpatient vists

	-- this is to get all ED and ed to inpatient. (very good one)
	INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
		Select T.Pat_ID,T.DX_ID,T.contact_date
		from 
		(
		select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,E.Pat_Enc_CSN_ID,
			EN.CONTACT_DATE,
			e.ED_EPISODE_ID,EN.ENC_TYPE_C, E.INP_ADM_DATE,
			E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
			z.name,
			Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
				 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
				 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
				 --ED patients only
				 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
				  --when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
					end as Enc_Type,
					ED.dx_ID,
					edg.CURRENT_ICD9_LIST,
					edg.CURRENT_ICD10_LIST,
					edg.DX_NAME,
					D.DEPARTMENT_NAME,
					C.BIRTH_DATE,
					DATEDIFF(yy,C.Birth_date,GetDate()) as Age
		from #Epic_Consults HF 
		inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
		inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.Pat_ID = HF.Pat_ID
		inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.Pat_ID = HF.Pat_ID
		inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID) 
		inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
		inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
		inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
		inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
		where --I.IDENTITY_TYPE_ID = '100' and
		 EN.ENC_TYPE_C = '3') T
		 where T.Enc_type is not null
		 and 
		 (
		 T.current_ICD9_List in
		  ('434','434.1','434.91','435.9',
			'435','435.1','435.3','435.8',
			'369.9','444.9','997.01')
		or 
		T.current_ICD10_List in
		('G45.0','G45.1','G45.8','I97.89',
			'G45.9','H54.7','I74.9','G97.81',
			'G97.82','I63.9','I66.9','Z82.3','Z86.69','Z86.73')

		)


--End step 4

--Start Step 5 Get all Office visits

	
 -- this is to get all Office vists. 
INSERT INTO #Pat_IDs (Pat_ID,Dx_ID,Noted_Date)
Select T.Pat_ID,T.DX_ID,T.contact_date
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID, EN.Pat_Enc_CSN_ID,
	EN.CONTACT_DATE,
	EN.ENC_TYPE_C,
	--e.ED_EPISODE_ID,, E.INP_ADM_DATE,
	--E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,  
	z.name,
	Case 
		  when EN.ENC_TYPE_C = '101' and EN.Contact_Date is not null   then 'Office_Visit'
			end as Enc_Type,
			ED.dx_ID,
			edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,
			edg.DX_NAME,
			D.DEPARTMENT_NAME,
			C.BIRTH_DATE,
			DATEDIFF(yy,C.Birth_date,GetDate()) as Age
	from #Epic_Consults HF 
	inner JOIN Patient C on C.Pat_ID = HF.Pat_ID
inner join Pat_Enc EN on C.PAT_ID = EN.PAT_ID and EN.Pat_ID = HF.Pat_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = EN.PAT_ID and ED.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and ED.Pat_ID = HF.Pat_ID)
inner join Identity_ID I on HF.PAT_ID = I.PAT_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
inner join Clarity_dep D on D.DEPARTMENT_ID = en.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '101') T
 where T.Enc_type is not null
 and 
		(
		 T.current_ICD9_List in
		  ('434','434.1','434.91','435.9',
			'435','435.1','435.3','435.8',
			'369.9','444.9','997.01')
		or 
		T.current_ICD10_List in
		('G45.0','G45.1','G45.8','I97.89',
		'G45.9','H54.7','I74.9','G97.81',
		'G97.82','I63.9','I66.9','Z82.3','Z86.69','Z86.73')

		)

--End Step 5

--End TIA **************************

-- First noted date of the disease for the Pat_Ids do it for all diseases as a last step
INSERT INTO #Pat_ID_First_Date (Pat_ID,Dx_ID,Noted_Date)
Select Pat_ID,DX_ID,Noted_date
from 
(
select T.Pat_ID,T.DX_ID,T.Noted_date,
	ROW_NUMBER() OVER (PARTITION BY T.PAT_ID, T.Dx_ID ORDER BY T.Noted_date ASC) AS ROW_NUM
	from #Pat_IDs T ) First_Noted_date --where T.Noted_Date is not null
	where row_num = 1

-- get the problem list
-- start HF
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'HF' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		  ('398.91','402.01','402.11','402.91','404.01','404.03','404.11','404.13','404.91','404.93','425.4',
		'425.5','425.7','425.8','425.9','428.0','428.1','428.2','428.21','428.22','428.23','428.3','428.31',
		'428.32','428.33','428.4','428.41','428.42','428.43','428.90')
		or 
		E.current_ICD10_List in
		('I50.9','I50.20','I50.40','I50.30','I50.32','I50.33','I50.810',
		'I50.31','I50.42','I50.81','I50.812','I50.82','I50.84','I50.1','I11.0',
		'I50.21','I50.23','I50.811','I50.22','I50.41','I50.43','I50.813',
		'I50.8','I50.814','I50.83','I50.90','II50.32','I50.2','I50.4',
		'I50','I51.7','I50.3','I50.89')

		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end HF

--Start CAD
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'CAD' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
	(
		 E.current_ICD9_List in
		('410.0','410.00','410.01','410.02','410.1','410.10','410.11','410.11','410.12','410.20','410.21','410.22',
		'410.30','410.31','410.32','410.40','410.41','410.42','410.50','410.51','410.52','410.60','410.61','410.62',
		'410.70','410.71','410.72','410.80','410.81','410.82','410.90','410.91','410.92','411.0','411.1','411.89',
		'412','413','413.0','413.1','413.9','414','414.01','414.02','414.03','414.04','414.05','414.06','414.07',
		'414.10','414.11','414.12','414.19','414.2','414.3','414.4','414.8','414.9' )
		or 
		E.current_ICD10_List in
		('I20.9','I20','I20.0','I20.1','I20.8','I21','I21.0','I21.01','I21.02','I21.09',
		'I21.29','I21.1','I21.11','I21.19','I21.2','I21.21','I23.6','I21.3','I21.4',
		'I21.9','I21.A','I21.A1','I21.A9','I23.8','I25.9','I25.9 ','I51.3','I22',
		'I22.0','I22.1','I22.2','I22.8','I22.9','I23','I23.0','I23.1','I23.2','I23.3','I23.4','I23.5',
		'I23.7','I24.1','I25.810','I25','I25.1','I25.10','I25.10 ','I25.2','I25.82','I25.83',
		'I25.84','I25.11','I25.110','I25.111','I25.118','I25.119','I25.3','I25.4','I25.41',
		'I25.42','I25.5','I25.6','I25.7','I25.70','I25.700','I25.701','I25.708','I25.709''I25.71',
		'I25.710','I25.711','I25.718','I25.719','I25.72','I25.720','I25.721','I25.728','I25.729',
		'I25.73','I25.730','I25.731','I25.738','I25.739','I25.75','I25.750','I25.751','I25.758',
		'I25.759','I25.76','I25.760','I25.761','I25.768','I25.769','I25.79','I25.790','I25.791',
		'I25.798','I25.799','I25.8','I25.81','I25.811','I25.812','I25.89','I50.32','I50.33')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--End CAD

-- start HTN
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'HTN' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		 ('401','401.0','401.1','401.9','402','402.0','402.01','402.1','402.10','402.11','402.90','402.91',
		'403','403.00','403.01','403.10','403.11','403.90','403.91','404','404.0','404.01','404.02','404.03',
		'404.10','404.11','404.12','404.13','404.90','404.91','404.92','404.93','405','405.0','405.01','405.09',
		'405.1','405.11','405.19','405.9','405.91','405.99')

		or 
		E.current_ICD10_List in
		('I10','I11','I11.0','I11.9','I13','I13.0','I13.1',
		'I13.10','I13.11','I13.2','I15','I15.1','I15.2','I15.8','I15.9')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end HTN

-- start Dyslipidemia
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Dyslipidemia' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		 ('272','272.0','272.1','272.2','272.3','272.4','272.5','272.6','272.7','272.8','272.9',
			'272','272.2','272.4','249.8','272.3','272.5'
		,'250.8','250.81','272.1')
		or 
		E.current_ICD10_List in
		('E78.0','E78.00','E78.01','E.78.2','E.78.4','E78.5',
			'E10.69','E78.2','E78.01','E78.49','E09.69'
		,'E78.5','E11.69','E13.69','E78.3','E78.1'
		,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end Dyslipidemia

-- start Afib
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Afib' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		 ('427.3','427.31','427.32')
		or 
		E.current_ICD10_List in
		('I48.0','I48.1','I48.2','I48.3','I48.4','I48.9','I48.91','I48.92')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end Afib

-- start MI
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'MI' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List like '410%'
		or 
		E.current_ICD10_List in
		('I21.01','I21.11','I24.9','I21.A1','I22.8','I21.09',
		'I21.9','Z51.89','I21.A9','I22.0','I23.8','I51.89',
		'I21.4','I23.3','T50.905A','I21.3','I32','I22.9',
		'I25.9','I22.1','I21.02','I21.09 ','I21.29','I21.19','I21.21',
		'I51.3','Z09, ','I25.2','I22.2','I24.0')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end MI

-- start PAD
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'PAD' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
				 E.current_ICD9_List in
				 ('093.0','437.3','440.1','440.2','440.3','440.4','440.5','440.6','440.7','440.8','440.9',
				'441.1','441.2','441.3','441.4','441.5','441.6','441.7','441.8','441.9',
				'443.1','443.2','443.3','443.4','443.5','443.6','443.7','443.8','443.9',
				'47.1','557.1','557.9','V43.4')
				or 
				E.current_ICD10_List in
				('I70.438','I70.448','I70.439','I70.449','I70.44','I70.45','I70.46',
				'I70.461','I70.462','I70.463','I70.468','I70.469','I70.49','I70.491','I70.492',
				'I70.493','I70.498','I70.499','I70.5','I70.50','I70.501','I70.502','I70.503','I70.508',
				'I70.509','I70.51','I70.511',
				'I70.512','I70.513','I70.518','I70.519','I70.52','I70.521',
				'I70.522','I70.523','I70.528','I70.529','I70.53','I70.531','I70.531 ',
				'I70.541','I70.532','I70.542','I70.533','I70.533 ','I70.543','I70.534','I70.544',
				'I70.535','I70.545','I70.538','I70.538','I70.548','I70.539','I70.539 ',
				'I70.549','I70.54','I70.55','I70.56','I70.561','I70.562','I70.563','I70.568',
				'I70.569','I70.59','I70.591','I70.592','I70.593','I70.598','I70.599','I70.6',
				'I70.60','I70.601','I70.602','I70.603','I70.608','I70.609','I70.61',
				'I70.611','I70.612','I70.613','I70.618','I70.619','I70.62','I70.621',
				'I70.622','I70.623','I70.628','I70.629','I70.63','I70.631','I70.631 ',
				'I70.641','I70.632','I70.632 ','I70.642','I70.633','I70.643','I70.634','I70.644',
				'I70.635','I70.645','I70.638','I70.648',
				'I70.639','I70.639 ','I70.649','I70.64','I70.65','I70.66','I70.661','I70.662',
				'I70.663','I70.668','I70.669','I70.69','I70.691','I70.692','I70.693',
				'I70.698','I70.699','I70.7','I70.70','I70.701','I70.702','I70.703','I70.708',
				'I70.709','I70.71','I70.711','I70.712','I70.713','I70.718','I70.719','I70.72',
				'I70.721','I70.722','I70.723','I70.728','I70.729','I70.73','I70.731','I70.741','I70.732',
				'I70.732 ','I70.742','I70.733','I70.743','I70.734','I70.744','I70.735','I70.745',
				'I70.738','I70.738 ','I70.748','I70.739','I70.739 ','I70.749','I70.74','I70.75',
				'I70.76','I70.761','I70.762','I70.763','I70.768','I70.769','I70.79',
				'I70.791','I70.792','I70.793','I70.798','I70.799','I70.9','I70.90',
				'I70.91','I70.92','I71.0','I71.00','I71.01','I71.02','I71.03','I71.1',
				'I71.2','I71.3','I71.4','I71.5','I71.6','I71.8','I71.9','I73.1',
				'I73.8','I73.9','I77.1','I79.0','I79.2','K55.1','K55.8','K55.9','Z95.8','Z95.9'
				)
				)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end PAD

-- start 'Stable_Angina'
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Stable_Angina' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
			 E.current_ICD9_List ='413.9'

			or 
			E.current_ICD10_List in ('I20.0','I20.1','I20.8','I20.9')
			)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end 'Stable_Angina'

-- start 'UNStable_Angina'
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'UnStable_Angina' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List ='411.1'

		or 
		E.current_ICD10_List in ('I20.0','I24.9')

		)
				and P.noted_DATE is not null 
		) closest_to_proc

--- end 'UNStable_Angina'

-- start 'Ischemic_Stroke'
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Ischemic_Stroke' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
		(
		 (E.current_ICD9_List = '434.11' or E.current_ICD9_List = '434.91' or E.current_ICD9_List like '436%' )
		or 
		E.current_ICD10_List in
		('I63.119','I63.431','I63.433','I63.449','I63.519','Z86.73',
		'G81.90','I63.10','I63.12','I63.139','I63.29','I63.543','I63.549',
		'G46.4','G46.5','I63.112','I63.232','I63.419','I63.429','I63.439',
		'I63.49','I63.513','I63.539','P91.0 ','I61.9','I63.219','I63.22',
		'I63.422','I63.522','I63.542','I63.89','I69.30','P91.0','I63.532',
		'G46.6','I63.19','I63.231','I63.411','I63.413','I63.421','I63.50','I63.531',
		'I63.59','I63.6','I63.81','P91.0, ','I63.511','I63.412','I63.432','I63.523',
		'I63.529','G46.3','I63.131','I63.20','I63.40','I63.442','I63.443','I63.512',
		'I63.533','I63.521','I63.111','I63.132','I63.211','I63.212 ','I63.423',
		'I63.441','I63.541','I63.9','I67.89'
		)
		)
				and P.noted_DATE is not null 
		) closest_to_proc

--- end Ischemic_Stroke

-- start Stroke'
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Stroke' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
		(
 (E.current_ICD9_List like '430%' or E.current_ICD9_List like '431%' or E.current_ICD9_List like '432%' or
E.current_ICD9_List like '434%' or E.current_ICD9_List like '435%' or E.current_ICD9_List like '436%' or E.current_ICD9_List like '437%' or 
E.current_ICD9_List like '438%' )
or 
E.current_ICD10_List in
('D57.00 ','D57.1','D57.01 ','D57.02 ','G23.2','G45.0',
'G45.0 ','G45.1','G45.4','G45.8','G45.8 ','I97.89',
'G45.9','G45.9 ','H54.7','I48.91','I74.9','G46.0','G46.1',
'G46.2','G46.3','G46.4','G46.5','G46.6','G46.7','G46.8',
'G81.90','G81.94 ','I61.9','I63.9','G83.9','G93.89','G93.9',
'G95.19','G96.0','H53.40 ','I69.398','I60.00','I60.01','I60.02',
'I60.10','I60.11','I60.12','I60.2','I60.20','I60.21','I60.22',
'I60.30','I60.31','I60.32','I60.4','I60.50','I60.51','I60.52',
'I60.6','I60.7','I60.8','I60.8 ','I67.1','I60.9','I60.9 ','D68.9',
'G81.10','G81.11','G81.12','G81.13','G81.14','G81.91','G81.92',
'G81.93','G81.94','H44.819','I10','Q28.3','R40.20','I61.0',
'I61.1','I61.2','I61.3','I61.4','I61.4 ','I61.8','I61.5',
'I61.5 ','D69.9','Q28.2','I61.6','I61.9 ','G81.00','G81.02',
'G81.03','G81.04','R41.89','I62.00','I62.01','I62.01 ','I62.03',
'I62.02','I62.03 ','F02.80','I62.1','I62.9','I62.9 ','I63.6',
'I63.10','I63.111','I63.112','I63.119','I63.12','I63.131','I63.132',
'I63.139','I63.19','I63.20','I63.211 ','I63.22','I63.212 ','I63.219 ',
'I63.231','I63.232','I63.29','I63.30','I63.311','I63.312','I63.313',
'I63.319','I63.321','I63.322','I63.323','I63.329','I63.331','I63.332',
'I63.333','I63.339','I63.341','I63.342','I63.343','I63.349','I63.39',
'I63.40','I63.411','I63.412','I63.413','I63.419','I63.421','I63.422',
'I63.423','I63.429','I63.431','I63.432','I63.433','I63.439','I63.441',
'I63.442','I63.443','I63.449','I63.49','I63.50','I63.511','I63.512',
'I63.513','I63.519','I63.521','I63.522','I63.523','I63.529','I63.531',
'I63.532','I63.533','I63.539','I63.541','I63.542','I63.543','I63.549',
'I63.59','I63.81','I63.89','I63.9 ','D57.00','D57.01','D57.02','F06.30','F06.31','F07.0',
'G43.909','G51.0','G83.10','G83.20','R20.9','R26.9','R27.9','R29.810','R29.818',
'R47.01','R47.1','R48.2','R53.1','R56.9','Z53.09','I66.01','I66.02',
'I66.03','I66.09','I66.11','I66.12','I66.13','I66.19','I66.21','I66.22','I66.23',
'I66.29','I66.3','I66.8','I66.9','I67.1 ','I67.0','K74.60 ','J43.9 ','Q89.7','I67.2','I67.2 ',
'L65.9 ','M54.5','Z86.73','I67.4','I67.5','I67.5 ','K22.0',
'I67.6',
'I67.7',
'I67.81',
'I67.82',
'I67.82 ',
'G93.1',
'I67.841',
'I67.848',
'I67.850',
'I67.858',
'I67.89',
'I67.89 ',
'F05',
'G81.01',
'W88.8XXA ',
'Z77.123',
'Y84.2',
'I67.9',
'I67.9 ',
'C80.1',
'H53.9',
'R27.0',
'I68.2',
'I68.8',
'I69.00',
'I69.010',
'I69.014',
'I69.015',
'I69.019',
'I69.020',
'I69.021',
'I69.022',
'I69.023',
'I69.028',
'I69.031',
'I69.032',
'I69.033',
'I69.034',
'I69.039',
'I69.041',
'I69.042',
'I69.043',
'I69.044',
'I69.049',
'I69.051',
'I69.052',
'I69.053',
'I69.054',
'I69.059',
'I69.061',
'I69.062',
'I69.063',
'I69.064',
'I69.065',
'I69.069',
'I69.090',
'I69.091',
'I69.092',
'I69.093',
'I69.098',
'I69.10',
'I69.110',
'I69.112',
'I69.114',
'I69.115',
'I69.119',
'I69.120',
'I69.121',
'I69.122',
'I69.123',
'I69.128',
'I69.131',
'I69.132',
'I69.133',
'I69.134',
'I69.139',
'I69.141',
'I69.142',
'I69.143',
'I69.144',
'I69.149',
'I69.151',
'I69.152',
'I69.153',
'I69.154',
'I69.159',
'I69.161',
'I69.162',
'I69.163',
'I69.164',
'I69.165',
'I69.169',
'I69.190',
'I69.191',
'I69.192',
'I69.193',
'I69.198',
'I69.198 ',
'G91.0',
'H53.469',
'M62.81',
'R42',
'I69.20',
'I69.210',
'I69.212',
'I69.214',
'I69.215',
'I69.219',
'I69.220',
'I69.221',
'I69.222',
'I69.223',
'I69.228',
'I69.231',
'I69.232',
'I69.233',
'I69.234',
'I69.239',
'I69.241',
'I69.242',
'I69.243',
'I69.244',
'I69.249',
'I69.251',
'I69.252',
'I69.253',
'I69.254',
'I69.259',
'I69.261',
'I69.262',
'I69.263',
'I69.264',
'I69.265',
'I69.269',
'I69.290',
'I69.291',
'I69.292',
'I69.293',
'I69.298',
'I69.30',
'I69.310',
'I69.311',
'I69.312',
'I69.313',
'I69.314',
'I69.315',
'I69.319',
'I69.320',
'I69.321',
'I69.322',
'I69.323',
'I69.328',
'I69.331',
'I69.332',
'I69.333',
'I69.334',
'I69.339',
'I69.341',
'I69.342',
'I69.343',
'I69.344',
'I69.349',
'I69.351',
'I69.352',
'I69.353',
'I69.354',
'I69.359',
'I69.359 ',
'I69.328 ',
'I69.361',
'I69.362',
'I69.363',
'I69.364',
'I69.365',
'I69.369',
'I69.369 ',
'I69.390',
'I69.391',
'I69.391 ',
'I69.320 ',
'I69.392',
'I69.393',
'I69.398 ',
'F09',
'F91.9',
'G40.909',
'G47.37',
'G82.20',
'H53.461',
'H53.462',
'M79.2',
'M79.641',
'M79.642',
'R25.9',
'R26.89',
'R52',
'I69.80',
'I69.810',
'I69.811',
'I69.812',
'I69.813',
'I69.814',
'I69.815',
'I69.819',
'I69.820',
'I69.821',
'I69.822',
'I69.823',
'I69.828',
'I69.831',
'I69.832',
'I69.833',
'I69.834',
'I69.839',
'I69.841',
'I69.842',
'I69.843',
'I69.844',
'I69.849',
'I69.851',
'I69.852',
'I69.853',
'I69.854',
'I69.859',
'I69.861',
'I69.862',
'I69.863',
'I69.864',
'I69.865',
'I69.869',
'I69.890',
'I69.891',
'I69.892',
'I69.893',
'I69.898',
'I69.898 ',
'R20.8',
'I69.90',
'I69.910',
'I69.911',
'I69.912',
'I69.913',
'I69.914',
'I69.915',
'I69.919',
'I69.920',
'I69.921',
'I69.922',
'I69.923',
'I69.928',
'I69.931',
'I69.932',
'I69.933',
'I69.934',
'I69.939',
'I69.941',
'I69.942',
'I69.943',
'I69.944',
'I69.949',
'I69.951',
'I69.952',
'I69.953',
'I69.954',
'I69.959',
'I69.961',
'I69.962',
'I69.963',
'I69.964',
'I69.965',
'I69.969',
'I69.990',
'I69.991',
'I69.992',
'I69.993',
'I69.998',
'I69.998 ',
'N31.9',
'R29.898',
'I70.8',
'I72.5',
'I76 ',
'I77.75',
'I77.89',
'I99.8',
'P52.3',
'P52.5',
'P52.8',
'P52.9',
'P54.8 ',
'P91.0 ',
'S06.2X9A',
'S06.4X4A',
'S06.4X9A',
'S06.5X0A',
'S06.5X9A',
'Z86.79')

)
				and P.noted_DATE is not null 
		) closest_to_proc

--- end Stroke


-- start Aortic_Aneurysm
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Aortic_Aneurysm' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
			 E.current_ICD9_List in
			 ('93','93.9','420','441','441.01',
			'441.02','441.03','441.1','441.2',
			'441.3','441.4','441.5','441.6','441.7',
			'441.9','909.3','442.1')
			or 
			E.current_ICD10_List in
			('A52.01','I71','I71.00','I71.01','I71.02','I71.03'
			,'I71.1','I32','I71.2','I71.3','I71.4','I71.5','I71.6','I71.8'
			,'I71.9 ','Q25.43','Z13.6','Z82.49','Z86.79','Z98.890','Z95.828')

			)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end Aortic_Aneurysm

-- start ACS
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'ACS' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		 ('411.1','786.50','790.6')
		or 
		E.current_ICD10_List in
		('I24.9','R07.9','R79.89','Z09')
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end ACS

-- start Hyperlipidemia
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Hyperlipidemia' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
			 E.current_ICD9_List in
			 ('272','272.2','272.4','249.8','272.3','272.5'
			,'250.8','250.81','272.1')
			or 
			E.current_ICD10_List in
			('E10.69','E78.2','E78.01','E78.49','E09.69'
			,'E78.5','E11.69','E13.69','E78.3','E78.1'
			,'E78.5','E78.6','Z83.438','Z86.39','E78.00','E78.4')

			)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end Hyperlipidemia

-- start Sec_Cardiomyopathy
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'Sec_Cardiomyopathy' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
		(
		 E.current_ICD9_List = '425.9'

		or 
		E.current_ICD10_List ='I42.9'
		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end Sec_Cardiomyopathy


-- start TIA
INSERT INTO #ProblemList
(	
	Pat_Id,
	MRN,
	Order_Date,
	Noted_Date,
	dx_id,
	current_ICD9_List,
	current_ICD10_List,
	Disease_Group,
	Diagnosis_name,
	DtmDiff 

)
SELECT pat_id, mrn,Order_Date,noted_date,dx_id,current_ICD9_List,current_ICD10_List, 'TIA' as Disease_Group,DX_NAME,date_diff
FROM (
SELECT
	C.PAT_ID, 
	C.MRN,
	C.Order_Date,
	P.Noted_date,
	E.Dx_ID,
	E.current_ICD9_List,
	E.current_ICD10_List,
	E.dx_name,
	--ABS(DATEDIFF(D,C.First_Ordered_Date,P.Noted_DATE)) as date_diff,
	DATEDIFF(D,C.Order_Date,P.Noted_DATE) as date_diff,
	ROW_NUMBER() OVER (PARTITION BY C.PAT_ID ORDER BY DATEDIFF(dd,C.Order_Date,P.noted_DATE) asc) AS ROW_NUM
	from #Epic_Consults C
	INNER JOIN #Pat_ID_First_Date P on C.Pat_ID = P.Pat_ID
	inner join Clarity_EDG E on E.Dx_ID = P.Dx_ID
	where  P.NOTED_DATE is not null 
		and
				(
		 E.current_ICD9_List in
		  ('434','434.1','434.91','435.9',
			'435','435.1','435.3','435.8',
			'369.9','444.9','997.01')
		or 
		E.current_ICD10_List in
		('G45.0','G45.1','G45.8','I97.89',
			'G45.9','H54.7','I74.9','G97.81',
			'G97.82','I63.9','I66.9','Z82.3','Z86.69','Z86.73')

		)
		and P.noted_DATE is not null 
		) closest_to_proc

--- end TIA

--Update comorbidities

--ACS
Update #Comorbidities Set ACS = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'ACS')

--AFib
Update #Comorbidities Set AFib = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'AFib')


--Aortic_Aneurysm
Update #Comorbidities Set Aortic_Aneurysm = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Aortic_Aneurysm' )


--CAD
Update #Comorbidities Set CAD = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'CAD' )


--Dyslipidemia
Update #Comorbidities Set Dyslipidemia = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Dyslipidemia' )


--HF
Update #Comorbidities Set HF = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'HF' )


--HTN
Update #Comorbidities Set HTN = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'HTN' )

--Ischemic_Stroke
Update #Comorbidities Set Ischemic_Stroke = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Ischemic_Stroke' )

--MI
Update #Comorbidities Set MI = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'MI' )


--PAD
Update #Comorbidities Set PAD = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'PAD' )


--Sec_Cardiomyopathy
Update #Comorbidities Set Sec_Cardiomyopathy = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Sec_Cardiomyopathy' )

--Stable_Angina
Update #Comorbidities Set Stable_Angina = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Stable_Angina' )

--Stroke
Update #Comorbidities Set Stroke = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Stroke' )

--TIA
Update #Comorbidities Set TIA = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'TIA' )

--Unstable_Angina
Update #Comorbidities Set Unstable_Angina = 'Y' 
where Pat_ID in (Select PL.Pat_ID from #ProblemList PL
inner join #Comorbidities C on PL.Pat_ID = C.Pat_ID
where PL.disease_group = 'Unstable_Angina' )


--end update comorbidities

--Update nulls
Update  #Comorbidities set ACS   = 'N/A'
where ACS is null

Update  #Comorbidities set AFib   = 'N/A'
where AFib is null

Update  #Comorbidities set Aortic_Aneurysm   = 'N/A'
where Aortic_Aneurysm is null

Update  #Comorbidities set CAD   = 'N/A'
where CAD is null

Update  #Comorbidities set Dyslipidemia   = 'N/A'
where Dyslipidemia is null

Update  #Comorbidities set HF   = 'N/A'
where HF is null

Update  #Comorbidities set HTN  = 'N/A'
where HTN is null

Update  #Comorbidities set Ischemic_Stroke   = 'N/A'
where Ischemic_Stroke is null

Update  #Comorbidities set MI   = 'N/A'
where MI is null

Update  #Comorbidities set PAD   = 'N/A'
where PAD is null

Update  #Comorbidities set Sec_Cardiomyopathy   = 'N/A'
where Sec_Cardiomyopathy is null

Update  #Comorbidities set Stable_Angina   = 'N/A'
where Stable_Angina is null

Update  #Comorbidities set Stroke   = 'N/A'
where Stroke is null

Update  #Comorbidities set Unstable_Angina   = 'N/A'
where Unstable_Angina is null

Update  #Comorbidities set TIA   = 'N/A'
where TIA is null

--end update nulls

-- this is to get all ED and ed to inpatient and insert to ED_Hosp_Vists table. 
INSERT INTO #ED_Hosp_Visits (Pat_ID,Pat_First_Name,Pat_Last_Name,HUP_MRN,Order_Date,Pat_Enc_CSN_ID,HOSP_ADMSN_TIME,HOSP_DISCH_TIME, 
								Enc_Type,DX_ID,current_ICD9_List,current_ICD10_List,contact_date,Diagnosis_name,PRIMARY_DX_YN,Dtmdiff)
Select T.Pat_ID, T.Pat_First_Name,T.Pat_Last_Name,T.IDENTITY_ID,T.Order_Date,T.Pat_Enc_CSN_ID,T.HOSP_ADMSN_TIME,T.HOSP_DISCH_TIME, T.Enc_Type,T.DX_ID,T.CURRENT_ICD9_LIST,
		T.CURRENT_ICD10_LIST,T.contact_date,T.DX_NAME,T.PRIMARY_DX_YN, T.Dtmdiff
from 
(
select distinct C.Pat_ID, C.Pat_First_Name,C.Pat_Last_Name,I.IDENTITY_ID,A.Order_Date,E.Pat_Enc_CSN_ID,
		E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME,
		Case when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is not null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null then 'ED to Hosp-Admission (Discharged)'
		 when EN.ENC_TYPE_C = '3' and E.INP_ADM_DATE is not null and E.HOSP_DISCH_TIME is not null and e.ED_EPISODE_ID is null 
		 and datediff(dd,E.HOSP_ADMSN_TIME, E.HOSP_DISCH_TIME) > 0 then 'Admission (Discharged)'-- dateddiff to find out for inpatients only
		 --ED patients only
		 when EN.ENC_TYPE_C = '3' and e.ED_EPISODE_ID is not null and E.INP_ADM_DATE is null and E.HOSP_ADMSN_TIME is not null and E.HOSP_DISCH_TIME is not null   then 'ED'
			end as Enc_Type,
	ED.dx_ID,edg.CURRENT_ICD9_LIST,
			edg.CURRENT_ICD10_LIST,	
	EN.CONTACT_DATE,
	edg.DX_NAME,
	ED.PRIMARY_DX_YN,
			DATEDIFF(dd,A.Order_Date,E.HOSP_ADMSN_TIME) as Dtmdiff
from #Epic_Consults A
inner join Patient C on C.Pat_ID = A.Pat_ID
inner join Pat_Enc_HSP E on C.PAT_ID = E.PAT_ID and E.PAT_ENC_CSN_ID = A.PAT_ENC_CSN_ID
inner join Pat_enc EN on e.PAT_ID = EN.PAT_ID and E.PAT_ENC_CSN_ID = EN.PAT_ENC_CSN_ID and EN.PAT_ENC_CSN_ID = A.PAT_ENC_CSN_ID
inner join PAT_ENC_DX ED on (ED.PAT_ID = E.PAT_ID and ED.PAT_ENC_CSN_ID = E.PAT_ENC_CSN_ID and ED.PAT_ENC_CSN_ID = A.PAT_ENC_CSN_ID)
inner join Identity_ID I on E.PAT_ID = I.PAT_ID and A.MRN = I.Identity_ID
inner join clarity_edg edg on edg.DX_ID = ED.DX_ID
inner join ZC_DISP_ENC_TYPE Z on z.DISP_ENC_TYPE_C = EN.ENC_TYPE_C
--inner join Clarity_dep D on D.DEPARTMENT_ID = e.DEPARTMENT_ID
where --I.IDENTITY_TYPE_ID = '100' and
 EN.ENC_TYPE_C = '3') T
 where T.Enc_type is not null


--Final output given to Sri A
select distinct EC.*, C.ACS,C.Afib,C.Aortic_Aneurysm,C.CAD,C.Dyslipidemia, C.HF,C.HTN,
C.Ischemic_Stroke,C.MI,C.PAD,C.Sec_Cardiomyopathy,C.Stable_Angina,C.Stroke,C.TIA,C.Unstable_Angina,
HV.Current_ICD9_List, HV.current_ICD10_List,HV.Diagnosis_name, HV.Primary_Dx_YN 
from #Epic_Consults_3 EC
inner join #Comorbidities C on (EC.Pat_ID = C.Pat_ID and C.HUP_MRN = EC.MRN)
inner join #ED_Hosp_Visits HV on (HV.Pat_ID = EC.Pat_ID and HV.Pat_Enc_CSN_ID = EC.Pat_Enc_CSN_ID)
order by EC.Pat_ID, EC.Hosp_Admission_Date ASC

-- End Final Output


--Test Area
select * from EPT_team_Audit where pat_ID = '017232141' and pat_enc_csn_ID = '180577529'
select * from EPT_team_Audit where pat_ID = '000003038' and pat_enc_csn_ID = '178006475'
select * from zc_team_action
select * from #Epic_Consults
select * from #Epic_Consults_2
select * from #Epic_Consults_3
Select * from #ProblemList
Select * from #Comorbidities
select * from #ED_Hosp_Visits where Pat_ID = '000003038' and Pat_Enc_CSN_ID = '178006475'
-- end Test area