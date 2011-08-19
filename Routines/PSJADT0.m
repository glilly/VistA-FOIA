PSJADT0 ;BIR/CML3,PR,MLM-AUTO DC/HOLD CANCEL ;11 Aug 98 / 8:25 AM
 ;;5.0; INPATIENT MEDICATIONS ;**17,111,112,135,181**;16 DEC 97;Build 190
 ;
 ;Reference to ^PS(55 supported by DBIA #2191.
 ;
ENDC ; dc active orders first, then non-verified orders
 W:'$D(PSJQUIET)&'$D(DGQUIET) !,"...discontinuing Inpatient Medication orders..."
 S $P(PSJPIND,"^")=""
 D NOW^%DTC N PSJDCDT S (PSJDCDT,PSGDT)=+%,PSJSYSW0="" I PSJFW S PSJSYSW=$O(^PS(59.6,"B",PSJFW,0)) S:PSJSYSW PSJSYSW0=$G(^PS(59.6,PSJSYSW,0))
 I PSGALO=1010!(PSGALO=1030)!(PSGALO=1050) D AUDDD
 D ENUNM^PSGOU S PSGALR=10,DIE="^PS(55,"_PSGP_",5," S:PSJFW PSGTOL=1,PSGUOW=PSJFW,PSGTOO=1
 F PSJS=PSGDT:0 S PSJS=$O(^PS(55,PSGP,5,"AUS",PSJS)) Q:'PSJS  F PSJDA=0:0 S PSJDA=$O(^PS(55,PSGP,5,"AUS",PSJS,PSJDA)) Q:'PSJDA  D
 .Q:'$$DCIMO(PSGP,PSJDA,"U") 
 .;first naked reference below refers to the full global reference to the right of the = sign (inside the $S)
 .K DA S DA(1)=PSGP,DA=PSJDA,PSGAL("C")=0,$P(^(2),"^",3)=$S($D(^PS(55,PSGP,5,DA,2)):$P(^(2),"^",4),1:"")
 .D ^PSGAL5
 .K TMP
 .S TMP(55.06,""_PSJDA_","_PSGP_","_"",28)="D"
 .S TMP(55.06,""_PSJDA_","_PSGP_","_"",136)=$S(PSGALO=1010:"DD",1:"DA")
 .D FILE^DIE("","TMP")
 .K TMP
 .S TMP(55.06,""_PSJDA_","_PSGP_","_"",34)=PSJDCDT
 .S TMP(55.06,""_PSJDA_","_PSGP_","_"",49)=1
 .D FILE^DIE("","TMP")
 .K TMP
 .D EN1^PSJHL2(PSGP,"OD",PSJDA_"U","AUTO DC")
 .I PSGALO'=1050 S DA=PSJDA,^PS(55,"AUE",PSGP,DA)="" I $P(PSJSYSW0,"^",15),(PSGALO'<1060) S $P(^PS(55,PSGP,5,PSJDA,7),"^",1,2)=PSJDCDT_"^D" D ENL^PSGVDS
 S PSGTOO=2 F PSJDA=0:0 S PSJDA=$O(^PS(53.1,"AC",PSGP,PSJDA)) Q:'PSJDA  D
 .Q:'$$DCIMO(PSGP,PSJDA,"P")
 .I PSGALO'<1060,$P(PSJSYSW0,U,15),$P($G(^PS(53.1,PSJDA,0)),U,9)="N" K DA D ENLBL^PSIVOPT(PSGTOL,PSGUOW,DFN,2,+PSJDA,"AD")
 .K DA S DA=PSJDA D  I $P($G(^PS(53.1,DA,0)),"^",21) D EN1^PSJHL2(PSGP,"OC",PSJDA_"P","AUTO DC")
 ..K TMP
 ..S TMP(53.1,""_PSJDA_","_"",28)="D"
 ..S TMP(53.1,""_PSJDA_","_"",42)=1
 ..D FILE^DIE("","TMP")
 ..K TMP
 ;
ENIV ;
 S DFN=PSGP F PSJIVON=0:0 S PSJIVON=$O(^PS(55,DFN,"IV",PSJIVON)) Q:'PSJIVON  S Y=$G(^(PSJIVON,0)) I "PDEN"'[$P(Y,U,17) S P(17)=$P(Y,U,17),P(3)=$P(Y,U,3) D DC
 Q
DC ;
 Q:'$$DCIMO(DFN,PSJIVON,"V")
 S (ON,ON55)=PSJIVON_"V" D NOW^%DTC I P(17)="H",P(3)<% D  D EXPIR^PSIVOE Q
 .K TMP
 .S TMP(55.01,""_+ON_","_DFN_","_"",100)="E"
 .D FILE^DIE("","TMP")
 .K TMP
 K PSIVALT S PSIVAC="AD",PSIVALCK="STOP",PSIVREA="D",PSIVAL=$S('+$G(PSGALO):$G(PSIVRES),1:$P($G(^PS(53.3,+PSGALO,0)),U)) D D1^PSIVOPT2,LOG^PSIVORAL
 K TMP
 S TMP(55.01,""_+ON_","_DFN_","_"",157)=$S(PSGALO=1010:"DD",1:"DA")
 S TMP(55.01,""_+ON_","_DFN_","_"",.03)=PSJDCDT
 S TMP(55.01,""_+ON_","_DFN_","_"",121)=1
 D FILE^DIE("","TMP")
 K TMP
 D EN1^PSJHL2(DFN,"OD",+ON_"V","AUTO DC")
 S PSJIVDCF=1
 Q
 ;
SIVDIE ; Setup DIE,DA for IV
 K DA,DIE,DR S DA=+ON,DA(1)=DFN,DIE="^PS(55,"_DFN_",""IV"","
 Q
 ;
AUDDD ; set up orders for discharge report and purging
 S DIS=+VAIP(17,1) I $S('DIS:1,1:$D(^PS(55,"AUDDD",DIS,PSGP))) Q
 S X=$$EN^PSGCT(+VAIP(13,1),-1)
 F Q=X:0 S Q=$O(^PS(55,PSGP,5,"AUS",Q)) Q:'Q  F QQ=0:0 S QQ=$O(^PS(55,PSGP,5,"AUS",Q,QQ)) Q:'QQ  I $S($D(^PS(55,PSGP,5,QQ,0)):'$P(^(0),"^",20),1:1) S $P(^(0),"^",20)=DIS,^PS(55,"AUDDD",DIS,PSGP,QQ)=""
 Q
 ;
ENHE ; status from hold to expired
 D NOW^%DTC S PSGDT=+$E(%,1,12),DIE="^PS(55,"_PSGP_",5,"
 F PSJS=+PSJPAD:0 S PSJS=$O(^PS(55,PSGP,5,"AUS",PSJS)) Q:'PSJS  Q:PSJS>PSGDT  F PSJDA=0:0 S PSJDA=$O(^PS(55,PSGP,5,"AUS",PSJS,PSJDA)) Q:'PSJDA  K DA S DA(1)=PSGP,DA=PSJDA I $D(^PS(55,PSGP,5,DA,0)),$P(^(0),"^",9)="H" S DR="28////E" D ^DIE
 Q
 ;
ENUNDC(PSJDCDT,PSGP,PSJUOW,PSGALO) ; Auto-reinstate orders DC'ed due to a patient movement.
 N PSJSYSW0 D NOW^%DTC S PSJUNDC=1,PSGDT=%,PSJFIRST='$D(PSJQUIET),PSJSYSW0=$G(^PS(59.6,+$O(^PS(59.6,"B",+PSJUOW,0)),0))
 S PSJS=$O(^PS(55,PSGP,5,"AUS",PSJDCDT-.0002)) F PSGORD=0:0 S PSGORD=$O(^PS(55,PSGP,5,"AUS",+PSJS,PSGORD)) Q:'PSGORD  D
 .I $P($G(^PS(55,PSGP,5,PSGORD,0)),U,9)["D",$P($G(^(4)),U,11) D DISREIN,ENRI^PSGOERI
 .S ^PS(55,"AUE",PSGP,PSGORD)=""
 ;
 S:PSJS="" PSJS=$O(^PS(55,PSGP,"IV","AIS",PSJDCDT-.0002))
 F PSGORD=0:0 S PSGORD=$O(^PS(55,PSGP,"IV","AIS",+PSJS,PSGORD)) Q:'PSGORD  D
 .I $P($G(^PS(55,PSGP,"IV",PSGORD,0)),U,12),$P($G(^(2)),U,7)>PSGDT S P(3)=$P($G(^(0)),U,3) D DISREIN,ENARI^PSIVOPT(PSGP,PSGORD,+PSJUOW,PSGALO)
 I $D(^TMP("PSJUNDC")) S ^TMP("PSJUNDC",$J,DFN)=$P(^DPT(DFN,0),"^")_"^"_$G(^DPT(PSGP,.1))_"^"_PSGALO D ^PSJADT2
 ;
ENKL ;
 F UW=0:0 S UW=$O(^PS(53.41,1,1,UW)) Q:'UW  D  I '$O(^PS(53.41,1,1,0)) K DA S DA=1,DIK="^PS(53.41," D ^DIK
 .F PSGP=0:0 S PSGP=$O(^PS(53.41,1,1,UW,1,PSGP)) Q:'PSGP  D  I '$O(^PS(53.41,1,1,UW,1,0)) K DA S DIK="^PS(53.41,1,1,",DA(1)=1,DA=UW D ^DIK
 ..F TO=0:0 S TO=$O(^PS(53.41,1,1,UW,1,PSGP,1,TO)) Q:'TO  D  I '$O(^PS(53.41,1,1,UW,1,PSGP,1,0)) K DA S DA(2)=1,DA(1)=UW,DA=PSGP,DIK="^PS(53.41,1,1,"_UW_",1," D ^DIK
 ...I '$O(^PS(53.41,1,1,UW,1,PSGP,1,TO,1,0))  K DA S DA(3)=1,DA(2)=UW,DA(1)=PSGP,DA=TO,DIK="^PS(53.41,1,1,"_UW_",1,"_PSGP_",1," D ^DIK
 K DA,DIK,P,PSGDT,PSGP,PSGORD,PSJS,PSJUNDC,TO,UW
 Q
 ;
DISREIN ; Display reinstate msg. for first order.
 W:PSJFIRST&'$D(DGQUIET) !,"...reinstating Inpatient Medication orders..." S PSJFIRST=0
 Q
 ;
DCIMO(DFN,ON,TYP) ; Check parameter before DC'ing clinic order
 N GLO,IMOND,A,CLINIC,APPT,B,C S GLO=$S(TYP="P":"^PS(53.1,",TYP="U":"^PS(55,"_DFN_",5,",TYP="V":"^PS(55,"_PSGP_",""IV"",",1:"") I TYP="" Q 1
 S IMOND=$S(TYP="P"!(TYP="V"):"""DSS""",TYP="U":8,1:"") I IMOND="" Q 1
 S GLO=GLO_+ON_","_IMOND_")",A=$G(@GLO),CLINIC=$P(A,"^"),APPT=$P(A,"^",2)
 Q:'$$CLINIC^PSJBCMA(A) 1
 I '$D(^PS(53.46,"B",CLINIC)) Q 1
 S B=$O(^PS(53.46,"B",CLINIC,"")),C=+$P(^PS(53.46,B,0),"^",3) Q C
