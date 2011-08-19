SROALLSP ;BIR/ADM - ASSESSMENTS BY SPECIALTY (PRINTER) ;01/18/07
 ;;3.0; Surgery ;**32,47,55,50,88,142,153,160**;24 Jun 93;Build 7
START S SRSOUT=0 K ^TMP("SRA",$J)
 F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D UTL
 D PRINT Q
UTL ; write to ^TMP("SRA,$J)
 S SRA(0)=^SRF(SRTN,0) I $P(SRA(0),"^",3)'="J" Q
 I $G(SRMNA),($P($G(^SRF(SRTN,"RA")),"^",2))'="" Q
 S CAN=$P($G(^SRF(SRTN,30)),"^") I CAN Q
 S CAN=$P($G(^SRF(SRTN,31)),"^",8) I CAN'="" Q
 I '$P($G(^SRF(SRTN,.2)),"^",12) Q:'$G(SRMNA)  I '$P($G(^SRF(SRTN,.2)),"^",3) Q
 I SRFLG,$P(^SRF(SRTN,0),"^",4)'=SRASP Q
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"SPECIALTY NOT ENTERED")
 S TYPE=$P($G(^SRF(SRTN,"RA")),"^",2) I SRSS="SPECIALTY NOT ENTERED",TYPE="C" S SRSS="N/A"
 S ^TMP("SRA",$J,SRSS,SRTN)=""
 Q
SET ; set variables
 S SREXCL="" I '$G(SRMNA) D
 .S SRA("RA")=$G(^SRF(SRTN,"RA")),X=$P(SRA("RA"),"^"),STATUS=$S(X="I":"INCOMPLETE",X="C":"COMPLETED",X="T":"TRANSMITTED",1:"NO ASSESSMENT")
 .S (SREXCL,Y)=$P(SRA("RA"),"^",7),C=$P(^DD(130,102,0),"^",2) D Y^DIQ S SREXCL=Y
 S SRA(0)=^SRF(SRTN,0),DFN=$P(SRA(0),"^") N I D DEM^VADPT S SRANM=VADM(1),SRASSN=VA("PID") K VADM
 S SROPER=$P(^SRF(SRTN,"OP"),"^") I $O(^SRF(SRTN,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRTN,13,SROTHER)) Q:'SROTHER  D OTHER
 I '$G(SRMNA) S X=$P($G(^SRF(SRTN,"RA")),"^",2) I X="C" S SROPER="* "_SROPER
 K SROPS,MM,MMM
 I $G(SRMNA) S:$L(SROPER)<85 SROPS(1)=SROPER I $L(SROPER)>84 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 I '$G(SRMNA) S:$L(SROPER)<44 SROPS(1)=SROPER I $L(SROPER)>43 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRSS=$P(SRA(0),"^",4),SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"SPECIALTY NOT ENTERED")
 D TECH^SROPRIN
 S (SRDOC,Y)=$P($G(^SRF(SRTN,.1)),"^",4),C=$P(^DD(130,.14,0),"^",2) D:Y'="" Y^DIQ I $L(Y)>24 S Z=$P(Y,",")_","_$E($P(Y,",",2))_".",Y=Z
 S SRDOC=Y
 S Y=$P(SRA(0),"^",9) D D^DIQ S SRDT=$P(Y,"@")
 Q
PRINT ;
 U IO S SRSS="",(SRTC,SRPAGE)=0 D HDR Q:SRSOUT
 F  S SRSS=$O(^TMP("SRA",$J,SRSS)) Q:SRSS=""!SRSOUT  S SRC=0 D SS S SRTN=0 F  S SRTN=$O(^TMP("SRA",$J,SRSS,SRTN)) D:'SRTN SSCT Q:'SRTN!SRSOUT  D SET,CASE
 Q:SRFLG  I $Y+5>IOSL D HDR Q:SRSOUT
 W !!,"TOTAL CASES FOR ALL SPECIALTIES: ",SRTC
 Q
CASE ; print a case
 S SRC=SRC+1,SRTC=SRTC+1
 I $Y+5>IOSL D HDR Q:SRSOUT  W !,"** SURGICAL SPECIALTY: ",SRSS," **",!
 W !,SRTN,?20,SRANM_"  "_VA("PID") I '$G(SRMNA) W ?67,STATUS
 W ?107,SRTECH,!,SRDT,?20,SROPS(1) I '$G(SRMNA),(SREXCL'="") W ?67,SREXCL
 W ?107,SRDOC
 I $D(SROPS(2)) W !,?20,SROPS(2) I $D(SROPS(3)) W !,?20,SROPS(3) I $D(SROPS(4)) W !,?20,SROPS(4)
 N I,SRPROC,SRL S SRL=100 D CPTS^SROAUTL0 W !,?20,"CPT Codes: "
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?31,SRPROC(I) W:I'=1 !,?31,SRPROC(I)
 W ! F LINE=1:1:132 W "-"
 Q
SS ; print surgical specialty
 I $Y+5>IOSL D HDR Q:SRSOUT
 W !,"** SURGICAL SPECIALTY: ",SRSS," **",!
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHD=$S($G(SRMNA):"NON-ASSESSED MAJOR SURGICAL CASES BY SURGICAL SPECIALTY",1:"ALL MAJOR SURGICAL CASES BY SURGICAL SPECIALTY"),SRPAGE=SRPAGE+1
 W:$Y @IOF W !,?(132-$L(SRHD)\2),SRHD,?120,"PAGE "_SRPAGE,!,?(132-$L(SRINST)\2),SRINST,!,?58,"SURGERY SERVICE",?100,"DATE REVIEWED:"
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,"REVIEWED BY:"
 W !!,"CASE #",?20,"PATIENT" I '$G(SRMNA) W ?67,"ASSESSMENT STATUS"
 W ?107,"ANESTHESIA TECHNIQUE",!,"OPERATION DATE",?20,"OPERATIVE PROCEDURE(S)"
 W:'$G(SRMNA) ?67,"EXCLUSION CRITERIA" W ?107,"SURGEON"
 W ! F L=1:1:132 W "="
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,SROTHER,0),"^"))>165 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS'=" ...":", "_SROPERS,1:SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)=""
 I $G(SRMNA) F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<85  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 I '$G(SRMNA) F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<44  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
SSCT ; write specialty count
 I $Y+5>IOSL D HDR Q:SRSOUT
 W !," >>> TOTAL ",SRSS,": ",SRC,! F L=1:1:132 W "-"
 Q
