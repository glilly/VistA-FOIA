PRCVRCG ;ISC-SF/GJW; Receive messages ; 5/24/05 10:56am
 ;;5.1;IFCAP;**81**;Oct. 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SUB(PRCVACT) ;
 N PRCVFS,PRCVCS,PRCVRS,PRCVES,PRCVSS,HLQUIT,HLNODE
 N PRCVMSG,PRCVMID,PRCVSEG,X,PRCVEVN,PRCVEVT,PRCVSTAT,PRCVCP
 N HLQUIT,HLNODE,X1,MYERR,MYSEQ
 S PRCVFS=$G(HL("FS"))
 S PRCVCS=$E($G(HL("ECH")),1)
 S PRCVRS=$E($G(HL("ECH")),2)
 S PRCVES=$E($G(HL("ECH")),3)
 S PRCVSS=$E($G(HL("ECH")),4)
 S (HLQUIT,HLNODE)=0
 ;Note: the following variable is KILLed to avoid certain
 ;problems with $$REPROC^HLUTIL
 K HLDONE1
 S PRCVMSG=$G(HL("MTN"))
 S PRCVMID=$G(HL("MID"))
 I ((PRCVACT=1)&(PRCVMSG'="QSB"))!((PRCVACT=2)&(PRCVMSG'="QCN")) D  Q
 .;Error: wrong message type
 .S MYERR("HL_CODE")="HL200"
 .S MYERR("HL_TEXT")="Unsupported Message Type"
 .S MYSEQ("FIELD_POS")=9 ;message type
 .S MYSEQ("SEG_POS")=1
 .D ACK("AR",PRCVMID,"MSH",.MYSEQ,.MYERR)
 X HLNEXT I HLQUIT'>0 D  Q
 .;Error: MSH segment not found
 .S MYERR("HL_CODE")="HL100"
 .S MYERR("HL_TEXT")="Segment Sequence Error"
 .S MYSEQ("SEG_POS")=1
 .D ACK("AE",$G(PRCVMID),"MSH",1,.MYERR)
 X HLNEXT I HLQUIT'>0 D  Q
 .;Error: no segments after MSH
 S PRCVSEG=$$FLD^HLCSUTL(.HLNODE,1)
 I ((PRCVACT=1)&(PRCVSEG'="QPD")) D  Q
 .;Error: QPD segment expected
 .S MYERR("HL_CODE")="HL100"
 .S MYERR("HL_TEXT")="Segment Sequence Error"
 .S MYSEQ("SEG_POS")=2
 .D ACK("AE",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 I ((PRCVACT=2)&(PRCVSEG'="QID")) D  Q
 .;Error: QID segment expected
 .S MYERR("HL_CODE")="HL100"
 .S MYERR("HL_TEXT")="Segment Sequence Error"
 .S MYSEQ("SEG_POS")=2
 .D ACK("AE",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 S X=$$FLD^HLCSUTL(.HLNODE,$S(PRCVACT=1:2,PRCVACT=2:3,1:999))
 I (X="") D  Q
 .S MYERR("HL_CODE")="HL101"
 .S MYERR("HL_TEXT")="Required field missing"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=$S(PRCVSEG="QPD":1,PRCVSEG="QID":2,1:"")
 .D ACK("AE",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 S PRCVEVN=$P(X,PRCVCS,1)
 S PRCVEVT=$P(X,PRCVCS,2)
 I PRCVEVN'="Q16" D  Q
 .;Error: wrong event code
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=1
 .S MYSEQ("FIELD_POS")=$S(PRCVACT=1:2,PRCVACT=1:2)
 .S MYSEQ("CMP_POS")=1
 .D ACK("AR",PRCVMID,$S(PRCVACT=1:"QPD",1:"QID"),.MYSEQ,.MYERR)
 I PRCVEVT'="Fund_Subscription" D  Q
 .;Error: wrong event
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=$S(PRCVACT=1:2,PRCVACT=1:2)
 .S MYSEQ("CMP_POS")=2
 .D ACK("AR",PRCVMID,$S(PRCVACT=1:"QPD",1:"QID"),.MYSEQ,.MYERR)
 I ((PRCVACT=2)&(PRCVEVT'="Fund_Subscription")) D  Q
 .;Error: wrong event
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=2
 .S MYSEQ("CMP_POS")=2
 .D ACK("AR",PRCVMID,"QID",.MYSEQ,.MYERR)
 S X=$$FLD^HLCSUTL(.HLNODE,$S(PRCVACT=1:3,PRCVACT=2:2,1:999))
 I (X="") D  Q
 .S MYERR("HL_CODE")="HL101"
 .S MYERR("HL_TEXT")="Required field missing"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=$S(PRCVSEG="QPD":3,PRCVSEG="QID":2,1:"")
 .D ACK("AE",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 S PRCVSTAT=$P(X,"-",1)
 S PRCVCP=+$P(X,"-",2)
 I '$D(^PRC(420,PRCVSTAT,0)) D  Q
 .;invalid station number
 .S MYERR("HL_CODE")="HL204"
 .S MYERR("HL_TEXT")="Unknown key identfier"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=$S(PRCVSEG="QPD":2,PRCVSEG="QID":1,1:"")
 .D ACK("AR",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 I '$D(^PRC(420,PRCVSTAT,1,PRCVCP,0)) D  Q
 .;invalid station/FCP pair
 .S MYERR("HL_CODE")="HL204"
 .S MYERR("HL_TEXT")="Unknown key identfier"
 .S MYSEQ("SEG_POS")=2
 .S MYSEQ("FIELD_POS")=$S(PRCVSEG="QPD":2,PRCVSEG="QID":1,1:"")
 .D ACK("AR",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 G:PRCVACT=2 DEL
 S X1=$$ADDSUB^PRCVSUB(PRCVSTAT,PRCVCP,1)
 I $P(X1,"^",1)["?" D  Q
 .;Duplicate
 .;S MYERR("SEVERITY")="W"
 .D ACK("AA",PRCVMID)
 I $P(X1,"^",1)="E" D  Q
 .;Fileman generated error
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=2
 .D ACK("AR",PRCVSEG,.MYSEQ,.MYERR)
 G:PRCVACT=2 DONE ;end of message
 X HLNEXT I HLQUIT'>0 D  Q
 .;Error: RCP segment expected
 .S MYERR("HL_CODE")="HL100"
 .S MYERR("HL_TEXT")="Segment sequence error"
 .S MYSEQ("SEG_POS")=3
 .D ACK("AE",PRCVMID,PRCVSEG,.MYSEQ,.MYERR)
 G DONE
DEL ;
 S X1=$$DELSUB^PRCVSUB(PRCVSTAT,+PRCVCP,1)
 I X1["E" D  Q
 .;Error during Fileman call
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=1
 .S MYSEQ("FIELD_POS")=1
 .D ACK("AE",PRCVMID,"QID",.MYSEQ,.MYERR)
 I X1'["@" D  Q
 .;Deletion error
 .S MYERR("HL_CODE")="HL207"
 .S MYERR("HL_TEXT")="Application internal error"
 .S MYSEQ("SEG_POS")=1
 .S MYSEQ("FIELD_POS")=1
 .D ACK("AE",PRCVMID,"QID",.MYSEQ,.MYERR)
DONE ;
 ;Success!
 D ACK("AA",PRCVMID)
 Q
 ;
ACK(PRCVSTAT,PRCVOMID,PRCVSID,PRCVSEQ,PRCVERR) ;
 N HLA,ERR,I,SEV,PRCVEID,PRCVAPP,PRCVEIDS,PRCVRES
 ;Make sure the parameters are defined
 S PRCVSTAT=$G(PRCVSTAT),PRCVOMID=$G(PRCVOMID),PRCVSID=$G(PRCVSID)
 S HLA("HLA",1)="MSA"_PRCVFS_$G(PRCVSTAT)_PRCVFS_$G(PRCVOMID)
 S SEV=$S($D(PRCVERR("SEVERITY")):$G(PRCVERR("SEVERITY")),1:"E")
 ;set some variables
 S PRCVEID=$G(HL("EID"))
 S PRCVEIDS=$G(HL("EIDS"))
 ;S PRCVAPP=$$FIND1^DIC(771,,"MX","PRCV_DYNAMED")
 Q:(($L(PRCVEID)=0)!($L($G(HLMTIENS))=0)!($L(PRCVEIDS)=0))
 S PRCVRES=""
 S:PRCVSTAT="AA" HLA("HLA",1)=HLA("HLA",1)_PRCVFS_"OK"
 D:$L(PRCVSID)>0
 .S ERR="ERR"_PRCVFS_PRCVFS_PRCVSID_PRCVCS_$G(PRCVSEQ("SEG_POS"))
 .S ERR=ERR_PRCVCS_$G(PRCVSEQ("FIELD_POS"))_PRCVFS
 .;S ERR=ERR_PRCVCS_$G(PRCVSEQ("FIELD_POS"))_PRCVCS
 .;S ERR=ERR_$G(PRCVSEQ("FIELD_REP"))_PRCVCS_$G(PRCVSEQ("CMP_POS"))
 .;S ERR=ERR_PRCVCS_$G(PRCVSEQ("SUBCMP_POS"))_PRCVFS
 .;S ERR=ERR_$G(PRCVSEQ("FIELD_REP"))_PRCVFS
 .S ERR=ERR_$G(PRCVERR("HL_CODE"))_PRCVCS_$G(PRCVERR("HL_TEXT"))
 .S ERR=ERR_PRCVCS_"0357"_PRCVFS_SEV_PRCVFS
 .I $D(PRCVERR("APP",1)) D
 ..;application error(s)
 ..S ERR=ERR_$G(PRCVERR("APP",1,"CODE"))_PRCVCS_$G(PRCVERR("APP",1,"TEXT"))
 ..S I=1
 ..F  S I=$O(PRCVERR("APP",I)) Q:((I="")!(I>10))  D
 ...S ERR=ERR_PRCVRS
 ...S ERR=ERR_$G(PRCVERR("APP",I,"CODE"))_PRCVCS
 ...S ERR=ERR_$G(PRCVERR("APP",I,"TEXT"))
 .S HLA("HLA",2)=ERR
 D GENACK^HLMA1(PRCVEID,$G(HLMTIENS),PRCVEIDS,"LM",1,.PRCVRES)
 Q
 ;
PUBACK ;
 N PRCVFS,PRCVCS,PRCVRS,PRCVES,PRCVSS,HLQUIT,HLNODE,X
 N ATYPE,OMID,SEQ,ERR,I,X1,ECNT,RFAC
 S PRCVFS=$G(HL("FS"))
 S PRCVCS=$E($G(HL("ECH")),1)
 S PRCVRS=$E($G(HL("ECH")),2)
 S PRCVES=$E($G(HL("ECH")),3)
 S PRCVSS=$E($G(HL("ECH")),4)
 S (HLQUIT,HLNODE)=0
 ;Note: the following variable is KILLed to avoid certain
 ;problems with $$REPROC^HLUTIL
 K HLDONE1
 S PRCVMSG=$G(HL("MTN"))
 S PRCVMID=$G(HL("MID"))
 Q:HL("MTN")'="MFK"
 X HLNEXT ;read MSH
 I HLQUIT'>0 Q
 S X=$$FLD^HLCSUTL(.HLNODE,1)
 Q:X'="MSH"
 S RFAC=$P($$FLD^HLCSUTL(.HLNODE,6),PRCVCS,1)
 X HLNEXT ;read MSA
 I HLQUIT'>0 Q
 S X=$$FLD^HLCSUTL(.HLNODE,1)
 Q:X'="MSA"
 S ATYPE=$$FLD^HLCSUTL(.HLNODE,2)
 ;No need to go further
 Q
