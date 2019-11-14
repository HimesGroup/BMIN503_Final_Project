#Clear existing data and graphics
#rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('ChronicConditionSpec_DATA_2019-10-02_1538.csv')
#Setting Labels

label(data$redcap_id)="REDCap ID"
label(data$redcap_event_name)="Event Name"
label(data$start_here_timestamp)="Survey Timestamp"
label(data$eng)="Click here if the patient would prefer the questions in English"
label(data$esp)="Haz un click aqu&iacute si el paciente prefiere Espa&ntildeol"
label(data$eng2)="Click here if the parent would prefer the questions in English"
label(data$esp2)="Haz un click aqu&iacute si el padre prefiere Espa&ntildeol"
label(data$start_here_complete)="Complete?"
label(data$borinquen_info_release_timestamp)="Survey Timestamp"
label(data$today_date)="[eng2]Todays Date:[esp2]La Fecha de Hoy"
label(data$not_part_ethnicity)="[eng2]What is your ethnic group or race?[esp2]&iquestCu&aacutel es tu grupo &eacutetnico o raza?"
label(data$not_part_asthma)="[eng2]Does your child have asthma?[esp2]&iquestSu hijo tiene asma?"
label(data$not_part_obese)="[eng2]Is your child overweight/obese?[esp2]&iquestSu ni&ntildeo tiene sobrepeso / es obeso?"
label(data$not_part_gender)="[eng2]Is your child a girl or a boy?[esp2]&iquestEs su hijo un ni&ntildeo o una ni&ntildea?"
label(data$participating)="[eng2]Are you interested in participating in this study? [esp2]&iquestEst&aacute interesado en participar en el estudio?"
label(data$first_date)="[eng2]This consent is granted for:  A  Continuing disclosure  (expires 12 month form the date I sign this form) or upon termination of treatment, whichever occurs first.  Todays Date:[esp2]Este consentimiento se otorga por: Divulgación continua (expira 12 meses de la fecha que firmo este formulario) o la terminación del tratamiento, lo que ocurra primero. Fecha de Hoy:"
label(data$borinquen_info_release_complete)="Complete?"
label(data$consent_timestamp)="Survey Timestamp"
label(data$parent_or_guardian___1)=" (choice=[eng2]Parent[esp2]Padre)"
label(data$parent_or_guardian___2)=" (choice=[eng2]Individual legally authorized to consent to the childs general medical care[esp2]Persona autorizada legalmente a dar su consentimiento a la atenci&oacuten m&eacutedica del ni&ntildeo (ver nota m&aacutes abajo))"
label(data$consent_complete)="Complete?"
label(data$assent_timestamp)="Survey Timestamp"
label(data$assent_complete)="Complete?"
label(data$consent_2_timestamp)="Survey Timestamp"
label(data$parent_or_guardian_v2___1)=" (choice=[eng2]Parent[esp2]Padre)"
label(data$parent_or_guardian_v2___2)=" (choice=[eng2]Individual legally authorized to consent to the childs general medical care[esp2]Persona autorizada legalmente a dar su consentimiento a la atenci&oacuten m&eacutedica del ni&ntildeo (ver nota m&aacutes abajo))"
label(data$consent_2_complete)="Complete?"
label(data$consent2_timestamp)="Survey Timestamp"
label(data$consent2_complete)="Complete?"
label(data$perception_timestamp)="Survey Timestamp"
label(data$worthtime)="Did you feel the FitTech program was worth your time?"
label(data$tablet_v_drvisit___1)="Did you prefer the tablet session to a regular doctors office visit? (choice=Yes)"
label(data$tablet_v_drvisit___0)="Did you prefer the tablet session to a regular doctors office visit? (choice=No)"
label(data$tablet_v_telephone)="Do you think telephone calls would be better than video conferencing?"
label(data$parentchild)="Do you think it would have worked better if we conducted part of the session with you (parent) and part with your child?"
label(data$frequency)="How often do you think the online sessions should be?"
label(data$easy_tablet)="How easy was the tablet to use?"
label(data$wifi)=" Does your family have access to wifi?"
label(data$fuze)="Would you recommend Fuze (the video conferencing app) for other studies like this one?"
label(data$appssites)="10. Which apps/websites did you like or find useful?"
label(data$acad_accom)=" Does your child receive any academic accommodations?"
label(data$perception_complete)="Complete?"
label(data$demographics_patient_timestamp)="Survey Timestamp"
label(data$dem_gender)="[eng]What is your gender?[esp]&iquestCu&aacutel es tu g&eacutenero?"
label(data$dem_ethnicity)="[eng]What is your ethnic group or race?[esp]&iquestCu&aacutel es tu grupo &eacutetnico o raza?"
label(data$dem_language_home)="[eng]What language is spoken at home?[esp]&iquestQu&eacute idioma se habla en tu hogar?"
label(data$dem_language_pref)="[eng]What language do you prefer to speak?[esp]&iquestQu&eacute idioma prefieres hablar?"
label(data$dem_grade)="[eng]What grade are you in this year?[esp]&iquestEn qu&eacute grado est&aacutes en este a&ntildeo?"
label(data$demographics_patient_complete)="Complete?"
label(data$tech_patient_timestamp)="Survey Timestamp"
label(data$tech_kid_smart_device)="[eng]1. Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?[esp]1. &iquestTiene un smartphone (tel&eacutefono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_kid_brand___1)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]iPhone or iPad[esp]iPhone o iPad )"
label(data$tech_kid_brand___2)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_kid_brand___3)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_kid_brand___4)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_kid_brand___5)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_kid_brand___6)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]Other[esp]Otro)"
label(data$tech_kid_brand___7)="[eng]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]Unsure[esp]No estoy serguro)"
label(data$tech_kid_os___1)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]iPhone or iPad[esp]iPhone o iPad)"
label(data$tech_kid_os___2)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_kid_os___3)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_kid_os___4)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_kid_os___5)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]Other[esp]Otro)"
label(data$tech_kid_os___6)="[eng]3. What type of smart phone or tablet do you have? (Select all that apply)[esp]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng]Unsure[esp]No estoy serguro)"
label(data$tech_kid_phone_service)="[eng]4. Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid? [esp]4. &iquest Ha sido desconectado (apagado) tu smartphone (tel&eacutefono inteligente) porque la factura mensual no haya sido pagado? "
label(data$tech_kid_disconnect)="[eng]How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?[esp]&iquestCu&aacutentas veces al a&ntildeo han desconectado (apagado) su smartphone (tel&eacutefono inteligente) porque la factura mensual no se pago? "
label(data$tech_kid_apps)="[eng]5. Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)? [esp]5. &iquestUtiliza alguna aplicaci&oacuten app) o sitios web en su smartphone (tel&eacutefono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentaci??"
label(data$tech_kid_function___1)="[eng]6. What do the health apps or websites help you do?[esp]6. &iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng]Keep track of your exercise[esp]Mantener un seguimiento de tu ejercicio)"
label(data$tech_kid_function___2)="[eng]6. What do the health apps or websites help you do?[esp]6. &iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng]Keep track of what you eat[esp]Mantener un seguimiento de lo que come)"
label(data$tech_kid_function___3)="[eng]6. What do the health apps or websites help you do?[esp]6. &iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng]Keep track of your weight[esp]Mantener un seguimiento de tu peso)"
label(data$tech_kid_function___4)="[eng]6. What do the health apps or websites help you do?[esp]6. &iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng]Look up information about exercise[esp]Buscar informaci&oacuten obre el ejercicio)"
label(data$tech_kid_function___5)="[eng]6. What do the health apps or websites help you do?[esp]6. &iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng]Look up information about healthy eating[esp]Buscar informaci&oacuten obre la alimentaci&oacuten saludable)"
label(data$tech_kid_privileges)="[eng]8. How often do you lose your technology privileges (e.g., have your smart phone or tablet taken away as punishment)?[esp]8. &iquestCon qu&eacute frecuencia pierdes los privilegios de la tecnolog&iacutea?(por ejemplo, te quitan tu Smartphone (tel&eacutefono inteligente) o tableta como castigo)?"
label(data$tech_kid_device_time)="[eng]9. How much time do you usually spend in total on your smart phone or tablet each day?[esp]9. &iquestNormalmente cu&aacutento tiempo pasas en total en tu Smartphone (tel&eacutefono inteligente) o tableta cada d&iacutea?"
label(data$tech_kid_given_device)="[eng]10. If you were provided a tablet, would you use the tablet to help you be healthier?[esp]10. Si le dieran una tableta, la usar&iacutea? para ayudarte a ser m&aacutes saludable?"
label(data$tech_patient_complete)="Complete?"
label(data$pedsql_patient_timestamp)="Survey Timestamp"
label(data$pedsqlkids_01)="1.[eng] It is hard for me to walk more than one block[esp]Se me hace dif&iacutecil caminar m&aacutes de una cuadra"
label(data$pedsqlkids_02)="2.[eng] It is hard for me to run[esp]Se me hace dif&iacutecil correr"
label(data$pedsqlkids_03)="3.[eng] It is hard for me to do sports activity or exercise[esp]Se me hace dif&iacutecil practicar deportes o ejercicios"
label(data$pedsqlkids_04)="4.[eng] It is hard for me to lift something heavy[esp]Se me hace dif&iacutecil levantar algo pesado"
label(data$pedsqlkids_05)="5.[eng] It is hard for me to take a bath or shower by myself[esp]Se me hace dif&iacutecil banarme solo en tina o regadera"
label(data$pedsqlkids_06)="6.[eng] It is hard for me to do chores around the house[esp]Se me hace dif&iacutecil hacer quehaceres en la casa"
label(data$pedsqlkids_07)="7.[eng] I hurt or ache[esp]Siento dolores o molestias"
label(data$pedsqlkids_08)="8.[eng] I have low energy[esp]Tengo poca energ&iacutea"
label(data$pedsqlkids_09)="9.[eng] I feel afraid or scared[esp]Me siento asustado o con miedo"
label(data$pedsqlkids_10)="10.[eng] I feel sad or blue[esp]Me siento triste o deca&iacutedo"
label(data$pedsqlkids_11)="11.[eng] I feel angry[esp]Me siento enojado"
label(data$pedsqlkids_12)="12.[eng] I have trouble sleeping[esp]Tengo dificultades para dormir"
label(data$pedsqlkids_13)="13.[eng] I worry about what will happen to me[esp]Me preocupo por lo que me vaya a pasar"
label(data$pedsqlkids_14)="14.[eng] I have trouble getting along with other kids[esp]Tengo problemas llev&aacutendome bien con otros ni&ntildeos"
label(data$pedsqlkids_15)="15.[eng] Other kids do not want to be my friend[esp]Otros ni&ntildeos no quieren ser mis amigos"
label(data$pedsqlkids_16)="16.[eng] Other kids tease me[esp]Otros ni&ntildeos se burlan de m&iacute"
label(data$pedsqlkids_17)="17.[eng] I cannot do things that other kids my age can do[esp]No puedo hacer cosas que otros ni&ntildeos de mi edad pueden hacer"
label(data$pedsqlkids_18)="18.[eng] It is hard to keep up when I play with other kids[esp]Se me hace dif&iacutecil mantenerme al igual que otros ni&ntildeos cuando juego con ellos"
label(data$pedsqlkids_19)="19.[eng] It is hard to pay attention in class[esp]Se me hace dif&iacutecil poner atenci&oacuten clase"
label(data$pedsqlkids_20)="20.[eng] I forget things[esp]Se me olvidan las cosas"
label(data$pedsqlkids_21)="21.[eng] I have trouble keeping up with my schoolwork[esp]Tengo problemas manteniendome al dia con mi trabajo escolar"
label(data$pedsqlkids_22)="22.[eng] I miss school because of not feeling well[esp]Falto a la escuela porque no me siento bien"
label(data$pedsqlkids_23)="23.[eng] I miss school to go to the doctor or hospital[esp]Falto a la escuela para ir al doctor o al hospital"
label(data$pedsql_patient_complete)="Complete?"
label(data$physical_activity_nutrition_patient_timestamp)="Survey Timestamp"
label(data$act_nutri_kids01)="1.[eng] During the past 7 days, on how many days were you physically active for a total of at least 60 minutes per day?  (Add up all the time you spent in any kind of physical activity that increased your heart rate and made you breathe hard some of the time.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestCu&aacutentos d&iacuteas estuviste f&iacutesicamente activo por un total de por lo menos 60 minutos al d&iacutea?  (Suma todo el tiempo que pas&oacute en cualquier tipo de actividad f&iacutesica que aumento tu ritmo card&iacuteaco y te hizo respirar fuerte parte del tiempo.)"
label(data$act_nutri_kids02)="2.[eng] On how many of the past 7 days did you exercise or participate in physical activity for at least 20 minutes that made you sweat and breathe hard, such as basketball, soccer, running, swimming laps, fast bicycling, fast dancing, or similar aerobic activities?[esp]&iquestEn cu&aacutentos de los &uacuteltimos 7 d&iacuteas ha hecho ejercicio o participado en actividad f&iacutesica por lo menos 20 minutos que te hizo sudar y respirar rapidamente, como el baloncesto, el f&uacutetbol, correr, nataci&oacuten, bicicleta r&aacutepida, baile movido o una actividad aer&oacutebica similar ?"
label(data$act_nutri_kids03)="3.[eng] On how many of the past 7 days did you do exercises to strengthen or tone your muscles, such as push-ups, sit-ups, or weight lifting?[esp]&iquestEn cu&aacutentos de los &uacuteltimos 7 d&iacuteas hiciste ejercicios para fortalecer o tonificar tus m&uacutesculos, como flexiones, abdominales o levantar pesas?"
label(data$act_nutri_kids04)="4.[eng] On an average school day, how many hours do you play video or computer games or use a computer for something that is not school work? (Include activities such as Nintendo, Game Boy, PlayStation, Xbox, computer games, and the Internet.)[esp]En un d&iacutea escolar regular, &iquestcu&aacutentas horas juegas a juegos de v&iacutedeo o juegos de computadora o utilizas una computadora para algo que no sea trabajo de la escuela? (Incluye actividades como Nintendo, Game Boy, PlayStation, Xbox, juegos de computadora y de Internet.)"
label(data$act_nutri_kids05)="5.[eng] On an average school day, how many hours do you spend watching DVDs or videos? Include DVDs or videos you watch on a TV, computer, iPod, or other portable device.[esp]En un d&iacutea escolar regular, &iquestcu&aacutentas horas pasas viendo DVDs o videos? Incluya DVDs o v&iacutedeos que se pueden ver en un televisor, computadora, iPod o cualquier otro aparato port&aacutetil."
label(data$act_nutri_kids06)="6.[eng] On an average school day, how many hours do you watch TV?[esp]En un d&iacutea escolar regular, &iquestcu&aacutentas horas ves la televisi&oacuten?"
label(data$act_nutri_kids07)="7.[eng] Encourage you to do physical activities or play sports?[esp]Te anima a hacer actividades fisicas o jugar deportes?"
label(data$act_nutri_kids08)="8.[eng] Do a physical activity or play sports with you?[esp]Hacer una actividad f&iacutesica o practicar deportes contigo?"
label(data$act_nutri_kids09)="9.[eng] Provide transportation to a place where you can do physical activities or play sports?[esp]Provee transporte a un lugar donde se pueden hacer actividades f&iacutesicas o jugar deportes?"
label(data$act_nutri_kids10)="10.[eng] Watch you participate in physical activities or play sports?[esp]Mirarte participar en actividades f&iacutesicas o jugar deportes?"
label(data$act_nutri_kids11)="11.[eng] During the past 7 days, how many times did you eat fruit? (Do not count fruit juice.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces comiste fruta? (No se cuenta el jugo de fruta.)"
label(data$act_nutri_kids12)="12.[eng] During the past 7 days, how many times did you eat green salad?[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces comiste ensalada verde? "
label(data$act_nutri_kids13)="13.[eng] During the past 7 days, how many times did you eat French fries or other fried potatoes, such as home fries, hash browns or tater tots? (Do not count potato chips.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces comiste papitas fritas u otro tipo de papa frita, como patatas fritas, croquetas de patata o tater (tater tots)? (No cuentes papitas fritas en bolsa/potato chips.)"
label(data$act_nutri_kids14)="14.[eng] During the past 7 days, how many times did you eat carrots?[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces comiste zanahorias?"
label(data$act_nutri_kids15)="15.[eng] During the past 7 days, how many times did you eat other vegetables? (Do not count green salad, potatoes, or carrots.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces comiste otros vegetales? (No cuentes ensalada verde, papas o zanahorias.)"
label(data$act_nutri_kids16)="16.[eng] During the past 7 days, how many times did you eat pizza?[esp]Durante los ultimos 7 dias, cuantas veces comiste pizza?"
label(data$act_nutri_kids17)="17.[eng] During the past 7 days, how many times did you drink 100% fruit juices such as orange juice, apple juice, or grape juice? (Do not count punch, Kool-Aid, sports drinks, or other fruit-flavored drinks.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces has bebido 100% jugos de fruta como jugo de naranja, jugo de manzana o jugo de uva? (No se cuenta el ponche, Kool-Aid, bebidas deportivas u otras bebidas con sabor a fruta.)"
label(data$act_nutri_kids18)="18.[eng] During the past 7 days, how many times did you drink a can, bottle, or glass of soda, such as Coke, Pepsi, or Sprite? (Do not count diet soda)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces usted bebio una lata, botella o vaso de refresco o soda, como Coca-Cola, Pepsi, o Sprite? (No cuentes refresco de dieta o soda de dieta.)"
label(data$act_nutri_kids19)="19.[eng] During the past 7 days, how many times did you drink a can, bottle, or glass of a sugar-sweetened beverage such as lemonade, sweetened tea or coffee drinks, flavored milk, Snapple, or Sunny Delight? (Do not count soda or pop, sports drinks, energy drinks, or 100% fruit juice.)[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces has bebido una lata, botella o vaso de una bebida endulzada con az&uacutecar como limonada, t&eacute o caf&eacute endulzado, leche con sabor, Snapple, o Sunny Delight? (No cuentes refresco o soda, bebidas para deportistas, bebidas energ&eacuteticas o jugo 100% de fruta.)"
label(data$act_nutri_kids20)="20.[eng] During the past 7 days, how many times did you drink a bottle or glass of plain water? Count tap, bottled, and unflavored sparkling water.[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces has bebido una botella o vaso de agua? Cuente agua de grifo, embotellada, con gas y sin sabor."
label(data$act_nutri_kids21)="21.[eng] About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) do you eat or drink each day?[esp]Acerca de cu&aacutentas tazas de frutas (incluyendo fruta congelada, enlatada, y seca y 100% jugo de fruta) comes o bebes cada d&iacutea?"
label(data$act_nutri_kids22)="22.[eng] About how many cups of vegetables (including frozen and canned vegetables and 100% vegetable juice) do you eat or drink each day?[esp]Acerca de cu&aacutentas tazas de vegetales (incluyendo vegetales congelados, enlatados, y secos y 100% jugo de vegetales) come o bebe cada d&iacutea?"
label(data$act_nutri_kids23)="23.[eng] During the past 7 days, on how many days did you eat breakfast or a morning meal?[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentos d&iacuteas comiste el desayuno o una comida de la ma&ntildeana?"
label(data$act_nutri_kids24)="24.[eng] During the past 7 days, on how many days did you eat dinner at home with at least one of your parents or guardians?[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentos d&iacuteas comio la cena en casa con al menos uno de sus padres o guardianes?"
label(data$act_nutri_kids25)="25.[eng] During the past 7 days, on how many days did you eat at least one meal or snack from a fast food restaurant such as McDonalds, Taco Bell, or KFC?[esp]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentos d&iacuteas comio al menos una comida o un bocadillo en un restaurante de comida r&aacutepida como McDonalds, Taco Bell, o KFC?"
label(data$act_nutri_kids26)="26.[eng] How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?[esp]&iquestCon qu&eacute frecuencia hay frutas o verduras para picar en su casa, como las zanahorias, el apio, manzanas, pl&aacutetanos, mel&oacuten?"
label(data$act_nutri_kids27)="27.[eng] How often are there foods such as chips, cookies, or cakes to snack on in your home?[esp]&iquestCon qu&eacute frecuencia hay alimentos como las papas fritas, galletas o pasteles para picar en su casa?"
label(data$physical_activity_nutrition_patient_complete)="Complete?"
label(data$weight_patient_timestamp)="Survey Timestamp"
label(data$weight_01)="1.[eng] I think I am pretty good at managing my weight.[esp]Creo que soy bastante bueno en el manejo de mi peso."
label(data$weight_02)="2.[eng] Compared to other kids, I think I do pretty well when it comes to managing my weight.[esp]En comparaci&oacuten otros ni&ntildeos, cuando se trata del manejo de mi peso creo que lo hago bastante bien."
label(data$weight_03)="3.[eng] I am satisfied with my ability to manage my weight.[esp]Estoy satisfecho con mi capacidad para manejar mi peso."
label(data$weight_04)="4.[eng] I am pretty skilled at managing my weight.[esp]Estoy bastante h&aacutebil en el manejo de mi peso."
label(data$weight_05)="5.[eng] Managing my diet is something that I cant do well.[esp]Manejar mi dieta es algo que no puedo hacer bien."
label(data$weight_06)="6.[eng] I put a lot of effort into managing my weight.[esp]Pongo mucho esfuerzo en manejar mi peso."
label(data$weight_07)="7.[eng] I try very hard to manage my weight by having healthy eating habits.[esp]Hago un gran esfuerzo para controlar mi peso por medio de tener h&aacutebitos alimenticios saludables."
label(data$weight_08)="8.[eng] I try very hard to manage my weight by being physically activity.[esp]Hago un gran esfuerzo para controlar mi peso por medio de hacer actividad f&iacutesica."
label(data$weight_09)="9.[eng] It is important for me to do well at managing my weight.[esp]Para m&iacute es importante que me vaya bien en manejar mi peso."
label(data$weight_10)="10.[eng] Overall, having a healthy diet is very important to me, a priority in my life.[esp]En general, tener una dieta saludable es muy importante para m&iacute, y es una prioridad en mi vida."
label(data$weight_11)="11.[eng] Overall, I feel confident in being able to manage my diet so that my weight will be healthy.[esp]En general, me siento seguro en ser capaz de manejar mi dieta para que mi peso sea saludable."
label(data$weight_12)="12.[eng] Overall, I feel confident in being physically active so that my weight will be healthy.[esp]En general, me siento seguro en mi habilidad de estar f&iacutesicamente activo para que mi peso sea saludable."
label(data$weight_13)="13.[eng] Overall, doing physical activity is very important to me, a priority in my life.[esp]En general, hacer actividad f&iacutesica es muy importante para m&iacute es una prioridad en mi vida."
label(data$weight_14)="14.[eng] I put a lot of effort into managing my diet and eating right.[esp]Pongo mucho esfuerzo en manejar mi dieta y en comer bien."
label(data$weight_15)="15.[eng] I put a lot of effort into not being inactive and being more physically active.[esp]Pongo mucho esfuerzo en no ser inactivo y en ser m&aacutes activo f&iacutesicamente. "
label(data$weight_16)="16.[eng] Compared to other kids, I think I do pretty well when it comes to being physically active.[esp]En comparaci&oacuten otros ni&ntildeos, creo que lo hago bastante bien cuando se trata de ser f&iacutesicamente activo."
label(data$has_asthma)="[eng]1. Does [first_name] [last_name] have asthma?[esp]&iquestTiene[first_name] [last_name] asthma?"
label(data$weight_patient_complete)="Complete?"
label(data$asthma_knowledge_patient_timestamp)="Survey Timestamp"
label(data$asthma01___0)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] sneezing[esp]estornudos)"
label(data$asthma01___1)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] shortness of breath[esp]falta de aire)"
label(data$asthma01___11)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] coughing[esp]tos)"
label(data$asthma01___00)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] skin rash[esp]erupci&oacuten cutanea)"
label(data$asthma01___000)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] fever[esp]fiebre)"
label(data$asthma01___111)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] wheezing[esp]sibilancias)"
label(data$asthma01___0000)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] nausea/vomiting[esp]n&aacuteuseas/v&oacutemitos)"
label(data$asthma01___00000)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] runny nose[esp]nariz que moquea)"
label(data$asthma01___000000)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] headache[esp]dolor de cabeza)"
label(data$asthma01___1111)="1.[eng] What are the 3 main symptoms of asthma?[esp]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng] chest tightness[esp]opresi&oacuten en el pecho)"
label(data$asthma02)="[eng]2.  More than 1 in 10 children will have asthma at some time during their childhood.[esp]2. 1 de cada 10 ni&ntildeos tendr&aacuten asma en alg&uacuten momento durante su infancia."
label(data$asthma03)="[eng]3. Children with asthma have overly sensitive air passages in their lungs.[esp]3. Los ni&ntildeos con asma tienen las v&iacuteas a&eacutereas pulmonares anormalmente sensibles. "
label(data$asthma04)="[eng]4. If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma.[esp]4. Si un ni&ntildeo en una familia tiene asma, entonces casi seguro que todos sus hermanos y hermanas la padecer&aacuten tambi&eacuten."
label(data$asthma05)="[eng] 5. Most children with asthma have an increase in mucus when they drink cows milk.[esp]5. La mayor&iacutea de los ni&ntildeos con asma sufren un aumento de mucosidad cuando beben leche de vaca."
label(data$asthma07)="[eng]7. Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs.[esp]7. Durante un ataque de asma los pitos pueden deberse a la contracci&oacuten muscular de la pared de las v&iacuteas a&eacutereas pulmonares."
label(data$asthma08)="[eng]8. Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs.[esp]8. Durante un ataque de asma, los pitos pueden deberse a la inflamaci&oacuten del revestimiento de las v&iacuteas a&eacutereas pulmonares."
label(data$asthma09)="[eng] 9. Asthma damages the heart.[esp]9. El asma da&ntildea el coraz&oacuten. "
label(data$asthma10___0)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Albuterol)"
label(data$asthma10___00)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Ventolin)"
label(data$asthma10___1)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Pulmicort)"
label(data$asthma10___000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Decadron)"
label(data$asthma10___0000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Abilify)"
label(data$asthma10___11)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Montelukast)"
label(data$asthma10___00000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Lexapro)"
label(data$asthma10___000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Benadryl)"
label(data$asthma10___0000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Claritin)"
label(data$asthma10___00000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Amoxicillin)"
label(data$asthma10___111)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Singulair)"
label(data$asthma10___000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Zoloft)"
label(data$asthma10___1111)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Budesonide)"
label(data$asthma10___0000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Effexor)"
label(data$asthma10___00000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Atrovent)"
label(data$asthma10___11111)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Flovent)"
label(data$asthma10___000000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Metformin)"
label(data$asthma10___0000000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Zithromax)"
label(data$asthma10___000000000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Zyrtec)"
label(data$asthma10___0000000000000000)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Prednisone)"
label(data$asthma10___111111)="[eng]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.[esp]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para EVITAR que se produzcan ataques de asma: (choice=Qvar)"
label(data$asthma11___1)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Albuterol)"
label(data$asthma11___11)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Ventolin)"
label(data$asthma11___0)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Pulmicort)"
label(data$asthma11___111)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Decadron)"
label(data$asthma11___00)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Abilify)"
label(data$asthma11___000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Montelukast)"
label(data$asthma11___0000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Lexapro)"
label(data$asthma11___00000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Benadryl)"
label(data$asthma11___000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Claritin)"
label(data$asthma11___0000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Amoxicillin)"
label(data$asthma11___00000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Singulair)"
label(data$asthma11___000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Zoloft)"
label(data$asthma11___0000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Budesonide)"
label(data$asthma11___00000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Effexor)"
label(data$asthma11___1111)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Atrovent)"
label(data$asthma11___000000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Flovent)"
label(data$asthma11___0000000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Metformin)"
label(data$asthma11___00000000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Zithromax)"
label(data$asthma11___000000000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Zyrtec)"
label(data$asthma11___11111)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Prednisone)"
label(data$asthma11___0000000000000000)="[eng]11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? [esp]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles DURANTE un ataque de asma? (choice=Qvar)"
label(data$asthma12)="[eng]12. Antibiotics are an important part of treatment for most children with asthma. [esp]12. Los antibi&oacuteticos son una parte importante del tratamiento para la mayor&iacutea de los ni&ntildeos con asma."
label(data$asthma13)="[eng]13. Most children with asthma should not eat dairy products.[esp]13. La mayor&iacutea de los ni&ntildeos con asma no deber&iacutean consumir productos l&aacutecteos."
label(data$asthma14)="[eng] 14.Allergy injections cure asthma.[esp]14. Las vacunas para la alergia curan el asma. "
label(data$asthma15)="[eng]15. If a child dies from an asthma attack, this usually means that there was no time to start any treatment. [esp]15. Si una persona muere de un ataque de asma, esto normalmente quiere decir que el ataque final debi&oacute de haber comenzado tan r&aacutepidamente que no hubo tiempo para empezar ning&uacuten tratamiento."
label(data$asthma16)="[eng]16. Children with asthma usually have emotional problems.[esp]16. Las personas con asma normalmente tienen problemas de nervios."
label(data$asthma17)="[eng]17. You can catch asthma from another person.[esp]17. El asma es infeccioso (es decir, te lo puede contagiar otra persona). "
label(data$asthma18)="[eng]18. Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets.[esp]18. Los medicamentos inhalados para el asma (por ejemplo, el inhalador Ventol&iacuten, Terbasmin) tienen menos efectos secundarios que las pastillas/jarabes."
label(data$asthma19)="[eng]19. Short courses of oral steroids (such as prednisone) usually cause significant side effects. [esp]19. Los ciclos cortos de corticoides orales (como Estilsona, Dacortin, Prednisona) habitualmente causan efectos secundarios importantes."
label(data$asthma20)="[eng]20. Some asthma treatments (such as Ventolin) damage the heart.[esp]20. Algunos tratamientos para el asma (como el Ventol&iacuten) da&ntildean el coraz&oacuten."
label(data$asthma22)="[eng]22. During an attack of asthma at home, you need your  nebulizer (mask) every 2 hours. You gain benefit but are very out of breath after 2 hours. Provided that you dont get any worse, its fine to continue with 2-hourly treatments.[esp]22. Durante un ataque de asma que est&aacuten tratando en casa tu necesitas el inhalador con c&aacutemara (o mascarilla) cada 2 horas. Est&aacutes mejorando pero despu&eacutes de 2 horas respiras con dificultad. Teniendo en cuenta que tu no empeoras, es correcto continuar con el tratamiento cada 2 horas."
label(data$asthma24)="[eng]24. Children with asthma become addicted to their asthma drugs. [esp]24. Los ni&ntildeos con asma se hacen adictos a sus medicinas para el asma. "
label(data$asthma25)="[eng]25. Swimming is the only good exercise for children with asthma.[esp]25. La nataci&oacuten es el &uacutenico deporte adecuado para los asm&aacuteticos."
label(data$asthma26)="[eng]26. A parents smoking in the home may make the childs asthma worse.[esp]26. El hecho de que los padres fumen puede empeorar el asma de su hijo/a."
label(data$asthma27)="[eng]27. With the right treatment most children with asthma live a normal life with no restriction on activity. [esp]27. Con el tratamiento adecuado, la mayor&iacutea de los ni&ntildeos con asma deber&iacutean llevar una vida normal sin restricciones en sus actividades."
label(data$asthma28)="[eng]28. The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest. [esp]28. La mejor manera de medir la gravedad del asma de un ni&ntildeo es que el m&eacutedico le escuche el pecho."
label(data$asthma29)="[eng]29. Asthma symptoms usually occur more frequently at night than during the day.[esp]29. El asma es normalmente m&aacutes problem&aacutetica durante la noche que durante el d&iacutea. "
label(data$asthma30)="[eng]30. Most children with asthma will have stunted growth.[esp]30. La mayor&iacutea de los ni&ntildeos con asma padecen un enlentecimiento de su crecimiento."
label(data$asthma31)="[eng]31. Children who frequently have asthma symptoms should have preventative drugs.[esp]31. Los ni&ntildeos con s&iacutentomas frecuentes de asma deber&iacutean tomar medicinas preventivas."
label(data$asthma_knowledge_patient_complete)="Complete?"
label(data$demographics_parent_timestamp)="Survey Timestamp"
label(data$dem_parent_sex)="[eng2]What is your gender?[esp2]&iquestCu&aacutel es su g&eacutenero?"
label(data$dem_parent_ethnicity)="[eng2]What is your ethnic group or race?[esp2]&iquestCu&aacutel es su grupo &eacutetnico o raza?"
label(data$dem_parent_language_pref)="[eng2]What language do you prefer to speak?[esp2]&iquest Qu&eacute idioma se habla en su hogar?"
label(data$dem_parent_school)="[eng2]What is the highest grade or level of education you have completed?[esp2]&iquestCu&aacutel es el grado o nivel de educaci&oacuten que usted ha completado?"
label(data$dem_parent_nationality)="[eng2]What is your country of origin/birth?[esp2]&iquestCu&aacutel es su  pa&iacutes de origen / nacimiento?"
label(data$dem_parent_us)="[eng2]How long have you lived in the United States?[esp2]&iquestCu&aacutento tiempo ha vivido en los Estados Unidos?"
label(data$dem_kid_nationality)="[eng2]What is your childs country of origin/birth?[esp2]&iquestCu&aacutel es el pa&iacutes de origen / nacimiento de su hijo?"
label(data$dem_kid_us)="[eng2]If not born in the United States, how long has your child been in the United States?[esp2]Si no naci&oacute en los Estados Unidos, &iquestcu&aacutento tiempo ha estado su hijo en los Estados Unidos?"
label(data$dem_parent_job)="[eng2]What is your current employment status?[esp2]&iquestCu&aacutel es su situaci&oacuten laboral actual?"
label(data$dem_parent_income)="[eng2]What is your household yearly income (before taxes)?[esp2]&iquestCu&aacutel es su ingreso familiar anual (antes de impuestos)?"
label(data$dem_parent_marital)="[eng2]What is your marital status?[esp2]Cu&aacutel es tu estado civil?"
label(data$dem_parent_habitants)="[eng2]How many people live in the primary house of the youth (including the youth)?[esp2]&iquestCu&aacutentas personas viven en la casa principal de su hijo (incluyendo su hijo)?"
label(data$dem_kid_pmhx___1)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Asthma[esp2]Asma)"
label(data$dem_kid_pmhx___2)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Sleep Apnea[esp2]Apnea del sue&ntildeo)"
label(data$dem_kid_pmhx___3)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Anxiety[esp2]Ansiedad)"
label(data$dem_kid_pmhx___4)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Cancer[esp2]C&aacutencer)"
label(data$dem_kid_pmhx___5)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Learning Disorder[esp2]Problemas de aprendizaje)"
label(data$dem_kid_pmhx___6)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Depression[esp2]Depresi&oacuten)"
label(data$dem_kid_pmhx___7)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Heart Disease[esp2]Enfermedad Del Coraz&oacuten)"
label(data$dem_kid_pmhx___8)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]ADHD/ADD[esp2]ADHD/ADD)"
label(data$dem_kid_pmhx___9)="[eng2]Does your child have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestTiene su hijo un historial de algunas condiciones m&eacutedicas o de salud mental? (marque todo lo que corresponda) (choice=[eng2]Other[esp2]Otro)"
label(data$dem_kid_famhx___1)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Asthma[esp2]Asma)"
label(data$dem_kid_famhx___2)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Sleep Apnea[esp2]Apnea del sue&ntildeo)"
label(data$dem_kid_famhx___3)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Anxiety[esp2]Ansiedad)"
label(data$dem_kid_famhx___4)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Cancer[esp2]C&aacutencer)"
label(data$dem_kid_famhx___5)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Learning Disorder[esp2]Problemas de aprendizaje)"
label(data$dem_kid_famhx___6)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Depression[esp2]Depresi&oacuten)"
label(data$dem_kid_famhx___7)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Heart Disease[esp2]Enfermedad Del Coraz&oacuten)"
label(data$dem_kid_famhx___8)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]ADHD/ADD[esp2]ADHD/ADD)"
label(data$dem_kid_famhx___9)="[eng2]Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)[esp2]&iquestHay alguien en la familia del joven que tenga un historial de problemas de salud mental o m&eacutedico? (marque todo lo que corresponda) (choice=[eng2]Other[esp2]Otro)"
label(data$demographics_parent_complete)="Complete?"
label(data$tech_parent_timestamp)="Survey Timestamp"
label(data$tech_parent_device)="[eng2]1. Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?[esp2]1. &iquestTiene un smartphone (tel&eacutefono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_parent_brand___1)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng2]iPhone or iPad[esp2]iPhone o iPad )"
label(data$tech_parent_brand___2)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_parent_brand___3)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_parent_brand___4)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_parent_brand___5)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_parent_brand___6)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng2]Other[esp2]Otro)"
label(data$tech_parent_brand___7)="[eng2]2. What brand of smart phone or tablet do you have? (Select all that apply)[esp2]2. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng2]Unsure[esp2]No estoy serguro)"
label(data$tech_parent_os___1)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=iPhone or iPad)"
label(data$tech_parent_os___2)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_parent_os___3)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_parent_os___4)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_parent_os___6)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng2]Other[esp2]Otro)"
label(data$tech_parent_os___7)="[eng2]3. What type of smart phone or tablet do you have? (Select all that apply)[esp2]3. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=[eng2]Unsure[esp2]No estoy serguro)"
label(data$tech_parent_phone_service)="[eng2]4. Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid? [esp2]4. &iquest Ha sido desconectado (apagado) tu smartphone (tel&eacutefono inteligente) porque la factura mensual no se haya sido pagado? "
label(data$tech_parent_disconnect)="[eng2]How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?[esp2]&iquestCu&aacutentas veces al a&ntildeo han desconectado (apagado) su smartphone (tel&eacutefono inteligente) porque la factura mensual no se pago? "
label(data$tech_parent_apps)="[eng2]5. Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)? [esp2]5. &iquestUtiliza alguna aplicaci&oacuten (app) o sitios web en su smartphone (tel&eacutefono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentaci&oacuten"
label(data$tech_parent_function___1)="[eng2]6. What do the health apps or websites help you do?[esp2]&iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng2]Keep track of your exercise[esp2]Mantener un seguimiento de tu ejercicio)"
label(data$tech_parent_function___2)="[eng2]6. What do the health apps or websites help you do?[esp2]&iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng2]Keep track of what you eat[esp2]Mantener un seguimiento de lo que come)"
label(data$tech_parent_function___3)="[eng2]6. What do the health apps or websites help you do?[esp2]&iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng2]Keep track of your weight[esp2]Mantener un seguimiento de tu peso)"
label(data$tech_parent_function___4)="[eng2]6. What do the health apps or websites help you do?[esp2]&iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng2]Look up information about exercise[esp2]Buscar informaci&oacuten sobre el ejercicio)"
label(data$tech_parent_function___5)="[eng2]6. What do the health apps or websites help you do?[esp2]&iquestCon que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=[eng2]Look up information about healthy eating[esp2]Buscar informaci&oacuten sobre la alimentaci&oacuten saludable)"
label(data$tech_parent_info___1)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2]Friends or Family[esp2]Amigos o familiares)"
label(data$tech_parent_info___2)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2] Doctor or other health professional[esp2]M&eacutedico u otro profesional de la salud)"
label(data$tech_parent_info___3)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2] Health app or website[esp2]Aplicaciones de salud o sitios web)"
label(data$tech_parent_info___4)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2]General or personal website (e.g., blog, Pinterest, social media such as Facebook or Twitter)[esp2]Sitio web general o personal (por ejemplo, blog, Pinterest, redes sociales como Facebook o Twitter))"
label(data$tech_parent_info___5)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2]Health-related printed material (e.g., book, health magazine)[esp2]Material impreso relacionado con la salud (libro electr&oacutenico, revista de salud))"
label(data$tech_parent_info___6)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2]General printed material (e.g., magazine, newspaper)[esp2]Material impreso general (por ejemplo, revistas, peri&oacutedicos))"
label(data$tech_parent_info___7)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2] Television (news, afternoon program, talk show)[esp2]Televisi&oacuten (noticias, programa de la tarde, programa de entrevistas))"
label(data$tech_parent_info___8)="[eng2]8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?[esp2]8. &iquest De d&oacutende usted recibe informaci&oacute sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=[eng2]Television (health program)[esp2]Televisi&oacuten (programa de salud))"
label(data$tech_kid_par_device)="[eng2]9. Does your youth have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?[esp2]9. &iquestTiene su hijo un smartphone (tel&eacutefono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_kid_par_brand___1)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=[eng2]iPhone or iPad[esp2]iPhone o iPad )"
label(data$tech_kid_par_brand___2)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_kid_par_brand___3)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_kid_par_brand___4)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_kid_par_brand___5)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_kid_par_brand___6)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=[eng2]Other[esp2]Otro)"
label(data$tech_kid_par_brand___7)="[eng2]10. What brand of smart phone or tablet does your youth have? (Select all that apply)[esp2]10. &iquestQu&eacute marca de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=[eng2]Unsure[esp2]No estoy serguro)"
label(data$tech_kid_par_os___1)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=iPhone or iPad)"
label(data$tech_kid_par_os___2)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_kid_par_os___3)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_kid_par_os___4)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_kid_par_os___6)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=[eng2]Other[esp2]Otro)"
label(data$tech_kid_par_os___7)="[eng2]11. What type of smart phone or tablet does your youth have? (Select all that apply)[esp2]11. &iquestQu&eacute tipo de smartphone (tel&eacutefono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=[eng2]Unsure[esp2]No estoy serguro)"
label(data$tech_kid_par_service)="[eng2]12. Does your youths smart phone ever get disconnected (turned off) because the monthly bill has not been paid? [esp2]12. &iquest Ha sido desconectado (apagado) el smartphone (tel&eacutefono inteligente) de su hijo(a) porque la factura mensual no se haya sido pagado? "
label(data$tech_kid_par_disconnected)="[eng2]How many times per year does your youths smart phone get disconnected (turned off) because the monthly bill has not been paid?[esp2]&iquestCu&aacutentas veces al a&ntildeo han desconectado (apagado) el smartphone (tel&eacutefono inteligente) de su hijo(a) porque la factura mensual no se pago? "
label(data$tech_kid_par_app)="[eng2]13. Does your youth use any applications (app) or websites on your smart phone or tablet to help him/her with health (e.g., exercise, eating)? [esp2]13. &iquestUtiliza su hijo(a) alguna aplicaci&oacuten (app) o sitios web en su smartphone (tel&eacutefono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentaci&oacuten"
label(data$tech_parent_privileges)="[eng2]15. How often does your youth lose their technology privileges (e.g., have their smart phone or tablet taken away as punishment)?[esp2]15. &iquestCon qu&eacute frecuencia su hijo(a) pierde sus privilegios de la tecnolog?(por ejemplo, su Smartphone (tel&eacutefono inteligente) o tableta quitado como castigo)?"
label(data$tech_parent_uses)="[eng2]16. If your youth was provided with a tablet, would they use the tablet to help them be healthier? [esp2]16. Si le dieran una tableta a su hijo, la usar&iacutea para para mejorar la saludable?"
label(data$tech_parent_complete)="Complete?"
label(data$pedsql_parent_timestamp)="Survey Timestamp"
label(data$pedsqlparent_01)="1.[eng2]Walking more than one block[esp2]Caminando m&aacutes de una cuadra"
label(data$pedsqlparent_02)="2.[eng2]Running[esp2]Corriendo"
label(data$pedsqlparent_03)="3.[eng2]Participating in sports activity or exercise[esp2]Participando en actividades deportivas o ejercicios"
label(data$pedsqlparent_04)="4.[eng2]Lifting something heavy[esp2]Levantando algo pesado"
label(data$pedsqlparent_05)="5.[eng2]Taking a bath or shower by him or herself[esp2]Tomando una ducha o tina por s&iacute mismo(a)"
label(data$pedsqlparent_06)="6.[eng2]Doing chores around the house[esp2]Haciendo quehaceres en la casa"
label(data$pedsqlparent_07)="7.[eng2]Having hurts or aches[esp2]Teniendo dolores o molestias"
label(data$pedsqlparent_08)="8.[eng2]Low energy level[esp2]Poca energ&iacutea"
label(data$pedsqlparent_09)="9.[eng2]Feeling afraid or scared[esp2]Sinti&eacutendose asustado o con miedo"
label(data$pedsqlparent_10)="10.[eng2]Feeling sad or blue[esp2]Sinti&eacutendose triste o deca&iacutedo"
label(data$pedsqlparent_11)="11.[eng2]Feeling angry[esp2]Sinti&eacutendose enojado"
label(data$pedsqlparent_12)="12.[eng2]Trouble sleeping[esp2]Dificultades para dormir"
label(data$pedsqlparent_13)="13.[eng2]Worrying about what will happen to him or her[esp2]Preocup&aacutendose por lo que le vaya a pasar"
label(data$pedsqlparent_14)="14.[eng2]Getting along with other kids[esp2]Llev&aacutendose bien con otros ni&ntildeos"
label(data$pedsqlparent_15)="15.[eng2] Other kids not wanting to be his or her friend[esp2]Otros ni&ntildeos no queriendo ser amigos de &eacutel o &eacutella"
label(data$pedsqlparent_16)="16.[eng2]Getting teased by other teens[esp2]Otros ni&ntildeos burl&aacutendose de &eacutel o &eacutella"
label(data$pedsqlparent_17)="17.[eng2]Not able to do things that other kids his or her age can do[esp2]No pudiendo hacer cosas que otros ni&ntildeos de su edad pueden hacer"
label(data$pedsqlparent_18)="18.[eng2]Keeping up with other kids[esp2]Pudiendo mantenerse al igual con otros ni&ntildeos cuando juega"
label(data$pedsqlparent_19)="19.[eng2]Paying attention in class[esp2]Poniendo atenci&oacuten en clase"
label(data$pedsqlparent_20)="20.[eng2]Forgetting things[esp2]Olvidando cosas"
label(data$pedsqlparent_21)="21.[eng2]Keeping up with schoolwork[esp2]Manteni&eacutendose al d&iacutea con actividades escolares"
label(data$pedsqlparent_22)="22.[eng2]Missing school because of not feeling well[esp2]Faltando a la escuela porque no se siente bien"
label(data$pedsqlparent_23)="23.[eng2]Missing school to go to the doctor or hospital[esp2]Faltando a la escuela para ir al doctor o al hospital"
label(data$pedsql_parent_complete)="Complete?"
label(data$physical_activity_nutrition_parent_timestamp)="Survey Timestamp"
label(data$act_nutri_parent01)="[eng2]1. Yesterday, was your child physically active for a total of at least 60 minutes? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)[esp2]1. Su hijo/a fue f&iacutesicamente activo por un total de al menos 60 minutos ayer? (Suma todo el tiempo que haya pasado en cualquier tipo de actividad f&iacutesica que aumentado su ritmo card&iacuteaco y lo haya respirar con fuerza una parte del tiempo."
label(data$act_nutri_parent02)="2.[eng2] During the past 7 days, on how many days was your child physically active for a total of at least 60 minutes per day? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestCu&aacutentos d&iacuteas fue su hijo/a f&iacutesicamente activo por un total de por lo menos 60 minutos al d&iacutea?  (Suma todo el tiempo que haya pasado en cualquier tipo de actividad f&iacutesica que haya aumentado su ritmo card&iacuteaco y que lo haya hecho respirar con fuerza una parte del tiempo.)"
label(data$act_nutri_parent03)="3.[eng2] On how many of the past 7 days did your child exercise or participate in physical activity for at least 20 minutes that made him/her sweat and breathe hard, such as basketball, soccer, running, swimming laps, fast bicycling, fast dancing, or similar aerobic activities?[esp2]&iquestEn los &uacuteltimos 7 d&iacuteas, cu&aacutentos d&iacuteas hizo su ni&ntildeo/a o particip&oacute en actividad f&iacutesica por al menos 20 minutos en el que hizo que &eacute/ella sudara y respirara agitadamente, como el baloncesto, el f&uacutetbol, correr, nataci&oacuten, bicicleta r&aacutepida, baile movido o una actividad aer&oacutebica similar ?"
label(data$act_nutri_parent04)="[eng2]4. On how many of the past 7 days did your child do exercises to strengthen or tone their muscles, such as push-ups, sit-ups, or weight lifting?[esp2]4. &iquestEn cu&aacutentos de los &uacuteltimos 7 d&iacuteas hizo su hijo/a ejercicios para fortalecer o tonificar sus m&uacutesculos, como flexiones, abdominales o levantar pesas?"
label(data$act_nutri_parent05)="5.[eng2] On an average school day, how many hours does your child play video or computer games or use a computer for something that is not school work? (Include activities such as Nintendo, Game Boy, PlayStation, Xbox, computer games, and the Internet.)[esp2]En un d&iacutea escolar promedio, &iquestcu&aacutentas horas juega su hijo con v&iacutedeo o juegos de computadora o utiliza una computadora para algo que no sea trabajo escolar?  (Incluye actividades como Nintendo, Game Boy, PlayStation, Xbox, juegos de computadora y de Internet.)"
label(data$act_nutri_parent06)="6.[eng2] On an average school day, how many hours does your child spend watching DVDs or videos? Include DVDs or videos you watch on a TV, computer, iPod, or other portable device.[esp2]En un d&iacutea escolar promedio, &iquestcu&aacutentas horas pasa su hijo viendo DVDs o videos? Incluya DVDs o v&iacutedeos que se pueden ver en un televisor, computadora, iPod o cualquier otro aparato port&aacutetil."
label(data$act_nutri_parent07)="7.[eng2] On an average school day, how many hours does your child watch TV?[esp2]En un d&iacutea escolar promedio, &iquestcu&aacutentas horas ve la televisi&oacuten su ni&ntildeo/a?"
label(data$act_nutri_parent08)="[eng2]8. In an average week when your child is in school, on how many days does he/she go to physical education (PE) classes?[esp2]8. En una semana normal cuando su hijo est&aacute en la escuela, &iquestcu&aacutentos d&iacuteas &eacutel/ella va a clases de educaci&oacuten f&iacutesica (PE)?"
label(data$act_nutri_parent09)="[eng2]9. How many TVs are in your home? (If you sleep in more than one home, answer based on the home you sleep in most.)[esp2]9. &iquestCu&aacutentos televisores hay en su casa? (Si usted duerme en más de una casa, responda a la respuesta en base a la casa donde duerme la mayor&iacutea del tiempo)"
label(data$act_nutri_parent10)="[eng2]10. Does your child have a TV in his/her bedroom? (If they have more than one bedroom, answer based on the bedroom they sleep in most.)[esp2]10. &iquestSu hijo tiene un televisor en su cuarto? (Si tiene m&aacutes de un cuarto, responde basada en el cuarto donde duerme la mayor&iacutea del tiempo.)"
label(data$act_nutri_parent11)="[eng2]11.  In an average week when your child is in school, on how many days does he/she walk or ride his/her bike to school when weather allows him/her to do so?[esp2]11. En una semana normal cuando su hijo est&aacute en la escuela, &iquestcu&aacutentos d&iacuteas camina o monta su bicicleta a la escuela cuando el clima lo permite? "
label(data$act_nutri_parent12)="12. [eng2]Encourage your child to do physical activities or play sports?[esp2]Anima a su hijo a hacer actividades f&iacutesicas o deportes de juego f&iacutesico?"
label(data$act_nutri_parent13)="13. [eng2]Do a physical activity or play sports with your child?[esp2]Hace una actividad f&iacutesica o practica deportes con su hijo?"
label(data$act_nutri_parent14)="14. [eng2]Provide transportation to a place where your child can do physical activities or play sports?[esp2]Provee el transporte a un lugar donde su hijo puede hacer actividades f&iacutesicas o deportes de juego?"
label(data$act_nutri_parent15)="15. [eng2]Watch your child participate in physical activities or play sports?[esp2]Observa a su ni&ntildeo a participar en actividades o deportes de juego f&iacutesico?"
label(data$act_nutri_parent16)="16. [eng2]During the past 7 days, how many times did your child eat fruit? (Do not count fruit juice.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su hijo comio fruta?? (No se cuenta el jugo de fruta.)"
label(data$act_nutri_parent17)="17. [eng2]During the past 7 days, how many times did your child eat green salad?[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su hijo/a comi&oacute ensalada verde? "
label(data$act_nutri_parent18)="18. [eng2]During the past 7 days, how many times did your child eat French fries or other fried potatoes, such as home fries, hash browns or tater tots? (Do not count potato chips.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su hijo/a comi&oacute papitas fritas u otro tipo de papa frita, como patatas fritas, croquetas de patata o tater (tater tots)? (No cuentes papitas fritas en bolsa/potato chips.)"
label(data$act_nutri_parent19)="19. [eng2]During the past 7 days, how many times did your child eat carrots?[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su hijo/a comi&oacute zanahorias?"
label(data$act_nutri_parent20)="20. [eng2]During the past 7 days, how many times did your child eat other vegetables? (Do not count green salad, potatoes, or carrots.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su hijo/a comi&oacute otros vegetales? (No cuentes ensalada verde, papas o zanahorias.)"
label(data$act_nutri_parent21)="21. [eng2]During the past 7 days, how many times did your child eat pizza?[esp2]Durante los ultimos 7 dias, cuantas veces su hijo/a comi&oacute pizza?"
label(data$act_nutri_parent22)="22. [eng2]During the past 7 days, how many times did your child drink a can, bottle, or glass of soda or pop, such as Coke, Pepsi, or Sprite? (Do not count diet soda or diet pop.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces tom&oacute su ni&ntildeo una lata, botella o vaso de refresco o soda, como Coca-Cola, Pepsi, o Sprite? (No cuentes refresco de dieta o soda de dieta.)"
label(data$act_nutri_parent23)="[eng2]23. During the past 7 days, how many times did your child drink a can, bottle, or glass of diet soda or pop, such as Diet Coke, Diet Pepsi, or Sprite Zero?[esp2]23. Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacuteas veces su ni&ntildeo tom&oacute una lata, botella o vaso de refresco o pop dieta, tales como Diet Coke, Diet Pepsi, o Sprite Zero?"
label(data$act_nutri_parent24)="24. [eng2]During the past 7 days, how many times did your child drink a can, bottle, or glass of a sugar-sweetened beverage such as lemonade, sweetened tea or coffee drinks, flavored milk, Snapple, or Sunny Delight? (Do not count soda or pop, sports drinks, energy drinks, or 100% fruit juice.)[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su ni&ntildeo tom&oacute una lata, botella o vaso de una bebida endulzada con az&uacutecar como limonada, t&eacute o caf&eacute endulzado, leche con sabor, Snapple, o Sunny Delight? (No cuentes refresco o soda, bebidas para deportistas, bebidas energ&eacuteticas o jugo 100% de fruta.)"
label(data$act_nutri_parent25)="25. [eng2]During the past 7 days, how many times did your child drink a bottle or glass of plain water? Count tap, bottled, and unflavored sparkling water.[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentas veces su ni&ntildeo tom&oacute una botella o vaso de agua? Cuente agua de grifo, embotellada, con gas y sin sabor."
label(data$act_nutri_parent26)="26. [eng2]About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) does your child eat or drink each day?[esp2]Aproximadamente  cu&aacutentas tazas de frutas (incluyendo fruta congelada, enlatada, y seca y 100% jugo de fruta) come o bebe su ni&ntildeo/a cada d&iacutea?"
label(data$act_nutri_parent27)="27. [eng2]About how many cups of vegetables (including frozen, canned, and vegetables and 100% vegetable juice) does your child eat or drink each day?[esp2]Aproximadamente cu&aacutenas tazas de vegetales (incluyendo vegetales congelados, enlatados, y secos y 100% jugo de vegetales) come o bebe su ni&ntildeo/a cada d&iacutea?"
label(data$act_nutri_parent28)="28. [eng2]During the past 7 days, on how many days did your child eat breakfast or a morning meal?[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentos d&iacuteas comi&oacute su ni&ntildeo/a un desayuno o una comida de la ma&ntildeana?"
label(data$act_nutri_parent29)="29. [eng2]During the last 7 days, when your child eats dinner at home, how often is a television on while he/ she is eating?[esp2]Durante los &uacuteltimos 7 d&iacuteas, cuando su hijo/a come la cena en casa, &iquest con qu&eacute frecuencia est&aacute un televisor encendido mientras &eacute/ella est&aacute comiendo?"
label(data$act_nutri_parent30)="30. [eng2]During the past 7 days, on how many days did your child eat at least one meal or snack from a fast food restaurant such as McDonalds, Taco Bell, or KFC?[esp2]Durante los &uacuteltimos 7 d&iacuteas, &iquestcu&aacutentos d&iacuteas comi&oacute su ni&ntildeo/a al menos una comida o un aperitivo en un restaurante de comida r&aacutepida como McDonalds, Taco Bell, o KFC?"
label(data$act_nutri_parent31)="31. [eng2]How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?[esp2]&iquestCon qu&eacute frecuencia hay frutas o vegetales para picar en su casa, como las zanahorias, el apio, manzanas, pl&aacutetanos, mel&oacuten?"
label(data$physical_activity_nutrition_parent_complete)="Complete?"
label(data$asthma_knowledge_parent_timestamp)="Survey Timestamp"
label(data$asthma_parent01___0)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] sneezing[esp2]estornudos)"
label(data$asthma_parent01___1)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] shortness of breath[esp2]falta de aire)"
label(data$asthma_parent01___11)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] coughing[esp2]tos)"
label(data$asthma_parent01___00)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] skin rash[esp2]erupci&oacuten cutanea)"
label(data$asthma_parent01___000)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] fever[esp2]fiebre)"
label(data$asthma_parent01___111)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] wheezing[esp2]sibilancias)"
label(data$asthma_parent01___0000)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] nausea/vomiting[esp2]n&aacuteuseas/v&oacutemitos)"
label(data$asthma_parent01___00000)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] runny nose[esp2]nariz que moquea)"
label(data$asthma_parent01___000000)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] headache[esp2]dolor de cabeza)"
label(data$asthma_parent01___1111)="1.[eng2] What are the 3 main symptoms of asthma?[esp2]&iquestCu&aacuteles son los tres s&iacutentomas principales del asma?  (choice=[eng2] chest tightness[esp2]opresi&oacuten en el pecho)"
label(data$asthma_parent02)="[eng2]2.  More than 1 in 10 children will have asthma at some time during their childhood.[esp2]2. 1 de cada 10 ni&ntildeos tendr&aacuten asma en alg&uacuten momento durante su infancia."
label(data$asthma_parent03)="[eng2]3. Children with asthma have overly sensitive air passages in their lungs.[esp2]3. Los ni&ntildeos con asma tienen las v&iacuteas a&eacutereas pulmonares anormalmente sensibles. "
label(data$asthma_parent04)="[eng2]4. If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma.[esp2]4. Si un ni&ntildeo en una familia tiene asma, entonces casi seguro que todos sus hermanos y hermanas la padecer&aacuten tambi&eacuten."
label(data$asthma_parent05)="[eng2] 5. Most children with asthma have an increase in mucus when they drink cows milk.[esp2]5. La mayor&iacutea de los ni&ntildeos con asma sufren un aumento de mucosidad cuando beben leche de vaca."
label(data$asthma_parent07)="[eng2]7. Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs.[esp2]7. Durante un ataque de asma los pitos pueden deberse a la contracci&oacuten muscular de la pared de las v&iacuteas a&eacutereas pulmonares."
label(data$asthma_parent08)="[eng2]8. Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs.[esp2]8. Durante un ataque de asma, los pitos pueden deberse a la inflamaci&oacuten del revestimiento de las v&iacuteas a&eacutereas pulmonares."
label(data$asthma_parent09)="[eng2] 9. Asthma damages the heart.[esp2]9. El asma da&ntildea el coraz&oacuten. "
label(data$asthma_parent10___0)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Albuterol)"
label(data$asthma_parent10___00)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Ventolin)"
label(data$asthma_parent10___1)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Pulmicort)"
label(data$asthma_parent10___000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Decadron)"
label(data$asthma_parent10___0000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Abilify)"
label(data$asthma_parent10___11)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Montelukast)"
label(data$asthma_parent10___00000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Lexapro)"
label(data$asthma_parent10___000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Benadryl)"
label(data$asthma_parent10___0000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Claritin)"
label(data$asthma_parent10___00000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Amoxicillin)"
label(data$asthma_parent10___111)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Singulair)"
label(data$asthma_parent10___000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Zoloft)"
label(data$asthma_parent10___1111)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Budesonide)"
label(data$asthma_parent10___0000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Effexor)"
label(data$asthma_parent10___00000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Atrovent)"
label(data$asthma_parent10___11111)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Flovent)"
label(data$asthma_parent10___000000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Metformin)"
label(data$asthma_parent10___0000000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Zithromax)"
label(data$asthma_parent10___000000000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Zyrtec)"
label(data$asthma_parent10___0000000000000000)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Prednisone)"
label(data$asthma_parent10___111111)="[eng2]10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.[esp2]10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los d&iacuteas para evitar que se produzcan ataques de asma: (choice=Qvar)"
label(data$asthma_parent11___1)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Albuterol)"
label(data$asthma_parent11___11)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Ventolin)"
label(data$asthma_parent11___0)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Pulmicort)"
label(data$asthma_parent11___111)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Decadron)"
label(data$asthma_parent11___00)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Abilify)"
label(data$asthma_parent11___000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Montelukast)"
label(data$asthma_parent11___0000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Lexapro)"
label(data$asthma_parent11___00000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Benadryl)"
label(data$asthma_parent11___000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Claritin)"
label(data$asthma_parent11___0000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Amoxicillin)"
label(data$asthma_parent11___00000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Singulair)"
label(data$asthma_parent11___000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Zoloft)"
label(data$asthma_parent11___0000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Budesonide)"
label(data$asthma_parent11___00000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Effexor)"
label(data$asthma_parent11___1111)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Atrovent)"
label(data$asthma_parent11___000000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Flovent)"
label(data$asthma_parent11___0000000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Metformin)"
label(data$asthma_parent11___00000000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Zithromax)"
label(data$asthma_parent11___000000000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Zyrtec)"
label(data$asthma_parent11___11111)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Prednisone)"
label(data$asthma_parent11___0000000000000000)="[eng2]11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? [esp2]11. &iquestQu&eacute tres tratamientos (medicinas) para el asma son &uacutetiles durante un ataque de asma? (choice=Qvar)"
label(data$asthma_parent12)="[eng2]12. Antibiotics are an important part of treatment for most children with asthma. [esp2]12. Los antibi&oacuteticos son una parte importante del tratamiento para la mayor&iacutea de los ni&ntildeos con asma."
label(data$asthma_parent13)="[eng2]13. Most children with asthma should not eat dairy products.[esp2]13. La mayor&iacutea de los ni&ntildeos con asma no deber&iacutean consumir productos l&aacutecteos."
label(data$asthma_parent14)="[eng2] 14.Allergy injections cure asthma.[esp2]14. Las vacunas para la alergia curan el asma. "
label(data$asthma_parent15)="[eng2]15. If a child dies from an asthma attack, this usually means that there was no time to start any treatment. [esp2]15. Si una persona muere de un ataque de asma, esto normalmente quiere decir que el ataque final debi&oacute de haber comenzado tan r&aacutepidamente que no hubo tiempo para empezar ning&uacuten tratamiento."
label(data$asthma_parent16)="[eng2]16. Children with asthma usually have emotional problems.[esp2]16. Las personas con asma normalmente tienen problemas de nervios."
label(data$asthma_parent17)="[eng2]17. You can catch asthma from another person.[esp2]17. El asma es infeccioso (es decir, te lo puede contagiar otra persona). "
label(data$asthma_parent18)="[eng2]18. Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets.[esp2]18. Los medicamentos inhalados para el asma (por ejemplo, el inhalador Ventol&iacuten, Terbasmin) tienen menos efectos secundarios que las pastillas/jarabes."
label(data$asthma_parent19)="[eng2]19. Short courses of oral steroids (such as prednisone) usually cause significant side effects. [esp2]19. Los ciclos cortos de corticoides orales (como Estilsona, Dacortin, Prednisona) habitualmente causan efectos secundarios importantes."
label(data$asthma_parent20)="[eng2]20. Some asthma treatments (such as Ventolin) damage the heart.[esp2]20. Algunos tratamientos para el asma (como el Ventol&iacuten) da&ntildean el coraz&oacuten."
label(data$asthma_parent22)="[eng2]22. During an attack of asthma that you are managing at home, your child is requesting the nebulizer (mask) every 2 hours. He/she is gaining benefit but is very breathless after 2 hours. Provided that he/she doesnt get any worse, its fine to continue with 2-hourly treatments.[esp2]22. Durante un ataque de asma que est&aacuten tratando en casa su hijo necesita el inhalador con c&aacutemara (o mascarilla) cada 2 horas. Est&aacute mejorando pero despu&eacutes de 2 horas respira con dificultad. Teniendo en cuenta que el ni&ntildeo no empeora, es correcto continuar con el tratamiento cada 2 horas."
label(data$asthma_parent24)="[eng2]24. Children with asthma become addicted to their asthma drugs. [esp2]24. Los ni&ntildeos con asma se hacen adictos a sus medicinas para el asma. "
label(data$asthma_parent25)="[eng2]25. Swimming is the only good exercise for children with asthma.[esp2]25. La nataci&oacuten es el &uacutenico deporte adecuado para los asm&aacuteticos."
label(data$asthma_parent26)="[eng2]26. A parents smoking in the home may make the childs asthma worse.[esp2]26. El hecho de que los padres fumen puede empeorar el asma de su hijo/a."
label(data$asthma_parent27)="[eng2]27. With the right treatment most children with asthma live a normal life with no restriction on activity. [esp2]27. Con el tratamiento adecuado, la mayor&iacutea de los ni&ntildeos con asma deber&iacutean llevar una vida normal sin restricciones en sus actividades."
label(data$asthma_parent28)="[eng2]28. The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest. [esp2]28. La mejor manera de medir la gravedad del asma de un ni&ntildeo es que el m&eacutedico le escuche el pecho."
label(data$asthma_parent29)="[eng2]29. Asthma symptoms usually occur more frequently at night than during the day.[esp2]29. El asma es normalmente m&aacutes problem&aacutetica durante la noche que durante el d&iacutea. "
label(data$asthma_parent30)="[eng2]30. Most children with asthma will have stunted growth.[esp2]30. La mayor&iacutea de los ni&ntildeos con asma padecen un enlentecimiento de su crecimiento."
label(data$asthma_parent31)="[eng2]31. Children who frequently have asthma symptoms should have preventative drugs.[esp2]31. Los ni&ntildeos con s&iacutentomas frecuentes de asma deber&iacutean tomar medicinas preventivas."
label(data$asthma_knowledge_parent_complete)="Complete?"
label(data$usherwood_timestamp)="Survey Timestamp"
label(data$usherwood_01)="[eng2]Your child has been wheezy during the day[esp2]Su hijo/a ha sido sibilante durante el d&iacutea"
label(data$usherwood_02)="[eng2]Your child has coughed during the day[esp2]Su hijo/a ha tosido durante el d&iacutea"
label(data$usherwood_03)="[eng2]Your child has complained of being short of breath[esp2]Su hijo/a se ha quejado de falta de aire"
label(data$usherwood_04)="[eng2]Your child has complained of a pain in the chest[esp2]Su hijo/a se ha quejado de dolor en el pecho"
label(data$usherwood_05)="[eng2]Exertion (e.g., running) has made your child breathless[esp2]Esfuerzo fisico (por ejemplo, correr) ha dejado a su hijo/a sin aire"
label(data$usherwood_06)="[eng2]Your child has stayed indoors because of wheezing or coughing[esp2]Su hijo/a se ha mantenido adentro de la casa debido a sibilancias o tos"
label(data$usherwood_07)="[eng2]His/her asthma has stopped your child from playing with his or her friends[esp2]Asma ha hecho que su ni&ntildeo/a no juegue con sus amigos"
label(data$usherwood_08)="[eng2]During term time, your childs education has suffered due to his or her asthma[esp2]Durante el a&ntildeo escolar, la educaci&oacuten de su hijo/a ha sufrido debido a su asma"
label(data$usherwood_09)="[eng2]Asthma has stopped your child from doing all the things that a boy or girl should at his or her age[esp2]El asma ha detenido a su hijo/a de hacer todas las cosas que un ni&ntildeo/a debe de hacer a su edad"
label(data$usherwood_10)="[eng2]Your childs asthma has interfered with his or her life[esp2]El asma de su hijo/a ha interferido con su vida"
label(data$usherwood_11)="[eng2]Asthma has limited your childs activities[esp2]El asma ha limitado las actividades de su hijo/a"
label(data$usherwood_12)="[eng2]Taking his or her inhaler or other treatment has interrupted your childs life[esp2]Usar su inhalador u otro tratamiento ha interrumpido la vida de su hijo/a"
label(data$usherwood_13)="[eng2]Your childs asthma has limited your activities[esp2]El asma de su hijo/a ha limitado tus actividades"
label(data$usherwood_14)="[eng2]You have had to make adjustments to family life because of your childs asthma[esp2]Has tenido que hacer cambios a la vida familiar a causa del asma de su hijo/a"
label(data$usherwood_15)="[eng2]Your child has coughed at night[esp2]Su hijo/a ha tosido durante la noche"
label(data$usherwood_16)="[eng2]Your childs sleep has been disturbed by wheezing or coughing[esp2] El sue&ntildeo de su hijo/a ha sido interumpido por sibilancias o tos"
label(data$usherwood_17)="[eng2]Your child has been woken up by wheezing or coughing[esp2]Su hijo/a ha sido despertado por sibilancias o tos"
label(data$usherwood_complete)="Complete?"
label(data$equipment_signout_timestamp)="Survey Timestamp"
label(data$tablet_group)="Were you randomized to the tablet group?"
label(data$equipment_signout_complete)="Complete?"
label(data$gift_receipt_timestamp)="Survey Timestamp"
label(data$gift_receipt_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("initial_visit_arm_1","fu_visit_1_arm_1","fu_visit_2_arm_1","fu_visit_3_arm_1","fu_visit_4_arm_1","final_visit_arm_1"))
data$eng.factor = factor(data$eng,levels=c("1"))
data$esp.factor = factor(data$esp,levels=c("1"))
data$eng2.factor = factor(data$eng2,levels=c("1"))
data$esp2.factor = factor(data$esp2,levels=c("1"))
data$start_here_complete.factor = factor(data$start_here_complete,levels=c("0","1","2"))
data$not_part_ethnicity.factor = factor(data$not_part_ethnicity,levels=c("1","2","3","4","5","6"))
data$not_part_asthma.factor = factor(data$not_part_asthma,levels=c("1","0"))
data$not_part_obese.factor = factor(data$not_part_obese,levels=c("1","0"))
data$not_part_gender.factor = factor(data$not_part_gender,levels=c("1","2"))
data$participating.factor = factor(data$participating,levels=c("1","0"))
data$borinquen_info_release_complete.factor = factor(data$borinquen_info_release_complete,levels=c("0","1","2"))
data$parent_or_guardian___1.factor = factor(data$parent_or_guardian___1,levels=c("0","1"))
data$parent_or_guardian___2.factor = factor(data$parent_or_guardian___2,levels=c("0","1"))
data$consent_complete.factor = factor(data$consent_complete,levels=c("0","1","2"))
data$assent_complete.factor = factor(data$assent_complete,levels=c("0","1","2"))
data$parent_or_guardian_v2___1.factor = factor(data$parent_or_guardian_v2___1,levels=c("0","1"))
data$parent_or_guardian_v2___2.factor = factor(data$parent_or_guardian_v2___2,levels=c("0","1"))
data$consent_2_complete.factor = factor(data$consent_2_complete,levels=c("0","1","2"))
data$consent2_complete.factor = factor(data$consent2_complete,levels=c("0","1","2"))
data$worthtime.factor = factor(data$worthtime,levels=c("1","0"))
data$tablet_v_drvisit___1.factor = factor(data$tablet_v_drvisit___1,levels=c("0","1"))
data$tablet_v_drvisit___0.factor = factor(data$tablet_v_drvisit___0,levels=c("0","1"))
data$tablet_v_telephone.factor = factor(data$tablet_v_telephone,levels=c("1","0"))
data$parentchild.factor = factor(data$parentchild,levels=c("1","0"))
data$frequency.factor = factor(data$frequency,levels=c("1","2","3","4","5","6"))
data$easy_tablet.factor = factor(data$easy_tablet,levels=c("1","2","3","4","5"))
data$wifi.factor = factor(data$wifi,levels=c("1","0"))
data$fuze.factor = factor(data$fuze,levels=c("1","0"))
data$appssites.factor = factor(data$appssites,levels=c("1","2","3","4","5","6","7"))
data$acad_accom.factor = factor(data$acad_accom,levels=c("1","0"))
data$perception_complete.factor = factor(data$perception_complete,levels=c("0","1","2"))
data$dem_gender.factor = factor(data$dem_gender,levels=c("1","2"))
data$dem_ethnicity.factor = factor(data$dem_ethnicity,levels=c("1","2","3","4","5","6"))
data$dem_language_home.factor = factor(data$dem_language_home,levels=c("1","2","3","4"))
data$dem_language_pref.factor = factor(data$dem_language_pref,levels=c("1","2","3","4"))
data$dem_grade.factor = factor(data$dem_grade,levels=c("00","0","1","2","3","4","5","6","7","8","9","10","11","12","13"))
data$demographics_patient_complete.factor = factor(data$demographics_patient_complete,levels=c("0","1","2"))
data$tech_kid_smart_device.factor = factor(data$tech_kid_smart_device,levels=c("1","2","3","4"))
data$tech_kid_brand___1.factor = factor(data$tech_kid_brand___1,levels=c("0","1"))
data$tech_kid_brand___2.factor = factor(data$tech_kid_brand___2,levels=c("0","1"))
data$tech_kid_brand___3.factor = factor(data$tech_kid_brand___3,levels=c("0","1"))
data$tech_kid_brand___4.factor = factor(data$tech_kid_brand___4,levels=c("0","1"))
data$tech_kid_brand___5.factor = factor(data$tech_kid_brand___5,levels=c("0","1"))
data$tech_kid_brand___6.factor = factor(data$tech_kid_brand___6,levels=c("0","1"))
data$tech_kid_brand___7.factor = factor(data$tech_kid_brand___7,levels=c("0","1"))
data$tech_kid_os___1.factor = factor(data$tech_kid_os___1,levels=c("0","1"))
data$tech_kid_os___2.factor = factor(data$tech_kid_os___2,levels=c("0","1"))
data$tech_kid_os___3.factor = factor(data$tech_kid_os___3,levels=c("0","1"))
data$tech_kid_os___4.factor = factor(data$tech_kid_os___4,levels=c("0","1"))
data$tech_kid_os___5.factor = factor(data$tech_kid_os___5,levels=c("0","1"))
data$tech_kid_os___6.factor = factor(data$tech_kid_os___6,levels=c("0","1"))
data$tech_kid_phone_service.factor = factor(data$tech_kid_phone_service,levels=c("1","0","2"))
data$tech_kid_disconnect.factor = factor(data$tech_kid_disconnect,levels=c("1","2","3"))
data$tech_kid_apps.factor = factor(data$tech_kid_apps,levels=c("1","0"))
data$tech_kid_function___1.factor = factor(data$tech_kid_function___1,levels=c("0","1"))
data$tech_kid_function___2.factor = factor(data$tech_kid_function___2,levels=c("0","1"))
data$tech_kid_function___3.factor = factor(data$tech_kid_function___3,levels=c("0","1"))
data$tech_kid_function___4.factor = factor(data$tech_kid_function___4,levels=c("0","1"))
data$tech_kid_function___5.factor = factor(data$tech_kid_function___5,levels=c("0","1"))
data$tech_kid_privileges.factor = factor(data$tech_kid_privileges,levels=c("1","2","3","4","5"))
data$tech_kid_device_time.factor = factor(data$tech_kid_device_time,levels=c("0","1","2","3","4","5","6","7"))
data$tech_kid_given_device.factor = factor(data$tech_kid_given_device,levels=c("1","2","3"))
data$tech_patient_complete.factor = factor(data$tech_patient_complete,levels=c("0","1","2"))
data$pedsqlkids_01.factor = factor(data$pedsqlkids_01,levels=c("0","1","2","3","4"))
data$pedsqlkids_02.factor = factor(data$pedsqlkids_02,levels=c("0","1","2","3","4"))
data$pedsqlkids_03.factor = factor(data$pedsqlkids_03,levels=c("0","1","2","3","4"))
data$pedsqlkids_04.factor = factor(data$pedsqlkids_04,levels=c("0","1","2","3","4"))
data$pedsqlkids_05.factor = factor(data$pedsqlkids_05,levels=c("0","1","2","3","4"))
data$pedsqlkids_06.factor = factor(data$pedsqlkids_06,levels=c("0","1","2","3","4"))
data$pedsqlkids_07.factor = factor(data$pedsqlkids_07,levels=c("0","1","2","3","4"))
data$pedsqlkids_08.factor = factor(data$pedsqlkids_08,levels=c("0","1","2","3","4"))
data$pedsqlkids_09.factor = factor(data$pedsqlkids_09,levels=c("0","1","2","3","4"))
data$pedsqlkids_10.factor = factor(data$pedsqlkids_10,levels=c("0","1","2","3","4"))
data$pedsqlkids_11.factor = factor(data$pedsqlkids_11,levels=c("0","1","2","3","4"))
data$pedsqlkids_12.factor = factor(data$pedsqlkids_12,levels=c("0","1","2","3","4"))
data$pedsqlkids_13.factor = factor(data$pedsqlkids_13,levels=c("0","1","2","3","4"))
data$pedsqlkids_14.factor = factor(data$pedsqlkids_14,levels=c("0","1","2","3","4"))
data$pedsqlkids_15.factor = factor(data$pedsqlkids_15,levels=c("0","1","2","3","4"))
data$pedsqlkids_16.factor = factor(data$pedsqlkids_16,levels=c("0","1","2","3","4"))
data$pedsqlkids_17.factor = factor(data$pedsqlkids_17,levels=c("0","1","2","3","4"))
data$pedsqlkids_18.factor = factor(data$pedsqlkids_18,levels=c("0","1","2","3","4"))
data$pedsqlkids_19.factor = factor(data$pedsqlkids_19,levels=c("0","1","2","3","4"))
data$pedsqlkids_20.factor = factor(data$pedsqlkids_20,levels=c("0","1","2","3","4"))
data$pedsqlkids_21.factor = factor(data$pedsqlkids_21,levels=c("0","1","2","3","4"))
data$pedsqlkids_22.factor = factor(data$pedsqlkids_22,levels=c("0","1","2","3","4"))
data$pedsqlkids_23.factor = factor(data$pedsqlkids_23,levels=c("0","1","2","3","4"))
data$pedsql_patient_complete.factor = factor(data$pedsql_patient_complete,levels=c("0","1","2"))
data$act_nutri_kids01.factor = factor(data$act_nutri_kids01,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids02.factor = factor(data$act_nutri_kids02,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids03.factor = factor(data$act_nutri_kids03,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids04.factor = factor(data$act_nutri_kids04,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids05.factor = factor(data$act_nutri_kids05,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids06.factor = factor(data$act_nutri_kids06,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids07.factor = factor(data$act_nutri_kids07,levels=c("0","1","2","3","4"))
data$act_nutri_kids08.factor = factor(data$act_nutri_kids08,levels=c("0","1","2","3","4"))
data$act_nutri_kids09.factor = factor(data$act_nutri_kids09,levels=c("0","1","2","3","4"))
data$act_nutri_kids10.factor = factor(data$act_nutri_kids10,levels=c("0","1","2","3","4"))
data$act_nutri_kids11.factor = factor(data$act_nutri_kids11,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids12.factor = factor(data$act_nutri_kids12,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids13.factor = factor(data$act_nutri_kids13,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids14.factor = factor(data$act_nutri_kids14,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids15.factor = factor(data$act_nutri_kids15,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids16.factor = factor(data$act_nutri_kids16,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids17.factor = factor(data$act_nutri_kids17,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids18.factor = factor(data$act_nutri_kids18,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids19.factor = factor(data$act_nutri_kids19,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids20.factor = factor(data$act_nutri_kids20,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids21.factor = factor(data$act_nutri_kids21,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids22.factor = factor(data$act_nutri_kids22,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids23.factor = factor(data$act_nutri_kids23,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids24.factor = factor(data$act_nutri_kids24,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids25.factor = factor(data$act_nutri_kids25,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids26.factor = factor(data$act_nutri_kids26,levels=c("0","1","2","3","4"))
data$act_nutri_kids27.factor = factor(data$act_nutri_kids27,levels=c("0","1","2","3","4"))
data$physical_activity_nutrition_patient_complete.factor = factor(data$physical_activity_nutrition_patient_complete,levels=c("0","1","2"))
data$weight_01.factor = factor(data$weight_01,levels=c("1","2","3","4","5","6","7"))
data$weight_02.factor = factor(data$weight_02,levels=c("1","2","3","4","5","6","7"))
data$weight_03.factor = factor(data$weight_03,levels=c("1","2","3","4","5","6","7"))
data$weight_04.factor = factor(data$weight_04,levels=c("1","2","3","4","5","6","7"))
data$weight_05.factor = factor(data$weight_05,levels=c("1","2","3","4","5","6","7"))
data$weight_06.factor = factor(data$weight_06,levels=c("1","2","3","4","5","6","7"))
data$weight_07.factor = factor(data$weight_07,levels=c("1","2","3","4","5","6","7"))
data$weight_08.factor = factor(data$weight_08,levels=c("1","2","3","4","5","6","7"))
data$weight_09.factor = factor(data$weight_09,levels=c("1","2","3","4","5","6","7"))
data$weight_10.factor = factor(data$weight_10,levels=c("1","2","3","4","5","6","7"))
data$weight_11.factor = factor(data$weight_11,levels=c("1","2","3","4","5","6","7"))
data$weight_12.factor = factor(data$weight_12,levels=c("1","2","3","4","5","6","7"))
data$weight_13.factor = factor(data$weight_13,levels=c("1","2","3","4","5","6","7"))
data$weight_14.factor = factor(data$weight_14,levels=c("1","2","3","4","5","6","7"))
data$weight_15.factor = factor(data$weight_15,levels=c("1","2","3","4","5","6","7"))
data$weight_16.factor = factor(data$weight_16,levels=c("1","2","3","4","5","6","7"))
data$has_asthma.factor = factor(data$has_asthma,levels=c("1","0"))
data$weight_patient_complete.factor = factor(data$weight_patient_complete,levels=c("0","1","2"))
data$asthma01___0.factor = factor(data$asthma01___0,levels=c("0","1"))
data$asthma01___1.factor = factor(data$asthma01___1,levels=c("0","1"))
data$asthma01___11.factor = factor(data$asthma01___11,levels=c("0","1"))
data$asthma01___00.factor = factor(data$asthma01___00,levels=c("0","1"))
data$asthma01___000.factor = factor(data$asthma01___000,levels=c("0","1"))
data$asthma01___111.factor = factor(data$asthma01___111,levels=c("0","1"))
data$asthma01___0000.factor = factor(data$asthma01___0000,levels=c("0","1"))
data$asthma01___00000.factor = factor(data$asthma01___00000,levels=c("0","1"))
data$asthma01___000000.factor = factor(data$asthma01___000000,levels=c("0","1"))
data$asthma01___1111.factor = factor(data$asthma01___1111,levels=c("0","1"))
data$asthma02.factor = factor(data$asthma02,levels=c("0","1"))
data$asthma03.factor = factor(data$asthma03,levels=c("1","0"))
data$asthma04.factor = factor(data$asthma04,levels=c("0","1"))
data$asthma05.factor = factor(data$asthma05,levels=c("0","1"))
data$asthma07.factor = factor(data$asthma07,levels=c("1","0"))
data$asthma08.factor = factor(data$asthma08,levels=c("1","0"))
data$asthma09.factor = factor(data$asthma09,levels=c("0","1"))
data$asthma10___0.factor = factor(data$asthma10___0,levels=c("0","1"))
data$asthma10___00.factor = factor(data$asthma10___00,levels=c("0","1"))
data$asthma10___1.factor = factor(data$asthma10___1,levels=c("0","1"))
data$asthma10___000.factor = factor(data$asthma10___000,levels=c("0","1"))
data$asthma10___0000.factor = factor(data$asthma10___0000,levels=c("0","1"))
data$asthma10___11.factor = factor(data$asthma10___11,levels=c("0","1"))
data$asthma10___00000.factor = factor(data$asthma10___00000,levels=c("0","1"))
data$asthma10___000000.factor = factor(data$asthma10___000000,levels=c("0","1"))
data$asthma10___0000000.factor = factor(data$asthma10___0000000,levels=c("0","1"))
data$asthma10___00000000.factor = factor(data$asthma10___00000000,levels=c("0","1"))
data$asthma10___111.factor = factor(data$asthma10___111,levels=c("0","1"))
data$asthma10___000000000.factor = factor(data$asthma10___000000000,levels=c("0","1"))
data$asthma10___1111.factor = factor(data$asthma10___1111,levels=c("0","1"))
data$asthma10___0000000000.factor = factor(data$asthma10___0000000000,levels=c("0","1"))
data$asthma10___00000000000.factor = factor(data$asthma10___00000000000,levels=c("0","1"))
data$asthma10___11111.factor = factor(data$asthma10___11111,levels=c("0","1"))
data$asthma10___000000000000.factor = factor(data$asthma10___000000000000,levels=c("0","1"))
data$asthma10___0000000000000.factor = factor(data$asthma10___0000000000000,levels=c("0","1"))
data$asthma10___000000000000000.factor = factor(data$asthma10___000000000000000,levels=c("0","1"))
data$asthma10___0000000000000000.factor = factor(data$asthma10___0000000000000000,levels=c("0","1"))
data$asthma10___111111.factor = factor(data$asthma10___111111,levels=c("0","1"))
data$asthma11___1.factor = factor(data$asthma11___1,levels=c("0","1"))
data$asthma11___11.factor = factor(data$asthma11___11,levels=c("0","1"))
data$asthma11___0.factor = factor(data$asthma11___0,levels=c("0","1"))
data$asthma11___111.factor = factor(data$asthma11___111,levels=c("0","1"))
data$asthma11___00.factor = factor(data$asthma11___00,levels=c("0","1"))
data$asthma11___000.factor = factor(data$asthma11___000,levels=c("0","1"))
data$asthma11___0000.factor = factor(data$asthma11___0000,levels=c("0","1"))
data$asthma11___00000.factor = factor(data$asthma11___00000,levels=c("0","1"))
data$asthma11___000000.factor = factor(data$asthma11___000000,levels=c("0","1"))
data$asthma11___0000000.factor = factor(data$asthma11___0000000,levels=c("0","1"))
data$asthma11___00000000.factor = factor(data$asthma11___00000000,levels=c("0","1"))
data$asthma11___000000000.factor = factor(data$asthma11___000000000,levels=c("0","1"))
data$asthma11___0000000000.factor = factor(data$asthma11___0000000000,levels=c("0","1"))
data$asthma11___00000000000.factor = factor(data$asthma11___00000000000,levels=c("0","1"))
data$asthma11___1111.factor = factor(data$asthma11___1111,levels=c("0","1"))
data$asthma11___000000000000.factor = factor(data$asthma11___000000000000,levels=c("0","1"))
data$asthma11___0000000000000.factor = factor(data$asthma11___0000000000000,levels=c("0","1"))
data$asthma11___00000000000000.factor = factor(data$asthma11___00000000000000,levels=c("0","1"))
data$asthma11___000000000000000.factor = factor(data$asthma11___000000000000000,levels=c("0","1"))
data$asthma11___11111.factor = factor(data$asthma11___11111,levels=c("0","1"))
data$asthma11___0000000000000000.factor = factor(data$asthma11___0000000000000000,levels=c("0","1"))
data$asthma12.factor = factor(data$asthma12,levels=c("0","1"))
data$asthma13.factor = factor(data$asthma13,levels=c("0","1"))
data$asthma14.factor = factor(data$asthma14,levels=c("0","1"))
data$asthma15.factor = factor(data$asthma15,levels=c("0","1"))
data$asthma16.factor = factor(data$asthma16,levels=c("0","1"))
data$asthma17.factor = factor(data$asthma17,levels=c("0","1"))
data$asthma18.factor = factor(data$asthma18,levels=c("1","0"))
data$asthma19.factor = factor(data$asthma19,levels=c("0","1"))
data$asthma20.factor = factor(data$asthma20,levels=c("0","1"))
data$asthma22.factor = factor(data$asthma22,levels=c("0","1"))
data$asthma24.factor = factor(data$asthma24,levels=c("0","1"))
data$asthma25.factor = factor(data$asthma25,levels=c("0","1"))
data$asthma26.factor = factor(data$asthma26,levels=c("1","0"))
data$asthma27.factor = factor(data$asthma27,levels=c("1","0"))
data$asthma28.factor = factor(data$asthma28,levels=c("0","1"))
data$asthma29.factor = factor(data$asthma29,levels=c("1","0"))
data$asthma30.factor = factor(data$asthma30,levels=c("0","1"))
data$asthma31.factor = factor(data$asthma31,levels=c("1","0"))
data$asthma_knowledge_patient_complete.factor = factor(data$asthma_knowledge_patient_complete,levels=c("0","1","2"))
data$dem_parent_sex.factor = factor(data$dem_parent_sex,levels=c("1","2"))
data$dem_parent_ethnicity.factor = factor(data$dem_parent_ethnicity,levels=c("1","2","3","4","5","6"))
data$dem_parent_language_pref.factor = factor(data$dem_parent_language_pref,levels=c("1","2","3","4"))
data$dem_parent_school.factor = factor(data$dem_parent_school,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_nationality.factor = factor(data$dem_parent_nationality,levels=c("1","2","3","4","5"))
data$dem_parent_us.factor = factor(data$dem_parent_us,levels=c("1","2","3","4","5","6","7"))
data$dem_kid_nationality.factor = factor(data$dem_kid_nationality,levels=c("1","2","3","4","5"))
data$dem_kid_us.factor = factor(data$dem_kid_us,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_job.factor = factor(data$dem_parent_job,levels=c("1","2","3","4"))
data$dem_parent_income.factor = factor(data$dem_parent_income,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_marital.factor = factor(data$dem_parent_marital,levels=c("1","2","3","4","5"))
data$dem_parent_habitants.factor = factor(data$dem_parent_habitants,levels=c("2","3","4","5","6","7","8"))
data$dem_kid_pmhx___1.factor = factor(data$dem_kid_pmhx___1,levels=c("0","1"))
data$dem_kid_pmhx___2.factor = factor(data$dem_kid_pmhx___2,levels=c("0","1"))
data$dem_kid_pmhx___3.factor = factor(data$dem_kid_pmhx___3,levels=c("0","1"))
data$dem_kid_pmhx___4.factor = factor(data$dem_kid_pmhx___4,levels=c("0","1"))
data$dem_kid_pmhx___5.factor = factor(data$dem_kid_pmhx___5,levels=c("0","1"))
data$dem_kid_pmhx___6.factor = factor(data$dem_kid_pmhx___6,levels=c("0","1"))
data$dem_kid_pmhx___7.factor = factor(data$dem_kid_pmhx___7,levels=c("0","1"))
data$dem_kid_pmhx___8.factor = factor(data$dem_kid_pmhx___8,levels=c("0","1"))
data$dem_kid_pmhx___9.factor = factor(data$dem_kid_pmhx___9,levels=c("0","1"))
data$dem_kid_famhx___1.factor = factor(data$dem_kid_famhx___1,levels=c("0","1"))
data$dem_kid_famhx___2.factor = factor(data$dem_kid_famhx___2,levels=c("0","1"))
data$dem_kid_famhx___3.factor = factor(data$dem_kid_famhx___3,levels=c("0","1"))
data$dem_kid_famhx___4.factor = factor(data$dem_kid_famhx___4,levels=c("0","1"))
data$dem_kid_famhx___5.factor = factor(data$dem_kid_famhx___5,levels=c("0","1"))
data$dem_kid_famhx___6.factor = factor(data$dem_kid_famhx___6,levels=c("0","1"))
data$dem_kid_famhx___7.factor = factor(data$dem_kid_famhx___7,levels=c("0","1"))
data$dem_kid_famhx___8.factor = factor(data$dem_kid_famhx___8,levels=c("0","1"))
data$dem_kid_famhx___9.factor = factor(data$dem_kid_famhx___9,levels=c("0","1"))
data$demographics_parent_complete.factor = factor(data$demographics_parent_complete,levels=c("0","1","2"))
data$tech_parent_device.factor = factor(data$tech_parent_device,levels=c("1","2","3","4"))
data$tech_parent_brand___1.factor = factor(data$tech_parent_brand___1,levels=c("0","1"))
data$tech_parent_brand___2.factor = factor(data$tech_parent_brand___2,levels=c("0","1"))
data$tech_parent_brand___3.factor = factor(data$tech_parent_brand___3,levels=c("0","1"))
data$tech_parent_brand___4.factor = factor(data$tech_parent_brand___4,levels=c("0","1"))
data$tech_parent_brand___5.factor = factor(data$tech_parent_brand___5,levels=c("0","1"))
data$tech_parent_brand___6.factor = factor(data$tech_parent_brand___6,levels=c("0","1"))
data$tech_parent_brand___7.factor = factor(data$tech_parent_brand___7,levels=c("0","1"))
data$tech_parent_os___1.factor = factor(data$tech_parent_os___1,levels=c("0","1"))
data$tech_parent_os___2.factor = factor(data$tech_parent_os___2,levels=c("0","1"))
data$tech_parent_os___3.factor = factor(data$tech_parent_os___3,levels=c("0","1"))
data$tech_parent_os___4.factor = factor(data$tech_parent_os___4,levels=c("0","1"))
data$tech_parent_os___6.factor = factor(data$tech_parent_os___6,levels=c("0","1"))
data$tech_parent_os___7.factor = factor(data$tech_parent_os___7,levels=c("0","1"))
data$tech_parent_phone_service.factor = factor(data$tech_parent_phone_service,levels=c("1","0","2"))
data$tech_parent_disconnect.factor = factor(data$tech_parent_disconnect,levels=c("1","2","3"))
data$tech_parent_apps.factor = factor(data$tech_parent_apps,levels=c("1","0"))
data$tech_parent_function___1.factor = factor(data$tech_parent_function___1,levels=c("0","1"))
data$tech_parent_function___2.factor = factor(data$tech_parent_function___2,levels=c("0","1"))
data$tech_parent_function___3.factor = factor(data$tech_parent_function___3,levels=c("0","1"))
data$tech_parent_function___4.factor = factor(data$tech_parent_function___4,levels=c("0","1"))
data$tech_parent_function___5.factor = factor(data$tech_parent_function___5,levels=c("0","1"))
data$tech_parent_info___1.factor = factor(data$tech_parent_info___1,levels=c("0","1"))
data$tech_parent_info___2.factor = factor(data$tech_parent_info___2,levels=c("0","1"))
data$tech_parent_info___3.factor = factor(data$tech_parent_info___3,levels=c("0","1"))
data$tech_parent_info___4.factor = factor(data$tech_parent_info___4,levels=c("0","1"))
data$tech_parent_info___5.factor = factor(data$tech_parent_info___5,levels=c("0","1"))
data$tech_parent_info___6.factor = factor(data$tech_parent_info___6,levels=c("0","1"))
data$tech_parent_info___7.factor = factor(data$tech_parent_info___7,levels=c("0","1"))
data$tech_parent_info___8.factor = factor(data$tech_parent_info___8,levels=c("0","1"))
data$tech_kid_par_device.factor = factor(data$tech_kid_par_device,levels=c("1","2","3","4"))
data$tech_kid_par_brand___1.factor = factor(data$tech_kid_par_brand___1,levels=c("0","1"))
data$tech_kid_par_brand___2.factor = factor(data$tech_kid_par_brand___2,levels=c("0","1"))
data$tech_kid_par_brand___3.factor = factor(data$tech_kid_par_brand___3,levels=c("0","1"))
data$tech_kid_par_brand___4.factor = factor(data$tech_kid_par_brand___4,levels=c("0","1"))
data$tech_kid_par_brand___5.factor = factor(data$tech_kid_par_brand___5,levels=c("0","1"))
data$tech_kid_par_brand___6.factor = factor(data$tech_kid_par_brand___6,levels=c("0","1"))
data$tech_kid_par_brand___7.factor = factor(data$tech_kid_par_brand___7,levels=c("0","1"))
data$tech_kid_par_os___1.factor = factor(data$tech_kid_par_os___1,levels=c("0","1"))
data$tech_kid_par_os___2.factor = factor(data$tech_kid_par_os___2,levels=c("0","1"))
data$tech_kid_par_os___3.factor = factor(data$tech_kid_par_os___3,levels=c("0","1"))
data$tech_kid_par_os___4.factor = factor(data$tech_kid_par_os___4,levels=c("0","1"))
data$tech_kid_par_os___6.factor = factor(data$tech_kid_par_os___6,levels=c("0","1"))
data$tech_kid_par_os___7.factor = factor(data$tech_kid_par_os___7,levels=c("0","1"))
data$tech_kid_par_service.factor = factor(data$tech_kid_par_service,levels=c("1","0","2"))
data$tech_kid_par_disconnected.factor = factor(data$tech_kid_par_disconnected,levels=c("1","2","3"))
data$tech_kid_par_app.factor = factor(data$tech_kid_par_app,levels=c("1","0"))
data$tech_parent_privileges.factor = factor(data$tech_parent_privileges,levels=c("1","2","3","4","5"))
data$tech_parent_uses.factor = factor(data$tech_parent_uses,levels=c("1","2","3"))
data$tech_parent_complete.factor = factor(data$tech_parent_complete,levels=c("0","1","2"))
data$pedsqlparent_01.factor = factor(data$pedsqlparent_01,levels=c("0","1","2","3","4"))
data$pedsqlparent_02.factor = factor(data$pedsqlparent_02,levels=c("0","1","2","3","4"))
data$pedsqlparent_03.factor = factor(data$pedsqlparent_03,levels=c("0","1","2","3","4"))
data$pedsqlparent_04.factor = factor(data$pedsqlparent_04,levels=c("0","1","2","3","4"))
data$pedsqlparent_05.factor = factor(data$pedsqlparent_05,levels=c("0","1","2","3","4"))
data$pedsqlparent_06.factor = factor(data$pedsqlparent_06,levels=c("0","1","2","3","4"))
data$pedsqlparent_07.factor = factor(data$pedsqlparent_07,levels=c("0","1","2","3","4"))
data$pedsqlparent_08.factor = factor(data$pedsqlparent_08,levels=c("0","1","2","3","4"))
data$pedsqlparent_09.factor = factor(data$pedsqlparent_09,levels=c("0","1","2","3","4"))
data$pedsqlparent_10.factor = factor(data$pedsqlparent_10,levels=c("0","1","2","3","4"))
data$pedsqlparent_11.factor = factor(data$pedsqlparent_11,levels=c("0","1","2","3","4"))
data$pedsqlparent_12.factor = factor(data$pedsqlparent_12,levels=c("0","1","2","3","4"))
data$pedsqlparent_13.factor = factor(data$pedsqlparent_13,levels=c("0","1","2","3","4"))
data$pedsqlparent_14.factor = factor(data$pedsqlparent_14,levels=c("0","1","2","3","4"))
data$pedsqlparent_15.factor = factor(data$pedsqlparent_15,levels=c("0","1","2","3","4"))
data$pedsqlparent_16.factor = factor(data$pedsqlparent_16,levels=c("0","1","2","3","4"))
data$pedsqlparent_17.factor = factor(data$pedsqlparent_17,levels=c("0","1","2","3","4"))
data$pedsqlparent_18.factor = factor(data$pedsqlparent_18,levels=c("0","1","2","3","4"))
data$pedsqlparent_19.factor = factor(data$pedsqlparent_19,levels=c("0","1","2","3","4"))
data$pedsqlparent_20.factor = factor(data$pedsqlparent_20,levels=c("0","1","2","3","4"))
data$pedsqlparent_21.factor = factor(data$pedsqlparent_21,levels=c("0","1","2","3","4"))
data$pedsqlparent_22.factor = factor(data$pedsqlparent_22,levels=c("0","1","2","3","4"))
data$pedsqlparent_23.factor = factor(data$pedsqlparent_23,levels=c("0","1","2","3","4"))
data$pedsql_parent_complete.factor = factor(data$pedsql_parent_complete,levels=c("0","1","2"))
data$act_nutri_parent01.factor = factor(data$act_nutri_parent01,levels=c("1","0"))
data$act_nutri_parent02.factor = factor(data$act_nutri_parent02,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent03.factor = factor(data$act_nutri_parent03,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent04.factor = factor(data$act_nutri_parent04,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent05.factor = factor(data$act_nutri_parent05,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent06.factor = factor(data$act_nutri_parent06,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent07.factor = factor(data$act_nutri_parent07,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent08.factor = factor(data$act_nutri_parent08,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent09.factor = factor(data$act_nutri_parent09,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent10.factor = factor(data$act_nutri_parent10,levels=c("1","2"))
data$act_nutri_parent11.factor = factor(data$act_nutri_parent11,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent12.factor = factor(data$act_nutri_parent12,levels=c("0","1","2","3","4"))
data$act_nutri_parent13.factor = factor(data$act_nutri_parent13,levels=c("0","1","2","3","4"))
data$act_nutri_parent14.factor = factor(data$act_nutri_parent14,levels=c("0","1","2","3","4"))
data$act_nutri_parent15.factor = factor(data$act_nutri_parent15,levels=c("0","1","2","3","4"))
data$act_nutri_parent16.factor = factor(data$act_nutri_parent16,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent17.factor = factor(data$act_nutri_parent17,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent18.factor = factor(data$act_nutri_parent18,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent19.factor = factor(data$act_nutri_parent19,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent20.factor = factor(data$act_nutri_parent20,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent21.factor = factor(data$act_nutri_parent21,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent22.factor = factor(data$act_nutri_parent22,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent23.factor = factor(data$act_nutri_parent23,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent24.factor = factor(data$act_nutri_parent24,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent25.factor = factor(data$act_nutri_parent25,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent26.factor = factor(data$act_nutri_parent26,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent27.factor = factor(data$act_nutri_parent27,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent28.factor = factor(data$act_nutri_parent28,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent29.factor = factor(data$act_nutri_parent29,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent30.factor = factor(data$act_nutri_parent30,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent31.factor = factor(data$act_nutri_parent31,levels=c("0","1","2","3","4"))
data$physical_activity_nutrition_parent_complete.factor = factor(data$physical_activity_nutrition_parent_complete,levels=c("0","1","2"))
data$asthma_parent01___0.factor = factor(data$asthma_parent01___0,levels=c("0","1"))
data$asthma_parent01___1.factor = factor(data$asthma_parent01___1,levels=c("0","1"))
data$asthma_parent01___11.factor = factor(data$asthma_parent01___11,levels=c("0","1"))
data$asthma_parent01___00.factor = factor(data$asthma_parent01___00,levels=c("0","1"))
data$asthma_parent01___000.factor = factor(data$asthma_parent01___000,levels=c("0","1"))
data$asthma_parent01___111.factor = factor(data$asthma_parent01___111,levels=c("0","1"))
data$asthma_parent01___0000.factor = factor(data$asthma_parent01___0000,levels=c("0","1"))
data$asthma_parent01___00000.factor = factor(data$asthma_parent01___00000,levels=c("0","1"))
data$asthma_parent01___000000.factor = factor(data$asthma_parent01___000000,levels=c("0","1"))
data$asthma_parent01___1111.factor = factor(data$asthma_parent01___1111,levels=c("0","1"))
data$asthma_parent02.factor = factor(data$asthma_parent02,levels=c("0","1"))
data$asthma_parent03.factor = factor(data$asthma_parent03,levels=c("1","0"))
data$asthma_parent04.factor = factor(data$asthma_parent04,levels=c("0","1"))
data$asthma_parent05.factor = factor(data$asthma_parent05,levels=c("0","1"))
data$asthma_parent07.factor = factor(data$asthma_parent07,levels=c("1","0"))
data$asthma_parent08.factor = factor(data$asthma_parent08,levels=c("1","0"))
data$asthma_parent09.factor = factor(data$asthma_parent09,levels=c("0","1"))
data$asthma_parent10___0.factor = factor(data$asthma_parent10___0,levels=c("0","1"))
data$asthma_parent10___00.factor = factor(data$asthma_parent10___00,levels=c("0","1"))
data$asthma_parent10___1.factor = factor(data$asthma_parent10___1,levels=c("0","1"))
data$asthma_parent10___000.factor = factor(data$asthma_parent10___000,levels=c("0","1"))
data$asthma_parent10___0000.factor = factor(data$asthma_parent10___0000,levels=c("0","1"))
data$asthma_parent10___11.factor = factor(data$asthma_parent10___11,levels=c("0","1"))
data$asthma_parent10___00000.factor = factor(data$asthma_parent10___00000,levels=c("0","1"))
data$asthma_parent10___000000.factor = factor(data$asthma_parent10___000000,levels=c("0","1"))
data$asthma_parent10___0000000.factor = factor(data$asthma_parent10___0000000,levels=c("0","1"))
data$asthma_parent10___00000000.factor = factor(data$asthma_parent10___00000000,levels=c("0","1"))
data$asthma_parent10___111.factor = factor(data$asthma_parent10___111,levels=c("0","1"))
data$asthma_parent10___000000000.factor = factor(data$asthma_parent10___000000000,levels=c("0","1"))
data$asthma_parent10___1111.factor = factor(data$asthma_parent10___1111,levels=c("0","1"))
data$asthma_parent10___0000000000.factor = factor(data$asthma_parent10___0000000000,levels=c("0","1"))
data$asthma_parent10___00000000000.factor = factor(data$asthma_parent10___00000000000,levels=c("0","1"))
data$asthma_parent10___11111.factor = factor(data$asthma_parent10___11111,levels=c("0","1"))
data$asthma_parent10___000000000000.factor = factor(data$asthma_parent10___000000000000,levels=c("0","1"))
data$asthma_parent10___0000000000000.factor = factor(data$asthma_parent10___0000000000000,levels=c("0","1"))
data$asthma_parent10___000000000000000.factor = factor(data$asthma_parent10___000000000000000,levels=c("0","1"))
data$asthma_parent10___0000000000000000.factor = factor(data$asthma_parent10___0000000000000000,levels=c("0","1"))
data$asthma_parent10___111111.factor = factor(data$asthma_parent10___111111,levels=c("0","1"))
data$asthma_parent11___1.factor = factor(data$asthma_parent11___1,levels=c("0","1"))
data$asthma_parent11___11.factor = factor(data$asthma_parent11___11,levels=c("0","1"))
data$asthma_parent11___0.factor = factor(data$asthma_parent11___0,levels=c("0","1"))
data$asthma_parent11___111.factor = factor(data$asthma_parent11___111,levels=c("0","1"))
data$asthma_parent11___00.factor = factor(data$asthma_parent11___00,levels=c("0","1"))
data$asthma_parent11___000.factor = factor(data$asthma_parent11___000,levels=c("0","1"))
data$asthma_parent11___0000.factor = factor(data$asthma_parent11___0000,levels=c("0","1"))
data$asthma_parent11___00000.factor = factor(data$asthma_parent11___00000,levels=c("0","1"))
data$asthma_parent11___000000.factor = factor(data$asthma_parent11___000000,levels=c("0","1"))
data$asthma_parent11___0000000.factor = factor(data$asthma_parent11___0000000,levels=c("0","1"))
data$asthma_parent11___00000000.factor = factor(data$asthma_parent11___00000000,levels=c("0","1"))
data$asthma_parent11___000000000.factor = factor(data$asthma_parent11___000000000,levels=c("0","1"))
data$asthma_parent11___0000000000.factor = factor(data$asthma_parent11___0000000000,levels=c("0","1"))
data$asthma_parent11___00000000000.factor = factor(data$asthma_parent11___00000000000,levels=c("0","1"))
data$asthma_parent11___1111.factor = factor(data$asthma_parent11___1111,levels=c("0","1"))
data$asthma_parent11___000000000000.factor = factor(data$asthma_parent11___000000000000,levels=c("0","1"))
data$asthma_parent11___0000000000000.factor = factor(data$asthma_parent11___0000000000000,levels=c("0","1"))
data$asthma_parent11___00000000000000.factor = factor(data$asthma_parent11___00000000000000,levels=c("0","1"))
data$asthma_parent11___000000000000000.factor = factor(data$asthma_parent11___000000000000000,levels=c("0","1"))
data$asthma_parent11___11111.factor = factor(data$asthma_parent11___11111,levels=c("0","1"))
data$asthma_parent11___0000000000000000.factor = factor(data$asthma_parent11___0000000000000000,levels=c("0","1"))
data$asthma_parent12.factor = factor(data$asthma_parent12,levels=c("0","1"))
data$asthma_parent13.factor = factor(data$asthma_parent13,levels=c("0","1"))
data$asthma_parent14.factor = factor(data$asthma_parent14,levels=c("0","1"))
data$asthma_parent15.factor = factor(data$asthma_parent15,levels=c("0","1"))
data$asthma_parent16.factor = factor(data$asthma_parent16,levels=c("0","1"))
data$asthma_parent17.factor = factor(data$asthma_parent17,levels=c("0","1"))
data$asthma_parent18.factor = factor(data$asthma_parent18,levels=c("1","0"))
data$asthma_parent19.factor = factor(data$asthma_parent19,levels=c("0","1"))
data$asthma_parent20.factor = factor(data$asthma_parent20,levels=c("0","1"))
data$asthma_parent22.factor = factor(data$asthma_parent22,levels=c("0","1"))
data$asthma_parent24.factor = factor(data$asthma_parent24,levels=c("0","1"))
data$asthma_parent25.factor = factor(data$asthma_parent25,levels=c("0","1"))
data$asthma_parent26.factor = factor(data$asthma_parent26,levels=c("1","0"))
data$asthma_parent27.factor = factor(data$asthma_parent27,levels=c("1","0"))
data$asthma_parent28.factor = factor(data$asthma_parent28,levels=c("0","1"))
data$asthma_parent29.factor = factor(data$asthma_parent29,levels=c("1","0"))
data$asthma_parent30.factor = factor(data$asthma_parent30,levels=c("0","1"))
data$asthma_parent31.factor = factor(data$asthma_parent31,levels=c("1","0"))
data$asthma_knowledge_parent_complete.factor = factor(data$asthma_knowledge_parent_complete,levels=c("0","1","2"))
data$usherwood_01.factor = factor(data$usherwood_01,levels=c("0","1","2","3","4"))
data$usherwood_02.factor = factor(data$usherwood_02,levels=c("0","1","2","3","4"))
data$usherwood_03.factor = factor(data$usherwood_03,levels=c("0","1","2","3","4"))
data$usherwood_04.factor = factor(data$usherwood_04,levels=c("0","1","2","3","4"))
data$usherwood_05.factor = factor(data$usherwood_05,levels=c("0","1","2","3","4"))
data$usherwood_06.factor = factor(data$usherwood_06,levels=c("0","1","2","3","4"))
data$usherwood_07.factor = factor(data$usherwood_07,levels=c("0","1","2","3","4"))
data$usherwood_08.factor = factor(data$usherwood_08,levels=c("0","1","2","3","4"))
data$usherwood_09.factor = factor(data$usherwood_09,levels=c("0","1","2","3","4"))
data$usherwood_10.factor = factor(data$usherwood_10,levels=c("0","1","2","3","4"))
data$usherwood_11.factor = factor(data$usherwood_11,levels=c("0","1","2","3","4"))
data$usherwood_12.factor = factor(data$usherwood_12,levels=c("0","1","2","3","4"))
data$usherwood_13.factor = factor(data$usherwood_13,levels=c("0","1","2","3","4"))
data$usherwood_14.factor = factor(data$usherwood_14,levels=c("0","1","2","3","4"))
data$usherwood_15.factor = factor(data$usherwood_15,levels=c("0","1","2","3","4"))
data$usherwood_16.factor = factor(data$usherwood_16,levels=c("0","1","2","3","4"))
data$usherwood_17.factor = factor(data$usherwood_17,levels=c("0","1","2","3","4"))
data$usherwood_complete.factor = factor(data$usherwood_complete,levels=c("0","1","2"))
data$tablet_group.factor = factor(data$tablet_group,levels=c("1","0"))
data$equipment_signout_complete.factor = factor(data$equipment_signout_complete,levels=c("0","1","2"))
data$gift_receipt_complete.factor = factor(data$gift_receipt_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Initial Visit","F/U Visit 1","F/U Visit 2","F/U Visit 3","F/U Visit 4","Final Visit")
levels(data$eng.factor)=c("")
levels(data$esp.factor)=c("")
levels(data$eng2.factor)=c("")
levels(data$esp2.factor)=c("")
levels(data$start_here_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$not_part_ethnicity.factor)=c("[eng2]Black, Non-Hispanic[esp2]Negro o Afroamericano, no Hispano","[eng2]White, Non-Hispanic[esp2]Blanco, no Hispano","[eng2]Asian or Pacific Islander[esp2]Asi&aacutetico o Asi&aacutetico-americano, o de las Islas del Pac&iacutefico","[eng2]Native American or Alaskan Native[esp2]Indio americano o nativo Americano, o nativo de Alaska","[eng2]Hispanic[esp2]Hispano","[eng2]Other[esp2]Otro")
levels(data$not_part_asthma.factor)=c("[eng2]Yes[esp2]Si","No")
levels(data$not_part_obese.factor)=c("[eng2]Yes[esp2]Si","No")
levels(data$not_part_gender.factor)=c("[eng2]Girl[esp2]ni&ntildea","[eng2]Boy[esp2]ni&ntildeo")
levels(data$participating.factor)=c("[eng2]Yes[esp2]Si","No")
levels(data$borinquen_info_release_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$parent_or_guardian___1.factor)=c("Unchecked","Checked")
levels(data$parent_or_guardian___2.factor)=c("Unchecked","Checked")
levels(data$consent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$assent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$parent_or_guardian_v2___1.factor)=c("Unchecked","Checked")
levels(data$parent_or_guardian_v2___2.factor)=c("Unchecked","Checked")
levels(data$consent_2_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$consent2_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$worthtime.factor)=c("Yes","No")
levels(data$tablet_v_drvisit___1.factor)=c("Unchecked","Checked")
levels(data$tablet_v_drvisit___0.factor)=c("Unchecked","Checked")
levels(data$tablet_v_telephone.factor)=c("Yes","No")
levels(data$parentchild.factor)=c("Yes","No")
levels(data$frequency.factor)=c("Every 2 weeks","Every month","Every 2 months","Every 3 months","Every 6 months","Other")
levels(data$easy_tablet.factor)=c("Very Easy","Easy","Neutral","Hard","Very Hard")
levels(data$wifi.factor)=c("Yes","No")
levels(data$fuze.factor)=c("Yes","No")
levels(data$appssites.factor)=c("Fooducate","Myfitnesspal","Sworkit","Choosemyplate.gov","CDC Bam Food & Nutrition","CDC Bam Physical Activity","None of the above")
levels(data$acad_accom.factor)=c("Yes","No")
levels(data$perception_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$dem_gender.factor)=c("[eng]Female[esp]Femenino","[eng]Male[esp]Masculino")
levels(data$dem_ethnicity.factor)=c("[eng]Black, Non-Hispanic[esp]Negro o Afroamericano, no Hispano","[eng]White, Non-Hispanic[esp]Blanco, no Hispano","[eng]Asian or Pacific Islander[esp]Asi&aacutetico o Asi&aacutetico-americano, o de las Islas del Pac&iacutefico","[eng]Native American or Alaskan Native[esp]Indio americano o nativo Americano, o nativo de Alaska","[eng]Hispanic[esp]Hispano","[eng]Other[esp]Otro")
levels(data$dem_language_home.factor)=c("[eng]English[esp]Ingl&eacutes","[eng]Creole[esp]Creole Haitiano","[eng]Spanish[esp]Espa&ntildeol","[eng]Other[esp]Otro")
levels(data$dem_language_pref.factor)=c("[eng]English[esp]Ingl&eacutes","[eng]Creole[esp]Creole Haitiano","[eng]Spanish[esp]Espa&ntildeol","[eng]Other[esp]Otro")
levels(data$dem_grade.factor)=c("Pre-K","Kindergarten","1","2","3","4","5","6","7","8","9","10","11","12","Other/Otro")
levels(data$demographics_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$tech_kid_smart_device.factor)=c("[eng]smart phone[esp]tel&eacutefono inteligente","[eng]tablet[esp]tableta","[eng]both a smart phone and a tablet[esp]los dos un tel&eacutefono inteligente y una tableta ","[eng]neither[esp]ninguno")
levels(data$tech_kid_brand___1.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___2.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___3.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___4.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___5.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___6.factor)=c("Unchecked","Checked")
levels(data$tech_kid_brand___7.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___1.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___2.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___3.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___4.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___5.factor)=c("Unchecked","Checked")
levels(data$tech_kid_os___6.factor)=c("Unchecked","Checked")
levels(data$tech_kid_phone_service.factor)=c("[eng]Yes[esp]Si","[eng]No[esp]No","[eng] Unsure or Not Applicable[esp]No estoy seguro o no aplicable")
levels(data$tech_kid_disconnect.factor)=c("[eng]1-2 times/year[esp]1-2 veces / a&ntildeo","[eng]3-4 times/year[esp]3-4 veces / a&ntildeo","[eng]More than 5 times/year[esp]M&aacutes de 5 veces / a&ntildeo")
levels(data$tech_kid_apps.factor)=c("[eng]Yes[esp]Si","[eng]No[esp]No")
levels(data$tech_kid_function___1.factor)=c("Unchecked","Checked")
levels(data$tech_kid_function___2.factor)=c("Unchecked","Checked")
levels(data$tech_kid_function___3.factor)=c("Unchecked","Checked")
levels(data$tech_kid_function___4.factor)=c("Unchecked","Checked")
levels(data$tech_kid_function___5.factor)=c("Unchecked","Checked")
levels(data$tech_kid_privileges.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi nunca","[eng]Sometimes[esp]A veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$tech_kid_device_time.factor)=c("[eng]Less than 1 hour[esp]Menos de 1 hora","[eng]1 hour[esp]1 hora","[eng]1 - 2 hours[esp]1 - 2 horas ","[eng]2 - 3 hours[esp]2 - 3 horas ","[eng]3 - 4 hours[esp]3 - 4 horas ","[eng]4 - 5 hours[esp]4 - 5 horas ","[eng]5 - 6 hours[esp]5 - 6 horas ","[eng]More than 6 hours[esp]M&aacutes de 6 horas")
levels(data$tech_kid_given_device.factor)=c("[eng]Not Likely[esp]No es probable","[eng]Somewhat Likely[esp]Un poco probable","[eng]Very Likely[esp]Muy Probable")
levels(data$tech_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$pedsqlkids_01.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_02.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_03.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_04.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_05.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_06.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_07.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_08.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_09.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_10.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_11.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_12.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_13.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_14.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_15.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_16.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_17.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_18.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_19.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_20.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_21.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_22.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsqlkids_23.factor)=c("[eng]Never[esp]Nunca","[eng]Almost Never[esp]Casi Nunca","[eng]Sometimes[esp]Algunas Veces","[eng]Often[esp]A menudo","[eng]Almost Always[esp]Casi Siempre")
levels(data$pedsql_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$act_nutri_kids01.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids02.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids03.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids04.factor)=c(" [eng]I do not play video or computer games or use a computer for something that is not school work[esp]Yo no juego juegos de video o juegos de computadora o utilizo una computadora para algo que no sea trabajo de la escuela","[eng]Less than 1 hour per day[esp]Menos de 1 hora al d&iacutea","[eng]1 hour per day[esp]1 hora por d&iacutea ","[eng]2 hours per day[esp]2 horas por d&iacutea ","[eng]3 hours per day[esp]3 horas por d&iacutea ","[eng]4 hours per day[esp]4 horas por d&iacutea","[eng]5 or more hours per day[esp]5 o mas horas por d&iacutea")
levels(data$act_nutri_kids05.factor)=c("[eng]I do not watch DVDs or videos on an average school day[esp]No veo DVDs o v&iacutedeos en un d&iacutea escolar regular","[eng]Less than 1 hour per day[esp]Menos de 1 hora al d&iacutea","[eng]1 hour per day[esp]1 hora por d&iacutea ","[eng]2 hours per day[esp]2 horas por d&iacutea ","[eng]3 hours per day[esp]3 horas por d&iacutea ","[eng]4 hours per day[esp]4 horas por d&iacutea","[eng]5 or more hours per day[esp]5 o mas horas por d&iacutea")
levels(data$act_nutri_kids06.factor)=c("[eng]I do not watch TV on an average school day[esp]Yo no veo la televisi&oacuten en un d&iacutea regular de escuela","[eng]Less than 1 hour per day[esp]Menos de 1 hora al d&iacutea","[eng]1 hour per day[esp]1 hora por d&iacutea ","[eng]2 hours per day[esp]2 horas por d&iacutea ","[eng]3 hours per day[esp]3 horas por d&iacutea ","[eng]4 hours per day[esp]4 horas por d&iacutea","[eng]5 or more hours per day[esp]5 o mas horas por d&iacutea")
levels(data$act_nutri_kids07.factor)=c("[eng]Never[esp]Nunca","[eng]1-2 times per week[esp]1-2 veces por semana","[eng]3-4 times per week[esp]3-4 veces por semana","[eng]5-6 times per week[esp]5-6 veces por semana","[eng]Daily[esp]Diariamente")
levels(data$act_nutri_kids08.factor)=c("[eng]Never[esp]Nunca","[eng]1-2 times per week[esp]1-2 veces por semana","[eng]3-4 times per week[esp]3-4 veces por semana","[eng]5-6 times per week[esp]5-6 veces por semana","[eng]Daily[esp]Diariamente")
levels(data$act_nutri_kids09.factor)=c("[eng]Never[esp]Nunca","[eng]1-2 times per week[esp]1-2 veces por semana","[eng]3-4 times per week[esp]3-4 veces por semana","[eng]5-6 times per week[esp]5-6 veces por semana","[eng]Daily[esp]Diariamente")
levels(data$act_nutri_kids10.factor)=c("[eng]Never[esp]Nunca","[eng]1-2 times per week[esp]1-2 veces por semana","[eng]3-4 times per week[esp]3-4 veces por semana","[eng]5-6 times per week[esp]5-6 veces por semana","[eng]Daily[esp]Diariamente")
levels(data$act_nutri_kids11.factor)=c("[eng] I did not eat fruit during the past 7 days[esp]No he comido fruta durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1-3 veces durante los &uacuteltimos 7 d&iacuteas","[eng] 4 to 6 times during the past 7 days[esp]4-6 veces durante los &uacuteltimos 7 d&iacuteas","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 vez por d&iacutea","[eng] 3 times per day[esp]3 vez por d&iacutea","[eng] 4 or more times per day[esp]4 veces por d&iacutea o mas")
levels(data$act_nutri_kids12.factor)=c("[eng] I did not eat green salad during the past 7 days[esp]No he comido ensalda verde durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids13.factor)=c("[eng] I did not eat potatoes during the past 7 days[esp]No he comido papitas fritas durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids14.factor)=c("[eng] I did not eat carrots during the past 7 days[esp]No he comido zanahorias durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids15.factor)=c("[eng] I did not eat other vegetables during the past 7 days[esp]No he comido vegetales durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids16.factor)=c("[eng] I did not eat pizza during the past 7 days[esp]No he comido pizza durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids17.factor)=c("[eng] I did not drink 100% fruit juice during the past 7 days[esp]No he bebido 100% jugo de fruta durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids18.factor)=c("[eng] I did not drink soda or pop during the past 7 days[esp]No he bebido refresco o soda durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids19.factor)=c("[eng] I did not drink sugar-sweetened beverages  during the past 7 days[esp]No he bebido bebidas endulzadas con azucar durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids20.factor)=c("[eng] I did not drink water during the past 7 days[esp]No he bebido agua durante los &uacuteltimos 7 d&iacuteas","[eng] 1 to 3 times during the past 7 days[esp]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 4 to 6 times during the past 7 days[esp]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng] 1 time per day[esp]1 vez por d&iacutea","[eng] 2 times per day[esp]2 veces por d&iacutea","[eng] 3 times per day[esp]3 veces por d&iacutea","[eng] 4 or more times per day[esp]4 veces o mas por dia ")
levels(data$act_nutri_kids21.factor)=c("[eng] None[esp]Ninguna","[eng] 1/2 cup or less[esp]1/2 taza o menos","[eng] 1/2 cup to 1 cup[esp]1/2 taza a 1 taza","[eng] 1 to 2 cups[esp]1 a 2 tazas","[eng] 2 to 3 cups[esp]2 a 3 tazas","[eng] 3 to 4 cups[esp]3 a 4 tazas","[eng] 4 or more cups[esp]4 tazas o mas")
levels(data$act_nutri_kids22.factor)=c("[eng] None[esp]Ninguna","[eng] 1/2 cup or less[esp]1/2 taza o menos","[eng] 1/2 cup to 1 cup[esp]1/2 taza a 1 taza","[eng] 1 to 2 cups[esp]1 a 2 tazas","[eng] 2 to 3 cups[esp]2 a 3 tazas","[eng] 3 to 4 cups[esp]3 a 4 tazas","[eng] 4 or more cups[esp]4 o mas tazas")
levels(data$act_nutri_kids23.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids24.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids25.factor)=c("[eng] 0 days[esp]0 dias ","[eng] 1 day[esp]1 dia","[eng] 2 days[esp]2 dias ","[eng] 3 days[esp]3 dias ","[eng] 4 days[esp]4 dias ","[eng] 5 days[esp]5 dias ","[eng] 6 days[esp]6 dias ","[eng] 7 days[esp]7 dias ")
levels(data$act_nutri_kids26.factor)=c("[eng] Never[esp]Nunca","[eng] Rarely[esp]Raramente","[eng] Sometimes[esp]A veces","[eng] Most of the time[esp]La mayoria del tiempo","[eng] Always[esp]Siempre")
levels(data$act_nutri_kids27.factor)=c("[eng] Never[esp]Nunca","[eng] Rarely[esp]Raramente","[eng] Sometimes[esp]A veces","[eng] Most of the time[esp]La mayoria del tiempo","[eng] Always[esp]Siempre")
levels(data$physical_activity_nutrition_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$weight_01.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_02.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_03.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_04.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_05.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_06.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_07.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_08.factor)=c("[eng]Not True At All 1[esp]No es cierto en lo absoluto","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_09.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_10.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_11.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_12.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_13.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_14.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_15.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$weight_16.factor)=c("[eng]Not True At All[esp]No es cierto en lo absoluto 1","2","3","[eng]Somewhat True[esp]Algo Cierto4","5","6","[eng]Very True[esp]Muy Cierto7")
levels(data$has_asthma.factor)=c("[eng]Yes[esp]S&iacute ","No")
levels(data$weight_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$asthma01___0.factor)=c("Unchecked","Checked")
levels(data$asthma01___1.factor)=c("Unchecked","Checked")
levels(data$asthma01___11.factor)=c("Unchecked","Checked")
levels(data$asthma01___00.factor)=c("Unchecked","Checked")
levels(data$asthma01___000.factor)=c("Unchecked","Checked")
levels(data$asthma01___111.factor)=c("Unchecked","Checked")
levels(data$asthma01___0000.factor)=c("Unchecked","Checked")
levels(data$asthma01___00000.factor)=c("Unchecked","Checked")
levels(data$asthma01___000000.factor)=c("Unchecked","Checked")
levels(data$asthma01___1111.factor)=c("Unchecked","Checked")
levels(data$asthma02.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma03.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma04.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma05.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma07.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma08.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma09.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma10___0.factor)=c("Unchecked","Checked")
levels(data$asthma10___00.factor)=c("Unchecked","Checked")
levels(data$asthma10___1.factor)=c("Unchecked","Checked")
levels(data$asthma10___000.factor)=c("Unchecked","Checked")
levels(data$asthma10___0000.factor)=c("Unchecked","Checked")
levels(data$asthma10___11.factor)=c("Unchecked","Checked")
levels(data$asthma10___00000.factor)=c("Unchecked","Checked")
levels(data$asthma10___000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___0000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___00000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___111.factor)=c("Unchecked","Checked")
levels(data$asthma10___000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___1111.factor)=c("Unchecked","Checked")
levels(data$asthma10___0000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___00000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___11111.factor)=c("Unchecked","Checked")
levels(data$asthma10___000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___0000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___0000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma10___111111.factor)=c("Unchecked","Checked")
levels(data$asthma11___1.factor)=c("Unchecked","Checked")
levels(data$asthma11___11.factor)=c("Unchecked","Checked")
levels(data$asthma11___0.factor)=c("Unchecked","Checked")
levels(data$asthma11___111.factor)=c("Unchecked","Checked")
levels(data$asthma11___00.factor)=c("Unchecked","Checked")
levels(data$asthma11___000.factor)=c("Unchecked","Checked")
levels(data$asthma11___0000.factor)=c("Unchecked","Checked")
levels(data$asthma11___00000.factor)=c("Unchecked","Checked")
levels(data$asthma11___000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___0000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___00000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___0000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___00000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___1111.factor)=c("Unchecked","Checked")
levels(data$asthma11___000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___0000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___00000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma11___11111.factor)=c("Unchecked","Checked")
levels(data$asthma11___0000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma12.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma13.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma14.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma15.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma16.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma17.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma18.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma19.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma20.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma22.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma24.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma25.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma26.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma27.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma28.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma29.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma30.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma31.factor)=c("[eng] True[esp]Verdadero","[eng] False[esp]Falso")
levels(data$asthma_knowledge_patient_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$dem_parent_sex.factor)=c("[eng2]Female[esp2]Femenino","[eng2]Male[esp2]Masculino")
levels(data$dem_parent_ethnicity.factor)=c("[eng2]Black, Non-Hispanic[esp2]Negro o Afroamericano, no Hispano","[eng2]white, Non-Hispanic[esp2]Blanco, no Hispano","[eng2]Asian or Pacific Islander[esp2]Asi&aacutetico o Asi&aacutetico-americano, o de las Islas del Pacífico","[eng2]Native American or Alaskan Native[esp2]Indio americano o nativo Americano, o nativo de Alaska","[eng2]Hispanic[esp2]Hispano","[eng2]Other[esp2]Otro")
levels(data$dem_parent_language_pref.factor)=c("[eng2]English[esp2]Ingl&eacutes","[eng2]Creole[esp2]Creole Haitiano","[eng2]Spanish[esp2]Espa&ntildeol","[eng2]Other[esp2]Otro")
levels(data$dem_parent_school.factor)=c("[eng2]Never attended school[esp2]Nunca fue a la escuela","[eng2]1st to 8th grade (elementary)[esp2]1 a 8 grado (primaria)","[eng2]9th to 11th grade (some high school)[esp2]9 al 11 grado (educaci&oacuten secundaria incompleta)","[eng2]12th grade or GED (high school graduate)[esp2]12 grado o GED (graduado de la escuela secundaria)","[eng2]1 to 3 years college (some college or technical school)[esp2]1 a 3 a&ntildeos de universidad (algunos a&ntildeos de universidad o escuela t&eacutecnica)","[eng2]4 or more years college (college graduate)[esp2]4 o m&aacutes a&ntildeos de universidad (graduado de la universidad)","[eng2]Graduate training or professional degree[esp2]Formaci&oacuten de postgrado o t&iacutetulo profesional")
levels(data$dem_parent_nationality.factor)=c("[eng2]United States[esp2]Estados Unidos","[eng2]Cuba[esp2]Cuba","[eng2]Mexico[esp2]M&eacutexico","[eng2]Haiti[esp2]Hait&iacute","[eng2]Other[esp2]Otros")
levels(data$dem_parent_us.factor)=c("[eng2]Less than 1 year[esp2]Menos de 1 a&ntildeo","[eng2]1-3 years[esp2]1 - 3 a&ntildeos","[eng2]4-6 years[esp2]4 - 6 a&ntildeos","[eng2]7-9 years[esp2]7 - 9 a&ntildeos","[eng2]10-12 years[esp2]10 - 12 a&ntildeos","[eng2]13-15 years[esp2]13 - 15 a&ntildeos","[eng2]More than 15 years[esp2]M&aacutes de 15 a&ntildeos")
levels(data$dem_kid_nationality.factor)=c("[eng2]United States[esp2]Estados Unidos","[eng2]Cuba[esp2]Cuba","[eng2]Mexico[esp2]M&eacutexico","[eng2]Haiti[esp2]Hait&iacute","[eng2]Other[esp2]Otros")
levels(data$dem_kid_us.factor)=c("[eng2]Less than 1 year[esp2]Menos de 1 a&ntildeo","[eng2]1-3 years[esp2]1 - 3 a&ntildeos","[eng2]4-6 years[esp2]4 - 6 a&ntildeos","[eng2]7-9 years[esp2]7 - 9 a&ntildeos","[eng2]10-12 years[esp2]10 - 12 a&ntildeos","[eng2]13-15 years[esp2]13 - 15 a&ntildeos","[eng2]More than 15 years[esp2]M&aacutes de 15 a&ntildeos")
levels(data$dem_parent_job.factor)=c("[eng2]Full Time[esp2]Tiempo completo","[eng2]Part Time[esp2]Tiempo parcial","[eng2]Retired[esp2]Jubilado/Retirado","[eng2]Unemployed[esp2]Desempleado")
levels(data$dem_parent_income.factor)=c("[eng2]Below $10,000[esp2]Por debajo de $ 10,000","[eng2]$10,000 - $24,999[esp2]$10,000 - $24,999","[eng2]$25,000 - $39,999[esp2]$25,000 - $39,999","[eng2]$40,000 - $54,999[esp2]$40,000 - $54,999","[eng2]$55,000 - $69,999[esp2]$55,000 - $69,999","[eng2]$70,000 - $84,000[esp2]$70,000 - $84,000","[eng2]Over $85,000[esp2]Mas de $85,000")
levels(data$dem_parent_marital.factor)=c("[eng2]Single[esp2]Soltero","[eng2]Married[esp2]Casado","[eng2]Separated[esp2]Separado","[eng2]Divorced[esp2]Divorciado","[eng2]Widowed[esp2]Viudo")
levels(data$dem_parent_habitants.factor)=c("[eng2]2 people[esp2]2 personas","[eng2]3 people[esp2]3 personas","[eng2]4 people[esp2]4 personas","[eng2]5 people[esp2]5 personas","[eng2]6 people[esp2]6 personas","[eng2]7 people[esp2]7 personas","[eng2]More than 7 people[esp2]M&aacutes de 7 personas")
levels(data$dem_kid_pmhx___1.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___2.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___3.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___4.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___5.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___6.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___7.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___8.factor)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___9.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___1.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___2.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___3.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___4.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___5.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___6.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___7.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___8.factor)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___9.factor)=c("Unchecked","Checked")
levels(data$demographics_parent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$tech_parent_device.factor)=c("[eng2]smart phone[esp2]tel&eacutefono inteligente","[eng2]tablet[esp2]tableta","[eng2]both a smart phone and a tablet[esp2]los dos un tel&eacutefono inteligente y una tableta ","[eng2]neither[esp2]ninguno")
levels(data$tech_parent_brand___1.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___2.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___3.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___4.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___5.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___6.factor)=c("Unchecked","Checked")
levels(data$tech_parent_brand___7.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___1.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___2.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___3.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___4.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___6.factor)=c("Unchecked","Checked")
levels(data$tech_parent_os___7.factor)=c("Unchecked","Checked")
levels(data$tech_parent_phone_service.factor)=c("[eng2]Yes[esp2]Si","[eng2]No[esp2]No","[eng2] Unsure or Not Applicable[esp2]No estoy seguro o no aplicable")
levels(data$tech_parent_disconnect.factor)=c("[eng2]1-2 times/year[esp2]1-2 veces / a&ntildeo","[eng2]3-4 times/year[esp2]3-4 veces / a&ntildeo","[eng2]More than 5 times/year[esp2]M&aacutes de 5 veces / a&ntildeo")
levels(data$tech_parent_apps.factor)=c("[eng2]Yes[esp2]Si","[eng2]No[esp2]No")
levels(data$tech_parent_function___1.factor)=c("Unchecked","Checked")
levels(data$tech_parent_function___2.factor)=c("Unchecked","Checked")
levels(data$tech_parent_function___3.factor)=c("Unchecked","Checked")
levels(data$tech_parent_function___4.factor)=c("Unchecked","Checked")
levels(data$tech_parent_function___5.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___1.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___2.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___3.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___4.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___5.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___6.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___7.factor)=c("Unchecked","Checked")
levels(data$tech_parent_info___8.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_device.factor)=c("[eng2]smart phone[esp2]tel&eacutefono inteligente","[eng2]tablet[esp2]tableta","[eng2]both a smart phone and a tablet[esp2]los dos un tel&eacutefono inteligente y una tableta ","[eng2]neither[esp2]ninguno")
levels(data$tech_kid_par_brand___1.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___2.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___3.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___4.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___5.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___6.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___7.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___1.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___2.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___3.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___4.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___6.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___7.factor)=c("Unchecked","Checked")
levels(data$tech_kid_par_service.factor)=c("[eng2]Yes[esp2]Si","[eng2]No[esp2]No","[eng2] Unsure or Not Applicable[esp2]No estoy seguro o no aplicable")
levels(data$tech_kid_par_disconnected.factor)=c("[eng2]1-2 times/year[esp2]1-2 veces / a?questo","[eng2]3-4 times/year[esp2]3-4 veces / a?questo","[eng2]More than 5 times/year[esp2]M?quests de 5 veces / a?questo")
levels(data$tech_kid_par_app.factor)=c("[eng2]Yes[esp2]Si","[eng2]No[esp2]No")
levels(data$tech_parent_privileges.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi nunca","[eng2]Sometimes[esp2]A veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$tech_parent_uses.factor)=c("[eng2]Not Likely[esp2]No es probable","[eng2]Somewhat Likely[esp2]Un poco probable","[eng2]Very Likely[esp2]Muy Probable")
levels(data$tech_parent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$pedsqlparent_01.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_02.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_03.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_04.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_05.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_06.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_07.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_08.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_09.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_10.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_11.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_12.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_13.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_14.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_15.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_16.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_17.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_18.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_19.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_20.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_21.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_22.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsqlparent_23.factor)=c("[eng2]Never[esp2]Nunca","[eng2]Almost Never[esp2]Casi Nunca","[eng2]Sometimes[esp2]Algunas Veces","[eng2]Often[esp2]A menudo","[eng2]Almost Always[esp2]Casi Siempre")
levels(data$pedsql_parent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$act_nutri_parent01.factor)=c("[eng2]Yes[esp2]Si","No")
levels(data$act_nutri_parent02.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ","[eng2] 6 days[esp2]6 dias ","[eng2] 7 days[esp2]7 dias ")
levels(data$act_nutri_parent03.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ","[eng2] 6 days[esp2]6 dias ","[eng2] 7 days[esp2]7 dias ")
levels(data$act_nutri_parent04.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ","[eng2] 6 days[esp2]6 dias ","[eng2] 7 days[esp2]7 dias ")
levels(data$act_nutri_parent05.factor)=c("[eng2]o He/she does not play video or computer games or use a computer for something that is not schoolwork[esp2]&Eacute/ella no juega con videojuegos de computador ni utiliza su computador para cosas que no sean de trabajo escolar","[eng2]Less than 1 hour per day[esp2]Menos de 1 hora al d&iacutea","[eng2]1 hour per day[esp2]1 hora por d&iacutea ","[eng2]2 hours per day[esp2]2 horas por d&iacutea ","[eng2]3 hours per day[esp2]3 horas por d&iacutea ","[eng2]4 hours per day[esp2]4 horas por d&iacutea","[eng2]5 or more hours per day[esp2]5 o mas horas por d&iacutea")
levels(data$act_nutri_parent06.factor)=c("[eng2]o He/she does not watch DVDs or videos on an average school day[esp2]&Eacutel/ella no ve DVDs o v&iacutedeos en un d&iacutea escolar promedio","[eng2]Less than 1 hour per day[esp2]Menos de 1 hora al d&iacutea","[eng2]1 hour per day[esp2]1 hora por d&iacutea ","[eng2]2 hours per day[esp2]2 horas por d&iacutea ","[eng2]3 hours per day[esp2]3 horas por d&iacutea ","[eng2]4 hours per day[esp2]4 horas por d&iacutea","[eng2]5 or more hours per day[esp2]5 o mas horas por d&iacutea")
levels(data$act_nutri_parent07.factor)=c("[eng2] He/she does not watch television on an average school day[esp2]&Eacutel/ella no ve DVDs o v&iacutedeos en un d&iacutea escolar promedio","[eng2]Less than 1 hour per day[esp2]Menos de 1 hora al d&iacutea","[eng2]1 hour per day[esp2]1 hora por d&iacutea ","[eng2]2 hours per day[esp2]2 horas por d&iacutea ","[eng2]3 hours per day[esp2]3 horas por d&iacutea ","[eng2]4 hours per day[esp2]4 horas por d&iacutea","[eng2]5 or more hours per day[esp2]5 o mas horas por d&iacutea")
levels(data$act_nutri_parent08.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ")
levels(data$act_nutri_parent09.factor)=c("0","1","2","3","4","[eng2]5 or more[esp2]5 o m&aacutes")
levels(data$act_nutri_parent10.factor)=c("[eng2]Yes[esp2]Si","No")
levels(data$act_nutri_parent11.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ")
levels(data$act_nutri_parent12.factor)=c("[eng2]Never[esp2]Nunca","[eng2]1-2 times per week[esp2]1-2 veces por semana","[eng2]3-4 times per week[esp2]3-4 veces por semana","[eng2]5-6 times per week[esp2]5-6 veces por semana","[eng2]Daily[esp2]Diariamente")
levels(data$act_nutri_parent13.factor)=c("[eng2]Never[esp2]Nunca","[eng2]1-2 times per week[esp2]1-2 veces por semana","[eng2]3-4 times per week[esp2]3-4 veces por semana","[eng2]5-6 times per week[esp2]5-6 veces por semana","[eng2]Daily[esp2]Diariamente")
levels(data$act_nutri_parent14.factor)=c("[eng2]Never[esp2]Nunca","[eng2]1-2 times per week[esp2]1-2 veces por semana","[eng2]3-4 times per week[esp2]3-4 veces por semana","[eng2]5-6 times per week[esp2]5-6 veces por semana","[eng2]Daily[esp2]Diariamente")
levels(data$act_nutri_parent15.factor)=c("[eng2]Never[esp2]Nunca","[eng2]1-2 times per week[esp2]1-2 veces por semana","[eng2]3-4 times per week[esp2]3-4 veces por semana","[eng2]5-6 times per week[esp2]5-6 veces por semana","[eng2]Daily[esp2]Diariamente")
levels(data$act_nutri_parent16.factor)=c("[eng2] I did not eat fruit during the past 7 days[esp2]No comi&oacute fruta durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1-3 veces durante los &uacuteltimos 7 d&iacuteas","[eng2] 4 to 6 times during the past 7 days[esp2]4-6 veces durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 vez por d&iacutea","[eng2] 3 times per day[esp2]3 vez por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces por d&iacutea o mas")
levels(data$act_nutri_parent17.factor)=c("[eng2] I did not eat green salad during the past 7 days[esp2]No comi&oacute ensalda verde durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent18.factor)=c("[eng2] I did not eat potatoes during the past 7 days[esp2]No comi&oacute papitas fritas durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent19.factor)=c("[eng2] I did not eat carrots during the past 7 days[esp2]No comi&oacute zanahorias durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent20.factor)=c("[eng2] I did not eat other vegetables during the past 7 days[esp2]No comi&oacute vegetales durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent21.factor)=c("[eng2] I did not eat pizza during the past 7 days[esp2]No comi&oacute pizza durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent22.factor)=c("[eng2] I did not drink soda or pop during the past 7 days[esp2]No bebi&oacute refrescos o soda durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent23.factor)=c("[eng2] I did not drink diet soda or pop during the past 7 days[esp2]No bebi&oacute refrescos o soda de dieta durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent24.factor)=c("[eng2] I did not drink sugar-sweetened beverages  during the past 7 days[esp2]No beb&iacutea bebidas endulzadas con azucar durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent25.factor)=c("[eng2] I did not drink water during the past 7 days[esp2]No bebi&oacute agua durante los &uacuteltimos 7 d&iacuteas","[eng2] 1 to 3 times during the past 7 days[esp2]1 a 3 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 4 to 6 times during the past 7 days[esp2]4 a 6 veces durante los &uacuteltimos 7 d&iacuteas ","[eng2] 1 time per day[esp2]1 vez por d&iacutea","[eng2] 2 times per day[esp2]2 veces por d&iacutea","[eng2] 3 times per day[esp2]3 veces por d&iacutea","[eng2] 4 or more times per day[esp2]4 veces o mas por dia ")
levels(data$act_nutri_parent26.factor)=c("[eng2] None[esp2]Ninguna","[eng2] 1/2 cup or less[esp2]1/2 taza o menos","[eng2] 1/2 cup to 1 cup[esp2]1/2 taza a 1 taza","[eng2] 1 to 2 cups[esp2]1 a 2 tazas","[eng2] 2 to 3 cups[esp2]2 a 3 tazas","[eng2] 3 to 4 cups[esp2]3 a 4 tazas","[eng2] 4 or more cups[esp2]4 tazas o mas")
levels(data$act_nutri_parent27.factor)=c("[eng2] None[esp2]Ninguna","[eng2] 1/2 cup or less[esp2]1/2 taza o menos","[eng2] 1/2 cup to 1 cup[esp2]1/2 taza a 1 taza","[eng2] 1 to 2 cups[esp2]1 a 2 tazas","[eng2] 2 to 3 cups[esp2]2 a 3 tazas","[eng2] 3 to 4 cups[esp2]3 a 4 tazas","[eng2] 4 or more cups[esp2]4 o mas tazas")
levels(data$act_nutri_parent28.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ","[eng2] 6 days[esp2]6 dias ","[eng2] 7 days[esp2]7 dias ")
levels(data$act_nutri_parent29.factor)=c("[eng2]S/he does not eat dinner at home[esp2]No come la cena en casa","[eng2] Never[esp2]Nunca","[eng2] Rarely[esp2]Raramente","[eng2] Sometimes[esp2]A veces","[eng2] Most of the time[esp2]La mayor&iacutea del tiempo","[eng2] Always[esp2]Siempre")
levels(data$act_nutri_parent30.factor)=c("[eng2] 0 days[esp2]0 dias ","[eng2] 1 day[esp2]1 dia","[eng2] 2 days[esp2]2 dias ","[eng2] 3 days[esp2]3 dias ","[eng2] 4 days[esp2]4 dias ","[eng2] 5 days[esp2]5 dias ","[eng2] 6 days[esp2]6 dias ","[eng2] 7 days[esp2]7 dias ")
levels(data$act_nutri_parent31.factor)=c("[eng2] Never[esp2]Nunca","[eng2] Rarely[esp2]Raramente","[eng2] Sometimes[esp2]A veces","[eng2] Most of the time[esp2]La mayoria del tiempo","[eng2] Always[esp2]Siempre")
levels(data$physical_activity_nutrition_parent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$asthma_parent01___0.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___1.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___11.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___00.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___0000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___00000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent01___1111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent02.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent03.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent04.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent05.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent07.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent08.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent09.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent10___0.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___00.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___1.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___11.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___1111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___11111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent10___111111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___1.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___11.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___00.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___1111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___11111.factor)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000000000.factor)=c("Unchecked","Checked")
levels(data$asthma_parent12.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent13.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent14.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent15.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent16.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent17.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent18.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent19.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent20.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent22.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent24.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent25.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent26.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent27.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent28.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent29.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent30.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_parent31.factor)=c("[eng2] True[esp2]Verdadero","[eng2] False[esp2]Falso")
levels(data$asthma_knowledge_parent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$usherwood_01.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_02.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_03.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_04.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_05.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_06.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_07.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_08.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_09.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_10.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_11.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_12.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_13.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_14.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_15.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_16.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_17.factor)=c("[eng2]Not at all[esp2]Para nada","[eng2]A few days[esp2]Pocos d&iacuteas","[eng2]Some days[esp2]Algunos d&iacuteas","[eng2]Most days[esp2]La mayor&iacutea de los d&iacuteas","[eng2]Every day[esp2]Todos los d&iacuteas")
levels(data$usherwood_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$tablet_group.factor)=c("Yes","No")
levels(data$equipment_signout_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gift_receipt_complete.factor)=c("Incomplete","Unverified","Complete")
