LRSLOW ;SLC/CJS/DALISC/FHS - MODIFIED FAST ENTRY ;8/11/97
 ;;5.2;LAB SERVICE;**100,121**;Sep 27, 1994
 K LRLONG
 S LRLONG=""
SHORT S LRPANEL=0,LROUTINE=$P(^LAB(69.9,1,3),U,2),LRPTP=-1 I '$D(LRLONG) W !,"BYPASSING ORDER ENTRY!!",$C(7)
 I $D(^LAB(69.9,1,"RO")),+$H'=^("RO") W $C(7),!,"ROLLOVER ",$S($P(^("RO"),U,2):"IS RUNNING.",1:"HAS NOT RUN.")," ACCESSIONING SHOULDN'T BE DONE NOW.",$C(7),!,"  Are you sure you want to continue"
 I $T S %=2 D YN^DICN W:%=0 !,"Not sure?" I %'=1 W !,"OK, try later." Q
SH W !,"Do you want to enter draw times" S %=2 D YN^DICN S LRADT=(%=1) Q:%=-1
 I %=0 W !,"If you answer 'yes', you will be asked for the approximate time the specimen",!,"was taken from the patient.  Otherwise, the current time will be assumed." G SH
AMIS K LRCDEF,LRCDEF0 I $D(LRAA),$P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D ^LRCAPV I LREND S LREND=0 G QUIT
 S U="^",X="N",%DT="T" D ^%DT S LRNT=Y,LRODT=DT,LRAD=DT,LRIDT=9999999-Y,LRCDT=Y_"^1",LRSAMP="",LRURG=4 K DFN,DIC S DIC(0)="EMQ"_$S($P(LRPARAM,U,6):"L",1:"") D ^LRDPA G:(LRDFN=-1)!$D(DUOUT)!$D(DTOUT) QUIT
 S:'$D(^LRO(69,LRODT,0)) ^(0)=$P(^LRO(69,0),U,1,2)_U_LRODT_U_(1+$P(^(0),U,4)),^LRO(69,LRODT,0)=LRODT,^LRO(69,"B",LRODT,LRODT)="" S %H=$H-60 D YMD^LRX S LRTM60=9999999-X
QSN1 D PT^LRX K DR S LRLLOC=$S($L(LRWRD):LRWRD,$D(^LR(LRDFN,.1)):^(.1),1:"UNKNOWN") D:$L(LRWRD) DPT^LRWU
Q12 I $D(LRLONG) D LOC^LRWU G QUIT:LREND
Q11 S LRPRAC="" I $D(LRLONG) D PRAC^LRWU1 I LREND W !!,$C(7),"ORDER CANCELED",!! G QUIT
 S LRLWC="",LRNN=1 D ^LROW1 G QUIT:'$D(X3) S S9=LRSPEC
QSN2 IF LRADT S %DT("A")="DRAW DATE/TIME: ",%DT(0)="-N",%DT="EATPX" D ^%DT K %DT G:Y<0 QUIT S LRCDT=Y_U,LRIDT=9999999-Y G QSN2:Y<1
 S LRSNO=LRDFN_U_DUZ_U_LRSAMP_"^^"_+LRCDT_U_LRPRAC_U_LRLLOC
 S LRNCWL=1 D REST^LROW2 K LRNCWL S ^LRO(69,LRODT,1,LRSN,1)=+LRCDT_"^^"_DUZ_"^C^^^^"_DUZ(2),^LRO(69,"AA",+$G(^(.1)),LRODT_"|"_LRSN)=""
 S LRSPEC=S9,LRTSTS=0,LRNOLABL=1 D ^LRWLST K LRNOLABL Q:'$D(LRAN)
LROE ;from LROE1
 S LRLLOC=$P(^LRO(69,LRODT,1,LRSN,0),U,7) S:'$L(LRLLOC) LRLLOC=0 K LROE
 S I1=0 F  S I1=$O(^LRO(69,LRODT,1,LRSN,2,I1)) Q:I1<1  S X=^(I1,0) I $P(X,U,4) S LRAA=$P(X,U,4),LRAN=$P(X,U,5),LRAD=$P(X,U,3) I '$D(LROE(LRAD_LRAA_LRAN)) S LROE(LRAD_LRAA_LRAN)="" D LROE1
 D QUIT Q:'$D(LRSLOW)  S LRLONG="" G SHORT
LROE1 S LRX=$G(^LRO(68,LRAA,0)) S LRIDIV=$S($L($P(LRX,U,19)):$P(LRX,U,19),1:"CP") I $P(LRX,U,2)="CH" D:$P(LRPARAM,U,14)&($P($G(^LRO(68,LRAA,0)),U,16)) ^LRCAPV D ^LRVER1
 I $P(LRX,U,2)="MI" S LRPTP=-1,LRMIDEF=$P(^LAB(69.9,1,1),U,10),LRMIOTH=$P(^(0),U,11) D PAT1^LRMIEDZ2 K LRMIDEF,LRMIOTH
 K LRX Q
QUIT K ^TMP("LR",$J,"TMP"),%,A,AGE,D1,D2,DFN,DIE,DL,DLAYGO,DOB,DQ,DR,DX,H8,I,J,K,LRAA,LRACC,LRAD,LRADT,LRAN,LRAP,LRCDT,LRCW,I1
 K LRCWDT,LRD,LRDAT,LRDEL,LRDFN,LRDPF,LRDV,LRDVF,LREAL,LREDIT,LREND,LRFFLG,LRFP,LRIDT,LRIN,LRINI,LRIX,DIC,LRORD,LRSB
 K LRLBLBP,LRLCT,LRLDT,LRLLOC,LRLONG,LRMETH,LRNAME,LRNG,LRNG2,LRNG3,LRNG4,LRNG5,LRNP,LRNT,LRNTN,LRNX,LRODT,LROUT,LROUTINE,LROWDT,LROWLE,LRPR,LRPRAC,LRRB,LRPTP,LRSAMP,LRSN,LRSPEC,LRSS,LRSSP,LRST,LRSUB,LRSUM,LRTB,LRTD,LRTEST
 K LRTN,LRTS,LRTX,LRUNQ,LRURG,LRUSI,LRUSNM,^TMP("LR",$J,"VTO"),LRWL0,LRWLC,LRWRD,LRXD,LRXDH,LRXDP,LRYR,PNM,S,S9,SEX,SSN,T,X,X1,Y,Z,LRACD,LRADDTST,LRAOD,LRBED,LRCSS,LRDTO,LREXEC,LRFLOG,LRGCOM,LRGVP,LRIOZERO,LRNIDT,LROCN,LROID,LROLRDFN
 K LRCCOM,LRCFL,LRCS,LRCSN,LRCSP,LRCSX,LREXP,LRLWC,LRM,LRMAX,LRNN,LRSNO,LRTSTN,LRTY,LRVF,LRVRM,LRXS,I5,S2,S5,T1,POP,X2,X3,X9,LRORDER,LRORDR,LRORDTIM,LRORIFN,LROSN,LRPER,LRPHSET,LRPLOC,LRSPCDSC,LRSSQ,LRSSX,LRSVSN,LRTEC,LRTJ,LRTP,LRTSTNM
 K LRTCOM,LROE,LRUR,LRVOL,LRWPC,PNM,LROLLOC,LRTREA,LRMAX2,LRMX,LRCAPLOC,LRCOM,LRXST,LRY,LRJ,LRLABKY,LRLBL,LRMA,LRMAX1,LRNOW,LRODTSV,LRPANEL,LRSNSV,LRTNSV D END^LRMIEDZ Q
EN S LRLONG="" G SHORT
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
