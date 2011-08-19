LRLL ;SLC/RWF - LOAD LIST CONTROL ;2/19/91  10:41 ;
 ;;5.2;LAB SERVICE;**21,116,153**;Sep 27, 1994
 K DIC,%ZIS,ZTSK,LRCTRL,LRDSPEC,LRALL,LRTEST
 S U="^",LRST=1,LRLLT=9999999,LRFULL=0,LRHOLD=+^LAB(69.9,1,3) D DT^LRX K DIC
 S DIC="^LRO(68.2,",DIC(0)="AEMZ",DIC("S")="S %=$P(^(0),U,12) X ""I '$L(%),'$D(^DIC(19.1,+%,0))"" Q:$T  S %=$P(^DIC(19.1,%,0),U,1) I $D(^XUSEC(%,DUZ))" D ^DIC G:Y<1 KILL S LRINST=+Y
L1 ;
 I $S($D(^LRO(68.2,LRINST,3)):^(3),1:0) W !,"Waiting for another build to finish.",$C(7),!!?5,"Type '^' to stop waiting." R X:DTIME G L1:X'[U G KILL
 S LRTRANS=+$P(Y(0),U,2),LRTYPE=+$P(Y(0),U,3),LRFULL=$P(Y(0),U,5),LRLLINIT=+$P(Y(0),U,7),LRMAXCUP=+$P(Y(0),U,4),LRLLP(1)=$P(Y(0),U,10)
 S LRTRANS=$S($D(^LAB(62.07,LRTRANS,.1)):^(.1),1:"S LRCUP=LRCUP+1"),LRLLINIT=$S($D(^LAB(62.07,LRLLINIT,.1)):^(.1),1:"Q")
 S LRPROF=$O(^LRO(68.2,LRINST,10,0)) I LRPROF<1 W !,"No profile defined." D KILL Q
 S B=$O(^LRO(68.2,LRINST,10,LRPROF))
PRO K DIC("S") I B>0 W !,"ALL PROFILES" S %=2 D YN^DICN G:%<0 KILL S:%=1 LRALL=1 I %'=1 S DIC="^LRO(68.2,"_LRINST_",10," D ^DIC Q:Y<1  S LRPROF=+Y
AS W !,"(C)ondensed or (E)xpanded list ? (req. 132 column format):C//" R LRFRMT:DTIME Q:'$T!(LRFRMT[U)  S LRFRMT=$E(LRFRMT) S:LRFRMT']"" LRFRMT="C" I LRFRMT'="C"&(LRFRMT'="E") W !,"Answer C or E" G AS
 D PROF^LRLL3,^LRLL1A
KILL K %,%DT,%H,%ZIS,A,AGE,AN,B,C,D,DA,DFN,DIB,DIC,DOB,E,G,G1,G2,G4,I,I1,J,J1,K,L,L1,L2,L3,LAST,LRAA,LRAAN,LRACC,LRAD,LRADD,LRALL,LRALTH,LRAN,LRCDT,LRCNT
 K LRCT,LRCTRL,LRCUP,LRDC,LRDEF,LRDOC,LRDPF,LRDSPEC,LRDWDT,LRDWL,LRDWLE,LREND,LRET,LREXEC,LRFRMT,LRFULL,LRHD,LRHDT,LRHOLD,LRIDT,LRIFN,LRIIX,LRIX,LRINST,LRINSTIT,LRLLOC,LRLLP,LRLLT,LRLLX,LRLST,LRLWN,LRMAXCUP,LRNOLABL,LRNOW,LRODNUM
 K LRLINE,LRLL,LRLL1,LRLL2,LRLLINIT,IO("Q")
 K LRORD,LRPCUP,LRPGM,LRPROF,LRPTRAY,LRPWDT,LRPWL,LRPWLE,LRSHORT,LRSN,LRSPEC,LRSP,LRSPLIT,LRST,LRSTAR,LRSTART,LRTECH,LRTEST,LRTI,LRTIME,LRTK,LRTP,LRTRACNT,LRTRANS,LRTRAY,LRTSL,LRTST,LRTSTLM,LRTSTS,LRTX,LRTYPE,LRURG,LRURX,LRUS,LRV
 K LRWDTL,LRWPROF,LRWRD,LRXPD,PNM,POP,S,S1,S2,SEX,SSN,T,T1,W,X,X9,Z
 Q
LOAD ;
 S:$D(ZTQUEUED) ZTREQ="@" S U="^",LRHD="Listing of Active Load Work List",LRHDT=(80-$L(LRHD))/2
 S LREND=0 D HEAD
 S I=0 F  S I=$O(^LRO(68.2,I)) Q:I<1  S X=0 F  S X=$O(^LRO(68.2,I,1,X)) Q:X<1!(LREND)  I $D(^(X,0)) S X=^(0) D
 . Q:'$D(^LRO(68,+$P(X,U,4),0))#2
 . S LRLWN=$P(^LRO(68.2,I,0),U),Y=$P(X,U,2),LRTECH=$P(X,U,3),LRAAN=$S($P(X,U,4)]"":$P(^LRO(68,$P(X,U,4),0),U),1:"Unknown") D WRITE
 I '$D(LRLWN) W !?20,"********   None Found   ********",! K LRHD,LRHDT,LREND,I,LRAAN Q
 W !," * = Greater than 1 DAY Old ",! K S,I,X,LREND,LRHD,LRHDT,LRLWN,LRTECH,LRAAN,AN
 Q
HEAD ;
 W @IOF W !?LRHDT,LRHD,!!,"Load Work List Name",?24,"Date ",?36,"User Name",?57,"Acession Area",!
 Q
WRITE ;
 I IOST["C",$Y>(IOSL-5) W !!," * = Greater than 1 DAY Old " R !!,"Press Any Key to Continue ... ""^"" to Escape ",AN:$S($D(DTIME):DTIME,1:60) I '$T!(AN["^") S LREND=1 Q
 D:$Y>(IOSL-5) HEAD S S=$S((DT-Y>1):"*",1:"") D DD^LRX W !?5,LRLWN,?22,Y_S,?34,$S($D(^VA(200,+LRTECH,0)):$P(^(0),U),1:"Unknown"),?60,LRAAN
 Q
ASK K %ZIS S %ZIS="QN" D ^%ZIS K:POP %ZIS Q:POP  I IO'=IO(0) S ZTRTN="LOAD^LRLL",ZTIO=ION,ZTDESC="Print Active Load Worklist " D ^%ZTLOAD K ZTDTH,ZTDESC,ZTIO,ZTRTN,IO("Q"),%ZIS W !,"Listing Queued To Device ",ION,! D ^%ZISC Q
 D LOAD K %ZIS D ^%ZISC Q
