ORMPS1 ;SLC/MKB - Process Pharmacy ORM msgs cont ; 10/01/09 7:38am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**86,92,94,116,134,152,158,149,190,195,215,265,275,243,280**;Dec 17, 1997;Build 85
 ;;Per VHA Directive 2004-038, this routine should not be modified.
UDOSE ; -- new Unit Dose order
 N ADMIN,QT,DRUG,INSTR,DOSE,RTE,SCH,OI,URG,WP,DUR,STR,DRGNM,X,PSOI,PSDD,S0,ID,LDOSE,XC,NTE,S0,RXR
 S ORDIALOG=+$O(^ORD(101.41,"AB","PSJ OR PAT OE",0))
 I $G(ORAPPT)>0 S ORDG=+$O(^ORD(100.98,"B","CLINIC ORDERS",0))
 E  S ORDG=+$O(^ORD(100.98,"B","UNIT DOSE MEDICATIONS",0))
 S ORPKG=+$$PKG("PSJ")
 D GETDLG1^ORCD(ORDIALOG) S QT=$G(ORQT(1))
 S DRUG=$$PTR("DISPENSE DRUG"),INSTR=$$PTR("INSTRUCTIONS")
 S DOSE=$$PTR("DOSE"),RTE=$$PTR("ROUTE")
 S SCH=$$PTR("SCHEDULE"),ADMIN=$$PTR("ADMIN TIMES")
 S OI=$$PTR("ORDERABLE ITEM"),URG=$$PTR("URGENCY")
 S WP=$$PTR("WORD PROCESSING 1"),DUR=$$PTR("DURATION")
 S STR=$$PTR("STRENGTH"),DRGNM=$$PTR("DRUG NAME")
UD1 S:RXO X=$P(RXO,"|",2),ORDIALOG(OI,1)=$$ORDITEM^ORM(X),PSOI=$P(X,U,4,5)
 I '$G(ORDIALOG(OI,1)) S ORERR="Missing or invalid orderable item" Q
 S PSDD=$P($$FIND^ORM(+RXE,3),U,4,5),ORDIALOG(DRUG,1)=+PSDD
 S S0=$$FIND^ORM(+RXE,26)_"&"_$P($$FIND^ORM(+RXE,27),U,5)
 S ID=$P(QT,U),LDOSE=$P(QT,U,8) I 'ID,S0 D
 . N UNT,PTRN S UNT=$P(S0,"&",2),PTRN="1.N1"""_UNT_""""
 . I LDOSE?@PTRN S $P(ID,"&",1,2)=+LDOSE_"&"_UNT Q  ;pre-POE orders
 . S:$P(PSOI,U,2)'[S0 ORDIALOG(STR,1)=$TR(S0,"&")
 I 'ID,'S0 S ORDIALOG(DRGNM,1)=$$UNESC^ORMPS2($P(PSDD,U,2))
 S:$L(ID) ORDIALOG(DOSE,1)=$$UNESC^ORMPS2($P(ID,"&",1,4)_"&"_LDOSE_"&"_+PSDD_"&"_S0)
 I LDOSE="" D  I LDOSE="" S ORERR="Unable to determine instructions" Q
 . I $G(RXC)'>0 D  Q  ;look for units/dose
 .. S LDOSE=$P(ID,"&",3),X=$P(ID,"&",4) I 'LDOSE S LDOSE="" Q
 .. S:'$L(X) X=$$UNESC^ORMPS2($P($$FIND^ORM(+RXE,7),U,5)) S:$L(X) LDOSE=LDOSE_" "_X
 .. S ORDIALOG(DRGNM,1)=$$UNESC^ORMPS2($P(PSDD,U,2)) ;force use of DD
 . F  D  Q:LDOSE'=""  S RXC=$O(@ORMSG@(RXC)) Q:'RXC  Q:$E(@ORMSG@(RXC),1,3)'="RXC"
 .. S XC=@ORMSG@(RXC) Q:+$P($P(XC,"|",3),U,4)'=+PSOI
 .. S LDOSE=$P(XC,"|",4)_$P($P(XC,"|",5),U,5) ;strength_units
 S ORDIALOG(INSTR,1)=$$UNESC^ORMPS2(LDOSE)
UD2 S NTE=$$NTE^ORMPS3(21) I NTE D
 . N CNT,I S CNT=1,^TMP("ORWORD",$J,WP,1,CNT,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 . I $O(@ORMSG@(NTE,0)) S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S CNT=CNT+1,^TMP("ORWORD",$J,WP,1,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 . S ^TMP("ORWORD",$J,WP,1,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(WP,1)="^TMP(""ORWORD"",$J,"_WP_",1)"
 S RXR=$$RXR^ORMPS I 'RXR S ORERR="Missing or invalid RXR segment" Q
 S ORDIALOG(RTE,1)=$P($P(RXR,"|",2),U,4),ORDIALOG(URG,1)=ORURG
 S X=$P(QT,U,2)
 S ORDIALOG(SCH,1)=$$UNESC^ORMPS2($P(X,"&"))
 S:$L($P(X,"&",2)) ORDIALOG(ADMIN,1)=$P(X,"&",2)
 S X=$P(QT,U,3) I $L(X) D  ;set only if previous order had duration
 . N IFN S IFN=$S($G(ORIFN):+ORIFN,$P(ZRX,"|",2):+$P(ZRX,"|",2),1:0)
 . S:$O(^OR(100,+IFN,4.5,"ID","DAYS",0)) ORDIALOG(DUR,1)=$$DURATION^ORMPS3(X)
 D DOSETEXT^ORCDPS2 ;reset Instructions text, SIG
 D UNESCARR^ORMPS2("ORDIALOG")
 Q
OUT ; -- new Outpt order
 N OI,SIG,INSTR,DOSE,RTE,SCH,DUR,SC,STR,DRUG,PI,CONJ,PSOI,PSDD,S0,X,I,RXR,J,NTE,ZSC,CNT,PC
 S ORDIALOG=+$O(^ORD(101.41,"AB","PSO OERR",0))
 S ORDG=+$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS",0))
 S ORPKG=+$$PKG("PSO") D GETDLG1^ORCD(ORDIALOG)
 S OI=$$PTR("ORDERABLE ITEM"),SIG=$$PTR("SIG")
 S INSTR=$$PTR("INSTRUCTIONS"),DOSE=$$PTR("DOSE")
 S SCH=$$PTR("SCHEDULE"),DUR=$$PTR("DURATION")
 S RTE=$$PTR("ROUTE"),SC=$$PTR("SERVICE CONNECTED")
 S STR=$$PTR("STRENGTH"),DRUG=$$PTR("DISPENSE DRUG")
 S PI=$$PTR("PATIENT INSTRUCTIONS"),CONJ=$$PTR("AND/THEN")
 S PC=$$PTR("WORD PROCESSING 1")
 S:RXO X=$P(RXO,"|",2),ORDIALOG(OI,1)=$$ORDITEM^ORM(X),PSOI=$P(X,U,4,5)
 I '$G(ORDIALOG(OI,1)) S ORERR="Missing or invalid orderable item" Q
 S PSDD=$P($$FIND^ORM(+RXE,3),U,4,5),ORDIALOG(DRUG,1)=+PSDD
 S S0=$$FIND^ORM(+RXE,26)_"&"_$P($$FIND^ORM(+RXE,27),U,5)
 I S0,$P(PSOI,U,2)'[S0 S ORDIALOG(STR,1)=$TR(S0,"&")
 I 'S0,'$G(ORQT(1)) S ORDIALOG($$PTR("DRUG NAME"),1)=$$UNESC^ORMPS2($P(PSDD,U,2))
OUT1 S ORDIALOG($$PTR("QUANTITY"),1)=$$FIND^ORM(+RXE,11)
 S ORDIALOG($$PTR("REFILLS"),1)=$$FIND^ORM(+RXE,13)
 S X=$$FIND^ORM(+RXE,23) S:$E(X)="D" X=+$E(X,2,99)
 S:X ORDIALOG($$PTR("DAYS SUPPLY"),1)=X
 I ZRX S X=$P(ZRX,"|",5) S:$L(X) ORDIALOG($$PTR("ROUTING"),1)=X
 S:ORURG ORDIALOG($$PTR("URGENCY"),1)=ORURG F I=1:1:ORQT D
 . S ORDIALOG(INSTR,I)=$$UNESC^ORMPS2($P(ORQT(I),U,8)),X=$P(ORQT(I),U)
 . S:$L(X) ORDIALOG(DOSE,I)=$$UNESC^ORMPS2($P(X,"&",1,4)_"&"_$P(ORQT(I),U,8)_"&"_+PSDD_"&"_S0)
 . S X=$P(ORQT(I),U,2) S:$L(X) ORDIALOG(SCH,I)=$$UNESC^ORMPS2(X)
 . S X=$P(ORQT(I),U,3) S:$L(X) ORDIALOG(DUR,I)=$$DURATION^ORMPS3(X)
 . S X=$P(ORQT(I),U,9) S:$L(X) ORDIALOG(CONJ,I)=$S(X="S":"T",1:X)
 S RXR=$$RXR^ORMPS I RXR S ORDIALOG(RTE,1)=$P($P(RXR,"|",2),U,4) D
 . S I=1,J=+RXR ;look for multiple RXR's
 . F  S J=$O(@ORMSG@(J)) Q:J'>0  S RXR=@ORMSG@(J) Q:$E(RXR,1,3)'="RXR"  S I=I+1,ORDIALOG(RTE,I)=$P($P(RXR,"|",2),U,4)
OUT2 S NTE=$$NTE^ORMPS3(6) I NTE D  ;Prov Comm ;D:'NTE PCOMM^ORMPS2
 . S CNT=1,^TMP("ORWORD",$J,PC,1,CNT,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 . I $O(@ORMSG@(NTE,0)) S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S CNT=CNT+1,^TMP("ORWORD",$J,PC,1,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 . S ^TMP("ORWORD",$J,PC,1,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(PC,1)="^TMP(""ORWORD"",$J,"_PC_",1)",ORDIALOG(PC,"FORMAT")="@" ;keep, don't show
 . N XCNT,XCOMM,XCOMMENT,XORCOMM,XXCNT,XORIFN
 . S XORIFN=$G(ORIFN) S:XORIFN="" XORIFN=$P(RXR,"|",2) Q:XORIFN=""
 . S XCOMM=$O(^OR(100,+XORIFN,4.5,"ID","COMMENT",0)) Q:XCOMM=""
 . S XCNT=0 F  S XCNT=$O(^TMP("ORWORD",$J,PC,1,XCNT)) Q:XCNT=""  S XCOMMENT=^TMP("ORWORD",$J,PC,1,XCNT,0) D
 .. S XORCOMM=$G(^OR(100,+XORIFN,4.5,XCOMM,2,XCNT,0)),XXCNT=0
 .. I XORCOMM="" F  S XXCNT=$O(^OR(100,+XORIFN,4.5,XCOMM,2,XXCNT)) Q:XXCNT=""  S XORCOMM=$G(^(XXCNT,0)) Q:XORCOMM'=""
 .. I $G(XCOMMENT)=$G(XORCOMM) S ORDIALOG(PC,"FORMAT")="@"
 S NTE=$$NTE^ORMPS3(7) I NTE D  ;Pat Instr
 . S CNT=1,^TMP("ORWORD",$J,PI,1,CNT,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 . I $O(@ORMSG@(NTE,0)) S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S CNT=CNT+1,^TMP("ORWORD",$J,PI,1,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 . S ^TMP("ORWORD",$J,PI,1,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(PI,1)="^TMP(""ORWORD"",$J,"_PI_",1)"
 S NTE=$$NTE^ORMPS3(21) I NTE D  ;Sig
 . S CNT=1,^TMP("ORWORD",$J,SIG,1,CNT,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 . I $O(@ORMSG@(NTE,0)) S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S CNT=CNT+1,^TMP("ORWORD",$J,SIG,1,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 . S ^TMP("ORWORD",$J,SIG,1,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(SIG,1)="^TMP(""ORWORD"",$J,"_SIG_",1)"
 . S ORDIALOG(PI,"FORMAT")="@" ;PI already included in Sig
OUT3 I '$G(ORQT(1))!('NTE) D DOSETEXT^ORCDPS2 ;reset Instructions text, Sig
 S ZSC=$$ZSC^ORMPS3,X=$P(ZSC,"|",2) I X?2.3U S ORDIALOG(SC,1)=$S(X="SC":1,1:0)
 Q
IV ; -- new IV order
 N IVTYP,IVTYPE S IVTYP=$P(ZRX,"|",7) I IVTYP="",$$NUMADDS^ORMPS3'>1 G UDOSE
 N SOLN,VOL,ADDS,STR,UNITS,RATE,URG,X,X1,X2,X3,I,J,TYPE,OI,WP,NTE,SCH
 N DAYS,ROUTE,ADMIN,RXR,ADDFREQ
 S ORDIALOG=+$O(^ORD(101.41,"AB","PSJI OR PAT FLUID OE",0))
 I +$G(ORAPPT)>0 S ORDG=+$O(^ORD(100.98,"B","CLINIC ORDERS",0))
 E  S ORDG=+$O(^ORD(100.98,"B",$S($P(ZRX,"|",7)="TPN":"TPN",1:"IV RX"),0))
 S ORPKG=+$$PKG("PSJ") D GETDLG1^ORCD(ORDIALOG)
 S SOLN=$$PTR("ORDERABLE ITEM"),VOL=$$PTR("VOLUME"),SCH=$$PTR("SCHEDULE")
 S RATE=$$PTR("INFUSION RATE") S:ORURG ORDIALOG($$PTR("URGENCY"),1)=ORURG
 S WP=$$PTR("WORD PROCESSING 1"),ADDS=$$PTR("ADDITIVE")
 S ADDFREQ=$$PTR("ADDITIVE FREQUENCY")
 S STR=$$PTR("STRENGTH PSIV"),UNITS=$$PTR("UNITS")
 S DAYS=$$PTR("DURATION"),IVTYPE=$$PTR("IV TYPE"),ADMIN=$$PTR("ADMIN TIMES")
IV1 S NTE=$$NTE^ORMPS3(21) I NTE D
 . N CNT,I S CNT=1,^TMP("ORWORD",$J,WP,1,CNT,0)=$$UNESC^ORMPS2($P(@ORMSG@(NTE),"|",4))
 . I $O(@ORMSG@(NTE,0)) S I=0 F  S I=$O(@ORMSG@(NTE,I)) Q:I'>0  S CNT=CNT+1,^TMP("ORWORD",$J,WP,1,CNT,0)=$$UNESC^ORMPS2(@ORMSG@(NTE,I))
 . S ^TMP("ORWORD",$J,WP,1,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(WP,1)="^TMP(""ORWORD"",$J,"_WP_",1)"
 N ORDAYS S ORDAYS=""
 S:$D(RXO) ORDAYS=$P($P(RXO,"|",2),"^",3)
 S:$L(ORDAYS) ORDAYS=$$IVLIM^ORMPS2(ORDAYS)
 S:$L(ORDAYS) ORDIALOG(DAYS,1)=ORDAYS
 S ORDIALOG(IVTYPE,1)=IVTYP
 S X=$P($$FIND^ORM(+RXE,25),U,5)
 S ORDIALOG(RATE,1)=$$FIND^ORM(+RXE,24)_$S($L(X):" "_X,1:""),(I,J)=0
 F  D  S RXC=$O(@ORMSG@(RXC)) Q:'RXC  Q:$E(@ORMSG@(RXC),1,3)'="RXC"
 . S X=@ORMSG@(RXC),TYPE=$P(X,"|",2),OI=$$ORDITEM^ORM($P(X,"|",3)) Q:'OI
 . S X1=$P(X,"|",4),X2=$P($P(X,"|",5),U,5),X3=$P(X,"|",6)
 . I $E(TYPE)="B" S J=J+1,ORDIALOG(SOLN,J)=OI,ORDIALOG(VOL,J)=X1 Q
 . S I=I+1,ORDIALOG(ADDS,I)=OI,ORDIALOG(STR,I)=X1,ORDIALOG(UNITS,I)=X2,ORDIALOG(ADDFREQ,I)=$$ADDFRQCV^ORMBLDP1(X3,"I")
IV2 ;
 S RXR=$$RXR^ORMPS
 S ROUTE=$P(RXR,"|",2)
 S ORDIALOG($$PTR("ROUTE"),1)=$P(ROUTE,U,4)
 I IVTYP="I" S X=$P($G(ORQT(1)),U,2) D
 .S:$L($P(X,"&")) ORDIALOG(SCH,1)=$P(X,"&")
 .S:$L($P(X,"&",2)) ORDIALOG(ADMIN,1)=$P(X,"&",2)
 D UNESCARR^ORMPS2("ORDIALOG")
 Q
PKG(NMSP) ; -- Return Package file ptr for NMSP
 N I S I=0
 F  S I=+$O(^DIC(9.4,"C",NMSP,I)) Q:I<1  Q:'$O(^(I,0))  ;no Addl Prefs
 Q I
PTR(NAME) ; -- Returns ien of prompt NAME in Order Dialog file #101.41
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_NAME,1,63),0))
QT ; -- Unpiece the Q/T field from RXE
 I 'RXE S ORQT(1)=ORQT,ORQT=1 Q  ; nothing to reset
 N X,Y,I,J,P,SEG,DONE K ORQT
 S SEG=$G(@ORMSG@(+RXE)),X=$P(SEG,"|",2),(I,J,P,DONE)=0
 F  D  Q:DONE
 . S P=P+1,Y=$P(X,"~",P) I Y="" S DONE=1 Q
 . I P<$L(X,"~") S I=I+1,ORQT(I)=Y Q
 . I $L(SEG,"|")>2 S I=I+1,ORQT(I)=Y,DONE=1 Q
 . S J=+$O(@ORMSG@(+RXE,J)) I J'>0 S I=I+1,ORQT(I)=Y,DONE=1 Q
 . S SEG=$G(@ORMSG@(+RXE,J)),X=$P(SEG,"|"),P=1,I=I+1,ORQT(I)=Y_$P(X,"~")
 S ORQT=I Q:'ORQT  ; else reset ORSTRT, ORSTOP, ORURG
 S ORSTRT=$P(ORQT(1),U,4),ORSTOP=$P(ORQT(ORQT),U,5),ORURG=$P(ORQT(1),U,6)
 S:ORSTRT ORSTRT=$$FMDATE^ORM(ORSTRT) S:ORSTOP ORSTOP=$$FMDATE^ORM(ORSTOP) S:$L(ORURG) ORURG=$$URGENCY^ORM(ORURG)
 Q
