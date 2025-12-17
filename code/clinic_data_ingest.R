# This function set takes in PDF and CSV clinic data from SAMSHA and creates a flattened dataset across all available years

split_pdf <- function(document) {
  year = document[[2]]
  document = document[[1]]
  # year = as.numeric(substr(deparse(substitute(document)),8,12))
  pages <- 1:length(document)
    
   split_page <- function(x){
    page = unlist(document[[x]]) %>% as.data.frame()
    names(page) <- "text"
    x = as.character(x)
    
    # Calculate max text length
    max_text_length <- max(nchar(page$text))
    
    # Create column names and widths
    colnm <- paste0("a", 1:max_text_length)
    wid <- rep(1, max_text_length)
    names(wid) <- colnm
    
    # Separate text into columns
    mat <- page %>%
      separate_wider_position(text, widths = wid, too_few = "align_start") %>%
      mutate_at(colnm, ~as.numeric(str_replace_all(., c("[^[[:space:]]]" = "1", "[[:space:]]" = "0")))) %>%
      replace(is.na(.), 0)
    
    # Find indexes of column delimiters
    index <- mat %>%
      summarise_all(sum) %>%
      t() %>%
      as.data.frame() %>%
      mutate(
        zero = (V1 == 0),
        ind = row_number(),
        cut = cumsum(lag(zero, default = TRUE) & !zero),
        lead_n = lead(V1)
      ) %>%
      filter(zero)
    
    if (length(index$ind) > 0) {
      index <- index %>%
        add_count(cut) %>% 
        mutate(keep = case_when(
          min(n) == 1 & max(n) != 1 & n == 1 ~ 0,
          .default = 1
        )) %>%
        filter(keep==1)
    }
    
    ### 2018 has some screwed up pages because SAMSHA... 
    ## Sometimes, the column is delimited by only one space, so we wind up with really long columns with the above method.
    ## Those were identified by: df_2018 %>% mutate(n=nchar(.x)) %>% filter(n > 47) %>% select(page) %>% unique()
    #problems_2018 <- c("143","259","293","295","327","386","430","506","515","526","564","574","627","722","823","833","861","908","977","1024")
     
    if (year == 2018 & x %in% c("143","293","295","386","506","515","526","908","977","1024")) { # These guys just have columns with 1 space as a delimiter, so we handle them differently and allow for that
      index <- mat %>%
        summarise_all(sum) %>%
        t() %>%
        as.data.frame() %>%
        mutate(
          zero = (V1 == 0),
          ind = row_number(),
          cut = cumsum(lag(zero, default = TRUE) & !zero),
          lead_n = lead(V1)
        ) %>%
        filter(zero)
    }
    
    if (year == 2018 & x %in% c("259","327","430","564","627","823","861")) { # In some cases, there was just no space in between two columns. So, here we go with the lowest one (that one problem row)
      index <- mat %>%
        summarise_all(sum) %>%
        t() %>%
        as.data.frame() %>%
        mutate(
          lead_n = lead(V1),
          ind = row_number(),
          zero = 
            case_when(
              V1 == 0 ~ TRUE,
              lead_n == 1 & ind < 90 ~ TRUE,
              .default = FALSE,
            ),
          cut = cumsum(lag(zero, default = TRUE) & !zero)
        ) %>%
        filter(zero)
    }
    
    if (year == 2018 & x %in% c("574")) { # In some cases, there was just no space in between two columns, and two lines were messed up. So, here we go with the lowest two (that one problem row)
      index <- mat %>%
        summarise_all(sum) %>%
        t() %>%
        as.data.frame() %>%
        mutate(
          lead_n = lead(V1),
          ind = row_number(),
          zero = 
            case_when(
              V1 == 0 ~ TRUE,
              lead_n == 2 & ind < 90 & x == "574" ~ TRUE,
              .default = FALSE,
            ),
          cut = cumsum(lag(zero, default = TRUE) & !zero)
        ) %>%
        filter(zero)
    }
    
    # Determine number of columns
    num_cols <- length(unique(index$cut))+1 # If index is empty because there are no column "cuts", this will give 1 column. Otherwise it will yield 2 columns if 1 cut, 3 if 2 cuts.
    doc_col1 <- NA
    doc_col2 <- NA
    doc_col3 <- NA
    
    if(
      length(mat[1,]) <= 50 |
      year == 2005 & x == "630" |
      year == 2015 & x == "211" |
      year == 2013 & x == "176" |
      year == 2013 & x == "183" |
      year == 2010 & x == "127" |
      year == 2005 & x == "112" |
      year == 2009 & x == "186" |
      year == 2007 & x == "180" |
      year == 2005 & x == "286" |
      year == 2007 & x == "245" |
      year == 2011 & x == "488" |
      year == 2005 & x == "148" |
      year == 2017 & x == "1065" |
      year == 2005 & x == "391" |
      year == 2005 & x == "358" |
      year == 2009 & x == "348" |
      year == 2012 & x == "341" |
      year == 2009 & x == "570" |
      year == 2014 & x == "529" |
      year == 2010 & x == "654" |
      year == 2015 & x == "784" |
      year == 2014 & x == "29"
    ) {
      num_cols <- 1 # These guys had weird formatting (long, spaces, etc., didn't play well with my code above using the matrix operation)
    }
    
    # Extract text columns
    if(num_cols == 1) {
      doc_col1 <- substr(page$text,1,max(nchar(page$text)))
      doc_col2 <- NA
      doc_col3 <- NA
    }
    
    if(num_cols == 2) {
      doc_col1 <- substr(page$text,1,min(index$ind[index$cut==min(index$cut)]))
      doc_col2 <- substr(page$text,max(index$ind[index$cut==min(index$cut)])+1,max(nchar(page$text)))
      doc_col3 <- NA
    }
    
    if(num_cols == 3) {
      doc_col1 <- substr(page$text,1,min(index$ind[index$cut==min(index$cut)]))
      doc_col2 <- substr(page$text,max(index$ind[index$cut==min(index$cut)])+1,min(index$ind[index$cut==max(index$cut)]))
      doc_col3 <- substr(page$text,max(index$ind[index$cut==max(index$cut)])+1,max(nchar(page$text)))
    }
    
    # Manually fixing the pages which had no consistent delimiting
    # if (year == 2005 & x == "630") {
    #   doc_col1[1] <- "South Texas Council on Alc/Drug Abuse"
    #   doc_col2[1] <- ""
    # }
    # 
    # if (year == 2015 & x == "211") {
    #   doc_col1[12] <- "Salvation Army Lighthouse Recovery Ctr"
    #   doc_col2[12] <- ""
    # }
    #   
    
    if (year == 2014 & x == "300") {
      doc_col3[62] <- ""
    }
    
    if (year == 2014 & x == "529") {
      doc_col3[44] <- ""
    }  
    
    if (year == 2018 & x == "47") {
      doc_col2[69] <- "Hot Springs National Park, Arkansas 71901"
      doc_col2[70] <- ""
    }
    
    if (year == 2017 & x == "1167") { # This one had their name split across 2 pages??
      doc_col3[93] <- ""
    }
    if (year == 2017 & x == "1168") {
      doc_col1[1] <- "Palmetto Lowcountry Behavioral Health"
    }
    
    if (year == 2014 & x == "178") { # This one had their name split across 2 pages??
      doc_col3[89] <- ""
    }
    if (year == 2014 & x == "179") {
      doc_col1[1] <- "Positive Solutions Family Enrichment Services Inc"
    }
    
    if (year == 2018 & x == "83") {
      doc_col3[14] <- ""
      doc_col3[13] <- "Suite A" # These people can't spell
    }
    
    if (year == 2018 & x == "574") {
      doc_col2[10] <- "FSA MD MI PI SF SI ⑪ SS ⑫ AD DV TRMA XA"
      doc_col3[10] <- "TWFA ⑧ PVT ⑨ STMH ⑩ FSA MC MD MI PI"
      doc_col2[39] <- "DB UBN ⑥ BWN MPD ⑦ ANG BIA CBT RELP"
      doc_col3[39] <- "Phone: (662) 494-7060"
    }
    
    if (year == 2018 & x %in% "722") { # I'm just copying this one in manually, it's all messed up
      doc_col1 <- c("New Choices Recovery Center","OP","302 State Street","Schenectady, New York 12305","Phone: (518) 348-7968","Intake: (518) 346-4436x2","① SA ② ODT OMB OP ORT ④ BU NU ⑤","RPN UBN ⑥ ACM BWN BWON MPD NXN","VTRL ⑦ ANG CBT CMI DBT MOTI REBT","RELP SACA TRC ⑧ PVT ⑨ STAG ⑩ MD PI SF","⑪ PA SS ⑫ CJ CO DV MN TRMA WN XA ⑬","CSAA ISC ⑭ BABA DAUT HIVT SHC SMHD","SSA TBS ⑮ ACC DP ⑯ AOSS CM DVFP HS","SHG SSD TA ⑰ ADD TGD ⑲ EMP FCO GCO","HAEC HEOH ICO SAE TAEC ⑳ STU TCC ㉑","SMON ㉒ ADLT CHLD ㉓ FEM MALE ㉔ DU","㉕ SP","New Choices Recovery Center","OP 1","846 State Street","Schenectady, New York 12307","Phone: (518) 382-7838","① SA ② OMB OP ORT ④ BU ⑤ BUM UBN ⑥","BWN BWON ⑦ ANG BIA CBT MOTI REBT","RELP SACA TRC TWFA ⑧ PVT ⑨ STAG ⑩","MD PI SF ⑪ SS ⑫ AD CJ CO MN TRMA WN ⑬","CSAA ⑭ BABA DAUT SSA ⑮ ACC DP ⑲ EMP","FCO GCO ICO MCO SAE ㉑ SMON ㉒ ADLT","CHLD YAD ㉓ FEM MALE","New Choices Recovery Center","Perrin House","575 Lansing Street","Schenectady, New York 12303","Phone: (518) 346-4509","Intake: (518) 346-4436","① HH SA ② RES RL ④ BU ⑤ MOA ⑥ ACM","BWN BWON MPD NXN ⑦ ANG BIA CBT CMI","CRV DBT MOTI REBT RELP SACA TRC TWFA","⑧ PVT ⑨ STAG ⑩ FSA MC MD SF ⑫ CJ CO","DV GL HV MF PW TAY TRMA VET WN XA ⑬","CMHA CSAA ⑭ BABA DAUT HIVT SHC","SMHD SSA ⑮ ACC DP ⑯ AOSS CM DVFP HS","MHS SHG SSD TA ⑲ EMP FCO GCO HAEC","HEOH ICO MCO SAE TAEC ⑳ NRT NSC STU","TCC ㉑ SMON ㉒ ADLT YAD ㉓ FEM","Purcell House CR","406-408 Summit Avenue","Schenectady, New York 12307","Phone: (518) 346-5548","Intake: (518) 256-9669","① HH SA ② RES RL ⑤ MOA ⑦ ANG BIA","CBT MOTI REBT RELP SACA TWFA ⑧ PVT ⑨","STAG ⑩ FSA SF ⑪ SS ⑫ MN ⑬ CSAA ⑭","BABA DAUT SMHD SSA ⑮ DP ⑯ AOSS CM","HS PEER SSD TA ⑲ EMP GCO ICO SAE ⑳","STU ㉑ SMON ㉒ ADLT YAD ㉓ MALE")
      doc_col2 <- c("Saint Peters Addiction Recovery Ctr","(SPARC)/Alcoholism Outpatient Clinic","2925 Hamburg Street","Schenectady, New York 12303","Phone: (518) 357-2909","① SA ② OIT OMB OP ORT ③ GH ④ BU NU","⑤ BUM UBN ⑥ ACM BWN BWON DSF MPD","NXN VTRL ⑦ ANG BIA CBT DBT MOTI REBT","RELP SACA TRC ⑧ PVT ⑨ JC STAG ⑩ MD PI","SF SI ⑫ CJ CO MN WN ⑬ CSAA ⑭ BABA","DAUT HIVT SHC SMHD SSA ⑮ ACC DP ⑯","CM MHS SSD TA ⑲ FCO GCO HEOH ICO","MCO SAE ⑳ NRT NSC STU TCC ㉑ SMON ㉒","ADLT YAD ㉓ FEM MALE","SEAFORD","Southeast Nassau Guidance Ctr (SNG)","2146 Jackson Avenue","Seaford, New York 11783","Phone: (516) 679-9800","① SA ② OMB OP ORT ④ BU NU ⑤ BUM","RPN UBN ⑥ ACM BWN BWON DSF MPD","NXN ⑦ ANG BIA CBT CMI DBT MOTI MXM","REBT RELP SACA TRC ⑧ PVT ⑨ JC STAG ⑩","MC MD MI PI SF SI ⑪ SS ⑫ ADM CJ CO DV","GL HV MF MN PW SE TAY TRMA VET WN XA","⑬ CMHA CSAA ISC ⑭ BABA DAUT SMHD","SSA TBS ⑮ DP ⑯ AOSS CM MHS ⑰ TGD ⑲","EMP FCO GCO HEOH ICO MCO SAE TAEC ⑳","NRT NSC STU TCC ㉑ SMON ㉒ ADLT YAD","㉓ FEM MALE ㉔ DU","SMITHTOWN","Employee Assistance Resource Servs Inc","(EARS)/Drug Abuse Outpatient","278 East Main Street","Smithtown, New York 11787","Phone: (631) 361-6960","① DT SA ② OD OIT OMB OP ORT ④ BU NU","⑤ BMW BUM DB PAIN RPN UBN ⑥ ACM","BWN BWON MPD VTRL ⑦ BIA CBT DBT","REBT RELP SACA TRC TWFA ⑧ PVT ⑨ STAG","⑩ MC MD MI PI SF SI ⑫ AD ADM CJ CO DV","GL MF MN SE TAY TRMA VET WN XA ⑬","CMHA CSAA ⑭ BABA DAUT SMHD SSA ⑮","ACC DP ⑯ HS MHS ⑰ TGD ⑱ ADTX BDTX","CDTX MDTX ODTX ⑲ FCO GCO ICO MCO","SAE ⑳ NRT STU TCC ㉑ SMON ㉒ ADLT","CHLD YAD ㉓ FEM MALE ㉔ DU ㉕ FX SP ㉖","F35","Town of Smithtown/Horizons Counseling","161 East Main Street","Smithtown, New York 11787","Phone: (631) 360-7578","① SA ② OMB OP ORT ④ BU ⑤ BUM UBN ⑥","BWN MPD NXN ⑦ ANG CBT CMI MOTI","MXM RELP SACA TWFA ⑧ LCCG ⑨ STAG ⑩","FSA MC MD PI SF SI ⑪ SS ⑫ AD CJ MN TAY","WN ⑬ CMHA CSAA OPC ⑭ BABA DAUT","SMHD SSA ⑮ ACC DP ⑯ AOSS ⑲ EMP FCO","GCO HAEC ICO MCO SAE ⑳ STU TCC ㉑","SMON ㉒ ADLT CHLD ㉓ FEM MALE ㉔ DU")
      doc_col3 <- c("WellLife Network OP 1","11 Route 111","Floor 1","Smithtown, New York 11787","Phone: (631) 920-8300","Intake: (631) 920-8324","① SA ② OMB OP ORT ④ BU NU ⑤ BUM","RPN UBN ⑥ ACM BWN BWON DSF MPD","NXN VTRL ⑦ ANG BIA CBT CMI MOTI MXM","REBT RELP SACA TRC TWFA ⑧ PVT ⑨ STAG","⑩ FSA MC MD PI SF SI ⑫ AD ADM CJ CO DV","GL HV MF MN PW SE TAY TRMA VET WN XA","⑬ CMHA CSAA ISC OPC ⑭ BABA DAUT","SMHD SSA ⑮ ACC DP ⑯ AOSS CM DVFP HS","MHS SSD ⑲ EMP FCO GCO HAEC HEOH ICO","MCO SAE TAEC ⑳ NRT NSC STU TCC ㉑","SMON ㉒ ADLT CHLD ㉓ FEM MALE ㉔ DU","SOUTH OZONE PARK","Faith Mission","Crisis Center Inc","114-40 Van Wyck Expressway","South Ozone Park, New York 11420","Phone: (718) 322-3455x106","Intakes: (718) 322-3455 (855) 322-2323","① DT HH SA ② RD RES RS ⑤ MOA ⑥ MPD","⑦ ANG BIA CBT CRV DBT MOTI REBT RELP","SACA TRC TWFA ⑧ PVT ⑨ STAG STDH","STMH ⑩ FSA NP ⑪ PA ⑫ CJ CO DV GL HV","MN SE TAY TRMA VET WN XA ⑬ CMHA","CSAA OPC ⑭ BABA DAUT HIVT SMHD SSA","STDT ⑮ ACC DP ⑯ AOSS CM EIH HS MHS","SHG SSD TA ⑰ TGD ⑱ ADTX CDTX MDTX","ODTX ⑲ GCO HAEC ICO SAE TAEC ⑳ NRT","NSC STU TCC ㉑ SMON ㉒ ADLT YAD ㉓","FEM MALE ㉕ FX ㉖ F19","SPRINGVILLE","Spectrum Human Services","Springville Human Services Center","27 Franklin Street","Springville, New York 14141","Phone: (716) 592-9301","Intake: (716) 539-5500","① SA ② OP ORT ④ BU ⑤ MOA ⑥ BSDM ⑦","CMI RELP SACA TRC ⑧ PVT ⑨ STAG STDH","STMH ⑩ FSA MC MD MI PI SF ⑪ SS ⑬","CMHA CSAA ⑭ DAUT SMHD SSA ⑮ DP ⑯","CM MHS ⑲ FCO GCO ICO ⑳ STU ㉑ SMON","㉒ ADLT CHLD ㉓ FEM MALE","STATEN ISLAND","Amethyst House Inc","CD Community Residence","280 Richmond Terrace","Staten Island, New York 10301","Phone: (718) 448-1900","① HH SA ② RES RL ⑤ MOA ⑦ ANG BIA","CBT DBT MOTI RELP SACA TRC TWFA ⑧","PVT ⑨ STAG STDH STMH ⑩ FSA SF ⑫ CJ","CO DV GL HV MF SE TRMA VET WN XA ⑬","CSAA ⑭ BABA DAUT SMHD SSA ⑮ DP ⑯","AOSS CM HS PEER SHG SSD TA ⑲ FCO GCO","HAEC HEOH ICO SAE TAEC ⑳ STU TCC ㉑","SMON ㉒ ADLT YAD ㉓ FEM ㉕ SP")
    }
    
    if (year == 2018 & x == "750") {
      doc_col1[41] <- "Phone: (828) 595-9558" # These people just straight up only put in part of their phone number
    }
    
    if (year == 2018 & x %in% "833") { # I'm just copying this one in manually, it's all messed up
      doc_col1 <- c("Deer Creek/Adolescent Trt Center","2064 Douglas Street SE","Roseburg, Oregon 97470","Phone: (541) 673-5119","① SA ② RES RL RS ⑤ MOA ⑥ MPD ⑦ ANG","BIA CBT CMI DBT MOTI RELP SACA TRC","TWFA ⑧ PVT ⑨ STAG STDH STMH ⑩ FSA","PI SF SI ⑪ SS ⑫ AD CO TRMA ⑬ CMHA ⑭","DAUT SMHD ⑮ DP ⑯ AOSS DVFP EIH MHS","SHG SSD ⑲ FCO GCO HAEC HEOH ICO SAE","TAEC ⑳ STU TCC ㉑ SMON ㉒ CHLD ㉓","FEM MALE","ADAPT","Madrone","621 West Madrone Street","Roseburg, Oregon 97470","Phone: (541) 672-2691","① SA ② OIT OP ORT ⑤ MOA ⑦ ANG BIA","CBT MOTI RELP SACA TRC TWFA ⑧ PVT ⑨","STAG STMH ⑩ FSA MD PI SF SI ⑪ SS ⑫ CJ","CO PW TRMA WN ⑬ CSAA ISC ⑭ BABA","DAUT SMHD SSA ⑮ ACC DP ⑯ AOSS CM HS","MHS PEER SHG SSD TA ⑰ TGD ⑲ FCO GCO","ICO SAE ⑳ STU TCC ㉑ SMON ㉒ ADLT YAD","㉓ FEM MALE ㉔ DU ㉕ AH","ADAPT","The Crossroads","3099 Diamond Lake Boulevard NE","Roseburg, Oregon 97470","Phone: (541) 673-3469","Intakes: (541) 492-0222 (541) 673-","3469x1506","① DT SA ② CT RD RES RS ④ BU NU ⑤ DB","RPN UBN ⑥ ACM BWN BWON MPD NXN ⑦","ANG BIA CBT CMI CRV DBT MOTI MXM","REBT RELP SACA TRC ⑧ PVT ⑨ STAG ⑩","ATR FSA MD SF SI ⑪ PA SS ⑫ CO DV MN PW","TRMA WN ⑬ CMHA CSAA ISC OPC ⑭ BABA","DAUT HIVT SHB SHC SMHD SSA STDT TBS","⑮ ACC DP ⑯ AOSS CCC CM DVFP EIH HS","MHS PEER SHG SSD TA ⑱ ADTX BDTX","CDTX MDTX ODTX ⑲ EMP FCO GCO HAEC","HEOH ICO MCO SAE TAEC ⑳ NRT NSC STU","TCC ㉑ SMON ㉒ ADLT YAD ㉓ FEM MALE","Cow Creek Health and Wellness Ctr","North","2371 North East Stephens Street","Suite 200","Roseburg, Oregon 97470","Phone: (541) 672-8533","Intake: (541) 839-1345x2402","① SA ② OP ORT ④ NU ⑤ MOA RPN UBN ⑥","ACM DSF MPD NXN VTRL ⑦ ANG BIA CBT","CMI DBT MOTI MXM REBT RELP SACA TRC","TWFA ⑧ TBG ⑨ STAG STMH ⑩ FSA ITU","MC MD PI SF SI ⑫ CO TRMA ⑬ CMHA CSAA","ISC OPC ⑭ DAUT HIVT SHB SHC SMHD SSA","STDT TBS ⑮ ACC DP ⑯ AOSS CM DVFP EIH","HS MHS PEER SHG SSD TA ⑰ ADD ⑲ EMP","FCO GCO HAEC HEOH ICO MCO SAE TAEC","⑳ NRT NSC STU TCC ㉑ SMON ㉒ ADLT","CHLD ㉓ FEM MALE")
      doc_col2 <- c("Serenity Lane","Roseburg","2575 NW Kline Street","Roseburg, Oregon 97471","Phone: (541) 673-3504","① SA ② OIT OP ORT ⑤ MOA NMOA ⑦","ANG BIA CBT CMI DBT MOTI RELP SACA","TWFA ⑧ PVT ⑨ CARF JC STAG ⑩ ITU MD","PI SF SI ⑬ CMHA CSAA ISC ⑭ BABA DAUT","SMHD SSA ⑮ ACC DP ⑯ CM MHS PEER SHG","SSD TA ⑲ FCO GCO ICO SAE ⑳ STU ㉑","SMON ㉒ ADLT YAD ㉓ FEM MALE ㉔ DU","VA Roseburg Healthcare System","913 NW Garden Valley Boulevard","Roseburg, Oregon 97471","Phone: (541) 440-1000","Intakes: (541) 440-1000x44635 (800) 549-","8387","① DT SA ② OD OIT OP ORT RD RES RS ③","GH ④ BU NU ⑤ BUM RPN UBN ⑥ BWN","MPD ⑦ ANG BIA CBT DBT MOTI RELP SACA","TRC TWFA ⑧ VAMC ⑨ CARF HLA JC ⑩ FSA","MI PI SF ⑫ CO MN PW SE TRMA VET XA ⑬","CMHA CSAA ISC OPC ⑭ BABA DAUT HIVT","SHB SHC SMHD SSA STDT TBS ⑮ ACC DP ⑯","AOSS CM DVFP HS MHS PEER SHG SSD TA ⑱","ADTX BDTX CDTX MDTX ODTX ⑲ EMP","FCO GCO HAEC HEOH ICO MCO SAE TAEC","⑳ NRT NSC STU TCC ㉑ SMPD ㉒ ADLT","CHLD YAD ㉓ FEM MALE","SAINT HELENS","Columbia Community Mental Health","Alcohol and Drug Outpatient","58646 McNulty Way","P.O. Box 1234","Saint Helens, Oregon 97051","Phone: (503) 397-5211","Intake: (503) 438-2200","① SA ② ODT OIT OP ORT ⑤ MOA ⑥ MPD","⑦ ANG BIA CBT CMI CRV DBT MOTI MXM","RELP SACA TRC TWFA ⑧ PVT ⑨ STAG","STMH ⑩ FSA MC MD MI PI SF SI ⑪ SS ⑫ AD","CJ CO DV MN TRMA WN XA ⑬ CMHA CSAA","ISC OPC ⑭ BABA DAUT SMHD SSA ⑮ ACC","DP ⑯ AOSS CM DVFP HS MHS PEER SHG SSD","⑰ TGD ⑲ EMP FCO GCO ICO MCO SAE ⑳","STU TCC ㉑ SMON ㉒ ADLT CHLD ㉓ FEM","MALE ㉔ DU ㉕ AH")
      doc_col3 <- c("Columbia Community Mental Health","Pathways Residential","185 North 4th Street","Saint Helens, Oregon 97051","Phone: (503) 366-4540","Intakes: (503) 366-4540x11 (503) 366-","4540x14","① DT SA ② HI HID HIT ODT OIT OP ORT","RD RES RL RS ④ BU ⑤ MOA ⑥ BWN ⑦ ANG","BIA CBT DBT MOTI MXM RELP SACA TRC","TWFA ⑧ PVT ⑨ STAG ⑩ FSA MD PI SF ⑫ CJ","MN WN ⑬ CSAA ⑭ BABA DAUT SSA TBS ⑮","ACC DP ⑯ AOSS CM DVFP HS MHS PEER","SHG SSD ⑰ TGD ⑱ ADTX CDTX MDTX","ODTX ⑲ FCO GCO HAEC HEOH ICO MCO","SAE TAEC ⑳ NRT STU TCC ㉑ SMON ㉒","ADLT YAD ㉓ FEM MALE ㉕ AH","Inner Journey Healing Arts Center","161 Saint Helens Street","Suite 102","Saint Helens, Oregon 97051","Phone: (971) 777-0756","Intake: (503) 410-9209","① SA ② OIT OP ORT ⑤ MOA ⑦ BIA CBT","DBT MOTI RELP SACA TRC TWFA ⑧ PVT ⑨","STAG STDH ⑩ ATR MD MI PI SF SI ⑪ SS ⑫","CJ DV GL MN PW TAY TRMA WN ⑬ CSAA","ISC OPC ⑭ DAUT SMHD SSA ⑮ ACC DP ⑯","CM HS PEER SSD ⑲ FCO GCO HAEC HEOH","ICO MCO SAE TAEC ⑳ STU TCC ㉑ SMPD ㉒","ADLT YAD ㉓ FEM MALE ㉔ DU","SALEM","Amazing Treatment","525 Ferry Street SE","Suite 203","Salem, Oregon 97301","Phone: (503) 363-6103","Intake: (503) 930-6744","① SA ② CT ODT OIT OMB OP ORT ④ BU ⑤","BMW MOA UBN ⑥ BWN BWON ⑦ BIA CBT","CMI CRV MOTI MXM REBT RELP SACA","TWFA ⑧ PVT ⑨ STAG ⑩ ATR ITU MC MI PI","SF SI ⑪ PA SS ⑫ AD CJ GL MN PW SE TAY","TRMA WN ⑬ CSAA ISC OPC ⑭ BABA DAUT","SHB SMHD SSA ⑮ ACC DP ⑯ AOSS CM HS","PEER SHG SSD TA ⑲ EMP FCO GCO HAEC","HEOH ICO MCO SAE TAEC ⑳ STU TCC ㉑","SMON ㉒ ADLT CHLD ㉓ FEM MALE ㉔ DU","㉕ AH FX SP ㉖ F70 F81","Bridgeway Recovery Services","3325 Harold Drive","Salem, Oregon 97305","Phone: (503) 363-2021","① SA ② OIT OP ORT ④ BU ⑤ BUM MOA","PAIN UBN ⑥ BWN DSF MPD ⑦ ANG BIA","CBT CMI DBT MOTI MXM RELP SACA TRC","TWFA ⑧ PVT ⑨ STAG STDH STMH ⑩ FSA","MD PI SF SI ⑪ PA SS ⑫ CO MN TAY TRMA","WN ⑬ CMHA CSAA ISC ⑭ DAUT SMHD SSA","⑮ ACC DP ⑯ AOSS CM HS MHS PEER SHG","SSD TA ⑲ FCO GCO HAEC HEOH ICO MCO","SAE ⑳ NRT STU TCC ㉑ SMON ㉒ ADLT","CHLD ㉓ FEM MALE ㉔ DU ㉕ AH")
    }
    
    out <- c(doc_col1,doc_col2,doc_col3) # Drop empty strings, concat into single value array
    return(out)
    }
 
   out <- lapply(pages,split_page)
   
   df <- map_df(out, ~as.data.frame(.x), .id="page") %>% 
     mutate(year = year) %>%
     mutate(text = trimws(gsub(" s "," ",.x))) %>%
     filter(!is.na(text)) %>%
     filter(nchar(text) > 0) # Convert array into dataframe

   return(df)
}

extract_pdfs <- function(year){
  directory = paste0("data/directory/directory_",year,".pdf")
  ## Set text mining parameters ####
  read <- tm::readPDF(engine = "pdftools", control = list(text = "-layout"))
  #year = as.numeric(substr(directory,nchar(directory)-7,nchar(directory)-4))
  file = substr(directory,16,nchar(directory))
  
    document <- Corpus(URISource(directory),
                       readerControl = list(reader = read))
    doc <- document[[file]][["content"]]
    
      # Keep only pages which have the data of interest, split line breaks
    # Identify the first page with records (the first page containing the text "For Code Definitions")
    doc_filter <- doc[grepl("For Code Definitions",doc)] %>% str_split("\n")
    ## Remove header, footer, and empty rows ####
    doc_filter <- lapply(doc_filter,function(x) x[!grepl("For Code Definitions",x)]) #Footer text
    doc_filter <- doc_filter[doc_filter != ""] #Empty rows
    doc_filter  <- lapply(doc_filter,function(x) x[!grepl('^[[:space:]]{0,}$',x)])
    doc_filter <- lapply(doc_filter,function(x) x[!grepl('^\\s{0,}(ALABAMA|ALASKA|ARIZONA|AMERICAN SAMOA|ARKANSAS|CALIFORNIA|COLORADO|CONNECTICUT|DELAWARE|DISTRICT OF COLUMBIA|FEDERATED STATES OF MICRONESIA|MICRONESIA|FLORIDA|GEORGIA|GUAM|HAWAII|IDAHO|ILLINOIS|INDIANA|IOWA|KANSAS|KENTUCKY|LOUISIANA|MAINE|MARYLAND|MASSACHUSETTS|MARSHALL ISLANDS|MICHIGAN|MINNESOTA|MISSISSIPPI|MISSOURI|MONTANA|NEBRASKA|NEVADA|NEW HAMPSHIRE|NEW JERSEY|NEW MEXICO|NEW YORK|NORTH CAROLINA|NORTH DAKOTA|COMMONWEALTH OF THE NORTHERN MARIANA ISLANDS|NORTHERN MARIANA IS|OHIO|OKLAHOMA|OREGON|PENNSYLVANIA|PUERTO RICO|REPUBLIC OF PALAU|RHODE ISLAND|SOUTH CAROLINA|SOUTH DAKOTA|TENNESSEE|TEXAS|UTAH|VERMONT|VIRGINIA|VIRGIN ISLANDS|WASHINGTON|WEST VIRGINIA|WISCONSIN|WYOMING|District of Columbia|New York|Virgin Islands|Rhode Island|Maine|Connecticut|US Armed Forces Europe|Delaware|Virginia|West Virginia|South Carolina|Florida|Tennessee|Kentucky|Indiana|Iowa|Minnesota|North Dakota|Illinois|Kansas|Louisiana|Oklahoma|Colorado|Idaho|Arizona|Nevada|US Armed Forces Pacific|American Samoa|Palau|Northern Mariana Islands|Oregon|Alaska|Puerto Rico|Massachusetts|New Hampshire|Vermont|New Jersey|Pennsylvania|Washington, D.C.|Maryland|North Carolina|Georgia|Alabama|Mississippi|Ohio|Michigan|Wisconsin|South Dakota|Montana|Missouri|Nebraska|Arkansas|Texas|Wyoming|Utah|New Mexico|California|Hawaii|Guam|Federated States of Micronesia|Micronesia|Marshall Islands|Washington)\\s{0,}$',x,perl=TRUE)]) # Delete rows which only have a state name-- these are the delimiters between state pages!
    doc_filter <- lapply(doc_filter,function(x) x[!grepl("National Directory of",x)]) #Title page sometimes retained
    doc_filter <- doc_filter[sapply(doc_filter, length) >0] #Empty rows

    names(doc_filter) <- seq_along(doc_filter)
    doc_out <- list(
      doc_filter,
      year
    )
    return(doc_out)
}

import_keys <- function(directory) {
  keylist = list.files(directory,pattern="\\.csv$")
  keys_df = do.call(rbind,lapply(paste0(directory,"/",keylist), read_csv)) 
  keys <- format_delim(dplyr::distinct(as.data.frame(keys_df$Key)),delim="",col_names = F, eol = "|") # This leaves a trailing "|" delimiter
  keys <- substr(keys,1,nchar(keys)-1) # Trimming that extra delim
}

load_city_names <- function(file){
  # Identify the rows which are just the US City delimiters
  cities_df <- read_delim(file,delim="|")
  
  cities <- cities_df %>% transmute(city = toupper(City), drop = 1) %>% distinct() %>% 
    filter(city %in% c("OP","HS","JC","SS","SF") == F)
  
  return(cities)
}

tag_clinics <- function(df,keys,cities){
  key_grep <- paste0("grepl('^((s?\\\\s?F?\\\\s?",keys,")((\\\\s)|(\\\\s?\\\\.\\\\s?){1,}|(\\\\s?F\\\\s?){1,}|(\\\\s?s\\\\s?){1,}){0,}){1,}$',df$text,perl=TRUE)") # Creating the Regex that will identify the keys
  df$type <- case_when(
    grepl('  |  ||♦||①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|⑪|⑫|⑬|⑭|⑮|⑯|⑰|⑱|⑲|⑳|㉑|㉒|㉓|㉔|㉕|㉖|㉗|㉘|㉙|㉚|㉛',df$text,perl=TRUE) == TRUE ~ "Key", # Weird delimiters used only in keys
    grepl('^s .{0,}$',df$text,perl=TRUE) == TRUE ~ "Key", #In 2014, "s" was the delimiter sometimes, so strings that start with "s " are keys 
    grepl('^F [^Building][^Wing].{0,}$',df$text,perl=TRUE) == TRUE ~ "Key", #In 2007, "F" was the delimiter sometimes, so strings that start with "F " are keys 
    eval(parse(text = key_grep)) == TRUE ~ "Key", # Identifying keys using the dictionary imported
    grepl('Only',df$text) == TRUE ~ "Note",
    grepl('(WWW\\.)|(www\\.)|(\\.org)|(\\.gov)|(\\.htm)|(\\.com)|(\\.asp)|(\\.php)|(\\.mil)|(\\.ivnu)|(\\.cfm)|(careyexternalweb)|(\\.net)|(\\.shtml)',df$text) == TRUE ~ "URL",
    grepl('^.{1,}, [A-Z]{2} [0-9]{5,}$',df$text) == TRUE ~ "CityState",
    grepl('^.{1,}, (Northern Mariana Is|Republic of Palau|U.S. Virgin Islands|District of Columbia|New York|Virgin Islands|Rhode Island|Maine|Connecticut|US Armed Forces Europe|Delaware|Virginia|West Virginia|South Carolina|Florida|Tennessee|Kentucky|Indiana|Iowa|Minnesota|North Dakota|Illinois|Kansas|Louisiana|Oklahoma|Colorado|Idaho|Arizona|Nevada|US Armed Forces Pacific|American Samoa|Palau|Northern Mariana Islands|Oregon|Alaska|Puerto Rico|Massachusetts|New Hampshire|Vermont|New Jersey|Pennsylvania|Washington, D.C.|Maryland|North Carolina|Georgia|Alabama|Mississippi|Ohio|Michigan|Wisconsin|South Dakota|Montana|Missouri|Nebraska|Arkansas|Texas|Wyoming|Utah|New Mexico|California|Hawaii|Guam|Federated States of Micronesia|Micronesia|Marshall Islands|Washington) [0-9]{5,}$',df$text) == TRUE ~ "CityState",
    grepl('^Hotline',df$text) == TRUE ~ "Phone",
    grepl('^(Intake)(s){0,1}:',df$text) == TRUE ~ "Phone",
    grepl('\\({0,1}\\d{3}\\){0,1}[\\s|\\-]\\d{3}[\\s|\\-]\\d{4}',df$text,perl=TRUE) == TRUE ~ "Phone",
    grepl('^\\(?[0-9]{3}\\)? ?[A-Z]{7,8}x{0,1}.{0,}$',df$text,perl=TRUE) == TRUE ~ "Phone",
    grepl('^(\\([0-9]{3}\\)(\\ ?|\\-?)([A-Z]|[0-9]){7}\\ ?){1,}$',df$text,perl=TRUE) == TRUE ~ "Phone",
    grepl('^(\\([0-9]{3}\\)(\\ ?|\\-?)([A-Z]|[0-9]){3}\\-([A-Z]|[0-9]){4}\\ ?){1,}$',df$text,perl=TRUE) == TRUE ~ "Phone",
    grepl('^([0-9]{4}x([0-9]{1,}|[A-Z]{1,}).{0,})$',df$text,perl=TRUE) == TRUE ~ "Phone", # Phone partial
    grepl('^\\([0-9]{3}\\)(\\ ?|\\-?)([0-9]|[A-Z]){3}\\-?\\ ?$',df$text,perl=TRUE) == TRUE ~ "Phone", # Phone partial
    grepl('Barrio ',df$text,perl=TRUE) == TRUE ~ "Address", # Puerto Rican addresses start with Barrio and weren't being caught...
    grepl('^([^0-9]*)$',df$text) == TRUE ~ "Name", # Anything remaining which is a string that has no numbers in it is probably a name
    grepl('Team Management 2000 Inc',df$text) == TRUE ~ "Name", # This one clinic has a weird name and is screwing up my code
    .default = "Address" # Anything not assigned yet is the street address line 1 or 2, hopefully
  )
  
  df <- df %>% ungroup() %>% mutate(order = row_number())
  df_merge <- merge(df,cities,by.x="text",by.y="city",all.x = TRUE) %>% # Here we merge the cities dataframe with the main dataframe, and then filter out the rows which are city names only and get improperly tagged.
    filter(is.na(drop)) %>% # Filter out the rows which are city names only and get improperly tagged.
    arrange(order)
  df <- df_merge %>% select(-c("order","drop"))
  
  return(df)
}

group_clinics <- function(df,cities){
  ## Separate Individual DTCs ####
  ## We know that a DTC will always start with a name, and end with a key, so we can delimit using that
  df$clinic_id <- NA
  
  # I will now loop down the rows, and when I see "key" as the type, I will increment the ID
  # Update, I vectorized it and it cut the time from 2 hours to 1 second. Hahahahaha
  df <- df %>%
    mutate(
      clinic_id = cumsum(lag(type == "Key", default = TRUE) & type != "Key" )
    ) %>%
    group_by(clinic_id) %>%
    mutate(
      row = row_number(),
      type = case_when(
        row == 1 ~ "Name", # Clinic observations always start with a name!!
        .default = type
      )
    )
  
  # A couple edge cases, where clinics in 2008 did not list any services, so their keys can't be used to divide them. They are manually given IDs. 
  df <- df %>%
    mutate(
      clinic_id = case_when(
        ((text == "McKees Rocks") & (year == 2008) & lead(text == "Next Step Foundation") ) == TRUE ~ 4197800,
        ((text == "Next Step Foundation") & (year == 2008) & lead(text == "641 Broadway") ) == TRUE ~ 4197800,
        ((text == "641 Broadway") & (year == 2008) & lag(text == "Next Step Foundation") ) == TRUE ~ 4197800,
        ((text == "McKees Rocks, PA 15136") & (year == 2008) & lag(text == "641 Broadway") ) == TRUE ~ 4197800,
        ((text == "(877) 508-2800") & (year == 2008) & lag(text == "McKees Rocks, PA 15136") ) == TRUE ~ 4197800,
        ((text == "Jubilee House Ministry") & (year == 2008) & lead(text == "2705 Chestnut Avenue") ) == TRUE ~ 3668600,
        ((text == "2705 Chestnut Avenue") & (year == 2008) & lag(text == "Jubilee House Ministry") ) == TRUE ~ 3668600,
        ((text == "Fort Wayne, IN 46803") & (year == 2008) & lag(text == "2705 Chestnut Avenue") ) == TRUE ~ 3668600,
        ((text == "(260) 422-2908") & (year == 2008) & lag(text == "Fort Wayne, IN 46803")) == TRUE ~ 3668600,
        ((text == "Mental Health Center of Champaign Cnty") & (year == 2008) & lead(text == "Times Center") ) == TRUE ~ 3610900,
        ((text == "Times Center") & (year == 2008) & lag(text == "Mental Health Center of Champaign Cnty") ) == TRUE ~ 3610900,
        ((text == "70 East Washington Street") & (year == 2008) & lag(text == "Times Center") ) == TRUE ~ 3610900,
        ((text == "Champaign, IL 61820") & (year == 2008) & lag(text == "70 East Washington Street") ) == TRUE ~ 3610900,
        ((text == "(217) 398-7785") & (year == 2008) & lag(text == "Champaign, IL 61820") ) == TRUE ~ 3610900,      
        .default = clinic_id
      )
    )
  
  # Now, we will clean up mis-tagged columns. For instance, addresses never follow phone numbers. Also some keys were mistagged.
  df <- df %>%
    group_by(clinic_id) %>%
    mutate(
      row = row_number(),
      type = case_when(
        (type == "Key" & row < 4) == TRUE ~ "Name",# Beth Israel hospital decided it would be a great idea to name their treatment centers including key values like "OP" "HH" "IP" in them, so we need to classify them as names, not keys. We fix this by reclassifying any "Key" in the first 3 rows of a clinic observation as a name, given that there can be up to three rows of Names, and an address must always follow between Name and Key, so we know with certainty this is NOT a Key in row < 4.
        .default = type
      )) %>%
    select(-c(row)) %>% # Re-assign clinic ids because we fixed the keys. This WILL change the above assigned IDs.
    ungroup() %>%
    select(-clinic_id) %>%
    mutate(
      clinic_id = cumsum(lag(type == "Key", default = TRUE) & type != "Key" )
    )
  
  df <- df %>%
    group_by(clinic_id) %>%
    mutate(
      row = row_number(),
      name_cnt = cumsum((type == "Name")),
      key_cnt = cumsum((type == "Key")),
      addr_cnt = cumsum((type == "Address")),
      url_cnt = cumsum((type == "URL")),
      phone_cnt = cumsum((type == "Phone")),
      citst_cnt = cumsum((type == "CityState")),
      type = case_when(
        (phone_cnt > 0 & addr_cnt > 0 & type == "Address" & lag(type == "Phone")) == TRUE ~ "Phone", # If there is already an address and a phone, and it is marked "Address" and below a phone, it is not an address and is likely a phone partial
        (phone_cnt > 0 & name_cnt > 0 & type == "Name" & lag(type == "Phone")) == TRUE ~ "Phone", # If there is already a name and a phone, and it is marked "Name" and below a phone, it is not an Name and is likely a phone partial
        (url_cnt > 0 & name_cnt > 0 & type == "Name" & lag(type == "URL")) == TRUE ~ "URL", # If there is already a name and a URL, and it is marked "Name" and below a URL, it is not an Name and is likely a URL partial
        (addr_cnt == 0 & type == "Name" & lead(type == "CityState")) == TRUE ~ "Address", # If there is no address yet, and the next record is a CityState, we have an address field here, not a name.
        (addr_cnt > 0 & name_cnt > 0 & type == "Name" & lag(type == "Address")) == TRUE ~ "Address", # If there is already a name and a address, and it is marked "Name" and below a phone, it is not an Name and is likely a phone partial
        (addr_cnt > 0 & name_cnt > 0 & type == "Name" & lag(type == "Address")) == TRUE ~ "Address", # Running this one twice
        .default = type
      )) %>%
    select(
      -c(name_cnt,addr_cnt,phone_cnt,citst_cnt,url_cnt,key_cnt,row)
    )
  
  df <- df %>% # Because we changed the IDs by index above we need to reassign these keyless clinics their ids again
    mutate(
      clinic_id = case_when(
        ((text == "McKees Rocks") & (year == 2008) & lead(text == "Next Step Foundation") ) == TRUE ~ 4197800,
        ((text == "Next Step Foundation") & (year == 2008) & lead(text == "641 Broadway") ) == TRUE ~ 4197800,
        ((text == "641 Broadway") & (year == 2008) & lag(text == "Next Step Foundation") ) == TRUE ~ 4197800,
        ((text == "McKees Rocks, PA 15136") & (year == 2008) & lag(text == "641 Broadway") ) == TRUE ~ 4197800,
        ((text == "(877) 508-2800") & (year == 2008) & lag(text == "McKees Rocks, PA 15136") ) == TRUE ~ 4197800,
        ((text == "Jubilee House Ministry") & (year == 2008) & lead(text == "2705 Chestnut Avenue") ) == TRUE ~ 3668600,
        ((text == "2705 Chestnut Avenue") & (year == 2008) & lag(text == "Jubilee House Ministry") ) == TRUE ~ 3668600,
        ((text == "Fort Wayne, IN 46803") & (year == 2008) & lag(text == "2705 Chestnut Avenue") ) == TRUE ~ 3668600,
        ((text == "(260) 422-2908") & (year == 2008) & lag(text == "Fort Wayne, IN 46803")) == TRUE ~ 3668600,
        ((text == "Mental Health Center of Champaign Cnty") & (year == 2008) & lead(text == "Times Center") ) == TRUE ~ 3610900,
        ((text == "Times Center") & (year == 2008) & lag(text == "Mental Health Center of Champaign Cnty") ) == TRUE ~ 3610900,
        ((text == "70 East Washington Street") & (year == 2008) & lag(text == "Times Center") ) == TRUE ~ 3610900,
        ((text == "Champaign, IL 61820") & (year == 2008) & lag(text == "70 East Washington Street") ) == TRUE ~ 3610900,
        ((text == "(217) 398-7785") & (year == 2008) & lag(text == "Champaign, IL 61820") ) == TRUE ~ 3610900,      
        .default = clinic_id
      )
    )
  
  df_ids <- df %>% ungroup() %>% mutate(order = row_number()) #Change to a new df in case we need to step back for troubleshooting
  
  # Grouping consecutive rows with the same clinic_id
  df_ids_grouped <- df_ids %>%
    filter(type == "Key") %>%
    group_by(clinic_id, grp = cumsum(type != lag(type, default = first(type)))) %>%
    mutate(text = paste(text, collapse = " ")) %>%
    ungroup() %>%
    select(-grp) %>%
    bind_rows(df_ids %>% filter(type != "Key")) %>%
    arrange(order) %>%
    select(-order)
  
  # Below code merges all run=on text fields, but we want to be able to parse out address1 name2 phone2 etc
  # df_ids <- df_ids %>%
  #   group_by(clinic_id, grp = cumsum(type != lag(type, default = first(type)))) %>%
  #   mutate(text = paste(text, collapse = " ")) %>%
  #   ungroup() %>%
  #   select(-grp)
  
  # Removing duplicate rows
  df_ids_grouped <- df_ids_grouped %>%
    distinct()
  
  # Reshape Long-Wide ####  
  df_wide <- df_ids_grouped %>%
    #  filter(is.na(drop)) %>%
    #  select(-drop) %>%
    group_by(clinic_id,type) %>%
    mutate(row = row_number(),
           type = paste0(type,row)) %>%
    ungroup() %>%
    tidyr::pivot_wider(id_cols = c("clinic_id","year","page"), names_from = "type", values_from = "text") %>%
    select(
      page,year,clinic_id,Name1,Name2,Name3,Name4,Name5,Address1,Address2,Address3,Address4,CityState1,Phone1,Phone2,Phone3,Phone4,Phone5,URL1,URL2,Note1,Key1
    )
  
  
  ## Tidy up the address columns
  ## Some addresses did not feed in correctly, as their town names were lowercase and counted as names, shifting everything over. Fixing here.
  
  # These were shifted to have Address4 included:
  df_wide$Name1[!is.na(df_wide$Address4)] <- df_wide$Address1[!is.na(df_wide$Address4)]
  df_wide$Name2[!is.na(df_wide$Address4)] <- df_wide$Address2[!is.na(df_wide$Address4)]
  df_wide$Address1[!is.na(df_wide$Address4)] <- df_wide$Address3[!is.na(df_wide$Address4)]
  df_wide$Address2[!is.na(df_wide$Address4)] <- df_wide$Address4[!is.na(df_wide$Address4)]
  df_wide$Address3[!is.na(df_wide$Address4)] <- NA
  df_wide$Address4[!is.na(df_wide$Address4)] <- NA
  
  # These were shifted to have Address3 included:
  df_wide$Name2[!is.na(df_wide$Address3)] <- df_wide$Address1[!is.na(df_wide$Address3)]
  df_wide$Address1[!is.na(df_wide$Address3)] <- df_wide$Address2[!is.na(df_wide$Address3)]
  df_wide$Address2[!is.na(df_wide$Address3)] <- df_wide$Address3[!is.na(df_wide$Address3)]
  df_wide$Address3[!is.na(df_wide$Address3)] <- NA
  df_wide$Address4[!is.na(df_wide$Address3)] <- NA
  
  # These start with a weird character, so need to be categorized as names:
  df_wide$Name2[grepl("ULOC",df_wide$Address1,perl = TRUE)] <- df_wide$Address1[grepl("ULOC",df_wide$Address1,perl = TRUE)]
  df_wide$Address1[grepl("ULOC",df_wide$Address1,perl = TRUE)] <- df_wide$Address2[grepl("ULOC",df_wide$Address1,perl = TRUE)] # Some of these guys don't have an address in the raw data-- this will hopefully get resolved in geocoding and linkage, but TBD.
  df_wide$Address2[grepl("ULOC",df_wide$Address1,perl = TRUE)] <- NA
  
  # Some ZIP codes were split accross rows, so these are fixed and pasted together here
  df_wide$CityState1[!is.na(df_wide$Address3) & grepl(",", df_wide$Address2) & nchar(df_wide$Address3) == 5] <- paste0(df_wide$Address2[!is.na(df_wide$Address3) & grepl(",", df_wide$Address2) & nchar(df_wide$Address3) == 5]," ",df_wide$Address3[!is.na(df_wide$Address3) & grepl(",", df_wide$Address2) & nchar(df_wide$Address3) == 5])
  df_wide$Address2[!is.na(df_wide$Address3) & grepl(",", df_wide$Address2) & nchar(df_wide$Address3) == 5] <- NA
  df_wide$Address3[!is.na(df_wide$Address3) & is.na(df_wide$Address2) & nchar(df_wide$Address3) == 5] <- NA
  
  ## Clean up records with misformatted City/State values (Did not parse from Address1/Address2)
  df_wide$Fix <- 0
  df_wide$Fix[is.na(df_wide$CityState1) & nchar(df_wide$Address2) == 5] <- 1
  df_wide$CityState1[df_wide$Fix==1] <- paste(df_wide$Address1[df_wide$Fix==1],df_wide$Address2[df_wide$Fix==1],sep=" ")
  df_wide$Address1[df_wide$Fix==1] <- df_wide$Name2[df_wide$Fix==1]
  df_wide$Name2[df_wide$Fix==1] <- NA
  df_wide$Address2[df_wide$Fix==1] <- NA
  df_wide$Address3[df_wide$Fix==1] <- NA
  
  df_wide$Fix <- 0
  df_wide$Fix[is.na(df_wide$CityState1) & nchar(df_wide$Address2) > 0] <- 1
  df_wide$CityState1[df_wide$Fix==1] <- substr(df_wide$Address2[df_wide$Fix==1],1,(nchar(df_wide$Address2[df_wide$Fix==1])-1))
  df_wide$Address1[df_wide$Fix==1] <- substr(df_wide$Address1[df_wide$Fix==1],1,(nchar(df_wide$Address1[df_wide$Fix==1])-1))
  df_wide$Address2[df_wide$Fix==1] <- NA
  
  # For the NYC groups that wisely put key values in their names [ >:( ], we need to identify those and shift the columns around
  # Helpfully, these all start with a number in Name3!
  #df_wide$Address1[!is.na(df_wide$Name3) & grepl("^[0-9]", df_wide$Name3)] <- df_wide$Name3[!is.na(df_wide$Name3) & grepl("^[0-9]", df_wide$Name3)] 
  #df_wide$Name3[!is.na(df_wide$Name3) & grepl("^[0-9]", df_wide$Name3)] <- NA
  
  ## Tidy up Name columns
  # These were shifted to have no name
  #df_wide$Name1[is.na(df_wide$Name1)] <- df_wide$Name3[is.na(df_wide$Name1)]
  #df_wide$Name2[df_wide$Name1 == df_wide$Name3 & !is.na(df_wide$Name4)] <- df_wide$Name4[df_wide$Name1 == df_wide$Name3 & !is.na(df_wide$Name4)]
  #df_wide$Name3[df_wide$Name1 == df_wide$Name3] <- NA
  #df_wide$Name4[df_wide$Name1 == df_wide$Name3] <- NA
  
  # These got split weirdly, making Name6
  #df_wide$Address1[!is.na(df_wide$Name6)] <- df_wide$Name5[!is.na(df_wide$Name6)]
  #df_wide$Address2[!is.na(df_wide$Name6)] <- df_wide$Name6[!is.na(df_wide$Name6)]
  #df_wide$Name5[!is.na(df_wide$Name6)] <- NA
  #df_wide$Name6[!is.na(df_wide$Name6)] <- NA
  
  # These got split weirdly, making Name5
  df_wide$Name1[!is.na(df_wide$Name5) & df_wide$Name3 == "Medically"] <- paste0(df_wide$Name2[!is.na(df_wide$Name5) & df_wide$Name3 == "Medically"]," ",df_wide$Name3[!is.na(df_wide$Name5) & df_wide$Name3 == "Medically"]," ",df_wide$Name4[!is.na(df_wide$Name5) & df_wide$Name3 == "Medically"])
  df_wide$Address2[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)] <- df_wide$Address1[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)]
  df_wide$Address1[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)] <- df_wide$Name5[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)]
  df_wide$Name3[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)] <- NA
  df_wide$Name4[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)] <- NA
  df_wide$Name5[df_wide$Name1 == "Madison Cnty MH Prog/ADAPT Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name5)] <- NA
  
  # Same, but different columns
  df_wide$Name2[!is.na(df_wide$Name4) & df_wide$Name2 == "Medically"] <- paste0(df_wide$Name2[!is.na(df_wide$Name4) & df_wide$Name2 == "Medically"]," ",df_wide$Name3[!is.na(df_wide$Name4) & df_wide$Name2 == "Medically"])
  df_wide$Address2[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)] <- df_wide$Address1[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)]
  df_wide$Address1[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)] <- df_wide$Name4[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)]
  df_wide$Name3[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)] <- NA
  df_wide$Name4[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)] <- NA
  df_wide$Name5[df_wide$Name2 == "Medically Supervised Chemical Dependence OP Serv" & !is.na(df_wide$Name4)] <- NA
  
  # With Name4, we will now shift based on having "Building" in the Address1 column, or "Street" in the Name4 column
  # df_wide$Address2[grepl("^Building", df_wide$Address1) & !is.na(df_wide$Name4)] <- 
  
  
  # Now to deal with most of the remaining "Name 4" units-- if Name4 is not missing, and the Name1 contains a city name ONLY, we drop and shift over left.
  df_wide$Fix <- 0
  df_wide$Fix[(toupper(df_wide$Name1) %in% cities$city)] <- 1
  df_wide$Name1[df_wide$Fix == 1 & !is.na(df_wide$Name2)] <- df_wide$Name2[df_wide$Fix == 1 & !is.na(df_wide$Name2)]
  df_wide$Name2[df_wide$Fix == 1 & !is.na(df_wide$Name3)] <- df_wide$Name3[df_wide$Fix == 1 & !is.na(df_wide$Name3)]
  df_wide$Name3[df_wide$Fix == 1 & !is.na(df_wide$Name4)] <- df_wide$Name4[df_wide$Fix == 1 & !is.na(df_wide$Name4)]
  df_wide$Name3[df_wide$Fix == 1 & df_wide$Name2 == df_wide$Name3] <- NA
  df_wide$Name2[df_wide$Fix == 1 & df_wide$Name1 == df_wide$Name2 & is.na(df_wide$Name3)] <- NA
  df_wide$Name4[df_wide$Fix == 1] <- NA
  
  # Now, if Name2 or Name3 end in Road or Street, and Address1 starts with a character, we will shift things over.
  df_wide$Fix <- 0
  df_wide$Fix[grepl("((Road)|(Street))$", df_wide$Name2) & is.na(df_wide$Name3) & grepl("^[^0-9]",df_wide$Address1)] <- 1
  df_wide$Address3[df_wide$Fix == 1] <- df_wide$Address2[df_wide$Fix == 1]
  df_wide$Address2[df_wide$Fix == 1] <- df_wide$Address1[df_wide$Fix == 1]
  df_wide$Address1[df_wide$Fix == 1] <- df_wide$Name2[df_wide$Fix == 1]
  df_wide$Name2[df_wide$Fix == 1] <- NA
  
  df_wide$Fix <- 0
  df_wide$Fix[grepl("((Road)|(Street))$", df_wide$Name3) & is.na(df_wide$Name4) & grepl("^[^0-9]",df_wide$Address1)] <- 1
  df_wide$Address3[df_wide$Fix == 1] <- df_wide$Address2[df_wide$Fix == 1]
  df_wide$Address2[df_wide$Fix == 1] <- df_wide$Address1[df_wide$Fix == 1]
  df_wide$Address1[df_wide$Fix == 1] <- df_wide$Name3[df_wide$Fix == 1]
  df_wide$Name3[df_wide$Fix == 1] <- NA
  
  # Lastly, for Name4 and Address1, a couple edge cases
  df_wide$Address2[grepl("Edinboro University", df_wide$Name3)] <- df_wide$Address1[grepl("Edinboro University", df_wide$Name3)]
  df_wide$Address1[grepl("Edinboro University", df_wide$Name3)] <- df_wide$Name3[grepl("Edinboro University", df_wide$Name3)]
  df_wide$Name3[grepl("Edinboro University", df_wide$Name3)] <- NA
  
  ## Clean up Phone numbers
  df_wide$Phone4[grepl("^\\(",df_wide$Phone5)] <- paste(df_wide$Phone4[grepl("^\\(",df_wide$Phone5)],df_wide$Phone5[grepl("^\\(",df_wide$Phone5)],sep=", ")
  df_wide$Phone4[grepl("^[^\\(]",df_wide$Phone5)] <- paste0(df_wide$Phone4[grepl("^[^\\(]",df_wide$Phone5)],df_wide$Phone5[grepl("^[^\\(]",df_wide$Phone5)])
  df_wide$Phone3[grepl("^\\(|Hotl",df_wide$Phone4)] <- paste(df_wide$Phone3[grepl("^\\(|Hotl",df_wide$Phone4)],df_wide$Phone4[grepl("^\\(|Hotl",df_wide$Phone4)],sep=", ")
  df_wide$Phone3[grepl("^[^\\(|Hotl]",df_wide$Phone4)] <- paste0(df_wide$Phone3[grepl("^[^\\(|Hotl]",df_wide$Phone4)],df_wide$Phone4[grepl("^[^\\(|Hotl]",df_wide$Phone4)])
  df_wide$Phone2[grepl("^\\(|Hotl",df_wide$Phone3)] <- paste(df_wide$Phone2[grepl("^\\(|Hotl",df_wide$Phone3)],df_wide$Phone3[grepl("^\\(|Hotl",df_wide$Phone3)],sep=", ")
  df_wide$Phone2[grepl("^[^\\(|Hotl]",df_wide$Phone3)] <- paste0(df_wide$Phone2[grepl("^[^\\(|Hotl]",df_wide$Phone3)],df_wide$Phone3[grepl("^[^\\(|Hotl]",df_wide$Phone3)])
  
  # There remain 113 Clinics where the Name1 field is blank because there was no street address in the PDF, just "Name" then "CityState", and as we classify the row immediately preceeding CityState as Address, Name is emptied. Here we move those back.
  df_wide$Name1[is.na(df_wide$Name1) & !is.na(df_wide$Address1) & !grepl("^[0-9]",df_wide$Address1)] <- df_wide$Address1[is.na(df_wide$Name1) & !is.na(df_wide$Address1) & !grepl("^[0-9]",df_wide$Address1)]
  
  # Lastly, there were 7 clinics whose names were all-caps town names elsewhere in the country, so they got erased in the cleaning process. Fixing manually here.
  df_wide <- df_wide %>%
    mutate(Name1 = case_when(
      year %in% c(2005:2007) & Address1 == "325 North 1st Street" ~ "PAX",
      year %in% c(2005:2006) & Address1 == "202 East Mohave Street" ~ "MICA",
      year %in% c(2005:2006) & Address1 == "1595 Bailey Avenue" ~ "STAR",
      .default = Name1
    )
    )
  
  # There are still 2 records that have text in Name4 (clinic IDs 90858 and 110669), but the text is duplicated and not needed-- it will be dropped as a variable in the next step
  
  ## Remove now empty columns after cleaning
  df_wide <- df_wide %>% select(-c(Address3,Address4,
                                   Name4,Name5,
                                   Phone3,Phone4,Phone5,Fix))
  
  return(df_wide)
}

csv_clinics <- function(df){
  ## Merge in the 2022 & 2023 csv provided data
  # Import the CSVs, append together
  csv_dir <- read_xlsx("data/directory/National_Directory_SA_Facilities_2022.xlsx",sheet = "Facilities List",col_types = "text", skip = 1, col_names = c("Name1","Name2","Street1", "Street2", "City","State","Zip","Phone","Intake1","Intake2","Intake1a","Intake2a","Service_code_info")) %>%
    mutate(year = "2022") %>%
    bind_rows(
      read_xlsx("data/directory/national-directory-su-facilities-2023.xlsx",sheet = "Facilities List",col_types = "text") %>% mutate(year = "2023")
    ) %>%
    bind_rows(
      read_xlsx("data/directory/National Directory SU 2024_Final.xlsx",sheet = "Facilities List",col_types = "text") %>% mutate(year = "2024")
    ) %>%
    mutate_at(c("Phone","Intake1","Intake1a","Intake2","Intake2a"), ~str_replace_na(.,"")) %>%  
    mutate(Source = "CSV",
           clinic_id = 100000+row_number(),
           Name3 = "",
           Phone1 = Phone,
           Phone2 = paste(Intake1,Intake1a,Intake2,Intake2a,sep=", "),
           URL1 = "",
           URL2 = "",
           Note1 = ""
    ) %>%
    rename(Key1 = Service_code_info) %>%
    select(year,Source,clinic_id,Name1,Name2,Name3,Street1,Street2,City,State,Zip,Phone1,Phone2,URL1,URL2,Note1,Key1) %>%
    mutate(year = as.numeric(year))
  
  return(csv_dir)
}

all_clinics_merge <- function(pdf_merged,csv_merged){
  # Make the columns the same between the CSV and PDF sourced data
  df_wide_prepared <- pdf_merged %>%
    filter(year < 2022) %>%
    rename(Street1 = Address1,
           Street2 = Address2) %>%
    mutate(Source = "PDF",
           City = str_extract(CityState1,".+(?=\\,)"),
           State = str_extract(CityState1,"(?<=\\, ).+(?= [0-9]{5})"),
           Zip = str_extract(CityState1,"[0-9]{5}")) %>%
    select(year,Source,clinic_id,Name1,Name2,Name3,Street1,Street2,City,State,Zip,Phone1,Phone2,URL1,URL2,Note1,Key1) %>%
    bind_rows(csv_merged) %>%
    mutate(
      State = case_when(     # And finally, we will make the State abbreviations consistent across years (some were spelled out, some were abbreviated)
        State == "AK" ~ "Alaska",
        State == "AL" ~ "Alabama",
        State == "AR" ~ "Arkansas",
        State == "AZ" ~ "Arizona",
        State == "CA" ~ "California",
        State == "CNMI" | State == "MP" ~ "Northern Mariana Is",
        State == "CO" ~ "Colorado",
        State == "CT" ~ "Connecticut",
        State == "DC" ~ "District of Columbia",
        State == "DE" ~ "Delaware",
        State == "FL" ~ "Florida",
        State == "FM" | State == "FSM" ~ "Micronesia",
        State == "GA" ~ "Georgia",
        State == "GU" ~ "Guam",
        State == "HI" ~ "Hawaii",
        State == "IA" ~ "Iowa",
        State == "ID" ~ "Idaho",
        State == "IL" ~ "Illinois",
        State == "IN" ~ "Indiana",
        State == "KS" ~ "Kansas",
        State == "KY" ~ "Kentucky",
        State == "LA" ~ "Louisiana",
        State == "MA" ~ "Massachusetts",
        State == "MD" ~ "Maryland",
        State == "ME" ~ "Maine",
        State == "MI" ~ "Michigan",
        State == "MN" ~ "Minnesota",
        State == "MO" ~ "Missouri",
        State == "MS" ~ "Mississippi",
        State == "MT" ~ "Montana",
        State == "NC" ~ "North Carolina",
        State == "ND" ~ "North Dakota",
        State == "NE" ~ "Nebraska",
        State == "NH" ~ "New Hampshire",
        State == "NJ" ~ "New Jersey",
        State == "NM" ~ "New Mexico",
        State == "NV" ~ "Nevada",
        State == "NY" ~ "New York",
        State == "OH" ~ "Ohio",
        State == "OK" ~ "Oklahoma",
        State == "OR" ~ "Oregon",
        State == "PA" ~ "Pennsylvania",
        State == "PR" ~ "Puerto Rico",
        State == "PW" ~ "Republic of Palau",
        State == "RI" ~ "Rhode Island",
        State == "SC" ~ "South Carolina",
        State == "SD" ~ "South Dakota",
        State == "TN" ~ "Tennessee",
        State == "TX" ~ "Texas",
        State == "UT" ~ "Utah",
        State == "VA" ~ "Virginia",
        State == "Virgin Islands" | State == "USVI" | State == "VI" ~ "U.S. Virgin Islands",
        State == "VT" ~ "Vermont",
        State == "WA" ~ "Washington",
        State == "WI" ~ "Wisconsin",
        State == "WV" ~ "West Virginia",
        State == "WY" ~ "Wyoming",
        .default = State
      )) %>%
    unite(., col = "Name_Combine",  Name1, Name2, Name3, na.rm=TRUE, sep = " ", remove = FALSE) %>%
    unite(., col = "Address_Combine",  Street1, Street2, na.rm=TRUE, sep = " ", remove = FALSE) %>%
    unite(., col = "NameAddress_Combine", Name1, Name2, Name3, Street1, Street2, na.rm=TRUE, sep = " ", remove = FALSE)
  
  return(df_wide_prepared)
}

assign_keys <- function(df){
  df_wide_prepared <- df

  df_wide_prepared$Key <- str_squish(str_replace_all(df_wide_prepared$Key1, "[^(\\-|[:alnum:])]", " ")) # First, strip out all non-alphanumeric or non-hyphen characters
  df_wide_prepared$Key <- str_squish(str_replace_all(df_wide_prepared$Key, "[ s ]", " ")) # Some delimeters are letters, like a lowercase "s", so remove those
  df_wide_prepared$Key[df_wide_prepared$Key == ")) -"] <- "" # Special case not caught by regex
  df_wide_prepared$Key[df_wide_prepared$Key == ")) FEM"] <- "FEM" # Special case not caught by regex
  df_wide_prepared$Key[df_wide_prepared$Key == ")) MALE"] <- "MALE" # Special case not caught by regex
  
  split <- str_split_fixed(df_wide_prepared$Key," ",160) # Split out all keys into columns-- we split into 160 columns as the clinic with the most keys had 160 keys
  
  df_keys <- cbind(df_wide_prepared,split)%>%
    select(clinic_id,year,21:180) %>%
    pivot_longer(cols = 4:162) %>%
    filter(value != "" & value != "F" & value != "s") %>%
    mutate(contained = 1) %>%
    distinct(clinic_id,year,value,contained) %>%
    select(clinic_id,year,value,contained) %>%
    pivot_wider(id_cols=c(clinic_id,year),names_from=value,values_from=contained,values_fill = 0)
  
  df_wide_keyed <- merge(df_wide_prepared,df_keys,all.x = T) %>% select(-c(Key1)) %>%
    rename(Keys = Key)
  
  return(df_wide_keyed)
}

clinic_years_summary <- function(df){
  df_wide_keyed <- df
  # NSSATS Official Facility Counts
  # Source: https://www.samhsa.gov/data/sites/default/files/2009_nssats_rpt.pdf (Page 38)
  # Source 2: https://www.samhsa.gov/data/sites/default/files/reports/rpt35313/2020_NSSATS_FINAL.pdf (Page 44)
  
  nssats_counts <- data.frame(
    year = 2005:2024,
    official_count = c("13371","13771","13648","13688","13513","13339","13720","14311","14148","14152","13873","14399","13585","14809","15961","16066","16448","12176","12744","13074")
  )
  
  r_count <- df_wide_keyed %>% group_by(year) %>% tally()
  
  counts <- merge(r_count,nssats_counts) %>%
    # filter(year <= 2021) %>% # SAMSHA changed methodology in 2022, so there is a big delta in amount
    mutate(
      official_count = as.numeric(official_count),
      error = (official_count-n)/official_count*100
    )
  
  out <- list()
    out$counts_compare <- counts
    out$counts_compary_summary <- summary(counts$error)
    out$count_year <- df_wide_keyed %>% group_by(year) %>% tally()

  return(out)
}
