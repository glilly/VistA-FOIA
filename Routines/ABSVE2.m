ABSVE2 ;VAMC ALTOONA/CTB - CONTINUATION OF EDIT ROUTINES ;7/7/98  1:59 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**6,10**;JULY 6, 1994
PCOMB ;PRINT COMBINATIONS FOR VOL (DA) AND SITE (ABSV("SITE")
 ;USING AUSTIN COMBINATION SEQUENCE NUMBERS
 S %=0 I $S($D(DA)'["1":1,DA="":1,'$D(ABSV("SITE")):1,ABSV("SITE")="":1,1:0) Q
 I '$D(^ABS(503330,ABSVX("VOLDA"),1,"AD",ABSV("SITE"))) S X="No Combinations on File for Station "_ABSV("SITE")_".*" W !! D MSG^ABSVQ W !! S Y="" Q
 W !!,"Valid Combinations for "_$P(^ABS(503330,DA,0),"^")_" at Station "_ABSV("SITE")_" are: ",! S N=0
 K ABSVX("LIST") F I=1:1 S N=$O(^ABS(503330,DA,1,"AD",ABSV("SITE"),N)) Q:'N  D
  . S X=$O(^ABS(503330,DA,1,"AD",ABSV("SITE"),N,0)) I '$D(^ABS(503330,DA,1,+X,0)) K ^ABS(503330,DA,1,"AD",ABSV("SITE"),N,+X) Q
  . S ABSVX("LIST",N)=X,ABSVX("LIST")=I
  . QUIT
 S N=0 F I=1:1 S N=$O(ABSVX("LIST",N)) Q:'N  D WR
 Q
WR S X=ABSVX("LIST",N) W !,N,".  " S X=$G(^ABS(503330,DA,1,X,0)) W $P(X,"^",5),"   "
 I $P(X,"^",2)]"",$D(^ABS(503334,$P(X,"^",2),0)) W $E($P(^(0),"^",2),1,25)
 E  W $$GET^ABSVU1("INVALID ORG",$G(PLANG)),*7 K ABSVX("LIST",N)
 W ?54 I $P(X,"^",4)]"",$D(^ABS(503332,$P(X,"^",4),0)) W $E($P(^(0),"^",2),1,25)
 E  W $$GET^ABSVU1("INVALID SERVICE",$G(PLANG)),*7 K ABSVX("LIST",N)
 W ! Q
SELECT I '$D(ABSVX("LIST")) S Y="",ABSVOUT=1 Q
 I ABSVX("LIST")=1,$G(ABSVX("LIST",1))]"" S Y="1^"_ABSVX("LIST",1) W !,"  "_$$GET^ABSVU1("AUTO SELECT",$G(PLANG)),*7,! Q
 S DIR(0)="NOA^1:6:0",DIR("A")=$$GET^ABSVU1("SELECT COMBINATION",$G(PLANG)),DIR("?")=$$GET^ABSVU1("ENTER COMBINATION NUMBER",$G(PLANG),"'^'") D ^DIR K DIR
 I $S($D(DTOUT):1,$D(DUOUT):1,$D(DIRUT):1,$D(DIROUT):1,1:"") K DTOUT,DUOUT,DIRUT,DIROUT S Y="" Q
 I '$D(ABSVX("LIST",+Y)) S X=$$GET^ABSVU1("INVALID SELECTION",$G(PLANG))_"*" D MSG^ABSVQ,PCOMB G SELECT
 S $P(Y,"^",2)=$O(^ABS(503330,DA,1,"AD",ABSV("SITE"),Y,0)) Q
PC1 ;PRINT COMBINATIONS FOR VOL (ABSVX("VOLDA")) AND SITE (ABSV("SITE")
 ;USING SEQUENTIAL COMBINATION NUMBERS
 N X,N,I,TAB
 S %=0,TAB=$S($D(ABSVX("NOWRITE")):40,1:48) I $S($D(ABSVX("VOLDA"))'["1":1,ABSVX("VOLDA")="":1,'$D(ABSV("SITE")):1,ABSV("SITE")="":1,1:0) Q
 I '$D(^ABS(503330,ABSVX("VOLDA"),1,"AD",ABSV("SITE"))) S X=$$GET^ABSVU1("NO COMBINATIONS",$G(PLANG),ABSV("SITE"))_".*" W !! D MSG^ABSVQ K ABSVX("LIST") W !! S Y="" Q
 W !!,$$GET^ABSVU1("VALID COMBINATIONS",$G(PLANG),$P(^ABS(503330,ABSVX("VOLDA"),0),"^"),ABSV("SITE")),! S N=0
 K ABSVX("LIST") F I=1:1 S N=$O(^ABS(503330,ABSVX("VOLDA"),1,"AD",ABSV("SITE"),N)) Q:'N  D
  . S X=$O(^ABS(503330,ABSVX("VOLDA"),1,"AD",ABSV("SITE"),N,0)) I '$D(^ABS(503330,ABSVX("VOLDA"),1,+X,0)) K ^ABS(503330,ABSVX("VOLDA"),1,"AD",ABSV("SITE"),N,+X) Q
  . S ABSVX("LIST",I)=X,ABSVX("LIST")=I
  . QUIT
 S N=0 F I=1:1 S N=$O(ABSVX("LIST",N)) Q:'N  D WR1
 Q
WR1 S X=ABSVX("LIST",N) W !,N,". " S X=$G(^ABS(503330,ABSVX("VOLDA"),1,X,0)) W:'$D(ABSVX("NOWRITE")) $P(X,"^",5),?13
 I $P(X,"^",2)]"",$D(^ABS(503334,$P(X,"^",2),0)) W $P(^(0),"^",2)
 E  W $$GET^ABSVU1("INVALID ORG",$G(PLANG)),*7 K ABSVX("LIST",N)
 W ?TAB I $P(X,"^",4)]"",$D(^ABS(503332,$P(X,"^",4),0)) W $E($P(^(0),"^",2),1,24)
 E  W $$GET^ABSVU1("INVALID SERVICE",$G(PLANG)),*7 K ABSVX("LIST",N) S ABSVX("LIST")=ABSVX("LIST")-1 I ABSVX("LIST")'>0 K ABSVX("LIST")
 W ! Q
SEL1 S ABSVOUT=1,Y=""
 I $D(ABSVX("LIST"))'=11 S X=$$GET^ABSVU1("NO COMBINATIONS",$G(PLANG),ABSV("SITE"))_".*" W !! D MSG^ABSVQ K ABSVX("LIST") W !! S Y="" Q
 I ABSVX("LIST")=1,$G(ABSVX("LIST",1))]"" S Y="1^"_ABSVX("LIST",1),ABSVOUT="0000" W !,"  "_$$GET^ABSVU1("AUTO SELECT",$G(PLANG)),*7,! Q
 S DIR(0)="NOA^1:"_ABSVX("LIST")_":0",DIR("A")=$$GET^ABSVU1("SELECT COMBINATION",$G(PLANG)),DIR("?")=$$GET^ABSVU1("ENTER COMBINATION NUMBER",$G(PLANG),"'^'") N DQ,DP D ^DIR K DIR
 S ABSVOUT=$D(DTOUT)_$D(DUOUT)_$D(DIRUT)_$D(DIROUT) K DTOUT,DUOUT,DIROUT,DIRUT I ABSVOUT S Y="" Q
 I '$D(ABSVX("LIST",+Y)) S X=$$GET^ABSVU1("INVALID SELECTION",$G(PLANG))_"*" D MSG^ABSVQ,PC1 G SEL1
 S $P(Y,"^",2)=ABSVX("LIST",+Y) Q
