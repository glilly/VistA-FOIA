RCRCVL1 ;ALB/CMS - TP POSSIBLE REFERRAL LIST BUILD ; 09/02/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLDL ; build active list for third party possible referrals list
 ; Send: RCSBN or RCS* sort variables in RCRCVLB
 ; Returns: TMP("RCRCVL", TMP("RCRCVLPT", TMP("RCRCVLBX and VALMCNT
 ;
 K ^TMP("RCRCVL",$J,"B")
 I '$O(RCSBN(0)) D BLDL^RCRCVL2
 ;
 N CNT,PRCABN,RCCNT,RCY
 S (RCCNT,CNT,PRCABN)=0
 F  S PRCABN=$O(RCSBN(PRCABN)) Q:'PRCABN  D
 .S CNT=RCSBN(PRCABN)
 .S RCCNT=$G(RCCNT)+1
 .D SCRN(PRCABN,RCCNT)
 .QUIT
 ;
 ;Add findings to list sorted by Pt. Name then Activation date
 D RESL
 ;
BLDLQ K RCSBN,RCSI,RCSIF,RCSIL,RCRCI Q
 ;
SCRN(PRCABN,RCCNT) ;
 ; add bill to screen list "B" sort (must Re Sequence List after)
 ; Send: PRCABN,RCCNT
 I '$G(^PRCA(430,+$G(PRCABN),0)) G SCRNQ
 N PRCA,RCY,RCBN0,X,Y S X=""
 S RCBN0=$G(^PRCA(430,+PRCABN,0))
 D BNVAR^RCRCUTL(PRCABN),DEBT^RCRCUTL(PRCABN)
 S RCY=$G(RCCNT),X=$$SETFLD^VALM1(RCY,X,"NUMBER")
 S RCY=$P($G(^DPT(+$P(RCBN0,U,7),0),"UNK"),U,1),X=$$SETFLD^VALM1(RCY,X,"PATIENT")
 S RCY=$P($P(RCBN0,U,1),"-",2),X=$$SETFLD^VALM1(RCY,X,"BILL")
 S RCY=$S($$REFST^RCRCUTL(PRCABN):"r",$$RETN^RCRCUTL(PRCABN):"x",1:""),X=$$SETFLD^VALM1(RCY,X,"REFER")
 S RCY=$S($$HD^RCRCUIB(PRCABN):"*",1:""),X=$$SETFLD^VALM1(RCY,X,"CATCHOLD")
 S RCY=$P($G(PRCA("CAT")),U,3),X=$$SETFLD^VALM1(RCY,X,"CAT")
 S RCY=$S($$MINS^RCRCUIB(PRCABN):"+",1:""),X=$$SETFLD^VALM1(RCY,X,"MULTIIN")
 S RCY=$G(PRCA("DEBTNM")),X=$$SETFLD^VALM1(RCY,X,"DEBTOR")
 S RCY=$$DATE($P(RCBN0,U,10)),X=$$SETFLD^VALM1(RCY,X,"DATE")
 S RCY=$$BILL^RCJIBFN2(PRCABN)
 S X=$$SETFLD^VALM1($J(+$P(RCY,U,1),9,2),X,"ORIGAMT")
 S X=$$SETFLD^VALM1($J(+$P(RCY,U,3),10,2),X,"CURAMT")
 S ^TMP("RCRCVL",$J,"B",$P($G(^DPT(+$P(RCBN0,U,7),0),"UNK"),U,1),+PRCABN)=X
SCRNQ Q
 ;
DATE(X) ; date in external format
 N Y S Y="" I X?7N.E S Y=$$FMTE^XLFDT(X,"5ZD")
 Q Y
 ;
RESL ;Build or Rebuild and sequence List with added or subtracted bill
 N PRCABN,RCPT,X,Y
 I '$D(^TMP("RCRCVL",$J,"B")) G RESLQ
 S VALMCNT=0
 S RCPT="" F  S RCPT=$O(^TMP("RCRCVL",$J,"B",RCPT)) Q:RCPT=""  D
 .S PRCABN=0 F  S PRCABN=$O(^TMP("RCRCVL",$J,"B",RCPT,PRCABN)) Q:'PRCABN  D
 ..S VALMCNT=VALMCNT+1
 ..S X=^TMP("RCRCVL",$J,"B",RCPT,PRCABN)
 ..S RCY=VALMCNT,X=$$SETFLD^VALM1(RCY,X,"NUMBER")
 ..S ^TMP("RCRCVL",$J,VALMCNT,0)=X
 ..S ^TMP("RCRCVL",$J,"IDX",VALMCNT,VALMCNT)=""
 ..S ^TMP("RCRCVLX",$J,VALMCNT)=VALMCNT_U_PRCABN
 ..S ^TMP("RCRCVLPT",$J,VALMCNT)=+$P(^PRCA(430,PRCABN,0),U,7)
 ..D FLDCTRL^VALM10(VALMCNT)
RESLQ Q
 ;RCRCVL1
