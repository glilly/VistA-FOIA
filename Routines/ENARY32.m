ENARX32 ;(WIRMFO)/SAW/DH/SAB-EQUIPMENT INV. ARCHIVE ;1/10/2001
 ;;7.0;ENGINEERING;**40,68**;Aug 17, 1993
 D DT^DICRW S %=1,U="^",DSEC=0
 I $D(DIFQ(0)) W !,"SHALL I WRITE OVER EXISTING DATA DEFINITIONS" S %=2 D YN^DICN
 S NO=$P("I 0^I $D(@X)#2,X[U",U,%) I %<1 K DIFQ Q
 I %=1,$D(DIFQ(0)) W !,"SHALL I WRITE OVER FILE SECURITY CODES" S %=2 D YN^DICN S DSEC=%=1 I %<1 K DIFQ Q
 Q:'$D(DIFQ)  S %=0 W !!,"ARE YOU SURE EVERYTHING'S OK" D YN^DICN I %-1 K DIFQ Q
 D DT^DICRW K ^UTILITY(U,$J),^UTILITY("DIK",$J) D WAIT^DICD F R=1001:1:1003 D @("^ENARX3"_$E(R,3,4)) W "."
 F D=6919.3,6919.31,6919.313,6919.32,6919.33,6919.34,6919.35 D IX
DATA W "." S (D,DDF(1),DDT(0))=$O(^UTILITY(U,$J,0)) Q:D'>0
 I '$D(DIFQ(D)) S DTO=0,DMRG=1,DTO(0)=^UTILITY(U,$J,D),Z=^(D)_"0)",D0=^(D,0),@Z=D0,DFR(1)="^UTILITY(U,$J,DDF(1),D0,",DKP='$D(DIFQR(D)) F D0=0:0 S D0=$O(^UTILITY(U,$J,DDF(1),D0)) Q:'$D(^(D0,0))  S Z=^(0) D I^DITR
 K ^UTILITY(U,$J,DDF(1)),DDF,DDT,DTO,DFR,DFN,DTN G DATA
 ;
W S Y=$P($T(@X),";",2) W !,"NOTE: THIS PACKAGE ALSO CONTAINS "_Y_"S",! Q:'$D(DIFQ(0))
 S %=2 W ?5,"SHALL I WRITE OVER EXISTING "_Y_"S OF THE SAME NAME" D YN^DICN I %-1 S DIFQ(X)=0 K:%<1 DIFQ
 Q
 ;
OPT ;OPTION
ROU ;ROUTINE DOCUMENTATION NOTE
FUNC ;FUNCTION
BULL ;BULLETIN
SE ;SECURITY KEY
HELP ;HELP FRAME
DIPT ;PRINT TEMPLATE
DIE ;INPUT TEMPLATE
DIBT ;SORT TEMPLATE
 ;
IX W "." S DIK="A" F %=0:0 S DIK=$O(^DD(D,DIK)) Q:DIK=""  K ^(DIK)
 S DA(1)=D,DIK="^DD("_D_"," D IXALL^DIK
 I $D(^DIC(D,"%",0)) S DIK="^DIC(D,""%""," G IXALL^DIK
