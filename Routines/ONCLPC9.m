ONCLPC9 ;Hines OIFO/GWB - 2001 Lung (NSCLC) PCE Study ;05/16/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Print 
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-4),IE=ONCONUM
 S CMC=$$GET1^DIQ(165.5,IE,1400.6) ;LNG CO-MORBID CONDITIONS Y/N
 S TC=$$GET1^DIQ(165.5,IE,1426.5)  ;LNG TREATMENT COMPLICATIONS Y/N
 K LINE S $P(LINE,"-",40)="-"
I S TABLE="PATIENT INFORMATION"
 D HEAD^ONCLPC0
 K LINE S $P(LINE,"-",19)="-"
 W !?4,TABLE,!?4,LINE
ITEM1 W !," 1. CO-MORBID CONDITIONS:"
 D P Q:EX=U
 I CMC="No" D  G CMC2
 .W !,"     CO-MORBID CONDITION #1.......: 000.00 No co-morbidities"
 W !,"     CO-MORBID CONDITION #1.......: ",$P($$GET1^DIQ(165.5,IE,1400)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400)," ",2,99)
CMC2 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #2.......: ",$P($$GET1^DIQ(165.5,IE,1400.1)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400.1)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #3.......: ",$P($$GET1^DIQ(165.5,IE,1400.2)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400.2)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #4.......: ",$P($$GET1^DIQ(165.5,IE,1400.3)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400.3)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #5.......: ",$P($$GET1^DIQ(165.5,IE,1400.4)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400.4)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #6.......: ",$P($$GET1^DIQ(165.5,IE,1400.5)," ",1),?44,$P($$GET1^DIQ(165.5,IE,1400.5)," ",2,99)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM2 W !," 2. DURATION OF TOBACCO USE.......: ",$$GET1^DIQ(165.5,IE,1401)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM3 W !," 3. PERSONAL HISTORY OF OTHER"
 D P Q:EX=U
 W !,"     INVASIVE MALIGNANCIES PRIOR"
 D P Q:EX=U
 W !,"      TO THIS CANCER DIAGNOSIS....: ",$$GET1^DIQ(165.5,IE,1403)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G II
 D P Q:EX=U
II S TABLE="TUMOR IDENTIFICATION AND DIAGNOSIS"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCLPC0
 K LINE S $P(LINE,"-",34)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
ITEM4 W !," 4. SYMPTOMS PRESENT AT INITIAL DIAGNOSIS:"
 D P Q:EX=U
 W !,"     COUGH........................: ",$$GET1^DIQ(165.5,IE,1404)
 D P Q:EX=U
 W !,"     SHORTNESS OF BREATH..........: ",$$GET1^DIQ(165.5,IE,1404.1)
 D P Q:EX=U
 W !,"     WEIGHT LOSS..................: ",$$GET1^DIQ(165.5,IE,1404.2)
 D P Q:EX=U
 W !,"     HEMOPTYSIS...................: ",$$GET1^DIQ(165.5,IE,1404.3)
 D P Q:EX=U
 W !,"     PALPABLE LYMPH NODES.........: ",$$GET1^DIQ(165.5,IE,1404.4)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM5 W !," 5. SCREENING FOR HIGH RISK/ASYMPTOMATIC PRESENTATION:"
 D P Q:EX=U
 W !,"     CHEST X-RAY..................: ",$$GET1^DIQ(165.5,IE,1405)
 D P Q:EX=U
 W !,"     CT SCAN......................: ",$$GET1^DIQ(165.5,IE,1405.1)
 D P Q:EX=U
 W !,"     BRONCHOSCOPY.................: ",$$GET1^DIQ(165.5,IE,1405.2)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G ITEM6
 W !
 D P Q:EX=U
ITEM6 W !," 6. INITIAL DIAGNOSTIC STUDIES (PRE-THERAPY):"
 D P Q:EX=U
 W !,"     HISTORY AND PHYSICAL.........: ",$$GET1^DIQ(165.5,IE,1406)
 D P Q:EX=U
 W !,"     BRONCHOSCOPY.................: ",$$GET1^DIQ(165.5,IE,1406.1)
 D P Q:EX=U
 W !,"     FNAB.........................: ",$$GET1^DIQ(165.5,IE,1406.2)
 D P Q:EX=U
 W !,"     MEDIASTINOSCOPY..............: ",$$GET1^DIQ(165.5,IE,1406.3)
 D P Q:EX=U
 W !,"     THOROCOTOMY/OPEN BIOSPY......: ",$$GET1^DIQ(165.5,IE,1406.4)
 D P Q:EX=U
 W !,"     VATS.........................: ",$$GET1^DIQ(165.5,IE,1406.5)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y
 I IOST?1"C".E D HEAD^ONCLPC0
 D ^ONCLPC9A
KILL ;
 K CS,CSDAT,CSI,CSPNT,DESC,DESC1,DESC2,DLC,DOFCT
 K EX,IE,LIN,LINE,LOS,NOP,ONCOLST,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCLPC0 Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCLPC9",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Lung (NSCLC) PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
