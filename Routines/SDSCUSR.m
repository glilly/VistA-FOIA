SDSCUSR ;ALB/JAM/RBS - ASCD User Total Report ; 1/19/07 1:28pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This report gives a total of the number of encounters that meet
 ;  the criteria: SC='Yes', auto-verified, and changed
 Q
EN ;  Entry Point
 N DIR,X,Y,SDSCDVSL,SDSCDVLN,ZTQUEUED,POP,ZTRTN,ZTDTH,ZTDESC,ZTSAVE
 ;  Get start and end date for report
 D GETDATE^SDSCOMP I SDSCTDT="" G EXIT
 ; Get Divisions
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BEG^SDSCUSR",ZTDTH=$H,ZTDESC="ASCD User Total Report"
 . S ZTSAVE("SDSCBDT")="",ZTSAVE("SDSCEDT")="",ZTSAVE("SDSCDVSL")=""
 . S ZTSAVE("SDSCDVLN")="",ZTSAVE("GROUP")="",ZTSAVE("SDEDT")="",ZTSAVE("SDSCTDT")=""
 . K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED"
 ;
BEG ; Begin report
 N P,L,SDABRT,CT,SDSCDIV,SDSCDNM,THDR,SDI
 S (P,L,SDABRT,CT)=0
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D FND G EXT
 I SDSCDIV'="" D
 . S THDR=""
 . F SDI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",SDI) Q:SDSCDIV=""  D  Q:$G(SDABRT)=1
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1),THDR=THDR_SDSCDNM_",",CT=CT+1 D FND
 G EXT
 ;
FND ;
 N SDORG,SDOEDT,SDOE,EDNM,SDSCDATA,UIEN,UNAME,TYP,TOTAL,LEV1,COL,AMT
 K ^TMP("SDSCUSR",$J)
 S SDOEDT=SDSCTDT
 F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT!(SDOEDT="")  D
 . S SDOE=""
 . F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:SDOE=""  D
 .. I SDSCDIV'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. S EDNM=0,SDORG=$P($$SCHNG^SDSCUTL(SDOE),U,2)
 .. F  S EDNM=$O(^SDSC(409.48,SDOE,1,EDNM)) Q:'EDNM  D
 ... S SDSCDATA=^SDSC(409.48,SDOE,1,EDNM,0),UNAME=""
 ... S UIEN=$P(SDSCDATA,U,3) I UIEN'="" S UNAME=$$UP^XLFSTR($$NAME^XUSER(UIEN,"F"))
 ... I $P(SDSCDATA,U,6)=1 D STORE("REVIEW")
 ... I $P(SDSCDATA,U,5)=SDORG D STORE("NO CHANGE") Q
 ... I SDORG,$P(SDSCDATA,U,5)=0 D STORE("SCNSC") Q
 ... I 'SDORG,$P(SDSCDATA,U,5) D STORE("NSCSC")
 ;
PRT ; Print
 K TOTAL
 S SDHDR="User Summary Data Report"
 D HDR Q:$G(SDABRT)=1
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S TOTAL(TYP)=0
 S LEV1=""
 F  S LEV1=$O(^TMP("SDSCUSR",$J,LEV1)) Q:LEV1=""  D  Q:$G(SDABRT)=1
 . I L+4>IOSL D HDR Q:$G(SDABRT)=1
 . W !,LEV1 S L=L+1
 . S COL=30 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 .. S AMT=+$G(^TMP("SDSCUSR",$J,LEV1,TYP)),DTOT(LEV1,TYP)=$G(DTOT(LEV1,TYP))+AMT,TOTAL(TYP)=$G(TOTAL(TYP))+AMT
 .. W ?COL,$J(AMT,7)
 I $G(SDABRT)=1 Q
 S COL=30,L=L+1 W ! I L+4>IOSL D HDR Q:$G(SDABRT)=1
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 . W ?COL,"-------"
 S COL=30,L=L+1 W !,"TOTAL"
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 . W ?COL,$J($G(TOTAL(TYP)),7)
 Q
 ;
EXT ;
 I CT>1,$G(SDABRT)'=1 D PRTT
 D RPTEND^SDSCRPT1
 ;
EXIT ;
 K SDNWPV,SDPVCN,SDSCBDT,SDSCEDT,SDSCDATA,SDSCDIV,SDSCDNM,DIV,EDIV,TOTAL
 K SDHDR,SDSCTDT,SDEDT,I,L,P,SUBTOT,Y,POP,GROUP,SCLN,DTOUT,DUOUT,DTOT
 K ^TMP("SDSCUSR",$J) K LEV1,TYP
 Q
 ;
STORE(VAL) ; Total up and Store
 S ^TMP("SDSCUSR",$J,UNAME,VAL)=$G(^TMP("SDSCUSR",$J,UNAME,VAL))+1
 S ^TMP("SDSCUSR",$J,UNAME,VAL,SDOE)=""
 K VAL
 Q
 ;
HDR ;  Header
 U IO D STDHDR^SDSCRPT2 Q:$G(SDABRT)=1
 S SDNWPV=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"For Encounters Dated ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)_"  By Division: "_SDSCDNM
 W !?35,"SET to REVIEW",?50,"SC to NSC",?61,"NSC to SC",?72,"SC KEPT",!
 F I=1:1:79 W "-"
 Q
 ;
HDR1 ;
 N HHDR,HHDR1,HHDR2,HHDR3,HHDR4,I
 U IO D STDHDR^SDSCRPT2 Q:$G(SDABRT)=1
 I $E(THDR,$L(THDR))="," S THDR=$E(THDR,1,$L(THDR)-1)
 W SDHDR,?67,"PAGE: ",P
 S HHDR1="For Encounters Dated "_$$FMTE^XLFDT(SDSCTDT,2)_" THRU "_$$FMTE^XLFDT(SDEDT,2)_" TOTAL for "
 S HHDR2=THDR
 I $L(HHDR1)+$L(HHDR2)>IOM D
 . S HHDR3=$P(HHDR2,",",1),HHDR4=$P(HHDR2,",",2,99)
 . S HHDR=HHDR1_HHDR3
 . I HHDR4'="" S HHDR=HHDR_","
 I $L(HHDR1)+$L(HHDR2)'>IOM D
 . S HHDR=HHDR1_HHDR2
 W !,HHDR
 I $G(HHDR4)'="" W !,?5,HHDR4
 W !?40," REVIEW",?50,"SC CHNG",?60,"SC KEPT",!
 F I=1:1:79 W "-"
 Q
 ;
PRTT ;
 D HDR1 Q:$G(SDABRT)=1
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S TOTAL(TYP)=0
 S LEV1=""
 F  S LEV1=$O(DTOT(LEV1)) Q:LEV1=""  D
 . I L+4>IOSL D HDR1 Q:$G(SDABRT)=1
 . W !,LEV1 S L=L+1
 . S COL=30 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 .. S AMT=DTOT(LEV1,TYP),TOTAL(TYP)=$G(TOTAL(TYP))+AMT
 .. W ?COL,$J(AMT,7)
 S COL=30,L=L+1 W ! I L+4>IOSL D HDR1 Q:$G(SDABRT)=1
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 . W ?COL,"-------"
 S COL=30,L=L+1 W !,"TOTAL"
 F TYP="REVIEW","SCNSC","NSCSC","NO CHANGE" S COL=COL+10 D
 . W ?COL,$J($G(TOTAL(TYP)),7)
 Q
