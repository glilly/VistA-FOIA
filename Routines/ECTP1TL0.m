ECTP1TL0 ;B'ham ISC/PTD-PAID Data for One T&L Unit - CONTINUED ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**4,8,10**;
ENQ ;ENTRY POINT WHEN QUEUED
 K ^TMP($J) S YP=(BYRPP-1)
LP1 ;LOOP THROUGH DATE/PAY PERIOD REQUESTED
 F J=0:0 S YP=$O(^PRST(455,YP)) G:'YP EN1^ECTP1TL1 G:YP>EYRPP EN1^ECTP1TL1 S (EMPDA,PAL,PSL,PLWOP,PAA,PCTE,PCTU,PUNS,POT)=0 D LP2 D:$D(TMP(TLDA,YP)) SETGL
 ;
LP2 ;LOOP THROUGH ALL RECORDS FOR DATE/PAY PERIOD
 Q:'$O(^PRST(455,YP,0))
EMP F K=0:0 S EMPDA=$O(^PRST(455,YP,1,EMPDA)) Q:'EMPDA  S TL=$P(^PRST(455,YP,1,EMPDA,0),"^",7) G:TL="" EMP G:TL'=TLPTR EMP D GTDTA
 Q
 ;
 ;
GTDTA ;FOR SELECTED PAY PERIOD, EXTRACT DATA FOR INDIVIDUAL
 I '$D(^PRST(455,YP,1,EMPDA,1)) S LOC0=^PRST(455,YP,1,EMPDA,0) F PC=1,2,3,6,7,11,12,13,17,18,19,47,48,49,50,51,53 S $P(LOC1,"^",PC)="000"
 I  G CALC
 S LOC0=^PRST(455,YP,1,EMPDA,0),LOC1=^PRST(455,YP,1,EMPDA,1)
CALC ;COMPUTE FIRST AND SECOND WEEK TOTALS FOR PAY PERIOD
 S (AL,SL,LWOP,AA,CTE,CTU,UNS,OT)=0,(NC,L4SSN)=""
 S NC=$P(LOC0,"^",6),L4SSN=$E($P(LOC0,"^",5),6,9)
PHYS ;IS INDIVIDUAL FULL-TIME PHYSICIAN OR RESIDENT
 I (($P(LOC0,"^",10)="J")!($P(LOC0,"^",10)="L")),($P(LOC0,"^",11)=1) D CONV^ECTPAS0 G IND
AL S AL1=$P(LOC0,"^",13),AL2=$P(LOC0,"^",48),AL=(($E(AL1,3)/4)+($E(AL1,1,2))+($E(AL2,3)/4)+($E(AL2,1,2)))
SL S SL1=$P(LOC0,"^",14),SL2=$P(LOC0,"^",49),SL=(($E(SL1,3)/4)+($E(SL1,1,2))+($E(SL2,3)/4)+($E(SL2,1,2)))
LWOP S LWOP1=$P(LOC0,"^",15),LWOP2=$P(LOC0,"^",50),LWOP=(($E(LWOP1,3)/4)+($E(LWOP1,1,2))+($E(LWOP2,3)/4)+($E(LWOP2,1,2)))
AA S AA1=$P(LOC0,"^",17),AA2=$P(LOC0,"^",52),AA=(($E(AA1,3)/4)+($E(AA1,1,2))+($E(AA2,3)/4)+($E(AA2,1,2)))
CTE S CTE1=$P(LOC0,"^",19),CTE2=$P(LOC1,"^"),CTE=(($E(CTE1,3)/4)+($E(CTE1,1,2))+($E(CTE2,3)/4)+($E(CTE2,1,2)))
CTU S CTU1=$P(LOC0,"^",20),CTU2=$P(LOC1,"^",2),CTU=(($E(CTU1,3)/4)+($E(CTU1,1,2))+($E(CTU2,3)/4)+($E(CTU2,1,2)))
UNS S UNS1=$P(LOC0,"^",21),UNS2=$P(LOC1,"^",3),UNS=(($E(UNS1,3)/4)+($E(UNS1,1,2))+($E(UNS2,3)/4)+($E(UNS2,1,2)))
OT S (OT1,OT2)=0 F PC=25,29,30,31,33,35,36,37 S OT1=OT1+$P(LOC0,"^",PC) I $E(OT1,$L(OT1))>3 S OT1=OT1+6
 F PC=6,7,49 S OT1=OT1+$P(LOC1,"^",PC) I $E(OT1,$L(OT1))>3 S OT1=OT1+6
 F PC=11,12,13,17,18,19,47,48,50,51,53 S OT2=OT2+$P(LOC1,"^",PC) I $E(OT2,$L(OT2))>3 S OT2=OT2+6
 S OT1=$E("000",1,3-$L(OT1))_OT1,OT2=$E("000",1,3-$L(OT2))_OT2,OT=(($E(OT1,3)/4)+($E(OT1,1,2))+($E(OT2,3)/4)+($E(OT2,1,2)))
IND ;SET TMP GLOBAL WITH INDIVIDUAL'S DATA
 S ^TMP($J,TLDA,YP,NC,L4SSN)=AL_"^"_SL_"^"_LWOP_"^"_AA_"^"_CTE_"^"_CTU_"^"_UNS_"^"_OT
SETPP ;INCREMENT PAY PERIOD COUNTERS FOR THIS INDIVIDUAL
 S PAL=PAL+AL,PSL=PSL+SL,PLWOP=PLWOP+LWOP,PAA=PAA+AA,PCTE=PCTE+CTE,PCTU=PCTU+CTU,PUNS=PUNS+UNS,POT=POT+OT
 S TMP(TLDA,YP)=PAL_"^"_PSL_"^"_PLWOP_"^"_PAA_"^"_PCTE_"^"_PCTU_"^"_PUNS_"^"_POT
 Q
 ;
SETGL ;SET TMP GLOBAL
 S ^TMP($J,TLDA,YP)=TMP(TLDA,YP)
 Q
 ;
