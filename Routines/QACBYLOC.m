QACBYLOC ;WCIOFO/ERC - Report by Location ;03/23/99
 ;;2.0;Patient Representative;**9**;07/25/1995
 ;
 N QACDV,QACDIV,QAC1DIV,QACDVFLG
 S QACRTN="QACBYLOC"
 D DATDIV^QACUTL0 G:QAQPOP EXIT
 I QACDV=0!(QACDV']"") S QACDVFLG=1
 ;if just for 1 division, get name of division
 I +$G(QAC1DIV) D INST^QACUTL0(QAC1DIV,.QACDVNAM)
 ;
 S QACDESC="Issue Totals by Location"
 K %ZIS,IOP S %ZIS="MQ" W ! D ^%ZIS I POP D EXIT Q
 I $D(IO("Q")) D  Q
 . S ZTDESC=QACDESC
 . S ZTRTN="START^QACBYLOC"
 . S ZTSAVE("QAQRANG")=""
 . S ZTSAVE("QACRTN")=""
 . D TASK^QACUTL0
 ;
START ;
 D SETUP^QACEMPE
 S QACROU="SET^QACBYLOC"
 ;loop through "D" crossreference (date range)
 D LOOP1^QACSPRD(QACROU,QAQNBEG,QAQNEND,.QACD0)
 D REPORT
 D EXIT
 Q
SET ;set array variables for each ROC in date range
 K QACDATA,QACDIV,QACIC,QACISS,QACLOC
 D ISSLOOP
 I '$D(QACIC) Q
 D GETS^DIQ(745.1,QACD0,"14;37","NIE","QACDATA")
 S QACD0X=QACD0_","
 ;if not integrated, division set to 0 for sorting purposes in ^TMP
 S QACDIV=$S('$G(QACDVFLG):$G(QACDATA(745.1,QACD0X,37,"E"),"Unknown"),1:0)
 S QACLOC=$G(QACDATA(745.1,QACD0X,14,"E"),"Unknown")
 D SETMP
 Q
ISSLOOP ;loop through issue codes for the ROC
 S QACEE=0
 F  S QACEE=$O(^QA(745.1,QACD0,3,QACEE)) Q:QACEE'>0  D
 . S QACIC(QACEE)=^QA(745.1,QACD0,3,QACEE,0)
 Q
SETMP ;set ^TMP global for report
 S QACEE=""
 F  S QACEE=$O(QACIC(QACEE)) Q:QACEE']""  D
 . S QACISS=QACIC(QACEE)
 . D GETS^DIQ(745.2,QACISS,".01;2","E","QACICEXT")
 . S QACISSX=QACISS_","
 . S QACISSC=$G(QACICEXT(745.2,QACISSX,.01,"E"))
 . I $G(QACISSC)']"" Q
 . S QACICHDR=$E($G(QACICEXT(745.2,QACISSX,.01,"E")),1,2)
 . S QACNAME=$G(QACICEXT(745.2,QACISSX,2,"E"))
 . S ^TMP(QACRTN,$J,"ROC",QACDIV,QACLOC,QACICHDR,QACISS)=$G(^TMP(QACRTN,$J,"ROC",QACDIV,QACLOC,QACICHDR,QACISS))+1
 . S ^TMP(QACRTN,$J,"COUNT","TOT")=$G(^TMP(QACRTN,$J,"COUNT","TOT"))+1
 . S ^TMP(QACRTN,$J,"COUNT",QACDIV)=$G(^TMP(QACRTN,$J,"COUNT",QACDIV))+1
 . S ^TMP(QACRTN,$J,"COUNT",QACDIV,QACLOC)=$G(^TMP(QACRTN,$J,"COUNT",QACDIV,QACLOC))+1
 . S QACICHDR=$E($G(QACICEXT(745.2,QACISSX,.01,"E")),1,2)
 . S QACNAME=$G(QACICEXT(745.2,QACISSX,2,"E"))
 . S ^TMP(QACRTN,$J,"ISS",QACISS)=QACISSC_"  "_QACNAME
 . S ^TMP(QACRTN,$J,"COUNT",QACDIV,QACLOC,QACICHDR)=$G(^TMP(QACRTN,$J,"COUNT",QACDIV,QACLOC,QACICHDR))+1
 Q
REPORT ;
 U IO
 S QACAA=""
 F  S QACAA=$O(^TMP(QACRTN,$J,"ROC",QACAA)) Q:QACAA']""  D  Q:QACQUIT
 . S QACBB=""
 . F  S QACBB=$O(^TMP(QACRTN,$J,"ROC",QACAA,QACBB)) Q:QACBB']""  D  Q:QACQUIT
 . . D HEADER Q:QACQUIT
 . . ;if not integrated this next line will not print
 . . I $G(QACAA)'=0 W !?15,"Total Issues for Division: "_QACAA_"    "_^TMP(QACRTN,$J,"COUNT",QACAA)
 . . W !?10,"Total Issues for Location: "_QACBB_"    "_^TMP(QACRTN,$J,"COUNT",QACAA,QACBB)
 . . S QACCC=""
 . . F  S QACCC=$O(^TMP(QACRTN,$J,"ROC",QACAA,QACBB,QACCC)) Q:QACCC']""  D  Q:QACQUIT
 . . . I $Y>(IOSL-6) D HEADER Q:QACQUIT
 . . . W !?5,QACCC_"    "_$P(^QA(745.2,$O(^QA(745.2,"B",QACCC,0)),0),U,3)
 . . . W ?72,^TMP(QACRTN,$J,"COUNT",QACAA,QACBB,QACCC)
 . . . S QACDD=0
 . . . F  S QACDD=$O(^TMP(QACRTN,$J,"ROC",QACAA,QACBB,QACCC,QACDD)) Q:QACDD'>0  D  Q:QACQUIT
 . . . . I $Y>(IOSL-6) D HEADER Q:QACQUIT
 . . . . W !,^TMP(QACRTN,$J,"ISS",QACDD),?72,^TMP(QACRTN,$J,"ROC",QACAA,QACBB,QACCC,QACDD)
 I '$D(^TMP(QACRTN,$J,"ROC")) D
 . D HEADER
 . W !!!?25,"No data to report."
 Q
HEADER ;
 S QACPAGE=$G(QACPAGE)+1
 I QACPAGE>1 D  Q:QACQUIT
 . W $C(7)
 . I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S QACQUIT=$S(Y'>0:1,1:0)
 W:$E(IOST)="C"!(QACPAGE>1) @IOF
 W !,QACDESC,?48,QACTODAY,?70,"PAGE ",QACPAGE
 W !?(80-$L(QACHDR2))/2,QACHDR2
 W !,"Issue Code",?25,"Issue Code Name",?70,"Total"
 W !,QACUNDL,!
 Q
EXIT ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 D K^QAQDATE
 K ^TMP(QACRTN,$J)
 K DIQ,DIR,IOSL,POP
 K QAC1DIV,QACAA,QACBB,QACCC,QACD0,QACD0X,QACDATA,QACDESC,QACDD,QACDIV
 K QACDV,QACDVNAM,QACDVFLG,QACHDR2,QACIC,QACICEXT,QACICHDR
 K QACEE,QACISS,QACISSC,QACISSX,QACLOC,QACNAME
 K QACPAGE,QACQUIT,QACROU,QACRTN,QACTIME,QACTODAY,QACUNDL
 K QAQNBEG,QAQNEND,QAQPOP,QAQRANG
 K X,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
