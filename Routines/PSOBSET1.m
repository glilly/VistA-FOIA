PSOBSET1 ;BHAM ISC/CCG - BLACK LINE RESOLVER ; 10/24/92 13:23
 ;;7.0;OUTPATIENT PHARMACY;**268**;DEC 1997;Build 9
 S PSOBMX=$P(^PS(59,PSOBPS,0),"^",9) S:+PSOBMX<1000 PSOBMX=1000,^PS(59,PSOBPS,0)=$P(^(0),"^",1,8)_"^1000^"_$P(^(0),"^",10,255)
LCK L +^PS(52.9,PSOBIO,1,0):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) G:'$T LCK S Z=$P(^PS(52.9,PSOBIO,1,0),"^",3),ZX=$P(^(0),"^",4)
LP S Z=Z+1,ZX=ZX+1 G:$D(^PS(52.9,PSOBIO,1,Z,0)) LP D:(ZX>PSOBMX)&($D(^PS(52.9,PSOBIO,1,Z-PSOBMX))) DEL S ^PS(52.9,PSOBIO,1,0)=$P(^PS(52.9,PSOBIO,1,0),"^",1,2)_"^"_Z_"^"_ZX L -^PS(52.9,PSOBIO,1,0) S %DT="T",X="N" D ^%DT
 S ^PS(52.9,PSOBIO,1,Z,0)=PSOBDPT_"^"_PSOBR_"^"_Y_"^"_$G(RXP)_"^"_PSOBCP_"^"_PSOBVR2_"^"_PSOBPS,^PS(52.9,PSOBIO,1,"B",PSOBDPT,Z)="",PSOB=0
 S PSOBPCZ=PSOBPC F P=1:1:$L(^PSOBPPL($J)) I $E(^PSOBPPL($J),P)'?.AN,$E(^($J),P)'="*" S PSOBPC=$E(^($J),P) Q
PPL F P=1:1 Q:($P(^PSOBPPL($J),PSOBPC,P)="")&(P'=1)  S PSOBRX=$P($P(^PSOBPPL($J),PSOBPC,P),"*",1) D:PSOBRX'="" C
 I $D(PSOBPPL1),PSOBPPL1'="" S ^PSOBPPL($J)=PSOBPPL1 K PSOBPPL1 G PPL
 I PSOB S ^PS(52.9,PSOBIO,1,Z,2,0)="^52.9002P^"_PSOB_"^"_PSOB
 I +$P(^PS(52.9,PSOBIO,1,0),"^",3)=0 K ^PS(52.9,"B",^PS(52.9,PSOBIO,0),PSOBIO),^PS(52.9,PSOBIO) S ^PS(52.9,0)=$P(^PS(52.9,0),"^",1,2)_"^"_($P(^(0),"^",3)-1)_"^"_($P(^(0),"^",4)-1)
Q S:$D(PSOBPCZ) PSOBPC=PSOBPCZ K PSOBPCZ K:'$D(PSOBS) I,IOP,PSOBPPL1,PSOBR,PSOBPC,PSOBPS,^PSOBPPL($J),PSOB,PSOBIO,PSOBRX,PSOBDPT,PSOBCP,PSOBVR2,PSOBVR1,PSOBZ,PSOBMX,X,Y,Z,ZZX,ZX,P,%ZIS,%ZIS("B")
 Q
C Q:'$D(^PSRX(PSOBRX,0))  S PSOB=PSOB+1,^PS(52.9,PSOBIO,1,Z,2,PSOB,0)=PSOBRX,^PS(52.9,PSOBIO,1,"C",PSOBRX,Z,PSOB)="" S:$G(RXPR(PSOBRX)) $P(^PS(52.9,PSOBIO,1,Z,2,PSOB,0),"^",2)=$G(RXPR(PSOBRX))
 S:$D(RXFL(PSOBRX)) $P(^PS(52.9,PSOBIO,1,Z,2,PSOB,0),"^",3)=$G(RXFL(PSOBRX)) Q
DEL S ZZX=Z-PSOBMX F I=0:0 S I=$O(^PS(52.9,PSOBIO,1,ZZX,2,I)) Q:'I  K ^PS(52.9,PSOBIO,1,"C",^PS(52.9,PSOBIO,1,ZZX,2,I,0),ZZX)
 S PSOBZ=$P(^PS(52.9,PSOBIO,1,ZZX,0),"^") K ^PS(52.9,PSOBIO,1,"B",+PSOBZ,ZZX),^PS(52.9,PSOBIO,1,ZZX) S ZX=ZX-1 Q
