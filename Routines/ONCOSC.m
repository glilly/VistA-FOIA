ONCOSC ;WASH ISC/SRR,MLH-CROSS TAB REPORTS ;9/29/93  11:40
 ;;2.11;ONCOLOGY;**5,24,28**;Mar 07, 1995
ST ;Start
H W !!!,?10,"CROSS TABS for Total Registry",!!
AN ;ANNUAL (call ONCOST for time frames)
 S ONCOT=1 D TF^ONCOST G EX:$D(DIRUT) S TF=ONCOS("YR"),YR=$S(TF="ALL":" ",1:" ANNUAL ") I TF'="ALL" S BYR=$P(TF,U),EYR=$P(TF,U,2),EYR=$S(BYR=EYR:EYR,1:EYR)
 S HEAD=$S(TF="ALL":"ALL",BYR=EYR:BYR,1:BYR_"-"_EYR)
CAT K DIR S DIR("A")="     Select CLASS Category",DIR(0)="SO^N:Non-Analytic;A:Analytic;T:All Cases" D ^DIR G EX:Y="^"!(Y="")
 S GP=$S(Y="A":1,Y="N":0,1:2),G=$P($P(DIR(0),";",GP+1),":",2)
 Q
TR ;TOTAL REGISTRY CROSS TABS
 S R="TR" D ST G EX:$D(DIRUT) W !!?10,"Using ICDO-SITE for Rows...Select column:",! S ROW="ICDO-SITE"
 D COL G EX:$D(DIRUT) D PER G EX:$D(DIRUT) G ASK
CR ;DETERMINE CROSS TAB
 S R="CR" D ST G EX:$D(DIRUT) D ROW G EX:$D(DIRUT) D COL G EX:$D(DIRUT) D PER G EX:$D(DIRUT) G ASK
ROW ;SELECT ROW
 K DIR S DIR("A")="     Select Row",DIR(0)="SO^1:PRIMARY SITE/GP;2:ICDO-SITE;3:ICDO-TOPOGRAPHY;4:SELECTED SITES;5:SYSTEMS;6:HISTOLOGY (ICD-O-3)" D ^DIR Q:$D(DIRUT)  S ROW=$P($P(DIR(0),";",Y),":",2) Q
COL K DIR S DIR("A")="Select Column",S="S^0:ACCESSION YEAR;1:CLASS OF CASE;2:STATUS;3:SEX;4:RACE;5:RACE-SEX;6:DX AGE-GP;7:PLACE OF BIRTH;8:MARITAL STATUS AT DX;9:STATE;10:ST-COUNTY"
 S DIR(0)=S_$S($G(GP)'=1:";11:CLASS CATEGORY;12:ALL of the ABOVE",1:";11:STAGE GROUPING-AJCC;12:TREATMENT PLAN;13:SUMMARY STAGE;14:HISTOLOGY (ICD-O-3);15:ALL of the ABOVE") K S
 D ^DIR Q:$D(DIRUT)  S C=Y,XCOL=DIR(0),COL=$P($P(XCOL,";",C+1),":",2)
 Q
PER K DIR S DIR("A")="      Percentages",DIR(0)="Y" W ! D ^DIR Q:$D(DIRUT)  S PER=$S(Y=0:"",1:1)
 Q
ASK W !!,?6,"CROSS TABS: "_ROW_" vs "_COL
 W !!?11,"TOTAL: "_$P($G(G)," ")_" Cases in Registry",!!?11,"Years: ",$G(HEAD),!!
 S DIR("A")="Conditions OK",DIR(0)="Y",DIR("B")="Yes" D ^DIR G EX:$D(DIRUT),@R:'Y
 S ONCOS("C")=$S($E(COL,1,3)="ALL":"ALL",1:COL),ONCOS("R")=ROW,ONCOS("P")=PER,ONCOS("GP")=GP I ONCOS("C")="ALL" S ONCOS("CT")=XCOL
QUE ;Template in use
 W !!?15,"QUE ('Q') report unless to 'home' device",!!
 K IO("Q") S %ZIS="Q",%ZIS("A")="     Select Device to Print Cross Tabs: " W !! D ^%ZIS S IOP=ION I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D TOT^ONCOSC1 G EX
 S ZTRTN="TOT^ONCOSC1",ZTDESC="ONCOLOGY CROSS TABS ALL",ZTSAVE("*")="" D ^%ZTLOAD K ZTSK G EX
EX ;EXIT
 K IOP,ONCOT,ONCOS,XDA,XD,N,G,TEM,PER,COL,ROW,R,%DT,BYR,EYR,GLO,OT,ROWDEF
 K HEAD,%T,GP,TF,W,YR,%ZISOS,FNAM,GBL,HLAB,RC,SX,B
 K C,CO,DIC,ER,F,GP,HEAD,I,%I,%T,XCOL,J,K,NVA,Q,SL,VA,W,X,XD0,XDG,XX,%,%X
 D ^%ZISC
 Q
