SROSUR2 ;B'HAM ISC/MAM - SURGEON'S REPORT FOR ONE ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**34,50**;24 Jun 93
 W ! K DIC S DIC(0)="QEAMZ",DIC=200,DIC("A")="Print the report for which Surgeon ? " D ^DIC G:Y<0 END S SROSUR=+Y
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGEON STAFFING REPORT",ZTRTN="BEG^SROSUR2",(ZTSAVE("SRED"),ZTSAVE("SROSUR"),ZTSAVE("SRSD"),ZTSAVE("SRINST"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
BEG ; entry when queued
 U IO N SRFRTO S Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 S (SRF,SRUL)=0,PAGE=1 K J D HDR S J=SRSD-.0001,SRTN=0 K ^TMP("SRO",$J)
 F  S J=$O(^SRF("AC",J)) Q:J>(SRED+.9999)!(J="")  F  S SRTN=$O(^SRF("AC",J,SRTN)) Q:SRTN=""  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D SETUP
PRINT ; print from ^TMP(
 S J=0 F  S J=$O(^TMP("SRO",$J,J)) Q:J=""!(SRF)  D NAME S K=0 F  S K=$O(^TMP("SRO",$J,J,K)) Q:K=""!(SRF)  D ROLE S L=0 F  S L=$O(^TMP("SRO",$J,J,K,L)) Q:L=""!SRF  D PRIN2
 I '$D(^TMP("SRO",$J)) W $$NODATA^SROUTL0()
 K ^TMP("SRO",$J) W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I $E(IOST)'="P",'SRF W !!,"Press RETURN to continue  " R X:DTIME
END D ^SRSKILL,^%ZISC K SRTN W @IOF
 Q
ASK S SRUL=0 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:.  " R X:DTIME I '$T!(X="^") S SRF=1 Q
 D HDR Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
NAME I SRUL W ! F LINE=1:1:IOM W "-"
 S SRUL=1 W !!,"    ** "_J_" **" Q
ROLE I $Y+5>IOSL D ASK
 Q:SRF  W !!,?5,"ROLE: " W $S(K="1ST":"FIRST ASSISTANT",K="2ND":"SECOND ASSISTANT",K="ATT":"ATTENDING SURGEON",K="OTH":"OTHER ASSISTANT",1:"SURGEON"),!
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRF=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?120,"PAGE: "_PAGE,!,?58,"SURGICAL SERVICE",?100,"REVIEWED BY: ",!,?54,"SURGEON STAFFING REPORT",?100,"DATE REVIEWED: "
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,SRPRINT
 W !!,?1,"DATE/TIME",?23,"PATIENT",?43,"OPERATION(S)",?95,"DIAGNOSIS",!,?1,"CASE #",?23,"ID #",! F LINE=1:1:132 W "="
 S PAGE=PAGE+1 I $D(J) D ROLE
 Q
SETUP ; set up ^TMP(
 I $P($G(^SRF(SRTN,31)),"^",8)'="" Q
 Q:'$D(^SRF(SRTN,.2))  I $P(^(.2),"^",12)="" Q
 Q:'$D(^SRF(SRTN,.1))  S S(.1)=^(.1),DATE=$P(^SRF(SRTN,0),"^",9),SUR=$P(S(.1),"^",4),ATT=$P(S(.1),"^",13),FRST=$P(S(.1),"^",5),SCND=$P(S(.1),"^",6) S:SUR=SROSUR ^TMP("SRO",$J,$P(^VA(200,SUR,0),"^"),"SUR",DATE,SRTN)=""
 S:ATT=SROSUR ^TMP("SRO",$J,$P(^VA(200,ATT,0),"^"),"ATT",DATE,SRTN)="" S:FRST=SROSUR ^TMP("SRO",$J,$P(^VA(200,FRST,0),"^"),"1ST",DATE,SRTN)="" S:SCND=SROSUR ^TMP("SRO",$J,$P(^VA(200,SCND,0),"^"),"2ND",DATE,SRTN)=""
 I $O(^SRF(SRTN,28,0)) D ASSTS^SROSUR
 Q
PRIN2 S SRTN=0 F  S SRTN=$O(^TMP("SRO",$J,J,K,L,SRTN)) Q:SRTN=""!SRF  D SET
 Q
SET ; set variables and print from ^SRF(
 K CPT,ICD S S(0)=^SRF(SRTN,0),DFN=$P(S(0),"^") D DEM^VADPT S PAT=VADM(1),SSN=VA("PID"),Y=L D D^DIQ S DATE=Y
 I $L(PAT)>18 S PAT=$P(PAT,",")_", "_$E($P(PAT,",",2))
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F I=0:0 S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 K SROPS,MMM S:$L(SROPER)<50 SROPS(1)=SROPER I $L(SROPER)>49 F M=1:1 D LOOP Q:MMM=""
 I $D(^SRF(SRTN,.2)),$P(^(.2),"^",3)'="" S SRDG=34,SRDG1=15
 I '$D(SRDG) S SRDG=33,SRDG1=14
 S ICD("*")=$S($D(^SRF(SRTN,SRDG)):$P(^SRF(SRTN,SRDG),"^"),1:""),(CNT,ICD)=0 F I=0:0 S ICD=$O(^SRF(SRTN,SRDG1,ICD)) Q:ICD=""  S CNT=CNT+1,ICD(CNT)=$P(^SRF(SRTN,SRDG1,ICD,0),"^")
 I $Y+7>IOSL D ASK
 Q:SRF  W !,DATE,?23,PAT,?43,SROPS(1),?95,$E(ICD("*"),1,35) S (CPT,ICD)=0
 W !,SRTN,?23,SSN S ICD=$O(ICD(ICD)) W:$D(SROPS(2)) ?43,SROPS(2) W:ICD ?95,$E(ICD(ICD),1,35) S:ICD ICD=$O(ICD(ICD)) I $D(SROPS(3)) W !,?43,SROPS(3) I ICD W ?95,$E(ICD(ICD),1,35)
 I 'CPT W:ICD !,?95,$E(ICD(ICD),1,35)
 W:$D(SROPS(4)) !,?43,SROPS(4) W:$D(SROPS(5)) !,?43,SROPS(5) W:$D(SROPS(6)) !,?43,SROPS(6) W ! Q
 Q
LOOP ; break procedure if greater than 50 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<50  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
