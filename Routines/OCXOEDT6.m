OCXOEDT6 ;SLC/RJS,CLA -  Edit Site's Local Terms ;5/27/99  16:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 N OCXERR,OCXR,DIE,DIC,DR,X,Y,OCXD0,OCXREC,IOP,IOF,OCXEDIT
 ;
 I '$D(IOF) S IOP="HOME" D ^%ZIS K IOP
 ;
 S (OCXEDIT,OCXERR)=0 F  W @IOF,!! D LIST Q:$$EDIT($$LOOKUP)
 D:OCXEDIT QUE
 ;
 Q
 ;
LOOKUP() N DIC,X,Y S DIC("A")="Select National Term: ",DIC="^OCXS(860.9,",DIC(0)="AEQM" D ^DIC Q:(Y<0) 0 Q +Y
 ;
QUE ;
 D QUE^OCXOCMPV(30)
 W !!,"Expert system compiler queued to run in 30 seconds."
 W !,"You will be sent a Mailman bulletin when it has finished.",!!
 H 3
 Q
 ;
LIST ;
 N OCXD0,OCXCNT
 W !,?10,"Order Check National Terms",!
 S (OCXCNT,OCXD0)=0 F  S OCXD0=$O(^OCXS(860.9,OCXD0)) Q:'OCXD0  D  Q:(OCXCNT>9)
 .S OCXNAME=$P($G(^OCXS(860.9,OCXD0,0)),U,1) Q:'$L(OCXNAME)
 .S OCXCNT=OCXCNT+1
 .W !,?5,OCXNAME
 I OCXD0 W !!,?5," < Enter ?? to see the rest of the national terms on this list>"
 W !
 Q
 ;
EDIT(OCXD0) ;
 ;
 Q:'OCXD0 1
 ;
 N OCXF,OCXFN,OCXD1,OCXD2,DA,OCXCNT,OCXX,OCXQUIT,OCXSCR
 ;
 F  D  Q:OCXQUIT
 .;
 .S OCXQUIT=0 D CONV(OCXD0)
 .;
 .S OCXF=+$P(^OCXS(860.9,OCXD0,0),U,2)
 .S OCXSCR=$G(^OCXS(860.9,OCXD0,2))
 .W @IOF,!!,"National Term: ",$P(^OCXS(860.9,OCXD0,0),U,1)
 .I 'OCXF W !!,"  Database Error: Pointed to file not specified." S OCXD1=$$PAUSE,OCXQUIT=1 Q
 .S OCXFN=$$FILE^OCXBDTD(OCXF,"NAME")
 .I '$L(OCXFN) W !!,"  Database Error: Pointed to file (",OCXF,") does not exist." S OCXD1=$$PAUSE,OCXQUIT=1 Q
 .;
 .W !!,"  Translated from file: '",OCXFN,"'  ",+OCXF
 .;
 .W !
 .S OCXCNT=0,OCXD1="" F  S OCXD1=$O(^OCXS(860.9,OCXD0,1,"B",OCXD1)) Q:'$L(OCXD1)  D  Q:OCXQUIT
 ..S OCXD2="" F  S OCXD2=$O(^OCXS(860.9,OCXD0,1,"B",OCXD1,OCXD2)) Q:'OCXD2  D  Q:OCXQUIT
 ...W !,?5,$P(^OCXS(860.9,OCXD0,1,OCXD2,0),U,1),"    (",OCXD2,")"
 ...S OCXCNT=OCXCNT+1 I '(OCXCNT#10) S OCXQUIT=($$PAUSE*10)
 .;
 .Q:OCXQUIT
 .;
 .W ! S OCXD1=$$DIC(OCXF,$G(OCXSCR)) S OCXQUIT=(OCXD1<1) Q:OCXQUIT
 .;
 .I $D(^OCXS(860.9,OCXD0,1,+OCXD1,0)) D  Q
 ..I $$READ("Y","Do you want remove '"_$P(^OCXS(860.9,OCXD0,1,+OCXD1,0),U,1)_"    ("_(+OCXD1)_")' from the list ","NO") K ^OCXS(860.9,OCXD0,1,+OCXD1) W "  removed..." S OCXEDIT=1 H 2 Q
 ..W "  not removed..." H 2 Q
 .;
 .S ^OCXS(860.9,OCXD0,1,0)="^860.91IA^^"
 .S ^OCXS(860.9,OCXD0,1,+OCXD1,0)=$P(OCXD1,U,2)_U_(+OCXD1)
 .S OCXEDIT=1
 ;
 Q (OCXQUIT>1)
 ;
DIC(OCXDIC,OCXDICS) ;
 ;
 ;
 N X,Y,DIC,OCXDEL
 S DIC=+OCXDIC Q:'$G(DIC) 0
 S DIC(0)="AMNEQ",DIC("W")="W ""("",Y,"")"""
 S:$L($G(OCXDICS)) DIC("S")=$G(OCXDICS)
 D ^DIC
 Q:(+Y<1) 0 Q Y
 ;
CONV(OCXD0) ;
 ;
 N OCXREC1,OCXREC2,OCXF,OCXF0
 K OCXREC1,OCXREC2
 M OCXREC1=^OCXS(860.9,OCXD0)
 ;
 S OCXF=+$P(OCXREC1(0),U,2) Q:'OCXF
 ;
 K OCXREC1(1,"B"),OCXREC1(1,"C")
 S OCXD1=0 F  S OCXD1=$O(OCXREC1(1,OCXD1)) Q:'OCXD1  D
 .N OCXNAME,OCXPTR
 .S OCXPTR=+$P($G(OCXREC1(1,OCXD1,0)),U,2)
 .I 'OCXPTR K OCXREC1(1,OCXD1) Q
 .S OCXNAME=$$PTR(OCXF,+OCXPTR)
 .K OCXREC1(1,OCXD1)
 .Q:'$L(OCXNAME)
 .S OCXREC1(1,OCXD1,0)=OCXNAME_U_OCXPTR
 .S OCXREC1(1,"C",OCXPTR,OCXD1)=""
 ;
 S OCXREC2(0)=OCXREC1(0)
 S:$L($G(OCXREC1(2))) OCXREC2(2)=OCXREC1(2)
 I $D(OCXREC1(1,0)) D
 .N OCXD1,OCXD2,OCXD3,OCXX
 .S OCXREC2(1,0)=$P(OCXREC1(1,0),U,1,2)
 .S OCXD1=0 F  S OCXD1=$O(OCXREC1(1,"C",OCXD1)) Q:'OCXD1  D
 ..S OCXD2=0 F  S OCXD2=$O(OCXREC1(1,"C",OCXD1,OCXD2)) Q:'OCXD2  D
 ...Q:'$D(OCXREC1(1,OCXD2,0))
 ...N OCXT,OCXP
 ...S OCXT=$P(OCXREC1(1,OCXD2,0),U,1)
 ...S OCXP=$P(OCXREC1(1,OCXD2,0),U,2)
 ...S OCXREC2(1,OCXP,0)=OCXT_U_OCXP
 ...S OCXREC2(1,"B",OCXT,OCXP)=""
 ...S OCXREC2(1,"C",OCXP,OCXP)=""
 ...S OCXREC2(1,0)="^860.91IA^"_OCXP_U_($P($G(OCXREC2(1,0)),U,4)+1)
 ;
 K ^OCXS(860.9,OCXD0) M ^OCXS(860.9,OCXD0)=OCXREC2
 ;
 Q
 ;
PTR(FILE,D0) ;
 ;
 Q:'FILE ""
 Q:'D0 ""
 N REF,NAME
 S REF=$$FILE^OCXBDTD(+FILE,"GLOBAL NAME") Q:'$L(REF) ""
 X "S NAME=$P($G("_REF_D0_",0)),U,1)"
 Q NAME
 ;
PAUSE() N X W !!,"  Press <enter> to continue... " R X:DTIME W ! Q ((X[U)*10)
 ;
READ(OCX0,OCXA,OCXB,OCXL) ;
 N X,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCX0)) U
 S DIR(0)=OCX0
 S:$L($G(OCXA)) DIR("A")=OCXA
 S:$L($G(OCXB)) DIR("B")=OCXB
 F X=1:1:($G(OCXL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
