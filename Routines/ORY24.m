ORY24 ;SLC/MKB-Postinit for OR*3*24 ;4/16/98  16:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**24**;Dec 17, 1997
 ;
EN ; -- start here
 N X S X=$$GET^XPAR("ALL","ORPF DC OF GENERIC ORDERS")
 D:'$L(X) EN^XPAR("SYS","ORPF DC OF GENERIC ORDERS",1,2)
 S X=$$GET^XPAR("ALL","OR DC GEN ORD ON ADMISSION")
 D:'$L(X) EN^XPAR("SYS","OR DC GEN ORD ON ADMISSION",1,0)
 Q
 ;
TASK ; -- start here to task status update
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTDESC="Expire text orders more than 90 days old",ZTDTH=$H,ZTIO=""
 S ZTRTN="EXP^ORY24" D ^%ZTLOAD
 W !,"Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" queued."
 Q
 ;
EXP ; -- expire text orders more than 90 days old
 N ORPKG,ORALG,ORNOW,OROLD,ORIFN,OR0,OR3,ORSTRT,ORSTOP,ORLAST
 S ORPKG=+$O(^DIC(9.4,"C","OR",0)),ORALG=+$O(^DIC(9.4,"C","GMRA",0))
 S ORNOW=$$NOW^XLFDT,OROLD=$$FMADD^XLFDT(ORNOW,-90),ORIFN=0
 F  S ORIFN=$O(^OR(100,ORIFN)) Q:ORIFN'>0  S OR0=$G(^(ORIFN,0)),OR3=$G(^(3)) I "^1^2^7^12^13^14^15^"'[(U_$P(OR3,U,3)_U) D  ;still active
 . S ORSTRT=$P(OR0,U,8),ORSTOP=$P(OR0,U,9),ORLAST=$P(OR3,U)
 . I $P(OR0,U,14)=ORALG,ORSTRT,ORSTRT<OROLD D RESET(2,ORLAST) Q
 . Q:$P(OR0,U,14)'=ORPKG  ; ** generic orders only:
 . I ORSTOP D:ORSTOP'>ORNOW RESET(7) S:ORSTOP>ORNOW ^OR(100,"AE",ORSTOP,ORIFN)="" Q
 . I ORSTRT,ORSTRT<OROLD D RESET(7,ORLAST) Q
 Q
 ;
RESET(NEWSTS,STOP) ; -- reset terminal fields for ORIFN
 S:$G(NEWSTS) $P(^OR(100,ORIFN,3),U,3)=NEWSTS
 S:$G(STOP) $P(^OR(100,ORIFN,0),U,9)=STOP
 D SETALL^ORDD100(ORIFN)
 Q