IBATLM0 ;LL/ELZ - TRANSFER PRICING PT LIST LIST MANAGER ; 29-JAN-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(IBINST) ; -- main entry point for IBAT PATIENT LIST
 S $P(IBINST,"^",2)=$$GET1^DIQ(4,IBINST,.01)
 D EN^VALM("IBAT PATIENT LIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Patients with an Enrolled "_$S(IBINST["VISN":"VISN",1:"Facility")_" of "_$P(IBINST,"^",2)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("VALM DATA",$J),^TMP("VALMAR",$J),^TMP("IBAT0",$J)
 N IBIEN,IBDAT,IBSTRNG,IBNAM,IBXREF,IBCNT
 S IBXREF=$S($E($P(IBINST,"^",2),1,4)="VISN":"AC",1:"AD"),IBCNT=0
 W !,"Building List"
 S IBIEN=0 F  S IBIEN=$O(^IBAT(351.6,IBXREF,+IBINST,IBIEN)) Q:IBIEN<1  S ^TMP("IBAT0",$J,$P(^DPT(IBIEN,0),"^"),IBIEN)="",IBCNT=IBCNT+1 W:'(IBCNT#100) "."
 S VALMCNT=0,IBNAM=""
 F  S IBNAM=$O(^TMP("IBAT0",$J,IBNAM)) Q:IBNAM=""  S IBIEN=0 F  S IBIEN=$O(^(IBNAM,IBIEN)) Q:IBIEN<1  D
 . S IBDAT=$G(^IBAT(351.6,IBIEN,0)) Q:IBDAT=""
 . S IBSTRNG=""
 . S IBSTRNG=$$ST(VALMCNT+1,IBSTRNG,"ITEM")
 . S IBSTRNG=$$ST($P(^DPT(+IBDAT,0),"^"),IBSTRNG,"NAME")
 . S IBSTRNG=$$ST($$EX^IBATUTL(351.6,.04,$P(IBDAT,"^",4)),IBSTRNG,"STATUS")
 . S IBSTRNG=$$ST($P($P($$INST^IBATUTL($S($P(IBDAT,"^",10):$P(IBDAT,"^",10),1:$P(IBDAT,"^",3))),"^"),","),IBSTRNG,"FAC")
 . S IBSTRNG=$$ST($$DAT1^IBOUTL($P(IBDAT,"^",5)),IBSTRNG,"INPT")
 . S IBSTRNG=$$ST($$DAT1^IBOUTL($P(IBDAT,"^",6)),IBSTRNG,"OUT")
 . S IBSTRNG=$$ST($$DAT1^IBOUTL($P(IBDAT,"^",7)),IBSTRNG,"RX")
 . S IBSTRNG=$$ST($S($$INSURED^IBCNS1(+IBDAT):" Y",1:" N"),IBSTRNG,"INS")
 . S VALMCNT=$$SETVALM^IBATUTL(VALMCNT,IBSTRNG,IBIEN)
 . S IBCNT=IBCNT+1 W:'(IBCNT#100) "."
 I 'VALMCNT D SET^VALM10(1," "),SET^VALM10(2,"No Patients found") S VALMCNT=2
 K ^TMP("IBAT0",$J)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("VALM DATA",$J),^TMP("VALMAR",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ST(A,B,C) ; -- calls VALM1 to set up string
 Q $$SETFLD^VALM1($$LOWER^VALM1(A),B,C)
