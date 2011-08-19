PRCALST ;SF-ISC/YJK-AR LIST,REPORT ;6/20/95  9:50 AM
V ;;4.5;Accounts Receivable;**17,63,107**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This is a routine for list of new accounts, accounts with
 ;incompleted data , RC/DOJ ,pending CALM code sheet.
PENDBIL ;list the pending CALM code sheet accounts.
 S PRCAHDR="@",(PRCAFT,PRCALAST)=",107",PRCATEMP="[PRCAT NEW AR]"
WRLST S DIC="^PRCA(430," S:'$D(PRCATEMP) PRCATEMP="[PRCA AR LIST]"
 S PRCASORT="DATE BILL PREPARED,@CURRENT STATUS:STATUS NUMBER"
 D PRINT^PRCAREPT Q
 ;
INCOMPL S PRCAHDR="INCOMPLETE ACCOUNTS RECEIVABLE",(PRCAFT,PRCALAST)=",101"
 D WRLST Q
 ;
NEWBILL ;list new bills
 S PRCAHDR="LIST OF NEW BILLS",(PRCAFT,PRCALAST)=",104"
 S PRCATEMP="[PRCA NEWB LIST]" D WRLST Q
 ;
WROFF ;list of written-off accounts receivable.
 S PRCAHDR="LIST OF WRITTEN-OFF ACCOUNTS RECEIVABLE",(PRCAFT,PRCALAST)=",109"
 D WRLST Q
 ;
ACTBIL ;list of active accounts receivable
 S PRCAHDR="LIST OF ACTIVE ACCOUNTS RECEIVABLE",(PRCAFT,PRCALAST)=",102"
 D WRLST Q
 ;
RETNAR ;returned AR list
 S PRCAHDR="RETURNED AR LIST",PRCASORT="@CURRENT STATUS:STATUS NUMBER,@DATE RETURNED TO SERVICE",PRCAFT="220,",PRCALAST="230,"
 S PRCATEMP="[PRCAC RETURN AR]",DIC="^PRCA(430," D PRINT^PRCAREPT Q
 ;
RC ;list of AR to be referred to RC
 N PRCA
 S PRCAHDR="ACCOUNTS RECEIVABLE POSSIBLE REFERRALS TO REGIONAL COUNSEL" D MINMAX
 S PRCASORT="DEBTOR,@OVER LETTER3,@RC/DOJ REFERRAL DATE,@CURRENT STATUS:STATUS NUMBER",PRCAFT=",30,@,102",PRCALAST=",,@,102",PRCATEMP="[PRCAL L DC-DOJ]",DIS(0)="I $D(^PRCA(430,D0,7)),+^(7)'<PRCAMIN,+^(7)'>PRCAMAX"
 S DIC="^PRCA(430,"
 S:$D(ZTSK) IOP=ION
 D @$S($D(ZTSK):"DIP^PRCAREPT",1:"PRINT^PRCAREPT")
 K DIOBEG,DIS,PRCAMIN,PRCAMAX Q
 ;
DOJ ;list of AR to be referred to Dept. of Justice.
 N PRCA
 S PRCAHDR="ACCOUNTS RECEIVABLE POSSIBLE REFERRALS TO DEPT. OF JUSTICE" D MINMAX
 S PRCASORT="DEBTOR,@OVER LETTER3,@RC/DOJ REFERRAL DATE,@CURRENT STATUS:STATUS NUMBER",PRCAFT=",30,@,102",PRCALAST=",,@,102",PRCATEMP="[PRCAL L DC-DOJ]",DIS(0)="I $D(^PRCA(430,D0,7)),+^(7)'<PRCAMAX"
 S DIC="^PRCA(430,"
 D @$S($D(ZTSK):"DIP^PRCAREPT",1:"PRINT^PRCAREPT")
 K DIOBEG,DIS,PRCAMIN,PRCAMAX Q
 ;
COWC ;List of the accounts referred to COWC.
 S PRCA("DATE")="DATE REFERRED TO COWC" D ASKDT^PRCAQUE I (PRCADT1="")!(PRCADT2="") K PRCADT1,PRCADT2 Q
 S PRCAHDR="ACCOUNTS RECEIVABLE REFERRED TO COWC",PRCATEMP="[PRCAD COWC LIST]",PRCASORT="REFERRAL DATE TO COWC,DEBTOR"
 S PRCAFT=PRCADT1_",",PRCALAST=PRCADT2_",",DIC="^PRCA(430,"
 D PRINT^PRCAREPT,END Q
 ;
MINMAX ;get the minimum and maximum referral amount to the RC/DOJ.
 ;Returns: PRCAMIN, PRCAMAX
 N PRCAKDA,Z0,Z1,Z2
 S PRCAMIN=1,PRCAMAX=5000,PRCAKDA=$O(^RC(342.1,"B","REGIONAL COUNSEL",0))
 I +PRCAKDA'>0 Q
 S Z1=$G(^RC(342.1,PRCAKDA,2))
 S Z2=+$P(Z1,"^",2),Z1=+Z1
 S:(Z1>0)&(Z2>0) PRCAMIN=Z1,PRCAMAX=Z2 K Z0,Z1,Z2,PRCAKDA
 Q
 ;
PRCOMM ;print comment field
 Q:'$D(D0)!('$D(PRCAPC))  Q:'$D(^PRCA(430,D0,3))  S PRCAKGL=$P(^(3),U,PRCAPC) G:PRCAKGL="" EXCOMM
 I $L(PRCAKGL)<70 W !,?3,PRCAKGL K PRCAKGL Q
 F PRCAK=70:-1:1 Q:$E(PRCAKGL,PRCAK)=" "
 W !,?3 F PRCAJ=1:1:PRCAK W $E(PRCAKGL,PRCAJ)
 W !,?3 F PRCAI=PRCAK+1:1:$L(PRCAKGL) W $E(PRCAKGL,PRCAI)
EXCOMM K PRCAKGL,PRCAK,PRCAJ,PRCAI Q
 ;
END K PRCA Q
 ;
 ;============== COUNT NEW CALM PENDING TRANSACTIONS=================
COUNTR I $O(^PRCA(433,"AE",1,0)) W *7,!!,"*** You have new transactions from the AR section pending CALM transmission *** "
 Q
 ;
RETN ;returned bills list
 NEW ZTSK,POP,PRCAP,PRCASVC
 D SVC^PRCABIL Q:'$D(PRCAP("S"))
 S PRCASVC=PRCAP("S")
 S %ZIS="MQ" D ^%ZIS G:POP Q1
 I $D(IO("Q")) S ZTRTN="RETNDQ^PRCALST",ZTDESC="Returned Bill List",ZTSAVE("PRCASVC")="" D ^%ZTLOAD G Q1
RETNDQ ;
 NEW BILL,STAT,DIC,L,FR,TO,FLDS
 I $E(IOST)="C" W @IOF
 F STAT=$O(^PRCA(430.3,"AC",220,0)),$O(^PRCA(430.3,"AC",230,0)) D
 .S BILL=0 F  S BILL=$O(^PRCA(430,"AC",STAT,BILL)) Q:'BILL  I $D(^PRCA(430,BILL,100)),$P(^(100),"^",2)=PRCASVC D
 ..S D0=BILL K DXS D ^PRCATP6 K DXS I $Y+15>IOSL D
 ...I $E(IOST)="C" W *7 W ! R X:DTIME I X["^"!'$T S STAT=-1 Q
 ...W @IOF
 ...Q
 ..Q
 .Q
Q1 D ^%ZISC Q
