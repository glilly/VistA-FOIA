IBXSC68 ; ;08/13/09
 D DE G BEGIN
DE S DIE="^DGCR(399,D0,""RC"",",DIC=DIE,DP=399.042,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DGCR(399,D0,"RC",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(3)=% S %=$P(%Z,U,4) S:%]"" DE(4)=% S %=$P(%Z,U,5) S:%]"" DE(5)=% S %=$P(%Z,U,6) S:%]"" DE(7)=% S %=$P(%Z,U,7) S:%]"" DE(9)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(6)=% S %=$P(%Z,U,10) S:%]"" DE(12)=% S %=$P(%Z,U,12) S:%]"" DE(13)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="IBXSC68",DQ=1+D G B
1 S DW="0;1",DV="MR*P399.2'",DU="",DLB="REVENUE CODE",DIFLD=.01
 S DE(DW)="C1^IBXSC68",DE(DW,"INDEX")=1
 S DU="DGCR(399.2,"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^DGCR(399,DA(1),"RC","B",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 I $P(^DGCR(399,DA(1),"RC",DA,0),U,5) K ^DGCR(399,DA(1),"RC","ABS",$P(^DGCR(399,DA(1),"RC",DA,0),U,5),$E(X,1,30),DA)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGCR(399,DA(1),"RC","B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^DGCR(399,DA(1),"RC",DA,0),U,5) S ^DGCR(399,DA(1),"RC","ABS",$P(^DGCR(399,DA(1),"RC",DA,0),U,5),$E(X,1,30),DA)=""
C1F1 N X,X1,X2 S DIXR=53 D C1X1(U) K X2 M X2=X D C1X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . I X(2)'=""&'$D(^TMP("IBCRRX",$J)) D DELPR^IBCU1(DA(1),X(2))
 G C1F2
C1X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",399.042,DIIENS,.01,DION),$P($G(^DGCR(399,DA(1),"RC",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",399.042,DIIENS,.15,DION),$P($G(^DGCR(399,DA(1),"RC",DA,0)),U,15))
 S X=$G(X(1))
 Q
C1F2 Q
X1 S DIC("S")="I +$P(^(0),U,3)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;2",DV="RNJ8,2",DU="",DLB="CHARGES",DIFLD=.02
 S DE(DW)="C2^IBXSC68"
 G RE
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 D 22^IBCU2
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 D 21^IBCU2
C2F1 Q
X2 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999)!(X<0) X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;3",DV="RNJ6,0X",DU="",DLB="UNITS OF SERVICE",DIFLD=.03
 S DE(DW)="C3^IBXSC68"
 G RE
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 D 32^IBCU2
C3S S X="" G:DG(DQ)=X C3F1 K DB
 S X=DG(DQ),DIC=DIE
 D 31^IBCU2
C3F1 Q
X3 K:X'?1.N X I $D(X) S:X=0 X=1
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;4",DV="RNJ9,2XI",DU="",DLB="TOTAL",DIFLD=.04
 S DE(DW)="C4^IBXSC68"
 G RE
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 S DGXRF=2 D TC^IBCU2 K DGXRF
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 S DGXRF=1 D TC^IBCU2 K DGXRF
C4F1 Q
X4 K:X?1.10N.1".".2N X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;5",DV="R*P399.1'",DU="",DLB="BEDSECTION",DIFLD=.05
 S DE(DW)="C5^IBXSC68"
 S DU="DGCR(399.1,"
 G RE
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 K ^DGCR(399,DA(1),"RC","ABS",$E(X,1,30),+^DGCR(399,DA(1),"RC",DA,0),DA)
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGCR(399,DA(1),"RC","ABS",$E(X,1,30),+^DGCR(399,DA(1),"RC",DA,0),DA)=""
C5F1 Q
X5 S DIC("S")="I $P(^(0),U,5)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;9",DV="NJ8,2",DU="",DLB="NON-COVERED CHARGE",DIFLD=.09
 G RE
X6 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999)!(X<0)!(X?.E1"."3.N) X
 Q
 ;
7 S DW="0;6",DV="*P81'",DU="",DLB="PROCEDURE",DIFLD=.06
 S DE(DW)="C7^IBXSC68"
 S DU="ICPT("
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 K ^DGCR(399,"ASC1",$E(X,1,30),DA(1),DA)
 S X=DE(7),DIC=DIE
 K ^DGCR(399,"ASC2",DA(1),$E(X,1,30),DA)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$E(X,1,30),DA(1),DA)=""
 S X=DG(DQ),DIC=DIE
 I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$E(X,1,30),DA)=""
C7F1 Q
X7 S ICPTVDT=$$BDATE^IBACSV($G(DA(1))),DIC("S")="I $$CPTACT^IBACSV(+Y,ICPTVDT)",DIC("W")="D EN^DDIOL(""   ""_$P($$CPT^IBACSV(+Y,ICPTVDT),U,2),,""?0"")" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I '$P(^DGCR(399,DA(1),"RC",DA,0),U,6) S Y="@658"
 Q
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="0;7",DV="P40.8'X",DU="",DLB="DIVISION",DIFLD=.07
 S DE(DW)="C9^IBXSC68"
 S DU="DG(40.8,"
 G RE
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 K ^DGCR(399,"ASC1",+$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA(1),DA)
 S X=DE(9),DIC=DIE
 K ^DGCR(399,"ASC2",DA(1),+$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA)
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA(1),DA)=""
 S X=DG(DQ),DIC=DIE
 I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA)=""
C9F1 Q
X9 Q
10 S DQ=11 ;@658
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I +$P(^DGCR(399,DA(1),"RC",DA,0),U,8) S Y="@659"
 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW="0;10",DV="S",DU="",DLB="TYPE",DIFLD=.1
 S DE(DW)="C12^IBXSC68"
 S DU="1:INPT BS;2:OPT VST DT;3:RX;4:CPT;5:PROS;6:DRG;9:UNASSOCIATED;"
 G RE
C12 G C12S:$D(DE(12))[0 K DB
 D ^IBXSC612
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 ;
C12F1 Q
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW="0;12",DV="S",DU="",DLB="COMPONENT",DIFLD=.12
 S DU="1:INSTITUTIONAL;2:PROFESSIONAL;"
 G RE
X13 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I $P($G(^DGCR(399,DA(1),"RC",DA,0)),U,10)'=4!'$P(^DGCR(399,DA(1),"RC",DA,0),U,6) S Y="@659"
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 D LINKCPT^IBCEU5(DA(1),DA)
 Q
16 S DQ=17 ;@659
17 G 1^DIE17
