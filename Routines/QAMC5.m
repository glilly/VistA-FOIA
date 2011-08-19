QAMC5 ;HISC/DAD-CONDITION: MAS MOVEMENT TYPE GROUP ;9/3/93  13:21
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 ; *** CONDITION CODE
 S QAMTRANS=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:+^("P1"),1:0)
 Q:(QAMTRANS<1)!(QAMTRANS>7)  S QAMXREF="AMV"_QAMTRANS
 S QAMGRPD0=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:+^("P2"),1:0)
 F QAMOVEDT=(QAMTODAY-.0000001):0 S QAMOVEDT=$O(^DGPM(QAMXREF,QAMOVEDT)) Q:QAMOVEDT'>0!(QAMOVEDT>(QAMTODAY+.9999999))!(QAMOVEDT\1'?7N)  F QAMDFN=0:0 S QAMDFN=$O(^DGPM(QAMXREF,QAMOVEDT,QAMDFN)) Q:QAMDFN'>0  D LOOP1
 K QAMTRANS,QAMGRPD0,QAMOVEDT,QAMOVED0,QAMXREF,QAMOVETY
 Q
LOOP1 F QAMOVED0=0:0 S QAMOVED0=$O(^DGPM(QAMXREF,QAMOVEDT,QAMDFN,QAMOVED0)) Q:QAMOVED0'>0  D LOOP2
 Q
LOOP2 I QAMGRPD0 S QAMOVETY=+$S($D(^DGPM(QAMOVED0,0))#2:$P(^(0),"^",18),1:0) Q:$O(^QA(743.5,QAMGRPD0,"GRP","AB",QAMOVETY,0))'>0
 S ^UTILITY($J,"QAM CONDITION",QAMD1,QAMDFN)="",^(QAMDFN,QAMOVEDT)=QAMOVED0
 Q
EN2 ; *** PARAMETER CODE
 K DIR,DIRUT S DIR(0)="POA^405.3:AEMNQZ",DIR("A")="MAS MOVEMENT TRANSACTION TYPE: ",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:$P(^("P1"),"^",2),1:"") K:DIR("B")="" DIR("B")
 S DIR("?")="Enter the MAS transaction type of interest."
 S QAMPARAM="P1" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P1")=+Y_"^"_Y(0,0),QAMY(0,0)=Y(0,0)
 I $D(^QA(743,QAMD0,"COND",QAMD1,"P1"))[0 K ^QA(743,QAMD0,"COND",QAMD1,"P2") S Y=-1 G Y
2 K DIC,DIR,DIRUT S DIC=743.5,DIC(0)="EMNQZ",DIC("S")="I $P(^QA(743.5,+Y,0),""^"",2)=405.2"
 S DIC("A")=QAMY(0,0)_" TYPE GROUP: ",DIC("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:$P(^("P2"),"^",2),1:"") K:DIC("B")="" DIC("B")
 S DIR("?",1)="Enter a GROUP name that contains MAS "_QAMY(0,0)_" movement types",DIR("?",2)="Enter a MAS "_QAMY(0,0)_" movement type GROUP, or",DIR("?")="press 'RETURN' for all "_QAMY(0,0)_" types."
 S QAMPARAM="P2" D EN2^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P2")=+Y_"^"_Y(0,0)
EXIT K Y
 K QAMPARAM,QAMY
Y Q