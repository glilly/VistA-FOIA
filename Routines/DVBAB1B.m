DVBAB1B ;ALB/SPH - CAPRI UTILITIES ;09/30/2009
 ;;2.7;AMIE;**104,143**;Apr 10, 1995;Build 4
 ;
DPA(LIST,DFN,CHOICE) ;Display Patient Appointments
 N DVBABCNT,CKCHOICE
 S LIST="",DVBABCNT=1,CKCHOICE="A,F,P",DFN=$G(DFN),CHOICE=$G(CHOICE) K ^TMP("DVBAAPPT",$J)
 I DFN="" S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="MISSING PATIENT NAME",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ)) Q
 I CHOICE="" S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="MISSING ALL, PAST, OR FUTURE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ)) Q
 I CKCHOICE'[CHOICE S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="INVALID SELECTION",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ)) Q
 I CHOICE["A" D
 .S SDT=0
 .S X="T+730" D ^%DT
 .I Y<0 S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="ERROR IN CALCULATING ENDING DATE RANGE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ))
 .S EDT=Y+.9
 I CHOICE["F" D
 .S X="T+1" D ^%DT
 .I Y<0 S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="ERROR IN CALCULATING START DATE RANGE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ))
 .S SDT=Y
 .K X,Y
 .S X="T+730" D ^%DT
 .I Y<0 S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="ERROR IN CALCULATING ENDING DATE RANGE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ))
 .S EDT=Y+.9
 I CHOICE["P" D
 .S X="T" D ^%DT
 .I Y<0 S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="ERROR IN CALCULATING ENDING DATE RANGE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ))
 .S EDT=Y+.9
 .K X,Y
 .S SDT=0
 Q:LIST["ERROR"
 I $O(^DPT(DFN,"S",SDT))'>0 S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="NO APPOINTMENTS FOUND FOR YOUR DATE RANGE",LIST=$NA(^TMP("DVBAAPPT",$J,DUZ)) Q
 F  S SDT=$O(^DPT(DFN,"S",SDT)) Q:'SDT!(SDT>EDT)  D
 .S CLN=$P(^DPT(DFN,"S",SDT,0),"^") Q:'CLN
 .Q:'$D(^SC(CLN,0))
 .S CLN=$P(^SC(CLN,0),"^")
 .S ZZ=$L(CLN)
 .I ZZ<31 D
 ..F ZZZ=ZZ:1:30 S CLN=CLN_" "
 .S Y=SDT X ^DD("DD")
 .S ZZ2=$L(Y)
 .I ZZ2<21 D
 ..F ZZZ2=ZZ2:1:20 S Y=Y_" "
 .S STATUS=$P(^DPT(DFN,"S",SDT,0),"^",2)
 .I STATUS'="" D
 ..I STATUS="N" S STATUS="NO-SHOW"
 ..I STATUS="C" S STATUS="CANCELLED BY CLINIC"
 ..I STATUS="CA" S STATUS="CANCELLED BY CLINIC & AUTO RE-BOOK"
 ..I STATUS="NA" S STATUS="NO-SHOW & AUTO-REBOOK"
 ..I STATUS="I" S STATUS="INPATIENT APPOINTMENT"
 ..I STATUS="PC" S STATUS="CANCELLED BY PATIENT"
 ..I STATUS="PCA" S STATUS="CANCELLED BY PATIENT & AUTO RE-BOOK"
 ..I STATUS="NT" S STATUS="NO ACTION TAKEN"
 . I $D(^DPT(DFN,"S",SDT,"R")) S REMARK=$P(^DPT(DFN,"S",SDT,"R"),"^",1) ;ADDED
 .S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)=CLN_"  "_Y_" "_STATUS,DVBABCNT=DVBABCNT+1
 . I $D(REMARK) S ^TMP("DVBAAPPT",$J,DUZ,DVBABCNT)="   Cancellation Remarks: "_REMARK,DVBABCNT=DVBABCNT+1
 . I $D(REMARK) K REMARK
 .S LIST=$NA(^TMP("DVBAAPPT",$J,DUZ))
 K DFN,X,%DT,CLN,CHOICE,Y,SDT,EDT
 Q
 ;
CHECK(DVBRSLTS,DVBPATCH) ; Checks for KIDS Patch install
 ; RPC: DVBA CHECK PATCH
 ; Input:  DVBPATCH - Patch Number (i.e. DVBA*2.7*142)
 ; Output: Returns "1^Patch Is Installed" on success; 
 ;         otherwise returns "0^Patch Is Not Installed" 
 N DVBX
 S DVBX=$$PATCH^XPDUTL(DVBPATCH)
 S DVBRSLTS=$S(DVBX:"1^Patch Is Installed",1:"0^Patch Is Not Installed")
 Q
