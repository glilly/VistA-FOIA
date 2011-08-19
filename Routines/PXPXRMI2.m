PXPXRMI2 ; SLC/PKR,SCK - Build indexes for the V files (continued). ;06/17/2003
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**119,194**;Aug 12, 1996;Build 2
 ;DBIA 4113 supports PXRMSXRM entry points. 
 ;DBIA 4114 supports setting and killing ^PXRMINDX
 ;===============================================================
VPED ;Build the indexes for V PATIENT ED.
 N DAS,DATE,DFN,DIFF,DONE,EDU,END,ENTRIES,ETEXT,GLOBAL,IND,NE,NERROR
 N START,TEMP,TENP,TEXT,VISIT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(9000010.16)
 S GLOBAL=$$GET1^DID(9000010.16,"","","GLOBAL NAME")
 S ENTRIES=$P(^AUPNVPED(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for V PATIENT ED")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,DONE,IND,NE,NERROR)=0
 F  S DAS=$O(^AUPNVPED(DAS)) Q:DONE  D
 . I +DAS=0 S DONE=1 Q
 . I +DAS'=DAS D  Q
 .. S DONE=1
 .. S ETEXT="Bad ien: "_DAS_", cannot continue."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=^AUPNVPED(DAS,0)
 . S EDU=$P(TEMP,U,1)
 . I EDU="" D  Q
 .. S ETEXT=DAS_" missing education topic"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUTTEDT(EDU)) D  Q
 .. S ETEXT=DAS_" invalid education topic"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=DAS_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S VISIT=$P(TEMP,U,3)
 . I VISIT="" D  Q
 .. S ETEXT=DAS_" missing visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUPNVSIT(VISIT)) D  Q
 .. S ETEXT=DAS_" invalid visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DATE=$P(^AUPNVSIT(VISIT,0),U,1)
 . I DATE="" D  Q
 .. S ETEXT=DAS_" missing visit date"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S NE=NE+1
 . S ^PXRMINDX(9000010.16,"IP",EDU,DFN,DATE,DAS)=""
 . S ^PXRMINDX(9000010.16,"PI",DFN,EDU,DATE,DAS)=""
 S END=$H
 S TEXT=NE_" V PATIENT ED results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(9000010.16,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(9000010.16,"BUILT BY")=DUZ
 S ^PXRMINDX(9000010.16,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
VPOV ;Build the indexes for V POV.
 N DAS,DATE,DFN,DIFF,DONE,END,ENTRIES,ETEXT,GLOBAL,IND,NE,NERROR,POV,PS
 N START,TEMP,TENP,TEXT,VISIT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(9000010.07)
 S GLOBAL=$$GET1^DID(9000010.07,"","","GLOBAL NAME")
 S ENTRIES=$P(^AUPNVPOV(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for V POV")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,DONE,IND,NE,NERROR)=0
 F  S DAS=$O(^AUPNVPOV(DAS)) Q:DONE  D
 . I +DAS=0 S DONE=1 Q
 . I +DAS'=DAS D  Q
 .. S DONE=1
 .. S ETEXT="Bad ien: "_DAS_", cannot continue."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=^AUPNVPOV(DAS,0)
 . S POV=$P(TEMP,U,1)
 . I POV="" D  Q
 .. S ETEXT=DAS_" missing POV (ICD9)"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . ;I '$D(^ICD9(POV)) D  Q
 . I $$ICDDX^ICDCODE(POV)<0 D  Q
 .. S ETEXT=DAS_" invalid ICD9"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=DAS_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S VISIT=$P(TEMP,U,3)
 . I VISIT="" D  Q
 .. S ETEXT=DAS_" missing visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUPNVSIT(VISIT)) D  Q
 .. S ETEXT=DAS_" invalid visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S PS=$P(TEMP,U,12)
 . I PS="" S PS="U"
 . S DATE=$P(^AUPNVSIT(VISIT,0),U,1)
 . I DATE="" D  Q
 .. S ETEXT=DAS_" missing visit date"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S NE=NE+1
 . S ^PXRMINDX(9000010.07,"IPP",POV,PS,DFN,DATE,DAS)=""
 . S ^PXRMINDX(9000010.07,"PPI",DFN,PS,POV,DATE,DAS)=""
 S END=$H
 S TEXT=NE_" V POV results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(9000010.07,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(9000010.07,"BUILT BY")=DUZ
 S ^PXRMINDX(9000010.07,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
VSK ;Build the indexes for V SKIN TEST.
 N DAS,DATE,DFN,DIFF,DONE,END,ENTRIES,GLOBAL,IND,NE,NERROR
 N SK,START,TEMP,TENP,TEXT,VISIT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(9000010.12)
 S GLOBAL=$$GET1^DID(9000010.12,"","","GLOBAL NAME")
 S ENTRIES=$P(^AUPNVSK(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for V SKIN TEST")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,DONE,IND,NE,NERROR)=0
 F  S DAS=$O(^AUPNVSK(DAS)) Q:DONE  D
 . I +DAS=0 S DONE=1 Q
 . I +DAS'=DAS D  Q
 .. S DONE=1
 .. S ETEXT="Bad ien: "_DAS_", cannot continue."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=^AUPNVSK(DAS,0)
 . S SK=$P(TEMP,U,1)
 . I SK="" D  Q
 .. S ETEXT=DAS_" missing skin test"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUTTSK(SK)) D  Q
 .. S ETEXT=DAS_" invalid skin test"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=DAS_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S VISIT=$P(TEMP,U,3)
 . I VISIT="" D  Q
 .. S ETEXT=DAS_" missing visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUPNVSIT(VISIT)) D  Q
 .. S ETEXT=DAS_" invalid visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DATE=$P(^AUPNVSIT(VISIT,0),U,1)
 . I DATE="" D  Q
 .. S ETEXT=DAS_" missing visit date"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S NE=NE+1
 . S ^PXRMINDX(9000010.12,"IP",SK,DFN,DATE,DAS)=""
 . S ^PXRMINDX(9000010.12,"PI",DFN,SK,DATE,DAS)=""
 S END=$H
 S TEXT=NE_" V SKIN TEST results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(9000010.12,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(9000010.12,"BUILT BY")=DUZ
 S ^PXRMINDX(9000010.12,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
VXAM ;Build the indexes for V EXAM.
 N DAS,DATE,DFN,DIFF,DONE,END,ENTRIES,ETEXT,EXAM,GLOBAL,IND,NE,NERROR
 N START,TEMP,TENP,TEXT,VISIT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(9000010.13)
 S GLOBAL=$$GET1^DID(9000010.13,"","","GLOBAL NAME")
 S ENTRIES=$P(^AUPNVXAM(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for V EXAM")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,DONE,IND,NE,NERROR)=0
 F  S DAS=$O(^AUPNVXAM(DAS)) Q:DONE  D
 . I +DAS=0 S DONE=1 Q
 . I +DAS'=DAS D  Q
 .. S DONE=1
 .. S ETEXT="Bad ien: "_DAS_", cannot continue."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=^AUPNVXAM(DAS,0)
 . S EXAM=$P(TEMP,U,1)
 . I EXAM="" D  Q
 .. S ETEXT=DAS_" missing exam"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUTTEXAM(EXAM)) D  Q
 .. S ETEXT=DAS_" invalid exam"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=DAS_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S VISIT=$P(TEMP,U,3)
 . I VISIT="" D  Q
 .. S ETEXT=DAS_" missing visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^AUPNVSIT(VISIT)) D  Q
 .. S ETEXT=DAS_" invalid visit"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DATE=$P(^AUPNVSIT(VISIT,0),U,1)
 . I DATE="" D  Q
 .. S ETEXT=DAS_" missing visit date"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S NE=NE+1
 . S ^PXRMINDX(9000010.13,"IP",EXAM,DFN,DATE,DAS)=""
 . S ^PXRMINDX(9000010.13,"PI",DFN,EXAM,DATE,DAS)=""
 S END=$H
 S TEXT=NE_" V EXAM results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(9000010.13,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(9000010.13,"BUILT BY")=DUZ
 S ^PXRMINDX(9000010.13,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
