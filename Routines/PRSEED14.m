PRSEED14 ;HISC/MD-E/E MI ATTENDANCE BY MULTIPLE EMPLOYEES ;JUN 93
 ;;4.0;PAID;**5,18,20**;Sep 21, 1995
EN1 ;PRSE-MI-MULT
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!X D MSG6^PRSEMSG Q
 D EN2^PRSEUTL3($G(DUZ)) I PRSESER=""&'(DUZ(0)="@") D MSG3^PRSEMSG G Q1
 K ^TMP("PRSE",$J),^TMP($J) S (NOUT,NSW)=0,(PRSEQWIK,PRSESW)=1,PRSESRCE="VA",PRSEGF="G",PRSELCL="L",PRSEPURP="IMPROVE PRESENT PERFORMANCE",PRSELOC=$P($G(^PRSE(452.7,1,0)),U,2),PRSECOD="N",PRSEROU="R"
 S (PRSEBAD,NOUT,POUT)=0,Y=DT D D^DIQ S %DT("B")=Y
DT K POUT D DATE G Q1:$G(POUT)
MI S (NOUT,POUT)=0 K ^TMP("PRSE",$J),^TMP($J) S PRSESEL="M" D NAM^PRSEED1 I $D(POUT)!'($G(VA200DA)) G DT
 S SSN=$P($G(^VA(200,+$G(VA200DA),1)),U,9),VA450DA=$O(^PRSPC("SSN",SSN,0)) S PRSESER("TX")=$P($G(^PRSP(454.1,+PRSESER,0)),U) I $G(PRSESER("TX"))="",(+$G(PRSPDA(1))>0) D MSG3^PRSEMSG G Q1
 I '+$O(^PRSE(452.6,"B","MANDATORY TRAINING",0)) S:'$D(^PRSE(452.6,0)) ^(0)="PRSE SVC REASONS FOR TRAINING^452.6^0^0" S X="MANDATORY TRAINING",DIC(0)="L",DIC="^PRSE(452.6,",DLAYGO=452.6 K DD,DO D FILE^DICN
 S PRSDA=0 D GRPEDT
 G MI
Q1 D ^PRSEKILL K ^TMP("PRSE",$J),^TMP($J)
 Q
DATE W ! S %DT("A")="Date Class Attended: ",%DT="AET",%DT(0)=-DT D ^%DT K %DT I Y<0 S POUT=1 Q
 S (PRSEED,PRSEDT)=Y Q
GRPEDT ;CREDIT CLASSES
 I '$O(^PRSPC(+VA450DA,6,0)),(+$G(PRSPDA(1))>0) W !?3,"NO MANDATORY CLASSES ASSIGNED TO THIS EMPLOYEE!!",! S DIR(0)="E" D ^DIR K DIR Q:Y'>0  D ASK1 Q
 S DIK="^PRSPC(+VA450DA,6," F I=0:0 S I=$O(^PRSPC(+VA450DA,6,"B",I)) Q:I'>0  I $G(^PRSE(452.1,+I,0))=""!($P($G(^(0)),U,7)'="M") S DA(1)=VA450DA,DA=$O(^PRSPC(+VA450DA,6,"B",I,0)) D ^DIK
 D DISP
STUFF S (PRSEII,NDA)=0 F  S PRSEII=$O(^TMP("PRSE",$J,PRSEII)) Q:PRSEII'>0!($G(POUT))  S NDA=+$G(^TMP("PRSE",$J,PRSEII)) I $P($G(^PRSE(452.1,+NDA,0)),U)'="" S PRSENAM="`"_+NDA D
 .S PRSELNG=+$P($G(^PRSE(452.1,NDA,0)),U,3),PRSDA=+$O(^PRSE(452.8,"B",NDA,0))
 .S PRSECAT="" I ($P($G(^PRSE(452.1,NDA,0)),U,9)=0!($$EN3^PRSEUTL3($G(VA200DA))=$P($G(^PRSE(452.8,PRSDA,0)),U,21))) S PRSECAT=$P($G(^PRSE(452.4,+$P($G(^PRSE(452.8,PRSDA,0)),U,10),0)),U)
 .W ! S (NSW,NDUPSW)=0 D RECHK^PRSEED7 Q:NOUT  I 'NDUPSW W ! S DIC("S")="I $D(^PRSPC(VA450DA,6,""B"",+Y))" D ADD^PRSEED12 Q:$G(POUT)  S NSW=1 W !?9,$P($G(^PRSE(452.1,+NDA,0)),U),"  ",PRSESTUD,"  " S Y=PRSEDT D DT^DIQ
 Q
ASK1 ;
 I $D(^PRSE(452,"AA","M",VA200DA)) D NOMIHLP
ASK2 S NOUT=0 W ! S DIC=452.1,DIC(0)="AEQ",DIC("A")="Select Mandatory Training Class: ",DIC("S")="S PRS=^(0) I ($P(PRS,U,8)=PRSESER!($P(PRS,U,9)=0)),$P(PRS,U,7)=""M""" D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!("^^"[X) S NOUT=1 Q
 I +Y'>0 G ASK1:X?1"?".E,ASK2
 S PRSENAM="`"_+Y,PRSELNG=$P($G(^PRSE(452.1,+Y,0)),U,3),PRSDA=+$O(^PRSE(452.8,"B",+Y,0)),(NSW,NDUPSW)=0
 S PRSECAT="" I ($P($G(^PRSE(452.1,+Y,0)),U,9)=0!($$EN3^PRSEUTL3($G(VA200DA))=$P($G(^PRSE(452.8,PRSDA,0)),U,21))) S PRSECAT=$P($G(^PRSE(452.4,+$P($G(^PRSE(452.8,PRSDA,0)),U,10),0)),U)
 D RECHK^PRSEED7 G:NOUT ASK2 I 'NDUPSW D ADD^PRSEED12 Q:$G(POUT)
 I 'NDUPSW,'NSW W !?9,PRSENAM(0),"   ",PRSESTUD,"   " S Y=PRSEDT D DT^DIQ S NSW=1
 Q
DISP K PRSETAB,PSV,PSVC S (PRSCLAS,PRSEMAX)=0,PRSCLAS(1)=""
 F  S PRSCLAS=$O(^PRSPC(+VA450DA,6,"B",PRSCLAS)) Q:PRSCLAS'>0  I $P($G(^PRSE(452.1,+PRSCLAS,0)),U)'="" S ^TMP($J,"PSV",$P($G(^(0)),U))=+PRSCLAS
 F  S PRSCLAS(1)=$O(^TMP($J,"PSV",PRSCLAS(1))) Q:PRSCLAS(1)=""  S PRSEMAX=PRSEMAX+1,^TMP($J,"PSVC",PRSEMAX)=+^TMP($J,"PSV",PRSCLAS(1))_U_PRSCLAS(1)
 S PRSEMAX=PRSEMAX+1,PRSESTRT=1,^TMP($J,"PSVC",PRSEMAX)="ALL^ALL"
 F  D DSP I $G(PRSEDONE)!$G(POUT) Q
 Q
DSP ;
 D HDR S PRSEAQ=$Y
 F PRSE=PRSESTRT:1:PRSEMAX S PRSEI=PRSE,PRSETAB=4 D  I $Y>(IOSL+PRSEAQ-7),PRSE'=PRSEMAX S PRSESTRT=PRSE+1 Q
 .Q:$D(^TMP($J,"PSVC",PRSEI))[0
 .W:PRSETAB=4 ! W:^TMP($J,"PSVC",PRSEI)'="" ?PRSETAB,$J(PRSEI,2),". ",$P($G(^TMP($J,"PSVC",PRSEI)),U,2) D LASTDAT
 S PRSEDONE=(PRSE=PRSEMAX)
 W:'PRSEDONE !,"<<More>>"
ASK ;
 W !!,?5,"Select TRAINING Class(es) to be added: " R PRX:DTIME
 I '$T!(PRX=U) S PRX=U I PRX[U S:$E(PRX)=U POUT=1 Q
 I PRX=PRSEMAX!(PRX="A")!(PRX="ALL") D LOOP Q
 D VALENT^PRSEED7 I (PRX["?"!(PRSEBAD)) G DSP:PRX?2."?",ASK
 F PRSEI=1:1 S PRSECLA=$P(PRX,",",PRSEI) Q:PRSECLA=""  S PRSESL=$P(PRSECLA,"-",2)_"+"_PRSECLA F PRSECNT=+PRSECLA:1:PRSESL I $D(^TMP($J,"PSVC",PRSECNT)) S ^TMP("PRSE",$J,PRSECNT)=+^TMP($J,"PSVC",PRSECNT)
 Q
NOMIHLP ;
 D HDR S DA(2)="" F  S DA(2)=$O(^PRSE(452,"AA",PRSESEL,VA200DA,DA(2))) Q:DA(2)=""  S D2=$O(^PRSE(452,"AA",PRSESEL,VA200DA,DA(2),0)) Q:D2'>0  D
 .S D1=$O(^PRSE(452,"AA",PRSESEL,VA200DA,DA(2),D2,0)) Q:D1'>0  I $D(^PRSE(452,D1,0)),'($P(^(0),U,2)="") S PRSEDATA=^(0) D
 ..I $P(PRSEDATA,U,2)'="" W !?9,$P(PRSEDATA,U,2) S Y=(9999999-$O(^PRSE(452,"AA",PRSESEL,VA200DA,$P(PRSEDATA,U,2),""))) D D^DIQ W ?63,$E(Y,1,12)
 Q
LASTDAT ;LAST ATTENDED
 Q:$P($G(^TMP($J,"PSVC",+PRSEI)),U,2)=""  I +$O(^PRSE(452,"AA",PRSESEL,VA200DA,$P(^TMP($J,"PSVC",PRSEI),U,2),0))>0 S Y=(9999999-$O(^PRSE(452,"AA",PRSESEL,VA200DA,$P(^TMP($J,"PSVC",PRSEI),U,2),0))) D D^DIQ W ?63,$E(Y,1,12)
 Q
HDR K X S $P(X,"-",80)="" W @IOF,!,?1,"MANDATORY TRAINING CLASS",?60,"DATE LAST ATTENDED",!,X,!
 Q
LOOP S PRSEI=0 F  S PRSEI=$O(^TMP($J,"PSVC",PRSEI)) Q:PRSEI>(PRSEMAX-1)  I $D(^TMP($J,"PSVC",PRSEI)) S ^TMP("PRSE",$J,+PRSEI)=+^TMP($J,"PSVC",PRSEI)
 Q
