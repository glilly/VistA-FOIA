LBRYRET ;ISC2/DJM-LIBRARY RETURN FROM ROUTING ;[ 11/26/97  4:36 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
EN I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
 D CKIN G:Y<0 EXIT S X=$O(^LBRY(681,"AC",LBRYLOC,0)) G:X="" NOT
CONT S (E,E0,E1)=0 D MORE
 G:'$D(A(1)) DISPLAY
CONT1 S E=0,V1=$O(^LBRY(682,"A1",LBRYLOC,9999998-YDT1)) G:V1="" INIT S E1=$O(^LBRY(682,"A1",LBRYLOC,V1,0)) F I=1:1 G:'$D(A(I)) INIT S:A(I)=E1 E=I G:E>0 INIT
INIT S E1=E-3 S:E1<1 E1=1 S E0=E1 D FWD1^LBRYCK0 G DISPLAY
CKIN W @IOF,?5,"VA Library Return from Routing for "_LBRYNAM
 S (YDT1,Y)=DT X ^DD("DD") W "   ",Y,! S YDT=Y
 S DIC="^LBRY(680,",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,4)=LBRYPTR&($P(^(0),U,2)="""")"
 D ^DIC K DIC("S")
 Q:Y<0  S (DA,LBRYLOC)=$P(Y,U),LBRYCLS=$P(Y,U,2)
 S LA0=$P(^LBRY(680.5,LBRYCLS,0),U),LA00=""
 S:$D(^LBRY(680,LBRYLOC,1)) LA00="  "_$P(^(1),U,5)
 S LA0="TITLE: "_LA0
 Q
MORE S N="",A(1)="",LA1="JOURNAL",LA2="DATE",LA3="V(I)",LA4="CPY'S"
 S LA5="COPIES",LA6="RECEIVED",LA7="ORD'D",LA8="COMPLETED"
 S LA9="DISPOSITION",LA10="RCV'D",LA12="SHELVED"
 F I=1:1 S:A(I)="" N=$O(^LBRY(682,"AC",LBRYLOC,N)) G:N="" MORE1 S A(I)=$O(^LBRY(682,"AC",LBRYLOC,N,A(I))) S:$O(^(A(I)))>0 A(I+1)=A(I) S:$O(^(A(I)))="" A(I+1)=""
MORE1 K A(I) S II=E Q
DISPLAY ;SHOW ISSUES
DISP0 W @IOF,?5,"VA Library Return from Routing",?60,YDT
 W !!,LA0,!,LA00,!!,"ID",?6,LA1,?41,LA2,?52,LA4,?59,LA4,?66,LA5
 W !,"NUM",?7,LA2,?20,LA3,?41,LA6,?52,LA7,?59,LA10,?66,LA12,!
 F I=1:1:77 W "-"
 W !
 S AA="",RTD=0 G:E0=0 ASK1 F I=E0:1:E1 S AA=^LBRY(682,A(I),1),RTD=0,RFLAG=0,MR=0,RTD1="" D RTED,DISPX,DISP1
 ;  Display to user their options
ASK1 D ^LBRYRET0
 ;  Go select user's option.  State error prompt if needed
ASK3 G ASK3^LBRYRET0
RTED S MR=$O(^LBRY(682,A(I),4,MR)) Q:MR=""!(MR?.AP)  S BB=^LBRY(682,A(I),4,MR,0) S BB2=$P(BB,U,2),BB1=$P(BB,U) S:BB2=3&(BB1'="ToC") RTD=RTD+1 S:BB1="ToC" BB1=""
 I BB2=3,RTD<5 S RTD1=RTD1_BB1_"," G RTED
 I BB2=3,RTD'<5,RFLAG=0 S RTD1=$E(RTD1,1,$L(RTD1)-1)_"...",RFLAG=1
 G RTED
DISPX S AA1=$P(AA,U),AA2=$P(AA,U,2),AA3=$P(AA,U,3)
 S AA4=$P(AA,U,4),AA5=$P(AA,U,5),AA6=""
 S:$D(^LBRY(682,A(I),4,1,0)) AA6=$P(^(0),U,7) I AA4=0 S AA4=""
 S RTDA=$S(RTD=AA5:"   ALL",1:RTD1)
 S:AA3'="" AA2=AA2_"("_AA3_")" S Y=AA1 X ^DD("DD") S AA1=Y I AA6'="" S Y=AA6 X ^DD("DD") S AA6=Y
 Q
DISP1 W !,I,?5,AA1,?18,AA2,?40,AA6,?54,AA5,?61,AA4,?66,RTDA Q
NOT W !!,LA0,!!,"This title is not fully initialized."
 W !,"Please use SUPERVISOR option 1 and/or option 2 to set up this title."
 S XZ="Exit// " D PAUSE^LBRYUTL
 G LBRYRET
EXIT K %,%DT,%X,LA0,LA1,LA2,LA3,LA4,LA5,LA6,LA7,LA8,LA9,LA10,LA11,LA12,A,I
 K II,IA,I1,J,AA,AA1,AA2,AA3,AA4,AA5,AA6,AA7,AA8,AB,AB1,AB2,CA,CA1,DIC
 K DIW,DIWF,DIWL,DIWR,DIWT,DIWTC,DIWX,CLR,LL,DN,DR,DX,DY,N,O,X1,X2,XX
 K Z,LB,LB1,LB2,MM,E,E0,E1,V1,Y,YDT,YDT1,RRY,A,LA00,RTD,MR,BB,BB1,BB2
 K RTD1,RFLAG,RTDA,XZ,XT1,XT2,XT3,XT4,LS,LINE1,LINE2,XQH,XTA,XTB,XTC
 K XTD,XTE,LBX,RC,N1,N2,RR,RR1,RR2,RR7,RRX,RR4,RR5,RR8,Q,G1,G,G2,NUM
 K LBRYR,LBRYLOC,LBRYCLS,RRX0
 Q
