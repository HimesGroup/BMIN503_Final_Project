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
label(data$esp)="Haz un click aquí si el paciente prefiere Español"
label(data$eng2)="Click here if the parent would prefer the questions in English"
label(data$esp2)="Haz un click aquí si el padre prefiere Español"
label(data$start_here_complete)="Complete?"
label(data$borinquen_info_release_timestamp)="Survey Timestamp"
label(data$today_date)="Todays Date:La Fecha de Hoy"
label(data$not_part_ethnicity)="What is your ethnic group or race?¿Cuál es tu grupo étnico o raza?"
label(data$not_part_asthma)="Does your child have asthma?¿Su hijo tiene asma?"
label(data$not_part_obese)="Is your child overweight/obese?¿Su niño tiene sobrepeso / es obeso?"
label(data$not_part_gender)="Is your child a girl or a boy?¿Es su hijo un niño o una niña?"
label(data$participating)="Are you interested in participating in this study? ¿Está interesado en participar en el estudio?"
label(data$first_date)="This consent is granted for:  A  Continuing disclosure  (expires 12 month form the date I sign this form) or upon termination of treatment, whichever occurs first.  Todays Date:Este consentimiento se otorga por: Divulgación continua (expira 12 meses de la fecha que firmo este formulario) o la terminación del tratamiento, lo que ocurra primero. Fecha de Hoy:"
label(data$borinquen_info_release_complete)="Complete?"
label(data$consent_timestamp)="Survey Timestamp"
label(data$parent_or_guardian___1)=" (choice=ParentPadre)"
label(data$parent_or_guardian___2)=" (choice=Individual legally authorized to consent to the childs general medical carePersona autorizada legalmente a dar su consentimiento a la atención médica del niño (ver nota más abajo))"
label(data$consent_complete)="Complete?"
label(data$assent_timestamp)="Survey Timestamp"
label(data$assent_complete)="Complete?"
label(data$consent_2_timestamp)="Survey Timestamp"
label(data$parent_or_guardian_v2___1)=" (choice=ParentPadre)"
label(data$parent_or_guardian_v2___2)=" (choice=Individual legally authorized to consent to the childs general medical carePersona autorizada legalmente a dar su consentimiento a la atención médica del niño (ver nota más abajo))"
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
label(data$dem_gender)="What is your gender?¿Cuál es tu género?"
label(data$dem_ethnicity)="What is your ethnic group or race?¿Cuál es tu grupo étnico o raza?"
label(data$dem_language_home)="What language is spoken at home?¿Qué idioma se habla en tu hogar?"
label(data$dem_language_pref)="What language do you prefer to speak?¿Qué idioma prefieres hablar?"
label(data$dem_grade)="What grade are you in this year?¿En qué grado estás en este año?"
label(data$demographics_patient_complete)="Complete?"
label(data$tech_patient_timestamp)="Survey Timestamp"
label(data$tech_kid_smart_device)="1. Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?1. ¿Tiene un smartphone (teléfono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_kid_brand___1)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=iPhone or iPadiPhone o iPad )"
label(data$tech_kid_brand___2)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_kid_brand___3)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_kid_brand___4)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_kid_brand___5)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_kid_brand___6)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_kid_brand___7)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_kid_os___1)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=iPhone or iPadiPhone o iPad)"
label(data$tech_kid_os___2)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_kid_os___3)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_kid_os___4)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_kid_os___5)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_kid_os___6)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_kid_phone_service)="4. Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid? 4. ¿ Ha sido desconectado (apagado) tu smartphone (teléfono inteligente) porque la factura mensual no haya sido pagado? "
label(data$tech_kid_disconnect)="How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?¿Cuántas veces al año han desconectado (apagado) su smartphone (teléfono inteligente) porque la factura mensual no se pago? "
label(data$tech_kid_apps)="5. Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)? 5. ¿Utiliza alguna aplicación app) o sitios web en su smartphone (teléfono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentaci??"
label(data$tech_kid_function___1)="6. What do the health apps or websites help you do?6. ¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of your exerciseMantener un seguimiento de tu ejercicio)"
label(data$tech_kid_function___2)="6. What do the health apps or websites help you do?6. ¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of what you eatMantener un seguimiento de lo que come)"
label(data$tech_kid_function___3)="6. What do the health apps or websites help you do?6. ¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of your weightMantener un seguimiento de tu peso)"
label(data$tech_kid_function___4)="6. What do the health apps or websites help you do?6. ¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Look up information about exerciseBuscar información obre el ejercicio)"
label(data$tech_kid_function___5)="6. What do the health apps or websites help you do?6. ¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Look up information about healthy eatingBuscar información obre la alimentación saludable)"
label(data$tech_kid_privileges)="8. How often do you lose your technology privileges (e.g., have your smart phone or tablet taken away as punishment)?8. ¿Con qué frecuencia pierdes los privilegios de la tecnología?(por ejemplo, te quitan tu Smartphone (teléfono inteligente) o tableta como castigo)?"
label(data$tech_kid_device_time)="9. How much time do you usually spend in total on your smart phone or tablet each day?9. ¿Normalmente cuánto tiempo pasas en total en tu Smartphone (teléfono inteligente) o tableta cada día?"
label(data$tech_kid_given_device)="10. If you were provided a tablet, would you use the tablet to help you be healthier?10. Si le dieran una tableta, la usaría? para ayudarte a ser más saludable?"
label(data$tech_patient_complete)="Complete?"
label(data$pedsql_patient_timestamp)="Survey Timestamp"
label(data$pedsqlkids_01)="1. It is hard for me to walk more than one blockSe me hace difícil caminar más de una cuadra"
label(data$pedsqlkids_02)="2. It is hard for me to runSe me hace difícil correr"
label(data$pedsqlkids_03)="3. It is hard for me to do sports activity or exerciseSe me hace difícil practicar deportes o ejercicios"
label(data$pedsqlkids_04)="4. It is hard for me to lift something heavySe me hace difícil levantar algo pesado"
label(data$pedsqlkids_05)="5. It is hard for me to take a bath or shower by myselfSe me hace difícil banarme solo en tina o regadera"
label(data$pedsqlkids_06)="6. It is hard for me to do chores around the houseSe me hace difícil hacer quehaceres en la casa"
label(data$pedsqlkids_07)="7. I hurt or acheSiento dolores o molestias"
label(data$pedsqlkids_08)="8. I have low energyTengo poca energía"
label(data$pedsqlkids_09)="9. I feel afraid or scaredMe siento asustado o con miedo"
label(data$pedsqlkids_10)="10. I feel sad or blueMe siento triste o decaído"
label(data$pedsqlkids_11)="11. I feel angryMe siento enojado"
label(data$pedsqlkids_12)="12. I have trouble sleepingTengo dificultades para dormir"
label(data$pedsqlkids_13)="13. I worry about what will happen to meMe preocupo por lo que me vaya a pasar"
label(data$pedsqlkids_14)="14. I have trouble getting along with other kidsTengo problemas llevándome bien con otros niños"
label(data$pedsqlkids_15)="15. Other kids do not want to be my friendOtros niños no quieren ser mis amigos"
label(data$pedsqlkids_16)="16. Other kids tease meOtros niños se burlan de mí"
label(data$pedsqlkids_17)="17. I cannot do things that other kids my age can doNo puedo hacer cosas que otros niños de mi edad pueden hacer"
label(data$pedsqlkids_18)="18. It is hard to keep up when I play with other kidsSe me hace difícil mantenerme al igual que otros niños cuando juego con ellos"
label(data$pedsqlkids_19)="19. It is hard to pay attention in classSe me hace difícil poner atención clase"
label(data$pedsqlkids_20)="20. I forget thingsSe me olvidan las cosas"
label(data$pedsqlkids_21)="21. I have trouble keeping up with my schoolworkTengo problemas manteniendome al dia con mi trabajo escolar"
label(data$pedsqlkids_22)="22. I miss school because of not feeling wellFalto a la escuela porque no me siento bien"
label(data$pedsqlkids_23)="23. I miss school to go to the doctor or hospitalFalto a la escuela para ir al doctor o al hospital"
label(data$pedsql_patient_complete)="Complete?"
label(data$physical_activity_nutrition_patient_timestamp)="Survey Timestamp"
label(data$act_nutri_kids01)="1. During the past 7 days, on how many days were you physically active for a total of at least 60 minutes per day?  (Add up all the time you spent in any kind of physical activity that increased your heart rate and made you breathe hard some of the time.)Durante los últimos 7 días, ¿Cuántos días estuviste físicamente activo por un total de por lo menos 60 minutos al día?  (Suma todo el tiempo que pasó en cualquier tipo de actividad física que aumento tu ritmo cardíaco y te hizo respirar fuerte parte del tiempo.)"
label(data$act_nutri_kids02)="2. On how many of the past 7 days did you exercise or participate in physical activity for at least 20 minutes that made you sweat and breathe hard, such as basketball, soccer, running, swimming laps, fast bicycling, fast dancing, or similar aerobic activities?¿En cuántos de los últimos 7 días ha hecho ejercicio o participado en actividad física por lo menos 20 minutos que te hizo sudar y respirar rapidamente, como el baloncesto, el fútbol, correr, natación, bicicleta rápida, baile movido o una actividad aeróbica similar ?"
label(data$act_nutri_kids03)="3. On how many of the past 7 days did you do exercises to strengthen or tone your muscles, such as push-ups, sit-ups, or weight lifting?¿En cuántos de los últimos 7 días hiciste ejercicios para fortalecer o tonificar tus músculos, como flexiones, abdominales o levantar pesas?"
label(data$act_nutri_kids04)="4. On an average school day, how many hours do you play video or computer games or use a computer for something that is not school work? (Include activities such as Nintendo, Game Boy, PlayStation, Xbox, computer games, and the Internet.)En un día escolar regular, ¿cuántas horas juegas a juegos de vídeo o juegos de computadora o utilizas una computadora para algo que no sea trabajo de la escuela? (Incluye actividades como Nintendo, Game Boy, PlayStation, Xbox, juegos de computadora y de Internet.)"
label(data$act_nutri_kids05)="5. On an average school day, how many hours do you spend watching DVDs or videos? Include DVDs or videos you watch on a TV, computer, iPod, or other portable device.En un día escolar regular, ¿cuántas horas pasas viendo DVDs o videos? Incluya DVDs o vídeos que se pueden ver en un televisor, computadora, iPod o cualquier otro aparato portátil."
label(data$act_nutri_kids06)="6. On an average school day, how many hours do you watch TV?En un día escolar regular, ¿cuántas horas ves la televisión?"
label(data$act_nutri_kids07)="7. Encourage you to do physical activities or play sports?Te anima a hacer actividades fisicas o jugar deportes?"
label(data$act_nutri_kids08)="8. Do a physical activity or play sports with you?Hacer una actividad física o practicar deportes contigo?"
label(data$act_nutri_kids09)="9. Provide transportation to a place where you can do physical activities or play sports?Provee transporte a un lugar donde se pueden hacer actividades físicas o jugar deportes?"
label(data$act_nutri_kids10)="10. Watch you participate in physical activities or play sports?Mirarte participar en actividades físicas o jugar deportes?"
label(data$act_nutri_kids11)="11. During the past 7 days, how many times did you eat fruit? (Do not count fruit juice.)Durante los últimos 7 días, ¿cuántas veces comiste fruta? (No se cuenta el jugo de fruta.)"
label(data$act_nutri_kids12)="12. During the past 7 days, how many times did you eat green salad?Durante los últimos 7 días, ¿cuántas veces comiste ensalada verde? "
label(data$act_nutri_kids13)="13. During the past 7 days, how many times did you eat French fries or other fried potatoes, such as home fries, hash browns or tater tots? (Do not count potato chips.)Durante los últimos 7 días, ¿cuántas veces comiste papitas fritas u otro tipo de papa frita, como patatas fritas, croquetas de patata o tater (tater tots)? (No cuentes papitas fritas en bolsa/potato chips.)"
label(data$act_nutri_kids14)="14. During the past 7 days, how many times did you eat carrots?Durante los últimos 7 días, ¿cuántas veces comiste zanahorias?"
label(data$act_nutri_kids15)="15. During the past 7 days, how many times did you eat other vegetables? (Do not count green salad, potatoes, or carrots.)Durante los últimos 7 días, ¿cuántas veces comiste otros vegetales? (No cuentes ensalada verde, papas o zanahorias.)"
label(data$act_nutri_kids16)="16. During the past 7 days, how many times did you eat pizza?Durante los ultimos 7 dias, cuantas veces comiste pizza?"
label(data$act_nutri_kids17)="17. During the past 7 days, how many times did you drink 100% fruit juices such as orange juice, apple juice, or grape juice? (Do not count punch, Kool-Aid, sports drinks, or other fruit-flavored drinks.)Durante los últimos 7 días, ¿cuántas veces has bebido 100% jugos de fruta como jugo de naranja, jugo de manzana o jugo de uva? (No se cuenta el ponche, Kool-Aid, bebidas deportivas u otras bebidas con sabor a fruta.)"
label(data$act_nutri_kids18)="18. During the past 7 days, how many times did you drink a can, bottle, or glass of soda, such as Coke, Pepsi, or Sprite? (Do not count diet soda)Durante los últimos 7 días, ¿cuántas veces usted bebio una lata, botella o vaso de refresco o soda, como Coca-Cola, Pepsi, o Sprite? (No cuentes refresco de dieta o soda de dieta.)"
label(data$act_nutri_kids19)="19. During the past 7 days, how many times did you drink a can, bottle, or glass of a sugar-sweetened beverage such as lemonade, sweetened tea or coffee drinks, flavored milk, Snapple, or Sunny Delight? (Do not count soda or pop, sports drinks, energy drinks, or 100% fruit juice.)Durante los últimos 7 días, ¿cuántas veces has bebido una lata, botella o vaso de una bebida endulzada con azúcar como limonada, té o café endulzado, leche con sabor, Snapple, o Sunny Delight? (No cuentes refresco o soda, bebidas para deportistas, bebidas energéticas o jugo 100% de fruta.)"
label(data$act_nutri_kids20)="20. During the past 7 days, how many times did you drink a bottle or glass of plain water? Count tap, bottled, and unflavored sparkling water.Durante los últimos 7 días, ¿cuántas veces has bebido una botella o vaso de agua? Cuente agua de grifo, embotellada, con gas y sin sabor."
label(data$act_nutri_kids21)="21. About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) do you eat or drink each day?Acerca de cuántas tazas de frutas (incluyendo fruta congelada, enlatada, y seca y 100% jugo de fruta) comes o bebes cada día?"
label(data$act_nutri_kids22)="22. About how many cups of vegetables (including frozen and canned vegetables and 100% vegetable juice) do you eat or drink each day?Acerca de cuántas tazas de vegetales (incluyendo vegetales congelados, enlatados, y secos y 100% jugo de vegetales) come o bebe cada día?"
label(data$act_nutri_kids23)="23. During the past 7 days, on how many days did you eat breakfast or a morning meal?Durante los últimos 7 días, ¿cuántos días comiste el desayuno o una comida de la mañana?"
label(data$act_nutri_kids24)="24. During the past 7 days, on how many days did you eat dinner at home with at least one of your parents or guardians?Durante los últimos 7 días, ¿cuántos días comio la cena en casa con al menos uno de sus padres o guardianes?"
label(data$act_nutri_kids25)="25. During the past 7 days, on how many days did you eat at least one meal or snack from a fast food restaurant such as McDonalds, Taco Bell, or KFC?Durante los últimos 7 días, ¿cuántos días comio al menos una comida o un bocadillo en un restaurante de comida rápida como McDonalds, Taco Bell, o KFC?"
label(data$act_nutri_kids26)="26. How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?¿Con qué frecuencia hay frutas o verduras para picar en su casa, como las zanahorias, el apio, manzanas, plátanos, melón?"
label(data$act_nutri_kids27)="27. How often are there foods such as chips, cookies, or cakes to snack on in your home?¿Con qué frecuencia hay alimentos como las papas fritas, galletas o pasteles para picar en su casa?"
label(data$physical_activity_nutrition_patient_complete)="Complete?"
label(data$weight_patient_timestamp)="Survey Timestamp"
label(data$weight_01)="1. I think I am pretty good at managing my weight.Creo que soy bastante bueno en el manejo de mi peso."
label(data$weight_02)="2. Compared to other kids, I think I do pretty well when it comes to managing my weight.En comparación otros niños, cuando se trata del manejo de mi peso creo que lo hago bastante bien."
label(data$weight_03)="3. I am satisfied with my ability to manage my weight.Estoy satisfecho con mi capacidad para manejar mi peso."
label(data$weight_04)="4. I am pretty skilled at managing my weight.Estoy bastante hábil en el manejo de mi peso."
label(data$weight_05)="5. Managing my diet is something that I cant do well.Manejar mi dieta es algo que no puedo hacer bien."
label(data$weight_06)="6. I put a lot of effort into managing my weight.Pongo mucho esfuerzo en manejar mi peso."
label(data$weight_07)="7. I try very hard to manage my weight by having healthy eating habits.Hago un gran esfuerzo para controlar mi peso por medio de tener hábitos alimenticios saludables."
label(data$weight_08)="8. I try very hard to manage my weight by being physically activity.Hago un gran esfuerzo para controlar mi peso por medio de hacer actividad física."
label(data$weight_09)="9. It is important for me to do well at managing my weight.Para mí es importante que me vaya bien en manejar mi peso."
label(data$weight_10)="10. Overall, having a healthy diet is very important to me, a priority in my life.En general, tener una dieta saludable es muy importante para mí, y es una prioridad en mi vida."
label(data$weight_11)="11. Overall, I feel confident in being able to manage my diet so that my weight will be healthy.En general, me siento seguro en ser capaz de manejar mi dieta para que mi peso sea saludable."
label(data$weight_12)="12. Overall, I feel confident in being physically active so that my weight will be healthy.En general, me siento seguro en mi habilidad de estar físicamente activo para que mi peso sea saludable."
label(data$weight_13)="13. Overall, doing physical activity is very important to me, a priority in my life.En general, hacer actividad física es muy importante para mí es una prioridad en mi vida."
label(data$weight_14)="14. I put a lot of effort into managing my diet and eating right.Pongo mucho esfuerzo en manejar mi dieta y en comer bien."
label(data$weight_15)="15. I put a lot of effort into not being inactive and being more physically active.Pongo mucho esfuerzo en no ser inactivo y en ser más activo físicamente. "
label(data$weight_16)="16. Compared to other kids, I think I do pretty well when it comes to being physically active.En comparación otros niños, creo que lo hago bastante bien cuando se trata de ser físicamente activo."
label(data$has_asthma)="1. Does [first_name] [last_name] have asthma?¿Tiene[first_name] [last_name] asthma?"
label(data$weight_patient_complete)="Complete?"
label(data$asthma_knowledge_patient_timestamp)="Survey Timestamp"
label(data$asthma01___0)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= sneezingestornudos)"
label(data$asthma01___1)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= shortness of breathfalta de aire)"
label(data$asthma01___11)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= coughingtos)"
label(data$asthma01___00)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= skin rasherupción cutanea)"
label(data$asthma01___000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= feverfiebre)"
label(data$asthma01___111)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= wheezingsibilancias)"
label(data$asthma01___0000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= nausea/vomitingnáuseas/vómitos)"
label(data$asthma01___00000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= runny nosenariz que moquea)"
label(data$asthma01___000000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= headachedolor de cabeza)"
label(data$asthma01___1111)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= chest tightnessopresión en el pecho)"
label(data$asthma02)="2.  More than 1 in 10 children will have asthma at some time during their childhood.2. 1 de cada 10 niños tendrán asma en algún momento durante su infancia."
label(data$asthma03)="3. Children with asthma have overly sensitive air passages in their lungs.3. Los niños con asma tienen las vías aéreas pulmonares anormalmente sensibles. "
label(data$asthma04)="4. If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma.4. Si un niño en una familia tiene asma, entonces casi seguro que todos sus hermanos y hermanas la padecerán también."
label(data$asthma05)=" 5. Most children with asthma have an increase in mucus when they drink cows milk.5. La mayoría de los niños con asma sufren un aumento de mucosidad cuando beben leche de vaca."
label(data$asthma07)="7. Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs.7. Durante un ataque de asma los pitos pueden deberse a la contracción muscular de la pared de las vías aéreas pulmonares."
label(data$asthma08)="8. Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs.8. Durante un ataque de asma, los pitos pueden deberse a la inflamación del revestimiento de las vías aéreas pulmonares."
label(data$asthma09)=" 9. Asthma damages the heart.9. El asma daña el corazón. "
label(data$asthma10___0)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Albuterol)"
label(data$asthma10___00)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Ventolin)"
label(data$asthma10___1)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Pulmicort)"
label(data$asthma10___000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Decadron)"
label(data$asthma10___0000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Abilify)"
label(data$asthma10___11)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Montelukast)"
label(data$asthma10___00000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Lexapro)"
label(data$asthma10___000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Benadryl)"
label(data$asthma10___0000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Claritin)"
label(data$asthma10___00000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Amoxicillin)"
label(data$asthma10___111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Singulair)"
label(data$asthma10___000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Zoloft)"
label(data$asthma10___1111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Budesonide)"
label(data$asthma10___0000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Effexor)"
label(data$asthma10___00000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Atrovent)"
label(data$asthma10___11111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Flovent)"
label(data$asthma10___000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Metformin)"
label(data$asthma10___0000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Zithromax)"
label(data$asthma10___000000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Zyrtec)"
label(data$asthma10___0000000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Prednisone)"
label(data$asthma10___111111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para EVITAR que se produzcan ataques de asma: (choice=Qvar)"
label(data$asthma11___1)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Albuterol)"
label(data$asthma11___11)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Ventolin)"
label(data$asthma11___0)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Pulmicort)"
label(data$asthma11___111)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Decadron)"
label(data$asthma11___00)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Abilify)"
label(data$asthma11___000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Montelukast)"
label(data$asthma11___0000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Lexapro)"
label(data$asthma11___00000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Benadryl)"
label(data$asthma11___000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Claritin)"
label(data$asthma11___0000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Amoxicillin)"
label(data$asthma11___00000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Singulair)"
label(data$asthma11___000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Zoloft)"
label(data$asthma11___0000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Budesonide)"
label(data$asthma11___00000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Effexor)"
label(data$asthma11___1111)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Atrovent)"
label(data$asthma11___000000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Flovent)"
label(data$asthma11___0000000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Metformin)"
label(data$asthma11___00000000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Zithromax)"
label(data$asthma11___000000000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Zyrtec)"
label(data$asthma11___11111)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Prednisone)"
label(data$asthma11___0000000000000000)="11. What are the three asthma treatments (medicines) that are useful DURING an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles DURANTE un ataque de asma? (choice=Qvar)"
label(data$asthma12)="12. Antibiotics are an important part of treatment for most children with asthma. 12. Los antibióticos son una parte importante del tratamiento para la mayoría de los niños con asma."
label(data$asthma13)="13. Most children with asthma should not eat dairy products.13. La mayoría de los niños con asma no deberían consumir productos lácteos."
label(data$asthma14)=" 14.Allergy injections cure asthma.14. Las vacunas para la alergia curan el asma. "
label(data$asthma15)="15. If a child dies from an asthma attack, this usually means that there was no time to start any treatment. 15. Si una persona muere de un ataque de asma, esto normalmente quiere decir que el ataque final debió de haber comenzado tan rápidamente que no hubo tiempo para empezar ningún tratamiento."
label(data$asthma16)="16. Children with asthma usually have emotional problems.16. Las personas con asma normalmente tienen problemas de nervios."
label(data$asthma17)="17. You can catch asthma from another person.17. El asma es infeccioso (es decir, te lo puede contagiar otra persona). "
label(data$asthma18)="18. Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets.18. Los medicamentos inhalados para el asma (por ejemplo, el inhalador Ventolín, Terbasmin) tienen menos efectos secundarios que las pastillas/jarabes."
label(data$asthma19)="19. Short courses of oral steroids (such as prednisone) usually cause significant side effects. 19. Los ciclos cortos de corticoides orales (como Estilsona, Dacortin, Prednisona) habitualmente causan efectos secundarios importantes."
label(data$asthma20)="20. Some asthma treatments (such as Ventolin) damage the heart.20. Algunos tratamientos para el asma (como el Ventolín) dañan el corazón."
label(data$asthma22)="22. During an attack of asthma at home, you need your  nebulizer (mask) every 2 hours. You gain benefit but are very out of breath after 2 hours. Provided that you dont get any worse, its fine to continue with 2-hourly treatments.22. Durante un ataque de asma que están tratando en casa tu necesitas el inhalador con cámara (o mascarilla) cada 2 horas. Estás mejorando pero después de 2 horas respiras con dificultad. Teniendo en cuenta que tu no empeoras, es correcto continuar con el tratamiento cada 2 horas."
label(data$asthma24)="24. Children with asthma become addicted to their asthma drugs. 24. Los niños con asma se hacen adictos a sus medicinas para el asma. "
label(data$asthma25)="25. Swimming is the only good exercise for children with asthma.25. La natación es el único deporte adecuado para los asmáticos."
label(data$asthma26)="26. A parents smoking in the home may make the childs asthma worse.26. El hecho de que los padres fumen puede empeorar el asma de su hijo/a."
label(data$asthma27)="27. With the right treatment most children with asthma live a normal life with no restriction on activity. 27. Con el tratamiento adecuado, la mayoría de los niños con asma deberían llevar una vida normal sin restricciones en sus actividades."
label(data$asthma28)="28. The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest. 28. La mejor manera de medir la gravedad del asma de un niño es que el médico le escuche el pecho."
label(data$asthma29)="29. Asthma symptoms usually occur more frequently at night than during the day.29. El asma es normalmente más problemática durante la noche que durante el día. "
label(data$asthma30)="30. Most children with asthma will have stunted growth.30. La mayoría de los niños con asma padecen un enlentecimiento de su crecimiento."
label(data$asthma31)="31. Children who frequently have asthma symptoms should have preventative drugs.31. Los niños con síntomas frecuentes de asma deberían tomar medicinas preventivas."
label(data$asthma_knowledge_patient_complete)="Complete?"
label(data$demographics_parent_timestamp)="Survey Timestamp"
label(data$dem_parent_sex)="What is your gender?¿Cuál es su género?"
label(data$dem_parent_ethnicity)="What is your ethnic group or race?¿Cuál es su grupo étnico o raza?"
label(data$dem_parent_language_pref)="What language do you prefer to speak?¿ Qué idioma se habla en su hogar?"
label(data$dem_parent_school)="What is the highest grade or level of education you have completed?¿Cuál es el grado o nivel de educación que usted ha completado?"
label(data$dem_parent_nationality)="What is your country of origin/birth?¿Cuál es su  país de origen / nacimiento?"
label(data$dem_parent_us)="How long have you lived in the United States?¿Cuánto tiempo ha vivido en los Estados Unidos?"
label(data$dem_kid_nationality)="What is your childs country of origin/birth?¿Cuál es el país de origen / nacimiento de su hijo?"
label(data$dem_kid_us)="If not born in the United States, how long has your child been in the United States?Si no nació en los Estados Unidos, ¿cuánto tiempo ha estado su hijo en los Estados Unidos?"
label(data$dem_parent_job)="What is your current employment status?¿Cuál es su situación laboral actual?"
label(data$dem_parent_income)="What is your household yearly income (before taxes)?¿Cuál es su ingreso familiar anual (antes de impuestos)?"
label(data$dem_parent_marital)="What is your marital status?Cuál es tu estado civil?"
label(data$dem_parent_habitants)="How many people live in the primary house of the youth (including the youth)?¿Cuántas personas viven en la casa principal de su hijo (incluyendo su hijo)?"
label(data$dem_kid_pmhx___1)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=AsthmaAsma)"
label(data$dem_kid_pmhx___2)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=Sleep ApneaApnea del sueño)"
label(data$dem_kid_pmhx___3)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=AnxietyAnsiedad)"
label(data$dem_kid_pmhx___4)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=CancerCáncer)"
label(data$dem_kid_pmhx___5)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=Learning DisorderProblemas de aprendizaje)"
label(data$dem_kid_pmhx___6)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=DepressionDepresión)"
label(data$dem_kid_pmhx___7)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=Heart DiseaseEnfermedad Del Corazón)"
label(data$dem_kid_pmhx___8)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=ADHD/ADDADHD/ADD)"
label(data$dem_kid_pmhx___9)="Does your child have a history of any medical or mental health conditions? (check all that apply)¿Tiene su hijo un historial de algunas condiciones médicas o de salud mental? (marque todo lo que corresponda) (choice=OtherOtro)"
label(data$dem_kid_famhx___1)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=AsthmaAsma)"
label(data$dem_kid_famhx___2)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=Sleep ApneaApnea del sueño)"
label(data$dem_kid_famhx___3)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=AnxietyAnsiedad)"
label(data$dem_kid_famhx___4)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=CancerCáncer)"
label(data$dem_kid_famhx___5)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=Learning DisorderProblemas de aprendizaje)"
label(data$dem_kid_famhx___6)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=DepressionDepresión)"
label(data$dem_kid_famhx___7)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=Heart DiseaseEnfermedad Del Corazón)"
label(data$dem_kid_famhx___8)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=ADHD/ADDADHD/ADD)"
label(data$dem_kid_famhx___9)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)¿Hay alguien en la familia del joven que tenga un historial de problemas de salud mental o médico? (marque todo lo que corresponda) (choice=OtherOtro)"
label(data$demographics_parent_complete)="Complete?"
label(data$tech_parent_timestamp)="Survey Timestamp"
label(data$tech_parent_device)="1. Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?1. ¿Tiene un smartphone (teléfono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_parent_brand___1)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=iPhone or iPadiPhone o iPad )"
label(data$tech_parent_brand___2)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_parent_brand___3)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_parent_brand___4)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_parent_brand___5)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_parent_brand___6)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_parent_brand___7)="2. What brand of smart phone or tablet do you have? (Select all that apply)2. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_parent_os___1)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=iPhone or iPad)"
label(data$tech_parent_os___2)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_parent_os___3)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_parent_os___4)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_parent_os___6)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_parent_os___7)="3. What type of smart phone or tablet do you have? (Select all that apply)3. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_parent_phone_service)="4. Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid? 4. ¿ Ha sido desconectado (apagado) tu smartphone (teléfono inteligente) porque la factura mensual no se haya sido pagado? "
label(data$tech_parent_disconnect)="How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?¿Cuántas veces al año han desconectado (apagado) su smartphone (teléfono inteligente) porque la factura mensual no se pago? "
label(data$tech_parent_apps)="5. Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)? 5. ¿Utiliza alguna aplicación (app) o sitios web en su smartphone (teléfono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentación"
label(data$tech_parent_function___1)="6. What do the health apps or websites help you do?¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of your exerciseMantener un seguimiento de tu ejercicio)"
label(data$tech_parent_function___2)="6. What do the health apps or websites help you do?¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of what you eatMantener un seguimiento de lo que come)"
label(data$tech_parent_function___3)="6. What do the health apps or websites help you do?¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Keep track of your weightMantener un seguimiento de tu peso)"
label(data$tech_parent_function___4)="6. What do the health apps or websites help you do?¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Look up information about exerciseBuscar información sobre el ejercicio)"
label(data$tech_parent_function___5)="6. What do the health apps or websites help you do?¿Con que le ayudan las aplicaciones de salud o sitios web a hacer? (choice=Look up information about healthy eatingBuscar información sobre la alimentación saludable)"
label(data$tech_parent_info___1)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=Friends or FamilyAmigos o familiares)"
label(data$tech_parent_info___2)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice= Doctor or other health professionalMédico u otro profesional de la salud)"
label(data$tech_parent_info___3)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice= Health app or websiteAplicaciones de salud o sitios web)"
label(data$tech_parent_info___4)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=General or personal website (e.g., blog, Pinterest, social media such as Facebook or Twitter)Sitio web general o personal (por ejemplo, blog, Pinterest, redes sociales como Facebook o Twitter))"
label(data$tech_parent_info___5)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=Health-related printed material (e.g., book, health magazine)Material impreso relacionado con la salud (libro electrónico, revista de salud))"
label(data$tech_parent_info___6)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=General printed material (e.g., magazine, newspaper)Material impreso general (por ejemplo, revistas, periódicos))"
label(data$tech_parent_info___7)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice= Television (news, afternoon program, talk show)Televisión (noticias, programa de la tarde, programa de entrevistas))"
label(data$tech_parent_info___8)="8. Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?8. ¿ De dónde usted recibe informació sobre la salud (por ejemplo, comida/dieta, ejercicio, enfermedades/trastornos / condiciones)? (choice=Television (health program)Televisión (programa de salud))"
label(data$tech_kid_par_device)="9. Does your youth have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?9. ¿Tiene su hijo un smartphone (teléfono inteligente) o tableta (e.g., iPhone/iPad, Samsung Galaxy)?"
label(data$tech_kid_par_brand___1)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=iPhone or iPadiPhone o iPad )"
label(data$tech_kid_par_brand___2)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Samsung)"
label(data$tech_kid_par_brand___3)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=LG)"
label(data$tech_kid_par_brand___4)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=HTC)"
label(data$tech_kid_par_brand___5)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Motorola)"
label(data$tech_kid_par_brand___6)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_kid_par_brand___7)="10. What brand of smart phone or tablet does your youth have? (Select all that apply)10. ¿Qué marca de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_kid_par_os___1)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=iPhone or iPad)"
label(data$tech_kid_par_os___2)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Android/Google)"
label(data$tech_kid_par_os___3)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Windows)"
label(data$tech_kid_par_os___4)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=Blackberry)"
label(data$tech_kid_par_os___6)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=OtherOtro)"
label(data$tech_kid_par_os___7)="11. What type of smart phone or tablet does your youth have? (Select all that apply)11. ¿Qué tipo de smartphone (teléfono inteligente) o tableta tiene su hijo? (Seleccione todas las que apliquen)  (choice=UnsureNo estoy serguro)"
label(data$tech_kid_par_service)="12. Does your youths smart phone ever get disconnected (turned off) because the monthly bill has not been paid? 12. ¿ Ha sido desconectado (apagado) el smartphone (teléfono inteligente) de su hijo(a) porque la factura mensual no se haya sido pagado? "
label(data$tech_kid_par_disconnected)="How many times per year does your youths smart phone get disconnected (turned off) because the monthly bill has not been paid?¿Cuántas veces al año han desconectado (apagado) el smartphone (teléfono inteligente) de su hijo(a) porque la factura mensual no se pago? "
label(data$tech_kid_par_app)="13. Does your youth use any applications (app) or websites on your smart phone or tablet to help him/her with health (e.g., exercise, eating)? 13. ¿Utiliza su hijo(a) alguna aplicación (app) o sitios web en su smartphone (teléfono inteligente) o tableta para ayudarle con tu salud (por ejemplo, el ejercicio, la alimentación"
label(data$tech_parent_privileges)="15. How often does your youth lose their technology privileges (e.g., have their smart phone or tablet taken away as punishment)?15. ¿Con qué frecuencia su hijo(a) pierde sus privilegios de la tecnolog?(por ejemplo, su Smartphone (teléfono inteligente) o tableta quitado como castigo)?"
label(data$tech_parent_uses)="16. If your youth was provided with a tablet, would they use the tablet to help them be healthier? 16. Si le dieran una tableta a su hijo, la usaría para para mejorar la saludable?"
label(data$tech_parent_complete)="Complete?"
label(data$pedsql_parent_timestamp)="Survey Timestamp"
label(data$pedsqlparent_01)="1.Walking more than one blockCaminando más de una cuadra"
label(data$pedsqlparent_02)="2.RunningCorriendo"
label(data$pedsqlparent_03)="3.Participating in sports activity or exerciseParticipando en actividades deportivas o ejercicios"
label(data$pedsqlparent_04)="4.Lifting something heavyLevantando algo pesado"
label(data$pedsqlparent_05)="5.Taking a bath or shower by him or herselfTomando una ducha o tina por sí mismo(a)"
label(data$pedsqlparent_06)="6.Doing chores around the houseHaciendo quehaceres en la casa"
label(data$pedsqlparent_07)="7.Having hurts or achesTeniendo dolores o molestias"
label(data$pedsqlparent_08)="8.Low energy levelPoca energía"
label(data$pedsqlparent_09)="9.Feeling afraid or scaredSintiéndose asustado o con miedo"
label(data$pedsqlparent_10)="10.Feeling sad or blueSintiéndose triste o decaído"
label(data$pedsqlparent_11)="11.Feeling angrySintiéndose enojado"
label(data$pedsqlparent_12)="12.Trouble sleepingDificultades para dormir"
label(data$pedsqlparent_13)="13.Worrying about what will happen to him or herPreocupándose por lo que le vaya a pasar"
label(data$pedsqlparent_14)="14.Getting along with other kidsLlevándose bien con otros niños"
label(data$pedsqlparent_15)="15. Other kids not wanting to be his or her friendOtros niños no queriendo ser amigos de él o élla"
label(data$pedsqlparent_16)="16.Getting teased by other teensOtros niños burlándose de él o élla"
label(data$pedsqlparent_17)="17.Not able to do things that other kids his or her age can doNo pudiendo hacer cosas que otros niños de su edad pueden hacer"
label(data$pedsqlparent_18)="18.Keeping up with other kidsPudiendo mantenerse al igual con otros niños cuando juega"
label(data$pedsqlparent_19)="19.Paying attention in classPoniendo atención en clase"
label(data$pedsqlparent_20)="20.Forgetting thingsOlvidando cosas"
label(data$pedsqlparent_21)="21.Keeping up with schoolworkManteniéndose al día con actividades escolares"
label(data$pedsqlparent_22)="22.Missing school because of not feeling wellFaltando a la escuela porque no se siente bien"
label(data$pedsqlparent_23)="23.Missing school to go to the doctor or hospitalFaltando a la escuela para ir al doctor o al hospital"
label(data$pedsql_parent_complete)="Complete?"
label(data$physical_activity_nutrition_parent_timestamp)="Survey Timestamp"
label(data$act_nutri_parent01)="1. Yesterday, was your child physically active for a total of at least 60 minutes? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)1. Su hijo/a fue físicamente activo por un total de al menos 60 minutos ayer? (Suma todo el tiempo que haya pasado en cualquier tipo de actividad física que aumentado su ritmo cardíaco y lo haya respirar con fuerza una parte del tiempo."
label(data$act_nutri_parent02)="2. During the past 7 days, on how many days was your child physically active for a total of at least 60 minutes per day? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)Durante los últimos 7 días, ¿Cuántos días fue su hijo/a físicamente activo por un total de por lo menos 60 minutos al día?  (Suma todo el tiempo que haya pasado en cualquier tipo de actividad física que haya aumentado su ritmo cardíaco y que lo haya hecho respirar con fuerza una parte del tiempo.)"
label(data$act_nutri_parent03)="3. On how many of the past 7 days did your child exercise or participate in physical activity for at least 20 minutes that made him/her sweat and breathe hard, such as basketball, soccer, running, swimming laps, fast bicycling, fast dancing, or similar aerobic activities?¿En los últimos 7 días, cuántos días hizo su niño/a o participó en actividad física por al menos 20 minutos en el que hizo que é/ella sudara y respirara agitadamente, como el baloncesto, el fútbol, correr, natación, bicicleta rápida, baile movido o una actividad aeróbica similar ?"
label(data$act_nutri_parent04)="4. On how many of the past 7 days did your child do exercises to strengthen or tone their muscles, such as push-ups, sit-ups, or weight lifting?4. ¿En cuántos de los últimos 7 días hizo su hijo/a ejercicios para fortalecer o tonificar sus músculos, como flexiones, abdominales o levantar pesas?"
label(data$act_nutri_parent05)="5. On an average school day, how many hours does your child play video or computer games or use a computer for something that is not school work? (Include activities such as Nintendo, Game Boy, PlayStation, Xbox, computer games, and the Internet.)En un día escolar promedio, ¿cuántas horas juega su hijo con vídeo o juegos de computadora o utiliza una computadora para algo que no sea trabajo escolar?  (Incluye actividades como Nintendo, Game Boy, PlayStation, Xbox, juegos de computadora y de Internet.)"
label(data$act_nutri_parent06)="6. On an average school day, how many hours does your child spend watching DVDs or videos? Include DVDs or videos you watch on a TV, computer, iPod, or other portable device.En un día escolar promedio, ¿cuántas horas pasa su hijo viendo DVDs o videos? Incluya DVDs o vídeos que se pueden ver en un televisor, computadora, iPod o cualquier otro aparato portátil."
label(data$act_nutri_parent07)="7. On an average school day, how many hours does your child watch TV?En un día escolar promedio, ¿cuántas horas ve la televisión su niño/a?"
label(data$act_nutri_parent08)="8. In an average week when your child is in school, on how many days does he/she go to physical education (PE) classes?8. En una semana normal cuando su hijo está en la escuela, ¿cuántos días él/ella va a clases de educación física (PE)?"
label(data$act_nutri_parent09)="9. How many TVs are in your home? (If you sleep in more than one home, answer based on the home you sleep in most.)9. ¿Cuántos televisores hay en su casa? (Si usted duerme en más de una casa, responda a la respuesta en base a la casa donde duerme la mayoría del tiempo)"
label(data$act_nutri_parent10)="10. Does your child have a TV in his/her bedroom? (If they have more than one bedroom, answer based on the bedroom they sleep in most.)10. ¿Su hijo tiene un televisor en su cuarto? (Si tiene más de un cuarto, responde basada en el cuarto donde duerme la mayoría del tiempo.)"
label(data$act_nutri_parent11)="11.  In an average week when your child is in school, on how many days does he/she walk or ride his/her bike to school when weather allows him/her to do so?11. En una semana normal cuando su hijo está en la escuela, ¿cuántos días camina o monta su bicicleta a la escuela cuando el clima lo permite? "
label(data$act_nutri_parent12)="12. Encourage your child to do physical activities or play sports?Anima a su hijo a hacer actividades físicas o deportes de juego físico?"
label(data$act_nutri_parent13)="13. Do a physical activity or play sports with your child?Hace una actividad física o practica deportes con su hijo?"
label(data$act_nutri_parent14)="14. Provide transportation to a place where your child can do physical activities or play sports?Provee el transporte a un lugar donde su hijo puede hacer actividades físicas o deportes de juego?"
label(data$act_nutri_parent15)="15. Watch your child participate in physical activities or play sports?Observa a su niño a participar en actividades o deportes de juego físico?"
label(data$act_nutri_parent16)="16. During the past 7 days, how many times did your child eat fruit? (Do not count fruit juice.)Durante los últimos 7 días, ¿cuántas veces su hijo comio fruta?? (No se cuenta el jugo de fruta.)"
label(data$act_nutri_parent17)="17. During the past 7 days, how many times did your child eat green salad?Durante los últimos 7 días, ¿cuántas veces su hijo/a comió ensalada verde? "
label(data$act_nutri_parent18)="18. During the past 7 days, how many times did your child eat French fries or other fried potatoes, such as home fries, hash browns or tater tots? (Do not count potato chips.)Durante los últimos 7 días, ¿cuántas veces su hijo/a comió papitas fritas u otro tipo de papa frita, como patatas fritas, croquetas de patata o tater (tater tots)? (No cuentes papitas fritas en bolsa/potato chips.)"
label(data$act_nutri_parent19)="19. During the past 7 days, how many times did your child eat carrots?Durante los últimos 7 días, ¿cuántas veces su hijo/a comió zanahorias?"
label(data$act_nutri_parent20)="20. During the past 7 days, how many times did your child eat other vegetables? (Do not count green salad, potatoes, or carrots.)Durante los últimos 7 días, ¿cuántas veces su hijo/a comió otros vegetales? (No cuentes ensalada verde, papas o zanahorias.)"
label(data$act_nutri_parent21)="21. During the past 7 days, how many times did your child eat pizza?Durante los ultimos 7 dias, cuantas veces su hijo/a comió pizza?"
label(data$act_nutri_parent22)="22. During the past 7 days, how many times did your child drink a can, bottle, or glass of soda or pop, such as Coke, Pepsi, or Sprite? (Do not count diet soda or diet pop.)Durante los últimos 7 días, ¿cuántas veces tomó su niño una lata, botella o vaso de refresco o soda, como Coca-Cola, Pepsi, o Sprite? (No cuentes refresco de dieta o soda de dieta.)"
label(data$act_nutri_parent23)="23. During the past 7 days, how many times did your child drink a can, bottle, or glass of diet soda or pop, such as Diet Coke, Diet Pepsi, or Sprite Zero?23. Durante los últimos 7 días, ¿cuáas veces su niño tomó una lata, botella o vaso de refresco o pop dieta, tales como Diet Coke, Diet Pepsi, o Sprite Zero?"
label(data$act_nutri_parent24)="24. During the past 7 days, how many times did your child drink a can, bottle, or glass of a sugar-sweetened beverage such as lemonade, sweetened tea or coffee drinks, flavored milk, Snapple, or Sunny Delight? (Do not count soda or pop, sports drinks, energy drinks, or 100% fruit juice.)Durante los últimos 7 días, ¿cuántas veces su niño tomó una lata, botella o vaso de una bebida endulzada con azúcar como limonada, té o café endulzado, leche con sabor, Snapple, o Sunny Delight? (No cuentes refresco o soda, bebidas para deportistas, bebidas energéticas o jugo 100% de fruta.)"
label(data$act_nutri_parent25)="25. During the past 7 days, how many times did your child drink a bottle or glass of plain water? Count tap, bottled, and unflavored sparkling water.Durante los últimos 7 días, ¿cuántas veces su niño tomó una botella o vaso de agua? Cuente agua de grifo, embotellada, con gas y sin sabor."
label(data$act_nutri_parent26)="26. About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) does your child eat or drink each day?Aproximadamente  cuántas tazas de frutas (incluyendo fruta congelada, enlatada, y seca y 100% jugo de fruta) come o bebe su niño/a cada día?"
label(data$act_nutri_parent27)="27. About how many cups of vegetables (including frozen, canned, and vegetables and 100% vegetable juice) does your child eat or drink each day?Aproximadamente cuánas tazas de vegetales (incluyendo vegetales congelados, enlatados, y secos y 100% jugo de vegetales) come o bebe su niño/a cada día?"
label(data$act_nutri_parent28)="28. During the past 7 days, on how many days did your child eat breakfast or a morning meal?Durante los últimos 7 días, ¿cuántos días comió su niño/a un desayuno o una comida de la mañana?"
label(data$act_nutri_parent29)="29. During the last 7 days, when your child eats dinner at home, how often is a television on while he/ she is eating?Durante los últimos 7 días, cuando su hijo/a come la cena en casa, ¿ con qué frecuencia está un televisor encendido mientras é/ella está comiendo?"
label(data$act_nutri_parent30)="30. During the past 7 days, on how many days did your child eat at least one meal or snack from a fast food restaurant such as McDonalds, Taco Bell, or KFC?Durante los últimos 7 días, ¿cuántos días comió su niño/a al menos una comida o un aperitivo en un restaurante de comida rápida como McDonalds, Taco Bell, o KFC?"
label(data$act_nutri_parent31)="31. How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?¿Con qué frecuencia hay frutas o vegetales para picar en su casa, como las zanahorias, el apio, manzanas, plátanos, melón?"
label(data$physical_activity_nutrition_parent_complete)="Complete?"
label(data$asthma_knowledge_parent_timestamp)="Survey Timestamp"
label(data$asthma_parent01___0)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= sneezingestornudos)"
label(data$asthma_parent01___1)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= shortness of breathfalta de aire)"
label(data$asthma_parent01___11)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= coughingtos)"
label(data$asthma_parent01___00)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= skin rasherupción cutanea)"
label(data$asthma_parent01___000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= feverfiebre)"
label(data$asthma_parent01___111)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= wheezingsibilancias)"
label(data$asthma_parent01___0000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= nausea/vomitingnáuseas/vómitos)"
label(data$asthma_parent01___00000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= runny nosenariz que moquea)"
label(data$asthma_parent01___000000)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= headachedolor de cabeza)"
label(data$asthma_parent01___1111)="1. What are the 3 main symptoms of asthma?¿Cuáles son los tres síntomas principales del asma?  (choice= chest tightnessopresión en el pecho)"
label(data$asthma_parent02)="2.  More than 1 in 10 children will have asthma at some time during their childhood.2. 1 de cada 10 niños tendrán asma en algún momento durante su infancia."
label(data$asthma_parent03)="3. Children with asthma have overly sensitive air passages in their lungs.3. Los niños con asma tienen las vías aéreas pulmonares anormalmente sensibles. "
label(data$asthma_parent04)="4. If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma.4. Si un niño en una familia tiene asma, entonces casi seguro que todos sus hermanos y hermanas la padecerán también."
label(data$asthma_parent05)=" 5. Most children with asthma have an increase in mucus when they drink cows milk.5. La mayoría de los niños con asma sufren un aumento de mucosidad cuando beben leche de vaca."
label(data$asthma_parent07)="7. Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs.7. Durante un ataque de asma los pitos pueden deberse a la contracción muscular de la pared de las vías aéreas pulmonares."
label(data$asthma_parent08)="8. Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs.8. Durante un ataque de asma, los pitos pueden deberse a la inflamación del revestimiento de las vías aéreas pulmonares."
label(data$asthma_parent09)=" 9. Asthma damages the heart.9. El asma daña el corazón. "
label(data$asthma_parent10___0)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Albuterol)"
label(data$asthma_parent10___00)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Ventolin)"
label(data$asthma_parent10___1)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Pulmicort)"
label(data$asthma_parent10___000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Decadron)"
label(data$asthma_parent10___0000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Abilify)"
label(data$asthma_parent10___11)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Montelukast)"
label(data$asthma_parent10___00000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Lexapro)"
label(data$asthma_parent10___000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Benadryl)"
label(data$asthma_parent10___0000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Claritin)"
label(data$asthma_parent10___00000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Amoxicillin)"
label(data$asthma_parent10___111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Singulair)"
label(data$asthma_parent10___000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Zoloft)"
label(data$asthma_parent10___1111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Budesonide)"
label(data$asthma_parent10___0000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Effexor)"
label(data$asthma_parent10___00000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Atrovent)"
label(data$asthma_parent10___11111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Flovent)"
label(data$asthma_parent10___000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Metformin)"
label(data$asthma_parent10___0000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Zithromax)"
label(data$asthma_parent10___000000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Zyrtec)"
label(data$asthma_parent10___0000000000000000)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Prednisone)"
label(data$asthma_parent10___111111)="10. Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring.10. Anote dos tratamientos (medicinas) para el asma que se toman regularmente todos los días para evitar que se produzcan ataques de asma: (choice=Qvar)"
label(data$asthma_parent11___1)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Albuterol)"
label(data$asthma_parent11___11)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Ventolin)"
label(data$asthma_parent11___0)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Pulmicort)"
label(data$asthma_parent11___111)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Decadron)"
label(data$asthma_parent11___00)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Abilify)"
label(data$asthma_parent11___000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Montelukast)"
label(data$asthma_parent11___0000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Lexapro)"
label(data$asthma_parent11___00000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Benadryl)"
label(data$asthma_parent11___000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Claritin)"
label(data$asthma_parent11___0000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Amoxicillin)"
label(data$asthma_parent11___00000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Singulair)"
label(data$asthma_parent11___000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Zoloft)"
label(data$asthma_parent11___0000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Budesonide)"
label(data$asthma_parent11___00000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Effexor)"
label(data$asthma_parent11___1111)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Atrovent)"
label(data$asthma_parent11___000000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Flovent)"
label(data$asthma_parent11___0000000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Metformin)"
label(data$asthma_parent11___00000000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Zithromax)"
label(data$asthma_parent11___000000000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Zyrtec)"
label(data$asthma_parent11___11111)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Prednisone)"
label(data$asthma_parent11___0000000000000000)="11. What are the three asthma treatments (medicines) that are useful during an attack of asthma? 11. ¿Qué tres tratamientos (medicinas) para el asma son útiles durante un ataque de asma? (choice=Qvar)"
label(data$asthma_parent12)="12. Antibiotics are an important part of treatment for most children with asthma. 12. Los antibióticos son una parte importante del tratamiento para la mayoría de los niños con asma."
label(data$asthma_parent13)="13. Most children with asthma should not eat dairy products.13. La mayoría de los niños con asma no deberían consumir productos lácteos."
label(data$asthma_parent14)=" 14.Allergy injections cure asthma.14. Las vacunas para la alergia curan el asma. "
label(data$asthma_parent15)="15. If a child dies from an asthma attack, this usually means that there was no time to start any treatment. 15. Si una persona muere de un ataque de asma, esto normalmente quiere decir que el ataque final debió de haber comenzado tan rápidamente que no hubo tiempo para empezar ningún tratamiento."
label(data$asthma_parent16)="16. Children with asthma usually have emotional problems.16. Las personas con asma normalmente tienen problemas de nervios."
label(data$asthma_parent17)="17. You can catch asthma from another person.17. El asma es infeccioso (es decir, te lo puede contagiar otra persona). "
label(data$asthma_parent18)="18. Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets.18. Los medicamentos inhalados para el asma (por ejemplo, el inhalador Ventolín, Terbasmin) tienen menos efectos secundarios que las pastillas/jarabes."
label(data$asthma_parent19)="19. Short courses of oral steroids (such as prednisone) usually cause significant side effects. 19. Los ciclos cortos de corticoides orales (como Estilsona, Dacortin, Prednisona) habitualmente causan efectos secundarios importantes."
label(data$asthma_parent20)="20. Some asthma treatments (such as Ventolin) damage the heart.20. Algunos tratamientos para el asma (como el Ventolín) dañan el corazón."
label(data$asthma_parent22)="22. During an attack of asthma that you are managing at home, your child is requesting the nebulizer (mask) every 2 hours. He/she is gaining benefit but is very breathless after 2 hours. Provided that he/she doesnt get any worse, its fine to continue with 2-hourly treatments.22. Durante un ataque de asma que están tratando en casa su hijo necesita el inhalador con cámara (o mascarilla) cada 2 horas. Está mejorando pero después de 2 horas respira con dificultad. Teniendo en cuenta que el niño no empeora, es correcto continuar con el tratamiento cada 2 horas."
label(data$asthma_parent24)="24. Children with asthma become addicted to their asthma drugs. 24. Los niños con asma se hacen adictos a sus medicinas para el asma. "
label(data$asthma_parent25)="25. Swimming is the only good exercise for children with asthma.25. La natación es el único deporte adecuado para los asmáticos."
label(data$asthma_parent26)="26. A parents smoking in the home may make the childs asthma worse.26. El hecho de que los padres fumen puede empeorar el asma de su hijo/a."
label(data$asthma_parent27)="27. With the right treatment most children with asthma live a normal life with no restriction on activity. 27. Con el tratamiento adecuado, la mayoría de los niños con asma deberían llevar una vida normal sin restricciones en sus actividades."
label(data$asthma_parent28)="28. The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest. 28. La mejor manera de medir la gravedad del asma de un niño es que el médico le escuche el pecho."
label(data$asthma_parent29)="29. Asthma symptoms usually occur more frequently at night than during the day.29. El asma es normalmente más problemática durante la noche que durante el día. "
label(data$asthma_parent30)="30. Most children with asthma will have stunted growth.30. La mayoría de los niños con asma padecen un enlentecimiento de su crecimiento."
label(data$asthma_parent31)="31. Children who frequently have asthma symptoms should have preventative drugs.31. Los niños con síntomas frecuentes de asma deberían tomar medicinas preventivas."
label(data$asthma_knowledge_parent_complete)="Complete?"
label(data$usherwood_timestamp)="Survey Timestamp"
label(data$usherwood_01)="Your child has been wheezy during the daySu hijo/a ha sido sibilante durante el día"
label(data$usherwood_02)="Your child has coughed during the daySu hijo/a ha tosido durante el día"
label(data$usherwood_03)="Your child has complained of being short of breathSu hijo/a se ha quejado de falta de aire"
label(data$usherwood_04)="Your child has complained of a pain in the chestSu hijo/a se ha quejado de dolor en el pecho"
label(data$usherwood_05)="Exertion (e.g., running) has made your child breathlessEsfuerzo fisico (por ejemplo, correr) ha dejado a su hijo/a sin aire"
label(data$usherwood_06)="Your child has stayed indoors because of wheezing or coughingSu hijo/a se ha mantenido adentro de la casa debido a sibilancias o tos"
label(data$usherwood_07)="His/her asthma has stopped your child from playing with his or her friendsAsma ha hecho que su niño/a no juegue con sus amigos"
label(data$usherwood_08)="During term time, your childs education has suffered due to his or her asthmaDurante el año escolar, la educación de su hijo/a ha sufrido debido a su asma"
label(data$usherwood_09)="Asthma has stopped your child from doing all the things that a boy or girl should at his or her ageEl asma ha detenido a su hijo/a de hacer todas las cosas que un niño/a debe de hacer a su edad"
label(data$usherwood_10)="Your childs asthma has interfered with his or her lifeEl asma de su hijo/a ha interferido con su vida"
label(data$usherwood_11)="Asthma has limited your childs activitiesEl asma ha limitado las actividades de su hijo/a"
label(data$usherwood_12)="Taking his or her inhaler or other treatment has interrupted your childs lifeUsar su inhalador u otro tratamiento ha interrumpido la vida de su hijo/a"
label(data$usherwood_13)="Your childs asthma has limited your activitiesEl asma de su hijo/a ha limitado tus actividades"
label(data$usherwood_14)="You have had to make adjustments to family life because of your childs asthmaHas tenido que hacer cambios a la vida familiar a causa del asma de su hijo/a"
label(data$usherwood_15)="Your child has coughed at nightSu hijo/a ha tosido durante la noche"
label(data$usherwood_16)="Your childs sleep has been disturbed by wheezing or coughing El sueño de su hijo/a ha sido interumpido por sibilancias o tos"
label(data$usherwood_17)="Your child has been woken up by wheezing or coughingSu hijo/a ha sido despertado por sibilancias o tos"
label(data$usherwood_complete)="Complete?"
label(data$equipment_signout_timestamp)="Survey Timestamp"
label(data$tablet_group)="Were you randomized to the tablet group?"
label(data$equipment_signout_complete)="Complete?"
label(data$gift_receipt_timestamp)="Survey Timestamp"
label(data$gift_receipt_complete)="Complete?"
#Setting Units

#Setting Factors(will create new variable for factors)
data$redcap_event_name = factor(data$redcap_event_name,levels=c("initial_visit_arm_1","fu_visit_1_arm_1","fu_visit_2_arm_1","fu_visit_3_arm_1","fu_visit_4_arm_1","final_visit_arm_1"))
data$eng = factor(data$eng,levels=c("1"))
data$esp = factor(data$esp,levels=c("1"))
data$eng2 = factor(data$eng2,levels=c("1"))
data$esp2 = factor(data$esp2,levels=c("1"))
data$start_here_complete = factor(data$start_here_complete,levels=c("0","1","2"))
data$not_part_ethnicity = factor(data$not_part_ethnicity,levels=c("1","2","3","4","5","6"))
data$not_part_asthma = factor(data$not_part_asthma,levels=c("1","0"))
data$not_part_obese = factor(data$not_part_obese,levels=c("1","0"))
data$not_part_gender = factor(data$not_part_gender,levels=c("1","2"))
data$participating = factor(data$participating,levels=c("1","0"))
data$borinquen_info_release_complete = factor(data$borinquen_info_release_complete,levels=c("0","1","2"))
data$parent_or_guardian___1 = factor(data$parent_or_guardian___1,levels=c("0","1"))
data$parent_or_guardian___2 = factor(data$parent_or_guardian___2,levels=c("0","1"))
data$consent_complete = factor(data$consent_complete,levels=c("0","1","2"))
data$assent_complete = factor(data$assent_complete,levels=c("0","1","2"))
data$parent_or_guardian_v2___1 = factor(data$parent_or_guardian_v2___1,levels=c("0","1"))
data$parent_or_guardian_v2___2 = factor(data$parent_or_guardian_v2___2,levels=c("0","1"))
data$consent_2_complete = factor(data$consent_2_complete,levels=c("0","1","2"))
data$consent2_complete = factor(data$consent2_complete,levels=c("0","1","2"))
data$worthtime = factor(data$worthtime,levels=c("1","0"))
data$tablet_v_drvisit___1 = factor(data$tablet_v_drvisit___1,levels=c("0","1"))
data$tablet_v_drvisit___0 = factor(data$tablet_v_drvisit___0,levels=c("0","1"))
data$tablet_v_telephone = factor(data$tablet_v_telephone,levels=c("1","0"))
data$parentchild = factor(data$parentchild,levels=c("1","0"))
data$frequency = factor(data$frequency,levels=c("1","2","3","4","5","6"))
data$easy_tablet = factor(data$easy_tablet,levels=c("1","2","3","4","5"))
data$wifi = factor(data$wifi,levels=c("1","0"))
data$fuze = factor(data$fuze,levels=c("1","0"))
data$appssites = factor(data$appssites,levels=c("1","2","3","4","5","6","7"))
data$acad_accom = factor(data$acad_accom,levels=c("1","0"))
data$perception_complete = factor(data$perception_complete,levels=c("0","1","2"))
data$dem_gender = factor(data$dem_gender,levels=c("1","2"))
data$dem_ethnicity = factor(data$dem_ethnicity,levels=c("1","2","3","4","5","6"))
data$dem_language_home = factor(data$dem_language_home,levels=c("1","2","3","4"))
data$dem_language_pref = factor(data$dem_language_pref,levels=c("1","2","3","4"))
data$dem_grade = factor(data$dem_grade,levels=c("00","0","1","2","3","4","5","6","7","8","9","10","11","12","13"))
data$demographics_patient_complete = factor(data$demographics_patient_complete,levels=c("0","1","2"))
data$tech_kid_smart_device = factor(data$tech_kid_smart_device,levels=c("1","2","3","4"))
data$tech_kid_brand___1 = factor(data$tech_kid_brand___1,levels=c("0","1"))
data$tech_kid_brand___2 = factor(data$tech_kid_brand___2,levels=c("0","1"))
data$tech_kid_brand___3 = factor(data$tech_kid_brand___3,levels=c("0","1"))
data$tech_kid_brand___4 = factor(data$tech_kid_brand___4,levels=c("0","1"))
data$tech_kid_brand___5 = factor(data$tech_kid_brand___5,levels=c("0","1"))
data$tech_kid_brand___6 = factor(data$tech_kid_brand___6,levels=c("0","1"))
data$tech_kid_brand___7 = factor(data$tech_kid_brand___7,levels=c("0","1"))
data$tech_kid_os___1 = factor(data$tech_kid_os___1,levels=c("0","1"))
data$tech_kid_os___2 = factor(data$tech_kid_os___2,levels=c("0","1"))
data$tech_kid_os___3 = factor(data$tech_kid_os___3,levels=c("0","1"))
data$tech_kid_os___4 = factor(data$tech_kid_os___4,levels=c("0","1"))
data$tech_kid_os___5 = factor(data$tech_kid_os___5,levels=c("0","1"))
data$tech_kid_os___6 = factor(data$tech_kid_os___6,levels=c("0","1"))
data$tech_kid_phone_service = factor(data$tech_kid_phone_service,levels=c("1","0","2"))
data$tech_kid_disconnect = factor(data$tech_kid_disconnect,levels=c("1","2","3"))
data$tech_kid_apps = factor(data$tech_kid_apps,levels=c("1","0"))
data$tech_kid_function___1 = factor(data$tech_kid_function___1,levels=c("0","1"))
data$tech_kid_function___2 = factor(data$tech_kid_function___2,levels=c("0","1"))
data$tech_kid_function___3 = factor(data$tech_kid_function___3,levels=c("0","1"))
data$tech_kid_function___4 = factor(data$tech_kid_function___4,levels=c("0","1"))
data$tech_kid_function___5 = factor(data$tech_kid_function___5,levels=c("0","1"))
data$tech_kid_privileges = factor(data$tech_kid_privileges,levels=c("1","2","3","4","5"))
data$tech_kid_device_time = factor(data$tech_kid_device_time,levels=c("0","1","2","3","4","5","6","7"))
data$tech_kid_given_device = factor(data$tech_kid_given_device,levels=c("1","2","3"))
data$tech_patient_complete = factor(data$tech_patient_complete,levels=c("0","1","2"))
data$pedsqlkids_01 = factor(data$pedsqlkids_01,levels=c("0","1","2","3","4"))
data$pedsqlkids_02 = factor(data$pedsqlkids_02,levels=c("0","1","2","3","4"))
data$pedsqlkids_03 = factor(data$pedsqlkids_03,levels=c("0","1","2","3","4"))
data$pedsqlkids_04 = factor(data$pedsqlkids_04,levels=c("0","1","2","3","4"))
data$pedsqlkids_05 = factor(data$pedsqlkids_05,levels=c("0","1","2","3","4"))
data$pedsqlkids_06 = factor(data$pedsqlkids_06,levels=c("0","1","2","3","4"))
data$pedsqlkids_07 = factor(data$pedsqlkids_07,levels=c("0","1","2","3","4"))
data$pedsqlkids_08 = factor(data$pedsqlkids_08,levels=c("0","1","2","3","4"))
data$pedsqlkids_09 = factor(data$pedsqlkids_09,levels=c("0","1","2","3","4"))
data$pedsqlkids_10 = factor(data$pedsqlkids_10,levels=c("0","1","2","3","4"))
data$pedsqlkids_11 = factor(data$pedsqlkids_11,levels=c("0","1","2","3","4"))
data$pedsqlkids_12 = factor(data$pedsqlkids_12,levels=c("0","1","2","3","4"))
data$pedsqlkids_13 = factor(data$pedsqlkids_13,levels=c("0","1","2","3","4"))
data$pedsqlkids_14 = factor(data$pedsqlkids_14,levels=c("0","1","2","3","4"))
data$pedsqlkids_15 = factor(data$pedsqlkids_15,levels=c("0","1","2","3","4"))
data$pedsqlkids_16 = factor(data$pedsqlkids_16,levels=c("0","1","2","3","4"))
data$pedsqlkids_17 = factor(data$pedsqlkids_17,levels=c("0","1","2","3","4"))
data$pedsqlkids_18 = factor(data$pedsqlkids_18,levels=c("0","1","2","3","4"))
data$pedsqlkids_19 = factor(data$pedsqlkids_19,levels=c("0","1","2","3","4"))
data$pedsqlkids_20 = factor(data$pedsqlkids_20,levels=c("0","1","2","3","4"))
data$pedsqlkids_21 = factor(data$pedsqlkids_21,levels=c("0","1","2","3","4"))
data$pedsqlkids_22 = factor(data$pedsqlkids_22,levels=c("0","1","2","3","4"))
data$pedsqlkids_23 = factor(data$pedsqlkids_23,levels=c("0","1","2","3","4"))
data$pedsql_patient_complete = factor(data$pedsql_patient_complete,levels=c("0","1","2"))
data$act_nutri_kids01 = factor(data$act_nutri_kids01,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids02 = factor(data$act_nutri_kids02,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids03 = factor(data$act_nutri_kids03,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids04 = factor(data$act_nutri_kids04,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids05 = factor(data$act_nutri_kids05,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids06 = factor(data$act_nutri_kids06,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_kids07 = factor(data$act_nutri_kids07,levels=c("0","1","2","3","4"))
data$act_nutri_kids08 = factor(data$act_nutri_kids08,levels=c("0","1","2","3","4"))
data$act_nutri_kids09 = factor(data$act_nutri_kids09,levels=c("0","1","2","3","4"))
data$act_nutri_kids10 = factor(data$act_nutri_kids10,levels=c("0","1","2","3","4"))
data$act_nutri_kids11 = factor(data$act_nutri_kids11,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids12 = factor(data$act_nutri_kids12,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids13 = factor(data$act_nutri_kids13,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids14 = factor(data$act_nutri_kids14,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids15 = factor(data$act_nutri_kids15,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids16 = factor(data$act_nutri_kids16,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids17 = factor(data$act_nutri_kids17,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids18 = factor(data$act_nutri_kids18,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids19 = factor(data$act_nutri_kids19,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids20 = factor(data$act_nutri_kids20,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids21 = factor(data$act_nutri_kids21,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids22 = factor(data$act_nutri_kids22,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_kids23 = factor(data$act_nutri_kids23,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids24 = factor(data$act_nutri_kids24,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids25 = factor(data$act_nutri_kids25,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_kids26 = factor(data$act_nutri_kids26,levels=c("0","1","2","3","4"))
data$act_nutri_kids27 = factor(data$act_nutri_kids27,levels=c("0","1","2","3","4"))
data$physical_activity_nutrition_patient_complete = factor(data$physical_activity_nutrition_patient_complete,levels=c("0","1","2"))
data$weight_01 = factor(data$weight_01,levels=c("1","2","3","4","5","6","7"))
data$weight_02 = factor(data$weight_02,levels=c("1","2","3","4","5","6","7"))
data$weight_03 = factor(data$weight_03,levels=c("1","2","3","4","5","6","7"))
data$weight_04 = factor(data$weight_04,levels=c("1","2","3","4","5","6","7"))
data$weight_05 = factor(data$weight_05,levels=c("1","2","3","4","5","6","7"))
data$weight_06 = factor(data$weight_06,levels=c("1","2","3","4","5","6","7"))
data$weight_07 = factor(data$weight_07,levels=c("1","2","3","4","5","6","7"))
data$weight_08 = factor(data$weight_08,levels=c("1","2","3","4","5","6","7"))
data$weight_09 = factor(data$weight_09,levels=c("1","2","3","4","5","6","7"))
data$weight_10 = factor(data$weight_10,levels=c("1","2","3","4","5","6","7"))
data$weight_11 = factor(data$weight_11,levels=c("1","2","3","4","5","6","7"))
data$weight_12 = factor(data$weight_12,levels=c("1","2","3","4","5","6","7"))
data$weight_13 = factor(data$weight_13,levels=c("1","2","3","4","5","6","7"))
data$weight_14 = factor(data$weight_14,levels=c("1","2","3","4","5","6","7"))
data$weight_15 = factor(data$weight_15,levels=c("1","2","3","4","5","6","7"))
data$weight_16 = factor(data$weight_16,levels=c("1","2","3","4","5","6","7"))
data$has_asthma = factor(data$has_asthma,levels=c("1","0"))
data$weight_patient_complete = factor(data$weight_patient_complete,levels=c("0","1","2"))
data$asthma01___0 = factor(data$asthma01___0,levels=c("0","1"))
data$asthma01___1 = factor(data$asthma01___1,levels=c("0","1"))
data$asthma01___11 = factor(data$asthma01___11,levels=c("0","1"))
data$asthma01___00 = factor(data$asthma01___00,levels=c("0","1"))
data$asthma01___000 = factor(data$asthma01___000,levels=c("0","1"))
data$asthma01___111 = factor(data$asthma01___111,levels=c("0","1"))
data$asthma01___0000 = factor(data$asthma01___0000,levels=c("0","1"))
data$asthma01___00000 = factor(data$asthma01___00000,levels=c("0","1"))
data$asthma01___000000 = factor(data$asthma01___000000,levels=c("0","1"))
data$asthma01___1111 = factor(data$asthma01___1111,levels=c("0","1"))
data$asthma02 = factor(data$asthma02,levels=c("0","1"))
data$asthma03 = factor(data$asthma03,levels=c("1","0"))
data$asthma04 = factor(data$asthma04,levels=c("0","1"))
data$asthma05 = factor(data$asthma05,levels=c("0","1"))
data$asthma07 = factor(data$asthma07,levels=c("1","0"))
data$asthma08 = factor(data$asthma08,levels=c("1","0"))
data$asthma09 = factor(data$asthma09,levels=c("0","1"))
data$asthma10___0 = factor(data$asthma10___0,levels=c("0","1"))
data$asthma10___00 = factor(data$asthma10___00,levels=c("0","1"))
data$asthma10___1 = factor(data$asthma10___1,levels=c("0","1"))
data$asthma10___000 = factor(data$asthma10___000,levels=c("0","1"))
data$asthma10___0000 = factor(data$asthma10___0000,levels=c("0","1"))
data$asthma10___11 = factor(data$asthma10___11,levels=c("0","1"))
data$asthma10___00000 = factor(data$asthma10___00000,levels=c("0","1"))
data$asthma10___000000 = factor(data$asthma10___000000,levels=c("0","1"))
data$asthma10___0000000 = factor(data$asthma10___0000000,levels=c("0","1"))
data$asthma10___00000000 = factor(data$asthma10___00000000,levels=c("0","1"))
data$asthma10___111 = factor(data$asthma10___111,levels=c("0","1"))
data$asthma10___000000000 = factor(data$asthma10___000000000,levels=c("0","1"))
data$asthma10___1111 = factor(data$asthma10___1111,levels=c("0","1"))
data$asthma10___0000000000 = factor(data$asthma10___0000000000,levels=c("0","1"))
data$asthma10___00000000000 = factor(data$asthma10___00000000000,levels=c("0","1"))
data$asthma10___11111 = factor(data$asthma10___11111,levels=c("0","1"))
data$asthma10___000000000000 = factor(data$asthma10___000000000000,levels=c("0","1"))
data$asthma10___0000000000000 = factor(data$asthma10___0000000000000,levels=c("0","1"))
data$asthma10___000000000000000 = factor(data$asthma10___000000000000000,levels=c("0","1"))
data$asthma10___0000000000000000 = factor(data$asthma10___0000000000000000,levels=c("0","1"))
data$asthma10___111111 = factor(data$asthma10___111111,levels=c("0","1"))
data$asthma11___1 = factor(data$asthma11___1,levels=c("0","1"))
data$asthma11___11 = factor(data$asthma11___11,levels=c("0","1"))
data$asthma11___0 = factor(data$asthma11___0,levels=c("0","1"))
data$asthma11___111 = factor(data$asthma11___111,levels=c("0","1"))
data$asthma11___00 = factor(data$asthma11___00,levels=c("0","1"))
data$asthma11___000 = factor(data$asthma11___000,levels=c("0","1"))
data$asthma11___0000 = factor(data$asthma11___0000,levels=c("0","1"))
data$asthma11___00000 = factor(data$asthma11___00000,levels=c("0","1"))
data$asthma11___000000 = factor(data$asthma11___000000,levels=c("0","1"))
data$asthma11___0000000 = factor(data$asthma11___0000000,levels=c("0","1"))
data$asthma11___00000000 = factor(data$asthma11___00000000,levels=c("0","1"))
data$asthma11___000000000 = factor(data$asthma11___000000000,levels=c("0","1"))
data$asthma11___0000000000 = factor(data$asthma11___0000000000,levels=c("0","1"))
data$asthma11___00000000000 = factor(data$asthma11___00000000000,levels=c("0","1"))
data$asthma11___1111 = factor(data$asthma11___1111,levels=c("0","1"))
data$asthma11___000000000000 = factor(data$asthma11___000000000000,levels=c("0","1"))
data$asthma11___0000000000000 = factor(data$asthma11___0000000000000,levels=c("0","1"))
data$asthma11___00000000000000 = factor(data$asthma11___00000000000000,levels=c("0","1"))
data$asthma11___000000000000000 = factor(data$asthma11___000000000000000,levels=c("0","1"))
data$asthma11___11111 = factor(data$asthma11___11111,levels=c("0","1"))
data$asthma11___0000000000000000 = factor(data$asthma11___0000000000000000,levels=c("0","1"))
data$asthma12 = factor(data$asthma12,levels=c("0","1"))
data$asthma13 = factor(data$asthma13,levels=c("0","1"))
data$asthma14 = factor(data$asthma14,levels=c("0","1"))
data$asthma15 = factor(data$asthma15,levels=c("0","1"))
data$asthma16 = factor(data$asthma16,levels=c("0","1"))
data$asthma17 = factor(data$asthma17,levels=c("0","1"))
data$asthma18 = factor(data$asthma18,levels=c("1","0"))
data$asthma19 = factor(data$asthma19,levels=c("0","1"))
data$asthma20 = factor(data$asthma20,levels=c("0","1"))
data$asthma22 = factor(data$asthma22,levels=c("0","1"))
data$asthma24 = factor(data$asthma24,levels=c("0","1"))
data$asthma25 = factor(data$asthma25,levels=c("0","1"))
data$asthma26 = factor(data$asthma26,levels=c("1","0"))
data$asthma27 = factor(data$asthma27,levels=c("1","0"))
data$asthma28 = factor(data$asthma28,levels=c("0","1"))
data$asthma29 = factor(data$asthma29,levels=c("1","0"))
data$asthma30 = factor(data$asthma30,levels=c("0","1"))
data$asthma31 = factor(data$asthma31,levels=c("1","0"))
data$asthma_knowledge_patient_complete = factor(data$asthma_knowledge_patient_complete,levels=c("0","1","2"))
data$dem_parent_sex = factor(data$dem_parent_sex,levels=c("1","2"))
data$dem_parent_ethnicity = factor(data$dem_parent_ethnicity,levels=c("1","2","3","4","5","6"))
data$dem_parent_language_pref = factor(data$dem_parent_language_pref,levels=c("1","2","3","4"))
data$dem_parent_school = factor(data$dem_parent_school,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_nationality = factor(data$dem_parent_nationality,levels=c("1","2","3","4","5"))
data$dem_parent_us = factor(data$dem_parent_us,levels=c("1","2","3","4","5","6","7"))
data$dem_kid_nationality = factor(data$dem_kid_nationality,levels=c("1","2","3","4","5"))
data$dem_kid_us = factor(data$dem_kid_us,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_job = factor(data$dem_parent_job,levels=c("1","2","3","4"))
data$dem_parent_income = factor(data$dem_parent_income,levels=c("1","2","3","4","5","6","7"))
data$dem_parent_marital = factor(data$dem_parent_marital,levels=c("1","2","3","4","5"))
data$dem_parent_habitants = factor(data$dem_parent_habitants,levels=c("2","3","4","5","6","7","8"))
data$dem_kid_pmhx___1 = factor(data$dem_kid_pmhx___1,levels=c("0","1"))
data$dem_kid_pmhx___2 = factor(data$dem_kid_pmhx___2,levels=c("0","1"))
data$dem_kid_pmhx___3 = factor(data$dem_kid_pmhx___3,levels=c("0","1"))
data$dem_kid_pmhx___4 = factor(data$dem_kid_pmhx___4,levels=c("0","1"))
data$dem_kid_pmhx___5 = factor(data$dem_kid_pmhx___5,levels=c("0","1"))
data$dem_kid_pmhx___6 = factor(data$dem_kid_pmhx___6,levels=c("0","1"))
data$dem_kid_pmhx___7 = factor(data$dem_kid_pmhx___7,levels=c("0","1"))
data$dem_kid_pmhx___8 = factor(data$dem_kid_pmhx___8,levels=c("0","1"))
data$dem_kid_pmhx___9 = factor(data$dem_kid_pmhx___9,levels=c("0","1"))
data$dem_kid_famhx___1 = factor(data$dem_kid_famhx___1,levels=c("0","1"))
data$dem_kid_famhx___2 = factor(data$dem_kid_famhx___2,levels=c("0","1"))
data$dem_kid_famhx___3 = factor(data$dem_kid_famhx___3,levels=c("0","1"))
data$dem_kid_famhx___4 = factor(data$dem_kid_famhx___4,levels=c("0","1"))
data$dem_kid_famhx___5 = factor(data$dem_kid_famhx___5,levels=c("0","1"))
data$dem_kid_famhx___6 = factor(data$dem_kid_famhx___6,levels=c("0","1"))
data$dem_kid_famhx___7 = factor(data$dem_kid_famhx___7,levels=c("0","1"))
data$dem_kid_famhx___8 = factor(data$dem_kid_famhx___8,levels=c("0","1"))
data$dem_kid_famhx___9 = factor(data$dem_kid_famhx___9,levels=c("0","1"))
data$demographics_parent_complete = factor(data$demographics_parent_complete,levels=c("0","1","2"))
data$tech_parent_device = factor(data$tech_parent_device,levels=c("1","2","3","4"))
data$tech_parent_brand___1 = factor(data$tech_parent_brand___1,levels=c("0","1"))
data$tech_parent_brand___2 = factor(data$tech_parent_brand___2,levels=c("0","1"))
data$tech_parent_brand___3 = factor(data$tech_parent_brand___3,levels=c("0","1"))
data$tech_parent_brand___4 = factor(data$tech_parent_brand___4,levels=c("0","1"))
data$tech_parent_brand___5 = factor(data$tech_parent_brand___5,levels=c("0","1"))
data$tech_parent_brand___6 = factor(data$tech_parent_brand___6,levels=c("0","1"))
data$tech_parent_brand___7 = factor(data$tech_parent_brand___7,levels=c("0","1"))
data$tech_parent_os___1 = factor(data$tech_parent_os___1,levels=c("0","1"))
data$tech_parent_os___2 = factor(data$tech_parent_os___2,levels=c("0","1"))
data$tech_parent_os___3 = factor(data$tech_parent_os___3,levels=c("0","1"))
data$tech_parent_os___4 = factor(data$tech_parent_os___4,levels=c("0","1"))
data$tech_parent_os___6 = factor(data$tech_parent_os___6,levels=c("0","1"))
data$tech_parent_os___7 = factor(data$tech_parent_os___7,levels=c("0","1"))
data$tech_parent_phone_service = factor(data$tech_parent_phone_service,levels=c("1","0","2"))
data$tech_parent_disconnect = factor(data$tech_parent_disconnect,levels=c("1","2","3"))
data$tech_parent_apps = factor(data$tech_parent_apps,levels=c("1","0"))
data$tech_parent_function___1 = factor(data$tech_parent_function___1,levels=c("0","1"))
data$tech_parent_function___2 = factor(data$tech_parent_function___2,levels=c("0","1"))
data$tech_parent_function___3 = factor(data$tech_parent_function___3,levels=c("0","1"))
data$tech_parent_function___4 = factor(data$tech_parent_function___4,levels=c("0","1"))
data$tech_parent_function___5 = factor(data$tech_parent_function___5,levels=c("0","1"))
data$tech_parent_info___1 = factor(data$tech_parent_info___1,levels=c("0","1"))
data$tech_parent_info___2 = factor(data$tech_parent_info___2,levels=c("0","1"))
data$tech_parent_info___3 = factor(data$tech_parent_info___3,levels=c("0","1"))
data$tech_parent_info___4 = factor(data$tech_parent_info___4,levels=c("0","1"))
data$tech_parent_info___5 = factor(data$tech_parent_info___5,levels=c("0","1"))
data$tech_parent_info___6 = factor(data$tech_parent_info___6,levels=c("0","1"))
data$tech_parent_info___7 = factor(data$tech_parent_info___7,levels=c("0","1"))
data$tech_parent_info___8 = factor(data$tech_parent_info___8,levels=c("0","1"))
data$tech_kid_par_device = factor(data$tech_kid_par_device,levels=c("1","2","3","4"))
data$tech_kid_par_brand___1 = factor(data$tech_kid_par_brand___1,levels=c("0","1"))
data$tech_kid_par_brand___2 = factor(data$tech_kid_par_brand___2,levels=c("0","1"))
data$tech_kid_par_brand___3 = factor(data$tech_kid_par_brand___3,levels=c("0","1"))
data$tech_kid_par_brand___4 = factor(data$tech_kid_par_brand___4,levels=c("0","1"))
data$tech_kid_par_brand___5 = factor(data$tech_kid_par_brand___5,levels=c("0","1"))
data$tech_kid_par_brand___6 = factor(data$tech_kid_par_brand___6,levels=c("0","1"))
data$tech_kid_par_brand___7 = factor(data$tech_kid_par_brand___7,levels=c("0","1"))
data$tech_kid_par_os___1 = factor(data$tech_kid_par_os___1,levels=c("0","1"))
data$tech_kid_par_os___2 = factor(data$tech_kid_par_os___2,levels=c("0","1"))
data$tech_kid_par_os___3 = factor(data$tech_kid_par_os___3,levels=c("0","1"))
data$tech_kid_par_os___4 = factor(data$tech_kid_par_os___4,levels=c("0","1"))
data$tech_kid_par_os___6 = factor(data$tech_kid_par_os___6,levels=c("0","1"))
data$tech_kid_par_os___7 = factor(data$tech_kid_par_os___7,levels=c("0","1"))
data$tech_kid_par_service = factor(data$tech_kid_par_service,levels=c("1","0","2"))
data$tech_kid_par_disconnected = factor(data$tech_kid_par_disconnected,levels=c("1","2","3"))
data$tech_kid_par_app = factor(data$tech_kid_par_app,levels=c("1","0"))
data$tech_parent_privileges = factor(data$tech_parent_privileges,levels=c("1","2","3","4","5"))
data$tech_parent_uses = factor(data$tech_parent_uses,levels=c("1","2","3"))
data$tech_parent_complete = factor(data$tech_parent_complete,levels=c("0","1","2"))
data$pedsqlparent_01 = factor(data$pedsqlparent_01,levels=c("0","1","2","3","4"))
data$pedsqlparent_02 = factor(data$pedsqlparent_02,levels=c("0","1","2","3","4"))
data$pedsqlparent_03 = factor(data$pedsqlparent_03,levels=c("0","1","2","3","4"))
data$pedsqlparent_04 = factor(data$pedsqlparent_04,levels=c("0","1","2","3","4"))
data$pedsqlparent_05 = factor(data$pedsqlparent_05,levels=c("0","1","2","3","4"))
data$pedsqlparent_06 = factor(data$pedsqlparent_06,levels=c("0","1","2","3","4"))
data$pedsqlparent_07 = factor(data$pedsqlparent_07,levels=c("0","1","2","3","4"))
data$pedsqlparent_08 = factor(data$pedsqlparent_08,levels=c("0","1","2","3","4"))
data$pedsqlparent_09 = factor(data$pedsqlparent_09,levels=c("0","1","2","3","4"))
data$pedsqlparent_10 = factor(data$pedsqlparent_10,levels=c("0","1","2","3","4"))
data$pedsqlparent_11 = factor(data$pedsqlparent_11,levels=c("0","1","2","3","4"))
data$pedsqlparent_12 = factor(data$pedsqlparent_12,levels=c("0","1","2","3","4"))
data$pedsqlparent_13 = factor(data$pedsqlparent_13,levels=c("0","1","2","3","4"))
data$pedsqlparent_14 = factor(data$pedsqlparent_14,levels=c("0","1","2","3","4"))
data$pedsqlparent_15 = factor(data$pedsqlparent_15,levels=c("0","1","2","3","4"))
data$pedsqlparent_16 = factor(data$pedsqlparent_16,levels=c("0","1","2","3","4"))
data$pedsqlparent_17 = factor(data$pedsqlparent_17,levels=c("0","1","2","3","4"))
data$pedsqlparent_18 = factor(data$pedsqlparent_18,levels=c("0","1","2","3","4"))
data$pedsqlparent_19 = factor(data$pedsqlparent_19,levels=c("0","1","2","3","4"))
data$pedsqlparent_20 = factor(data$pedsqlparent_20,levels=c("0","1","2","3","4"))
data$pedsqlparent_21 = factor(data$pedsqlparent_21,levels=c("0","1","2","3","4"))
data$pedsqlparent_22 = factor(data$pedsqlparent_22,levels=c("0","1","2","3","4"))
data$pedsqlparent_23 = factor(data$pedsqlparent_23,levels=c("0","1","2","3","4"))
data$pedsql_parent_complete = factor(data$pedsql_parent_complete,levels=c("0","1","2"))
data$act_nutri_parent01 = factor(data$act_nutri_parent01,levels=c("1","0"))
data$act_nutri_parent02 = factor(data$act_nutri_parent02,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent03 = factor(data$act_nutri_parent03,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent04 = factor(data$act_nutri_parent04,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent05 = factor(data$act_nutri_parent05,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent06 = factor(data$act_nutri_parent06,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent07 = factor(data$act_nutri_parent07,levels=c("00","0","1","2","3","4","5"))
data$act_nutri_parent08 = factor(data$act_nutri_parent08,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent09 = factor(data$act_nutri_parent09,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent10 = factor(data$act_nutri_parent10,levels=c("1","2"))
data$act_nutri_parent11 = factor(data$act_nutri_parent11,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent12 = factor(data$act_nutri_parent12,levels=c("0","1","2","3","4"))
data$act_nutri_parent13 = factor(data$act_nutri_parent13,levels=c("0","1","2","3","4"))
data$act_nutri_parent14 = factor(data$act_nutri_parent14,levels=c("0","1","2","3","4"))
data$act_nutri_parent15 = factor(data$act_nutri_parent15,levels=c("0","1","2","3","4"))
data$act_nutri_parent16 = factor(data$act_nutri_parent16,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent17 = factor(data$act_nutri_parent17,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent18 = factor(data$act_nutri_parent18,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent19 = factor(data$act_nutri_parent19,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent20 = factor(data$act_nutri_parent20,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent21 = factor(data$act_nutri_parent21,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent22 = factor(data$act_nutri_parent22,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent23 = factor(data$act_nutri_parent23,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent24 = factor(data$act_nutri_parent24,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent25 = factor(data$act_nutri_parent25,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent26 = factor(data$act_nutri_parent26,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent27 = factor(data$act_nutri_parent27,levels=c("0","1","2","3","4","5","6"))
data$act_nutri_parent28 = factor(data$act_nutri_parent28,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent29 = factor(data$act_nutri_parent29,levels=c("0","1","2","3","4","5"))
data$act_nutri_parent30 = factor(data$act_nutri_parent30,levels=c("0","1","2","3","4","5","6","7"))
data$act_nutri_parent31 = factor(data$act_nutri_parent31,levels=c("0","1","2","3","4"))
data$physical_activity_nutrition_parent_complete = factor(data$physical_activity_nutrition_parent_complete,levels=c("0","1","2"))
data$asthma_parent01___0 = factor(data$asthma_parent01___0,levels=c("0","1"))
data$asthma_parent01___1 = factor(data$asthma_parent01___1,levels=c("0","1"))
data$asthma_parent01___11 = factor(data$asthma_parent01___11,levels=c("0","1"))
data$asthma_parent01___00 = factor(data$asthma_parent01___00,levels=c("0","1"))
data$asthma_parent01___000 = factor(data$asthma_parent01___000,levels=c("0","1"))
data$asthma_parent01___111 = factor(data$asthma_parent01___111,levels=c("0","1"))
data$asthma_parent01___0000 = factor(data$asthma_parent01___0000,levels=c("0","1"))
data$asthma_parent01___00000 = factor(data$asthma_parent01___00000,levels=c("0","1"))
data$asthma_parent01___000000 = factor(data$asthma_parent01___000000,levels=c("0","1"))
data$asthma_parent01___1111 = factor(data$asthma_parent01___1111,levels=c("0","1"))
data$asthma_parent02 = factor(data$asthma_parent02,levels=c("0","1"))
data$asthma_parent03 = factor(data$asthma_parent03,levels=c("1","0"))
data$asthma_parent04 = factor(data$asthma_parent04,levels=c("0","1"))
data$asthma_parent05 = factor(data$asthma_parent05,levels=c("0","1"))
data$asthma_parent07 = factor(data$asthma_parent07,levels=c("1","0"))
data$asthma_parent08 = factor(data$asthma_parent08,levels=c("1","0"))
data$asthma_parent09 = factor(data$asthma_parent09,levels=c("0","1"))
data$asthma_parent10___0 = factor(data$asthma_parent10___0,levels=c("0","1"))
data$asthma_parent10___00 = factor(data$asthma_parent10___00,levels=c("0","1"))
data$asthma_parent10___1 = factor(data$asthma_parent10___1,levels=c("0","1"))
data$asthma_parent10___000 = factor(data$asthma_parent10___000,levels=c("0","1"))
data$asthma_parent10___0000 = factor(data$asthma_parent10___0000,levels=c("0","1"))
data$asthma_parent10___11 = factor(data$asthma_parent10___11,levels=c("0","1"))
data$asthma_parent10___00000 = factor(data$asthma_parent10___00000,levels=c("0","1"))
data$asthma_parent10___000000 = factor(data$asthma_parent10___000000,levels=c("0","1"))
data$asthma_parent10___0000000 = factor(data$asthma_parent10___0000000,levels=c("0","1"))
data$asthma_parent10___00000000 = factor(data$asthma_parent10___00000000,levels=c("0","1"))
data$asthma_parent10___111 = factor(data$asthma_parent10___111,levels=c("0","1"))
data$asthma_parent10___000000000 = factor(data$asthma_parent10___000000000,levels=c("0","1"))
data$asthma_parent10___1111 = factor(data$asthma_parent10___1111,levels=c("0","1"))
data$asthma_parent10___0000000000 = factor(data$asthma_parent10___0000000000,levels=c("0","1"))
data$asthma_parent10___00000000000 = factor(data$asthma_parent10___00000000000,levels=c("0","1"))
data$asthma_parent10___11111 = factor(data$asthma_parent10___11111,levels=c("0","1"))
data$asthma_parent10___000000000000 = factor(data$asthma_parent10___000000000000,levels=c("0","1"))
data$asthma_parent10___0000000000000 = factor(data$asthma_parent10___0000000000000,levels=c("0","1"))
data$asthma_parent10___000000000000000 = factor(data$asthma_parent10___000000000000000,levels=c("0","1"))
data$asthma_parent10___0000000000000000 = factor(data$asthma_parent10___0000000000000000,levels=c("0","1"))
data$asthma_parent10___111111 = factor(data$asthma_parent10___111111,levels=c("0","1"))
data$asthma_parent11___1 = factor(data$asthma_parent11___1,levels=c("0","1"))
data$asthma_parent11___11 = factor(data$asthma_parent11___11,levels=c("0","1"))
data$asthma_parent11___0 = factor(data$asthma_parent11___0,levels=c("0","1"))
data$asthma_parent11___111 = factor(data$asthma_parent11___111,levels=c("0","1"))
data$asthma_parent11___00 = factor(data$asthma_parent11___00,levels=c("0","1"))
data$asthma_parent11___000 = factor(data$asthma_parent11___000,levels=c("0","1"))
data$asthma_parent11___0000 = factor(data$asthma_parent11___0000,levels=c("0","1"))
data$asthma_parent11___00000 = factor(data$asthma_parent11___00000,levels=c("0","1"))
data$asthma_parent11___000000 = factor(data$asthma_parent11___000000,levels=c("0","1"))
data$asthma_parent11___0000000 = factor(data$asthma_parent11___0000000,levels=c("0","1"))
data$asthma_parent11___00000000 = factor(data$asthma_parent11___00000000,levels=c("0","1"))
data$asthma_parent11___000000000 = factor(data$asthma_parent11___000000000,levels=c("0","1"))
data$asthma_parent11___0000000000 = factor(data$asthma_parent11___0000000000,levels=c("0","1"))
data$asthma_parent11___00000000000 = factor(data$asthma_parent11___00000000000,levels=c("0","1"))
data$asthma_parent11___1111 = factor(data$asthma_parent11___1111,levels=c("0","1"))
data$asthma_parent11___000000000000 = factor(data$asthma_parent11___000000000000,levels=c("0","1"))
data$asthma_parent11___0000000000000 = factor(data$asthma_parent11___0000000000000,levels=c("0","1"))
data$asthma_parent11___00000000000000 = factor(data$asthma_parent11___00000000000000,levels=c("0","1"))
data$asthma_parent11___000000000000000 = factor(data$asthma_parent11___000000000000000,levels=c("0","1"))
data$asthma_parent11___11111 = factor(data$asthma_parent11___11111,levels=c("0","1"))
data$asthma_parent11___0000000000000000 = factor(data$asthma_parent11___0000000000000000,levels=c("0","1"))
data$asthma_parent12 = factor(data$asthma_parent12,levels=c("0","1"))
data$asthma_parent13 = factor(data$asthma_parent13,levels=c("0","1"))
data$asthma_parent14 = factor(data$asthma_parent14,levels=c("0","1"))
data$asthma_parent15 = factor(data$asthma_parent15,levels=c("0","1"))
data$asthma_parent16 = factor(data$asthma_parent16,levels=c("0","1"))
data$asthma_parent17 = factor(data$asthma_parent17,levels=c("0","1"))
data$asthma_parent18 = factor(data$asthma_parent18,levels=c("1","0"))
data$asthma_parent19 = factor(data$asthma_parent19,levels=c("0","1"))
data$asthma_parent20 = factor(data$asthma_parent20,levels=c("0","1"))
data$asthma_parent22 = factor(data$asthma_parent22,levels=c("0","1"))
data$asthma_parent24 = factor(data$asthma_parent24,levels=c("0","1"))
data$asthma_parent25 = factor(data$asthma_parent25,levels=c("0","1"))
data$asthma_parent26 = factor(data$asthma_parent26,levels=c("1","0"))
data$asthma_parent27 = factor(data$asthma_parent27,levels=c("1","0"))
data$asthma_parent28 = factor(data$asthma_parent28,levels=c("0","1"))
data$asthma_parent29 = factor(data$asthma_parent29,levels=c("1","0"))
data$asthma_parent30 = factor(data$asthma_parent30,levels=c("0","1"))
data$asthma_parent31 = factor(data$asthma_parent31,levels=c("1","0"))
data$asthma_knowledge_parent_complete = factor(data$asthma_knowledge_parent_complete,levels=c("0","1","2"))
data$usherwood_01 = factor(data$usherwood_01,levels=c("0","1","2","3","4"))
data$usherwood_02 = factor(data$usherwood_02,levels=c("0","1","2","3","4"))
data$usherwood_03 = factor(data$usherwood_03,levels=c("0","1","2","3","4"))
data$usherwood_04 = factor(data$usherwood_04,levels=c("0","1","2","3","4"))
data$usherwood_05 = factor(data$usherwood_05,levels=c("0","1","2","3","4"))
data$usherwood_06 = factor(data$usherwood_06,levels=c("0","1","2","3","4"))
data$usherwood_07 = factor(data$usherwood_07,levels=c("0","1","2","3","4"))
data$usherwood_08 = factor(data$usherwood_08,levels=c("0","1","2","3","4"))
data$usherwood_09 = factor(data$usherwood_09,levels=c("0","1","2","3","4"))
data$usherwood_10 = factor(data$usherwood_10,levels=c("0","1","2","3","4"))
data$usherwood_11 = factor(data$usherwood_11,levels=c("0","1","2","3","4"))
data$usherwood_12 = factor(data$usherwood_12,levels=c("0","1","2","3","4"))
data$usherwood_13 = factor(data$usherwood_13,levels=c("0","1","2","3","4"))
data$usherwood_14 = factor(data$usherwood_14,levels=c("0","1","2","3","4"))
data$usherwood_15 = factor(data$usherwood_15,levels=c("0","1","2","3","4"))
data$usherwood_16 = factor(data$usherwood_16,levels=c("0","1","2","3","4"))
data$usherwood_17 = factor(data$usherwood_17,levels=c("0","1","2","3","4"))
data$usherwood_complete = factor(data$usherwood_complete,levels=c("0","1","2"))
data$tablet_group = factor(data$tablet_group,levels=c("1","0"))
data$equipment_signout_complete = factor(data$equipment_signout_complete,levels=c("0","1","2"))
data$gift_receipt_complete = factor(data$gift_receipt_complete,levels=c("0","1","2"))

levels(data$redcap_event_name)=c("Initial Visit","F/U Visit 1","F/U Visit 2","F/U Visit 3","F/U Visit 4","Final Visit")
levels(data$eng)=c("")
levels(data$esp)=c("")
levels(data$eng2)=c("")
levels(data$esp2)=c("")
levels(data$start_here_complete)=c("Incomplete","Unverified","Complete")
levels(data$not_part_ethnicity)=c("Black, Non-Hispanic","White, Non-Hispanic","Asian or Pacific Islander","Native American or Alaskan Native","Hispanic","Otro")
levels(data$not_part_asthma)=c("YesSi","No")
levels(data$not_part_obese)=c("YesSi","No")
levels(data$not_part_gender)=c("Girlniña","Boyniño")
levels(data$participating)=c("YesSi","No")
levels(data$borinquen_info_release_complete)=c("Incomplete","Unverified","Complete")
levels(data$parent_or_guardian___1)=c("Unchecked","Checked")
levels(data$parent_or_guardian___2)=c("Unchecked","Checked")
levels(data$consent_complete)=c("Incomplete","Unverified","Complete")
levels(data$assent_complete)=c("Incomplete","Unverified","Complete")
levels(data$parent_or_guardian_v2___1)=c("Unchecked","Checked")
levels(data$parent_or_guardian_v2___2)=c("Unchecked","Checked")
levels(data$consent_2_complete)=c("Incomplete","Unverified","Complete")
levels(data$consent2_complete)=c("Incomplete","Unverified","Complete")
levels(data$worthtime)=c("Yes","No")
levels(data$tablet_v_drvisit___1)=c("Unchecked","Checked")
levels(data$tablet_v_drvisit___0)=c("Unchecked","Checked")
levels(data$tablet_v_telephone)=c("Yes","No")
levels(data$parentchild)=c("Yes","No")
levels(data$frequency)=c("Every 2 weeks","Every month","Every 2 months","Every 3 months","Every 6 months","Other")
levels(data$easy_tablet)=c("Very Easy","Easy","Neutral","Hard","Very Hard")
levels(data$wifi)=c("Yes","No")
levels(data$fuze)=c("Yes","No")
levels(data$appssites)=c("Fooducate","Myfitnesspal","Sworkit","Choosemyplate.gov","CDC Bam Food & Nutrition","CDC Bam Physical Activity","None of the above")
levels(data$acad_accom)=c("Yes","No")
levels(data$perception_complete)=c("Incomplete","Unverified","Complete")
levels(data$dem_gender)=c("FemaleFemenino","MaleMasculino")
levels(data$dem_ethnicity)=c("Black, Non-HispanicNegro o Afroamericano, no Hispano","White, Non-HispanicBlanco, no Hispano","Asian or Pacific IslanderAsiático o Asiático-americano, o de las Islas del Pacífico","Native American or Alaskan NativeIndio americano o nativo Americano, o nativo de Alaska","HispanicHispano","OtherOtro")
levels(data$dem_language_home)=c("EnglishInglés","CreoleCreole Haitiano","SpanishEspañol","OtherOtro")
levels(data$dem_language_pref)=c("EnglishInglés","CreoleCreole Haitiano","SpanishEspañol","OtherOtro")
levels(data$dem_grade)=c("Pre-K","Kindergarten","1","2","3","4","5","6","7","8","9","10","11","12","Other/Otro")
levels(data$demographics_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$tech_kid_smart_device)=c("smart phoneteléfono inteligente","tablettableta","both a smart phone and a tabletlos dos un teléfono inteligente y una tableta ","neitherninguno")
levels(data$tech_kid_brand___1)=c("Unchecked","Checked")
levels(data$tech_kid_brand___2)=c("Unchecked","Checked")
levels(data$tech_kid_brand___3)=c("Unchecked","Checked")
levels(data$tech_kid_brand___4)=c("Unchecked","Checked")
levels(data$tech_kid_brand___5)=c("Unchecked","Checked")
levels(data$tech_kid_brand___6)=c("Unchecked","Checked")
levels(data$tech_kid_brand___7)=c("Unchecked","Checked")
levels(data$tech_kid_os___1)=c("Unchecked","Checked")
levels(data$tech_kid_os___2)=c("Unchecked","Checked")
levels(data$tech_kid_os___3)=c("Unchecked","Checked")
levels(data$tech_kid_os___4)=c("Unchecked","Checked")
levels(data$tech_kid_os___5)=c("Unchecked","Checked")
levels(data$tech_kid_os___6)=c("Unchecked","Checked")
levels(data$tech_kid_phone_service)=c("YesSi","NoNo"," Unsure or Not ApplicableNo estoy seguro o no aplicable")
levels(data$tech_kid_disconnect)=c("1-2 times/year1-2 veces / año","3-4 times/year3-4 veces / año","More than 5 times/yearMás de 5 veces / año")
levels(data$tech_kid_apps)=c("YesSi","NoNo")
levels(data$tech_kid_function___1)=c("Unchecked","Checked")
levels(data$tech_kid_function___2)=c("Unchecked","Checked")
levels(data$tech_kid_function___3)=c("Unchecked","Checked")
levels(data$tech_kid_function___4)=c("Unchecked","Checked")
levels(data$tech_kid_function___5)=c("Unchecked","Checked")
levels(data$tech_kid_privileges)=c("NeverNunca","Almost NeverCasi nunca","SometimesA veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$tech_kid_device_time)=c("Less than 1 hourMenos de 1 hora","1 hour1 hora","1 - 2 hours1 - 2 horas ","2 - 3 hours2 - 3 horas ","3 - 4 hours3 - 4 horas ","4 - 5 hours4 - 5 horas ","5 - 6 hours5 - 6 horas ","More than 6 hoursMás de 6 horas")
levels(data$tech_kid_given_device)=c("Not LikelyNo es probable","Somewhat LikelyUn poco probable","Very LikelyMuy Probable")
levels(data$tech_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$pedsqlkids_01)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_02)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_03)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_04)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_05)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_06)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_07)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_08)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_09)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_10)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_11)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_12)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_13)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_14)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_15)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_16)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_17)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_18)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_19)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_20)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_21)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_22)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlkids_23)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsql_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$act_nutri_kids01)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids02)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids03)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids04)=c(" I do not play video or computer games or use a computer for something that is not school workYo no juego juegos de video o juegos de computadora o utilizo una computadora para algo que no sea trabajo de la escuela","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_kids05)=c("I do not watch DVDs or videos on an average school dayNo veo DVDs o vídeos en un día escolar regular","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_kids06)=c("I do not watch TV on an average school dayYo no veo la televisión en un día regular de escuela","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_kids07)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_kids08)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_kids09)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_kids10)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_kids11)=c(" I did not eat fruit during the past 7 daysNo he comido fruta durante los últimos 7 días"," 1 to 3 times during the past 7 days1-3 veces durante los últimos 7 días"," 4 to 6 times during the past 7 days4-6 veces durante los últimos 7 días"," 1 time per day1 vez por día"," 2 times per day2 vez por día"," 3 times per day3 vez por día"," 4 or more times per day4 veces por día o mas")
levels(data$act_nutri_kids12)=c(" I did not eat green salad during the past 7 daysNo he comido ensalda verde durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids13)=c(" I did not eat potatoes during the past 7 daysNo he comido papitas fritas durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids14)=c(" I did not eat carrots during the past 7 daysNo he comido zanahorias durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids15)=c(" I did not eat other vegetables during the past 7 daysNo he comido vegetales durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids16)=c(" I did not eat pizza during the past 7 daysNo he comido pizza durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids17)=c(" I did not drink 100% fruit juice during the past 7 daysNo he bebido 100% jugo de fruta durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids18)=c(" I did not drink soda or pop during the past 7 daysNo he bebido refresco o soda durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids19)=c(" I did not drink sugar-sweetened beverages  during the past 7 daysNo he bebido bebidas endulzadas con azucar durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids20)=c(" I did not drink water during the past 7 daysNo he bebido agua durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_kids21)=c(" NoneNinguna"," 1/2 cup or less1/2 taza o menos"," 1/2 cup to 1 cup1/2 taza a 1 taza"," 1 to 2 cups1 a 2 tazas"," 2 to 3 cups2 a 3 tazas"," 3 to 4 cups3 a 4 tazas"," 4 or more cups4 tazas o mas")
levels(data$act_nutri_kids22)=c(" NoneNinguna"," 1/2 cup or less1/2 taza o menos"," 1/2 cup to 1 cup1/2 taza a 1 taza"," 1 to 2 cups1 a 2 tazas"," 2 to 3 cups2 a 3 tazas"," 3 to 4 cups3 a 4 tazas"," 4 or more cups4 o mas tazas")
levels(data$act_nutri_kids23)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids24)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids25)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_kids26)=c(" NeverNunca"," RarelyRaramente"," SometimesA veces"," Most of the timeLa mayoria del tiempo"," AlwaysSiempre")
levels(data$act_nutri_kids27)=c(" NeverNunca"," RarelyRaramente"," SometimesA veces"," Most of the timeLa mayoria del tiempo"," AlwaysSiempre")
levels(data$physical_activity_nutrition_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$weight_01)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_02)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_03)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_04)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_05)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_06)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_07)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_08)=c("Not True At All 1No es cierto en lo absoluto","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_09)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_10)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_11)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_12)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_13)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_14)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_15)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$weight_16)=c("Not True At AllNo es cierto en lo absoluto 1","2","3","Somewhat TrueAlgo Cierto4","5","6","Very TrueMuy Cierto7")
levels(data$has_asthma)=c("YesSí ","No")
levels(data$weight_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$asthma01___0)=c("Unchecked","Checked")
levels(data$asthma01___1)=c("Unchecked","Checked")
levels(data$asthma01___11)=c("Unchecked","Checked")
levels(data$asthma01___00)=c("Unchecked","Checked")
levels(data$asthma01___000)=c("Unchecked","Checked")
levels(data$asthma01___111)=c("Unchecked","Checked")
levels(data$asthma01___0000)=c("Unchecked","Checked")
levels(data$asthma01___00000)=c("Unchecked","Checked")
levels(data$asthma01___000000)=c("Unchecked","Checked")
levels(data$asthma01___1111)=c("Unchecked","Checked")
levels(data$asthma02)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma03)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma04)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma05)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma07)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma08)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma09)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma10___0)=c("Unchecked","Checked")
levels(data$asthma10___00)=c("Unchecked","Checked")
levels(data$asthma10___1)=c("Unchecked","Checked")
levels(data$asthma10___000)=c("Unchecked","Checked")
levels(data$asthma10___0000)=c("Unchecked","Checked")
levels(data$asthma10___11)=c("Unchecked","Checked")
levels(data$asthma10___00000)=c("Unchecked","Checked")
levels(data$asthma10___000000)=c("Unchecked","Checked")
levels(data$asthma10___0000000)=c("Unchecked","Checked")
levels(data$asthma10___00000000)=c("Unchecked","Checked")
levels(data$asthma10___111)=c("Unchecked","Checked")
levels(data$asthma10___000000000)=c("Unchecked","Checked")
levels(data$asthma10___1111)=c("Unchecked","Checked")
levels(data$asthma10___0000000000)=c("Unchecked","Checked")
levels(data$asthma10___00000000000)=c("Unchecked","Checked")
levels(data$asthma10___11111)=c("Unchecked","Checked")
levels(data$asthma10___000000000000)=c("Unchecked","Checked")
levels(data$asthma10___0000000000000)=c("Unchecked","Checked")
levels(data$asthma10___000000000000000)=c("Unchecked","Checked")
levels(data$asthma10___0000000000000000)=c("Unchecked","Checked")
levels(data$asthma10___111111)=c("Unchecked","Checked")
levels(data$asthma11___1)=c("Unchecked","Checked")
levels(data$asthma11___11)=c("Unchecked","Checked")
levels(data$asthma11___0)=c("Unchecked","Checked")
levels(data$asthma11___111)=c("Unchecked","Checked")
levels(data$asthma11___00)=c("Unchecked","Checked")
levels(data$asthma11___000)=c("Unchecked","Checked")
levels(data$asthma11___0000)=c("Unchecked","Checked")
levels(data$asthma11___00000)=c("Unchecked","Checked")
levels(data$asthma11___000000)=c("Unchecked","Checked")
levels(data$asthma11___0000000)=c("Unchecked","Checked")
levels(data$asthma11___00000000)=c("Unchecked","Checked")
levels(data$asthma11___000000000)=c("Unchecked","Checked")
levels(data$asthma11___0000000000)=c("Unchecked","Checked")
levels(data$asthma11___00000000000)=c("Unchecked","Checked")
levels(data$asthma11___1111)=c("Unchecked","Checked")
levels(data$asthma11___000000000000)=c("Unchecked","Checked")
levels(data$asthma11___0000000000000)=c("Unchecked","Checked")
levels(data$asthma11___00000000000000)=c("Unchecked","Checked")
levels(data$asthma11___000000000000000)=c("Unchecked","Checked")
levels(data$asthma11___11111)=c("Unchecked","Checked")
levels(data$asthma11___0000000000000000)=c("Unchecked","Checked")
levels(data$asthma12)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma13)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma14)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma15)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma16)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma17)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma18)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma19)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma20)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma22)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma24)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma25)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma26)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma27)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma28)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma29)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma30)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma31)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_knowledge_patient_complete)=c("Incomplete","Unverified","Complete")
levels(data$dem_parent_sex)=c("FemaleFemenino","MaleMasculino")
levels(data$dem_parent_ethnicity)=c("Black, Non-HispanicNegro o Afroamericano, no Hispano","white, Non-HispanicBlanco, no Hispano","Asian or Pacific IslanderAsiático o Asiático-americano, o de las Islas del Pacífico","Native American or Alaskan NativeIndio americano o nativo Americano, o nativo de Alaska","HispanicHispano","OtherOtro")
levels(data$dem_parent_language_pref)=c("EnglishInglés","CreoleCreole Haitiano","SpanishEspañol","OtherOtro")
levels(data$dem_parent_school)=c("Never attended schoolNunca fue a la escuela","1st to 8th grade (elementary)1 a 8 grado (primaria)","9th to 11th grade (some high school)9 al 11 grado (educación secundaria incompleta)","12th grade or GED (high school graduate)12 grado o GED (graduado de la escuela secundaria)","1 to 3 years college (some college or technical school)1 a 3 años de universidad (algunos años de universidad o escuela técnica)","4 or more years college (college graduate)4 o más años de universidad (graduado de la universidad)","Graduate training or professional degreeFormación de postgrado o título profesional")
levels(data$dem_parent_nationality)=c("United StatesEstados Unidos","CubaCuba","MexicoMéxico","HaitiHaití","OtherOtros")
levels(data$dem_parent_us)=c("Less than 1 yearMenos de 1 año","1-3 years1 - 3 años","4-6 years4 - 6 años","7-9 years7 - 9 años","10-12 years10 - 12 años","13-15 years13 - 15 años","More than 15 yearsMás de 15 años")
levels(data$dem_kid_nationality)=c("United StatesEstados Unidos","CubaCuba","MexicoMéxico","HaitiHaití","OtherOtros")
levels(data$dem_kid_us)=c("Less than 1 yearMenos de 1 año","1-3 years1 - 3 años","4-6 years4 - 6 años","7-9 years7 - 9 años","10-12 years10 - 12 años","13-15 years13 - 15 años","More than 15 yearsMás de 15 años")
levels(data$dem_parent_job)=c("Full TimeTiempo completo","Part TimeTiempo parcial","RetiredJubilado/Retirado","UnemployedDesempleado")
levels(data$dem_parent_income)=c("Below $10,000Por debajo de $ 10,000","$10,000 - $24,999$10,000 - $24,999","$25,000 - $39,999$25,000 - $39,999","$40,000 - $54,999$40,000 - $54,999","$55,000 - $69,999$55,000 - $69,999","$70,000 - $84,000$70,000 - $84,000","Over $85,000Mas de $85,000")
levels(data$dem_parent_marital)=c("SingleSoltero","MarriedCasado","SeparatedSeparado","DivorcedDivorciado","WidowedViudo")
levels(data$dem_parent_habitants)=c("2 people2 personas","3 people3 personas","4 people4 personas","5 people5 personas","6 people6 personas","7 people7 personas","More than 7 peopleMás de 7 personas")
levels(data$dem_kid_pmhx___1)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___2)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___3)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___4)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___5)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___6)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___7)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___8)=c("Unchecked","Checked")
levels(data$dem_kid_pmhx___9)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___1)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___2)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___3)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___4)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___5)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___6)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___7)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___8)=c("Unchecked","Checked")
levels(data$dem_kid_famhx___9)=c("Unchecked","Checked")
levels(data$demographics_parent_complete)=c("Incomplete","Unverified","Complete")
levels(data$tech_parent_device)=c("smart phoneteléfono inteligente","tablettableta","both a smart phone and a tabletlos dos un teléfono inteligente y una tableta ","neitherninguno")
levels(data$tech_parent_brand___1)=c("Unchecked","Checked")
levels(data$tech_parent_brand___2)=c("Unchecked","Checked")
levels(data$tech_parent_brand___3)=c("Unchecked","Checked")
levels(data$tech_parent_brand___4)=c("Unchecked","Checked")
levels(data$tech_parent_brand___5)=c("Unchecked","Checked")
levels(data$tech_parent_brand___6)=c("Unchecked","Checked")
levels(data$tech_parent_brand___7)=c("Unchecked","Checked")
levels(data$tech_parent_os___1)=c("Unchecked","Checked")
levels(data$tech_parent_os___2)=c("Unchecked","Checked")
levels(data$tech_parent_os___3)=c("Unchecked","Checked")
levels(data$tech_parent_os___4)=c("Unchecked","Checked")
levels(data$tech_parent_os___6)=c("Unchecked","Checked")
levels(data$tech_parent_os___7)=c("Unchecked","Checked")
levels(data$tech_parent_phone_service)=c("YesSi","NoNo"," Unsure or Not ApplicableNo estoy seguro o no aplicable")
levels(data$tech_parent_disconnect)=c("1-2 times/year1-2 veces / año","3-4 times/year3-4 veces / año","More than 5 times/yearMás de 5 veces / año")
levels(data$tech_parent_apps)=c("YesSi","NoNo")
levels(data$tech_parent_function___1)=c("Unchecked","Checked")
levels(data$tech_parent_function___2)=c("Unchecked","Checked")
levels(data$tech_parent_function___3)=c("Unchecked","Checked")
levels(data$tech_parent_function___4)=c("Unchecked","Checked")
levels(data$tech_parent_function___5)=c("Unchecked","Checked")
levels(data$tech_parent_info___1)=c("Unchecked","Checked")
levels(data$tech_parent_info___2)=c("Unchecked","Checked")
levels(data$tech_parent_info___3)=c("Unchecked","Checked")
levels(data$tech_parent_info___4)=c("Unchecked","Checked")
levels(data$tech_parent_info___5)=c("Unchecked","Checked")
levels(data$tech_parent_info___6)=c("Unchecked","Checked")
levels(data$tech_parent_info___7)=c("Unchecked","Checked")
levels(data$tech_parent_info___8)=c("Unchecked","Checked")
levels(data$tech_kid_par_device)=c("smart phoneteléfono inteligente","tablettableta","both a smart phone and a tabletlos dos un teléfono inteligente y una tableta ","neitherninguno")
levels(data$tech_kid_par_brand___1)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___2)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___3)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___4)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___5)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___6)=c("Unchecked","Checked")
levels(data$tech_kid_par_brand___7)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___1)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___2)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___3)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___4)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___6)=c("Unchecked","Checked")
levels(data$tech_kid_par_os___7)=c("Unchecked","Checked")
levels(data$tech_kid_par_service)=c("YesSi","NoNo"," Unsure or Not ApplicableNo estoy seguro o no aplicable")
levels(data$tech_kid_par_disconnected)=c("1-2 times/year1-2 veces / a?questo","3-4 times/year3-4 veces / a?questo","More than 5 times/yearM?quests de 5 veces / a?questo")
levels(data$tech_kid_par_app)=c("YesSi","NoNo")
levels(data$tech_parent_privileges)=c("NeverNunca","Almost NeverCasi nunca","SometimesA veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$tech_parent_uses)=c("Not LikelyNo es probable","Somewhat LikelyUn poco probable","Very LikelyMuy Probable")
levels(data$tech_parent_complete)=c("Incomplete","Unverified","Complete")
levels(data$pedsqlparent_01)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_02)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_03)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_04)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_05)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_06)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_07)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_08)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_09)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_10)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_11)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_12)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_13)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_14)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_15)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_16)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_17)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_18)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_19)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_20)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_21)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_22)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsqlparent_23)=c("NeverNunca","Almost NeverCasi Nunca","SometimesAlgunas Veces","OftenA menudo","Almost AlwaysCasi Siempre")
levels(data$pedsql_parent_complete)=c("Incomplete","Unverified","Complete")
levels(data$act_nutri_parent01)=c("YesSi","No")
levels(data$act_nutri_parent02)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_parent03)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_parent04)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_parent05)=c("o He/she does not play video or computer games or use a computer for something that is not schoolworké/ella no juega con videojuegos de computador ni utiliza su computador para cosas que no sean de trabajo escolar","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_parent06)=c("o He/she does not watch DVDs or videos on an average school dayél/ella no ve DVDs o vídeos en un día escolar promedio","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_parent07)=c(" He/she does not watch television on an average school dayél/ella no ve DVDs o vídeos en un día escolar promedio","Less than 1 hour per dayMenos de 1 hora al día","1 hour per day1 hora por día ","2 hours per day2 horas por día ","3 hours per day3 horas por día ","4 hours per day4 horas por día","5 or more hours per day5 o mas horas por día")
levels(data$act_nutri_parent08)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias ")
levels(data$act_nutri_parent09)=c("0","1","2","3","4","5 or more5 o más")
levels(data$act_nutri_parent10)=c("YesSi","No")
levels(data$act_nutri_parent11)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias ")
levels(data$act_nutri_parent12)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_parent13)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_parent14)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_parent15)=c("NeverNunca","1-2 times per week1-2 veces por semana","3-4 times per week3-4 veces por semana","5-6 times per week5-6 veces por semana","DailyDiariamente")
levels(data$act_nutri_parent16)=c(" I did not eat fruit during the past 7 daysNo comió fruta durante los últimos 7 días"," 1 to 3 times during the past 7 days1-3 veces durante los últimos 7 días"," 4 to 6 times during the past 7 days4-6 veces durante los últimos 7 días"," 1 time per day1 vez por día"," 2 times per day2 vez por día"," 3 times per day3 vez por día"," 4 or more times per day4 veces por día o mas")
levels(data$act_nutri_parent17)=c(" I did not eat green salad during the past 7 daysNo comió ensalda verde durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent18)=c(" I did not eat potatoes during the past 7 daysNo comió papitas fritas durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent19)=c(" I did not eat carrots during the past 7 daysNo comió zanahorias durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent20)=c(" I did not eat other vegetables during the past 7 daysNo comió vegetales durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent21)=c(" I did not eat pizza during the past 7 daysNo comió pizza durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent22)=c(" I did not drink soda or pop during the past 7 daysNo bebió refrescos o soda durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent23)=c(" I did not drink diet soda or pop during the past 7 daysNo bebió refrescos o soda de dieta durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent24)=c(" I did not drink sugar-sweetened beverages  during the past 7 daysNo bebía bebidas endulzadas con azucar durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent25)=c(" I did not drink water during the past 7 daysNo bebió agua durante los últimos 7 días"," 1 to 3 times during the past 7 days1 a 3 veces durante los últimos 7 días "," 4 to 6 times during the past 7 days4 a 6 veces durante los últimos 7 días "," 1 time per day1 vez por día"," 2 times per day2 veces por día"," 3 times per day3 veces por día"," 4 or more times per day4 veces o mas por dia ")
levels(data$act_nutri_parent26)=c(" NoneNinguna"," 1/2 cup or less1/2 taza o menos"," 1/2 cup to 1 cup1/2 taza a 1 taza"," 1 to 2 cups1 a 2 tazas"," 2 to 3 cups2 a 3 tazas"," 3 to 4 cups3 a 4 tazas"," 4 or more cups4 tazas o mas")
levels(data$act_nutri_parent27)=c(" NoneNinguna"," 1/2 cup or less1/2 taza o menos"," 1/2 cup to 1 cup1/2 taza a 1 taza"," 1 to 2 cups1 a 2 tazas"," 2 to 3 cups2 a 3 tazas"," 3 to 4 cups3 a 4 tazas"," 4 or more cups4 o mas tazas")
levels(data$act_nutri_parent28)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_parent29)=c("S/he does not eat dinner at homeNo come la cena en casa"," NeverNunca"," RarelyRaramente"," SometimesA veces"," Most of the timeLa mayoría del tiempo"," AlwaysSiempre")
levels(data$act_nutri_parent30)=c(" 0 days0 dias "," 1 day1 dia"," 2 days2 dias "," 3 days3 dias "," 4 days4 dias "," 5 days5 dias "," 6 days6 dias "," 7 days7 dias ")
levels(data$act_nutri_parent31)=c(" NeverNunca"," RarelyRaramente"," SometimesA veces"," Most of the timeLa mayoria del tiempo"," AlwaysSiempre")
levels(data$physical_activity_nutrition_parent_complete)=c("Incomplete","Unverified","Complete")
levels(data$asthma_parent01___0)=c("Unchecked","Checked")
levels(data$asthma_parent01___1)=c("Unchecked","Checked")
levels(data$asthma_parent01___11)=c("Unchecked","Checked")
levels(data$asthma_parent01___00)=c("Unchecked","Checked")
levels(data$asthma_parent01___000)=c("Unchecked","Checked")
levels(data$asthma_parent01___111)=c("Unchecked","Checked")
levels(data$asthma_parent01___0000)=c("Unchecked","Checked")
levels(data$asthma_parent01___00000)=c("Unchecked","Checked")
levels(data$asthma_parent01___000000)=c("Unchecked","Checked")
levels(data$asthma_parent01___1111)=c("Unchecked","Checked")
levels(data$asthma_parent02)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent03)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent04)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent05)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent07)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent08)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent09)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent10___0)=c("Unchecked","Checked")
levels(data$asthma_parent10___00)=c("Unchecked","Checked")
levels(data$asthma_parent10___1)=c("Unchecked","Checked")
levels(data$asthma_parent10___000)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000)=c("Unchecked","Checked")
levels(data$asthma_parent10___11)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___111)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___1111)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___00000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___11111)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___000000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___0000000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent10___111111)=c("Unchecked","Checked")
levels(data$asthma_parent11___1)=c("Unchecked","Checked")
levels(data$asthma_parent11___11)=c("Unchecked","Checked")
levels(data$asthma_parent11___0)=c("Unchecked","Checked")
levels(data$asthma_parent11___111)=c("Unchecked","Checked")
levels(data$asthma_parent11___00)=c("Unchecked","Checked")
levels(data$asthma_parent11___000)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___1111)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___00000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___000000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent11___11111)=c("Unchecked","Checked")
levels(data$asthma_parent11___0000000000000000)=c("Unchecked","Checked")
levels(data$asthma_parent12)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent13)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent14)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent15)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent16)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent17)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent18)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent19)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent20)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent22)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent24)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent25)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent26)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent27)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent28)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent29)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent30)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_parent31)=c(" TrueVerdadero"," FalseFalso")
levels(data$asthma_knowledge_parent_complete)=c("Incomplete","Unverified","Complete")
levels(data$usherwood_01)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_02)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_03)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_04)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_05)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_06)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_07)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_08)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_09)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_10)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_11)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_12)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_13)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_14)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_15)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_16)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_17)=c("Not at allPara nada","A few daysPocos días","Some daysAlgunos días","Most daysLa mayoría de los días","Every dayTodos los días")
levels(data$usherwood_complete)=c("Incomplete","Unverified","Complete")
levels(data$tablet_group)=c("Yes","No")
levels(data$equipment_signout_complete)=c("Incomplete","Unverified","Complete")
levels(data$gift_receipt_complete)=c("Incomplete","Unverified","Complete")

#remove all of the non-level data

