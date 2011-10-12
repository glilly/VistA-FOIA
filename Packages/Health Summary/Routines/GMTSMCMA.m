GMTSMCMA ; WAS/DCB\KER - Medicine 2.2 interface routine      ; 02/11/2003 [11/14/03 9:12am]
 ;;2.7;Health Summary;**4,47,49,61,62,69**;Oct 20, 1995
 ;                   
 ; External Refernces
 ;    DBIA 10064  KILL^XM
 ;    DBIA 10070  ^XMD
 ;    DBIA  1236  $$HL7^MCORMN
 ;    DBIA  3778  HL1^MCORMN
 ;    DBIA 10090  ^DIC(4,
 ;    DBIA 10000  NOW^%DTC
 ;    DBIA 10106  $$HLDATE^HLFNC
 ;    DBIA 10106  $$HLNAME^HLFNC
 ;    DBIA 10017  ^DD("DD")
 ;    DBIA 10106  $$FMDATE^HLFNC
 ;    DBIA 10106  $$FMNAME^HLFNC
 ;    DBIA 10072  REMSBMSG^XMA1C
 ;                  
HSUM(PATID,BDATE,EDATE,OCC,WH,ATYPE) ; Health Summary API
 N ARRAY,MESSAGE,MSH,HLECH,ST,ORD,MSTR,LOOP,MSTR,SAP,SNF,RAP,RNF,MST,PCI,VID
 N REC,LOC,QID,XDEST,WSF,MWDDC,WDC,QRL,BUILDER,LOOP,MESS1,MESS2,TMP,SUB
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,GMTSG
 S GMTSG=0 S:$L($T(HL1^MCORMN))>1 GMTSG=1
 S ARRAY="TMP(""HS"",$J)"
 S XMTEXT="TMP(""HS"",$J,"
 S MSTR="|^~\&",HLECH=$E(MSTR,2,4)
 F LOOP=1:1:5 S ST(LOOP)=$E(MSTR,LOOP,LOOP)
 S MESSAGE="TMP",SAP="HEALTH SUMMARY",RAP="MEDICINE",VID=2.1
 S REC=+$O(^DIC(4,"D",DUZ(2),"")),LOC=$P($G(^DIC(4,REC,0)),U,1)
 S (RNF,SNF)=LOC,RAP="Medicine",SAP="Health Summary",MST="HS",PCI="P"
 S @ARRAY@(1,0)=$$MSH(MSTR,SAP,SNF,RAP,RNF,MST,PCI,VID)
 S ATYPE=$S(ATYPE="F":"RD",ATYPE="C":"RD",1:"PG")
 S QRL=$$CONVERT("D",BDATE)_ST(2)_$$CONVERT("D",EDATE)
 S QFC="R",QLR=ATYPE_ST(2)_OCC,WSF=PATID,WDDC=WH
 S @ARRAY@(2,0)=$$QRD(WSF,WDDC,QFC,QLR,QRL)
 I +($G(GMTSG))'>0 D  Q:+ARRY=0
 . S XMSUB="Health Summary Request",XMDUN="HEALTH SUMMARY"
 . S XMY("G.MC MESSAGING SERVER")=""
 . S XMDUZ=".5"
 . D ^XMD I +($G(XMZ))=0 D KILL^XM S ARRY=0 Q
 . S MESS1=XMZ
 . D KILL^XM
 . S ARRY=$$HL7^MCORMN(MESS1) D:+ARRY=0 REMOVE(MESS1,+ARRY)
 I +($G(GMTSG))>0 D  Q:$G(^TMP("MCAR1",$J,1,0))=""
 . D HL1^MCORMN(SAP,PATID,BDATE,EDATE,OCC,ATYPE)
 K ^TMP("MCAR",$J) D:+($G(GMTSG))'>0 SLIT(ARRY)
 ;Below the "0" input to slit is a dummy input in this case
 D:+($G(GMTSG))>0 SLIT(0)
 K ^TMP("MCAR1",$J) D:+($G(GMTSG))'>0 REMOVE(MESS1,ARRY)
 Q
SLIT(ARRY) ; Reformat Array
 N LOOP,COUNT,BASE,MCOUNT,BUILDER
 S BUILDER=$S(+($G(GMTSG))'>0:("^XMB(3.9,"_ARRY_",2)"),1:"^TMP(""MCAR1"",$J)")
 S LOOP=0,(MCOUNT,COUNT)=0,SUB=1,BASE="^TMP(""MCAR"",$J)"
 F  S LOOP=$O(@BUILDER@(LOOP)) Q:LOOP=""  D SLITTER
 Q
SLITTER ; This will slit the message in a usable form
 N VALUE,ROY,ROUT,LINE
 S VALUE=@BUILDER@(LOOP,0),ROY=$E(VALUE,1,3)
 S ROUT=$S(ROY="MSH":"SMSH",ROY="PID":"SPID",ROY="OBR":"SOBR",ROY="OBX":"SOBX",ROY="MSH":"SMSH",1:"OTHER")
 S LINE="D "_ROUT_"(VALUE)"
 X LINE
 Q
SMSH(VALUE) ; Slit the message header
 N PROC,LOOP
 S MSTR=$E(VALUE,4,8),SUB=1
 F LOOP=1:1:5 S ST(LOOP)=$E(MSTR,LOOP,LOOP)
 S MCOUNT=MCOUNT+1,COUNT=1
 S PROC=$P($P(VALUE,ST(1),3),U,1)
 S @BASE@(MCOUNT,COUNT,1)="PROCEDURE"_U_U_PROC
 D SETREF(MCOUNT,COUNT,"PROCEDURE")
 Q
SPID(VALUE) ; Slit the PID
 S SUB=1
 Q
SOBR(VALUE) ; Slit the OBR
 N TEMP,XDATE
 S TEMP=$$CONVERTA("D",$P(VALUE,ST(1),8))
 S XDATE=TEMP,COUNT=COUNT+1,SUB=1
 S @BASE@(MCOUNT,COUNT,1)="DATE/TIME"_U_U_TEMP
 D SETREF(MCOUNT,COUNT,"DATE/TIME")
 S TEMP=$$CONVERTA("P200",$P(VALUE,ST(1),33))
 I TEMP'="" S COUNT=COUNT+1,@BASE@(MCOUNT,COUNT,1)="PRINCIPAL RESUILT INTERPRETER"_U_U_TEMP D SETREF(MCOUNT,COUNT,"PRINCIPAL RESULT INTERPRETER") S COUNT=COUNT+1
 S TEMP=$$CONVERTA("P200",$P(VALUE,ST(1),34))
 I TEMP'="" S COUNT=COUNT+1,@BASE@(MCOUNT,COUNT,1)="ASSISTANT RESUILT INTERPRETER"_U_U_TEMP  D SETREF(MCOUNT,COUNT,"ASSISTANT RESULT") S COUNT=COUNT+1
 S TEMP=$$CONVERTA("P200",$P(VALUE,ST(1),35))
 I TEMP'="" S COUNT=COUNT+1,@BASE@(MCOUNT,COUNT,1)="TECHNICIAN"_U_U_TEMP  D SETREF(MCOUNT,COUNT,"TECHNICIAN") S COUNT=COUNT+1
 Q
SOBX(VALUE) ; Slit the OBX
 N XDES,TEMP,FLDTYPE,UNITS,VAL
 S COUNT=COUNT+1
 S SUB=1,TEMP=$P(VALUE,ST(1),4),XDES=$P(TEMP,ST(2),2)
 S TEMP=$P(TEMP,ST(2),1),FLDTYPE=$P(TEMP,ST(3),3)
 S:FLDTYPE=+FLDTYPE XDES=XDES_";W"
 S VAL=$$CONVERTA(FLDTYPE,$P(VALUE,ST(1),6))
 S UNITS=$P(TEMP,ST(1),7)
 S @BASE@(MCOUNT,COUNT,1)=XDES_U_UNITS_U_VAL
 D SETREF(MCOUNT,COUNT,XDES)
 Q
OTHER(VALUE) ; Set the next sub node if the lines continue
 N TEMP,UNITS
 S TEMP=$P(VALUE,ST(1),1),UNITS=$P(VALUE,ST(1),2),SUB=SUB+1
 S @BASE@(MCOUNT,COUNT,SUB)=U_U_TEMP
 S:UNITS'="" $P(@BASE@(MCOUNT,COUNT,1),U,2)=UNITS
 Q
MSH(MSTR,SAP,SNF,RAP,RNF,MST,PCI,VID) ; MSH Messaging Line
 N MSH,Y,%,%I
 S MSH="MSH"_MSTR,$P(MSH,ST(1),3)=SAP,$P(MSH,ST(1),4)=SNF
 D NOW^%DTC S $P(MSH,ST(1),8)=$$CONVERT("D",%)
 S $P(MSH,ST(1),5)=RAP,$P(MSH,ST(1),6)=RNF,$P(MSH,ST(1),9)=MST
 S $P(MSH,ST(1),10)=PCI,$P(MSH,ST(1),11)=VID
 Q MSH
QRD(WSF,WDDC,QFC,QLR,QRL) ; QRD Messaging Line
 N QRD,Y,%,%I
 S QRD="QRD"
 D NOW^%DTC S $P(ORD,ST(1),2)=$$CONVERT("D",%)
 S $P(QRD,ST(1),3)=QFC,$P(QRD,ST(1),4)="I"
 S $P(QRD,ST(1),6)=$J,$P(QRD,ST(1),8)=QLR
 S $P(QRD,ST(1),9)=WSF,$P(QRD,ST(1),11)=WDDC,$P(QRD,ST(1),12)=QRL
 Q QRD
CONVERT(FILETYPE,RST) ; Convert FileMan to HL7
 N TEMP
 S TEMP=RST
 S:FILETYPE="D" TEMP=$$HLDATE^HLFNC(RST,"TS")
 S:FILETYPE="P" TEMP=$$HLNAME^HLFNC(RST)
 Q TEMP
CONVERTA(FILETYPE,RST) ; Convert HL7 to FileMan
 N TEMP,Y
 S TEMP=RST
 I FILETYPE["D" S Y=$$FMDATE^HLFNC(RST) X ^DD("DD") S TEMP=Y
 S:(FILETYPE["P200")!(FILETYPE["P690") TEMP=$$FMNAME^HLFNC(RST)
 Q TEMP
REMOVE(MESS1,MESS2) ; Remove messages from the server basket
 N LOOP,XMSER S MESS1=+($G(MESS1)),MESS2=+($G(MESS2))
 F LOOP=MESS1,MESS2 S XMSER="S.MCHL7SERVER" S XMZ=LOOP D:LOOP'=0 REMSBMSG^XMA1C
 D KILL^XM
 Q
SETREF(MCOUNT,COUNT,XDES) ; Set Count
 S:XDES'="" @BASE@(MCOUNT,"B",XDES,COUNT)=""
 Q