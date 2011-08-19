RGEX05 ;BAY/ALS-LISTMANAGER ROUTINE FOR REMOTE PDAT IN EXCEPTION HANDLER ;10/04/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**23,20,31**;30 Apr 99
 ;Reference to RPCCHK^XWB2HL7 supported by IA #3144
 ;Reference to RTNDATA^XWBDRPC supported by IA #3149
EN(ICN) ;main entry point for RG EXCPT REMOTE PDAT
 D EN^VALM("RG EXCPT RPDAT")
 Q
HDR ;header code
 S VALMHDR(1)="MPI/PD REMOTE PATIENT DATA"
 S VALMHDR(2)=""
 Q
INIT ;
 K ^TMP("RGEXC5",$J)
 K @VALMAR
 I '$D(ICN) G EXIT
 S LIN=1,X=0,STR="",TXT=""
 S TXT="-> For ICN "_$P(ICN,"V",1) S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP
 S L=0 F  S L=$O(TFARR(L)) Q:'L  D
 . S SL=$P(TFARR(L),"^",1)
 . S STATUS=$P(TFL(SL),"^",3)
 . I STATUS["Handle" S STATUS="Error in Process"
 . E  I STATUS["New" S STATUS="Request Sent"
 . E  I STATUS["Running" S STATUS="Awaiting Response"
 . E  I STATUS["Done" S STATUS="Response Received"
 . S TXT="  "_$P(TFL(SL),"^")_"  status: ("_STATUS_")"
 . D ADDTMP
 . S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP D
 . S LOC=$P(TFL(SL),"^",2)
 . N STATUS,RETURN,RESULT,RET,RESULT
 . I '$D(^XTMP("RGPDAT"_ICN,0)) S TXT=" - No patient data query exists for this patient." S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP
 . I $D(^XTMP("RGPDAT"_ICN,LOC,0)) D
 .. S RETURN(0)=$P(^XTMP("RGPDAT"_ICN,LOC,0),"^")
 .. D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D
 ... D RTNDATA^XWBDRPC(.RET,RETURN(0)) D
 ... I $G(RET(0))<0 S TXT="No Data Returned Due To: "_$P(RET(0),"^",2,99) S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP Q
 ... I $G(RET)'="",$D(@RET) S GLO=RET F  S GLO=$Q(@GLO) Q:$QS(GLO,1)'=$J  S TXT=@GLO S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP
 ... S R="" F  S R=$O(RET(R)) Q:R=""  S TXT=RET(R) S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP ;**31
 K ICNARR,R,L,SL,LOC,TFL,GLO
 S VALMCNT=LIN-1
 Q
ADDTMP ;
 S ^TMP("RGEXC5",$J,LIN,0)=STR
 S ^TMP("RGEXC5",$J,"IDX",LIN,LIN)=""
 S LIN=LIN+1,STR=""
 Q
HELP ;
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ;
 S VALMBCK=""
 K ^TMP("RGEXC5",$J),LIN,X,STR,TXT
 S VALMBCK="R"
 Q
