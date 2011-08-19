MMRSIPC3 ;MIA/LMT - Print MRSA Report Cont. (Contains functions to collect patient labs and swabbing rate) ;10-20-06
 ;;1.0;MRSA PROGRAM TOOLS;**1**;Mar 22, 2009;Build 3
 ;
GETLABS ;Gets all lab data for the report.
 N MRSAMDRO,LOC,INDT,DFN,OUTDT,NARES24,NARES48,SURV48,CULT48,MRSA365,CULT365,KNOWMRSA,KNOWCULT,NARES24A,NARES48ASURV48A,NARES48A
 N MRSAFR,MRSATO,MRSA365A,CULT365A,SURV48A,NARES24D,NARES48D,SURV48D,MRSACPRD,TRANS
 S MRSAMDRO=$O(^MMRS(104.2,"B","MRSA",0))
 S ^TMP($J,"MMRSIPC","DSUM")="0^0^0^0^0^0^0^0^0"
 S LOC="" F  S LOC=$O(^TMP($J,"MMRSIPC","D",LOC)) Q:LOC=""  D
 .S ^TMP($J,"MMRSIPC","DSUM",LOC)="0^0^0^0^0^0^0^0^0"
 .S INDT=0 F  S INDT=$O(^TMP($J,"MMRSIPC","D",LOC,INDT)) Q:'INDT  D
 ..S DFN=0 F  S DFN=$O(^TMP($J,"MMRSIPC","D",LOC,INDT,DFN)) Q:'DFN  D
 ...S OUTDT=0 F  S OUTDT=$O(^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT)) Q:OUTDT=""  D
 ....I BYADM D
 .....S NARES24=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(INDT,0,-24),$$FMADD^XLFDT(INDT,0,24),"CD"),U,1)
 .....S NARES48=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD"),U,2)
 .....S SURV48=$P($$GETLAB(DFN,"MRSA_SURV",$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD"),U,2)
 .....I NARES48'["POS",SURV48["POS" S NARES48=SURV48
 .....S CULT48=$P($$GETLAB(DFN,"MRSA_CULTURE",$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD"),U,2) ;$$GETMCULT(DFN,$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD")
 .....S MRSA365=$P($$GETLAB(DFN,MRSAMDRO,$$FMADD^XLFDT(INDT,-365),INDT,"CD"),U,2)
 .....I $P($G(^MMRS(104,MMRSDIV,0)),U,4)=0 D
 ......S KNOWMRSA=$P($$GETLAB(DFN,MRSAMDRO,$$FMADD^XLFDT(INDT,-365),INDT,"RAD"),U,2)
 .....S ^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT)=^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT)_U_NARES24_U_NARES48_U_CULT48_U_MRSA365
 ....I 'BYADM D
 .....S NARES24A=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(INDT,0,-24),$$FMADD^XLFDT(INDT,0,24),"CD"),U,1)
 .....S NARES48A=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD"),U,2)
 .....S SURV48A=$P($$GETLAB(DFN,"MRSA_SURV",$$FMADD^XLFDT(INDT,0,-48),$$FMADD^XLFDT(INDT,0,48),"CD"),U,2)
 .....I NARES48A'["POS",SURV48A["POS" S NARES48A=SURV48A
 .....S MRSAFR=(INDT-10000) I STRTDT>INDT S MRSAFR=(STRTDT-10000) ;(ADM - 1 year) or  (START DT - 1 year) - whichever is later
 .....S MRSATO=$$FMADD^XLFDT(INDT,0,48,0,0) I STRTDT>MRSATO S MRSATO=STRTDT ;(ADM + 48 HRS) OR (START DT) - WHICHEVER IS GREATER
 .....S MRSA365A=$P($$GETLAB(DFN,MRSAMDRO,MRSAFR,MRSATO,"CD"),U,2)
 .....S (NARES24D,NARES48D,SURV48D)=""
 .....I OUTDT D
 ......S NARES24D=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(OUTDT,0,-24),$$FMADD^XLFDT(OUTDT,0,24),"CD"),U,1)
 ......S NARES48D=$P($$GETLAB(DFN,"MRSA_SCREEN",$$FMADD^XLFDT(OUTDT,0,-48),$$FMADD^XLFDT(OUTDT,0,48),"CD"),U,2)
 ......S SURV48D=$P($$GETLAB(DFN,"MRSA_SURV",$$FMADD^XLFDT(OUTDT,0,-48),$$FMADD^XLFDT(OUTDT,0,48),"CD"),U,2)
 ......I NARES48D'["POS",SURV48D["POS" S NARES48D=SURV48D
 .....S MRSAFR=$$FMADD^XLFDT(INDT,0,48,0,0) I STRTDT>MRSAFR S MRSAFR=STRTDT ;(ADM + 48 HRS) OR (START DT) - WHICHEVER IS LATER
 .....S MRSATO=ENDDT I +OUTDT S MRSATO=$$FMADD^XLFDT(OUTDT,0,48,0,0) ;(DIS + 48 HRS) OR (END DT) - WHICHEVER IS EARLIER
 .....S MRSACPRD=$P($$GETLAB(DFN,MRSAMDRO,MRSAFR,MRSATO,"CD"),U,2)
 .....I $P($G(^MMRS(104,MMRSDIV,0)),U,5)=0,OUTDT D
 ......S KNOWMRSA=$P($$GETLAB(DFN,MRSAMDRO,$$FMADD^XLFDT(OUTDT,-365),OUTDT,"RAD"),U,2)
 .....S TRANS=""
 .....I NARES48A'["POS",MRSA365A'["POS",(($G(NARES48D)["POS")!(MRSACPRD["POS")) S TRANS="T"
 .....S ^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT)=^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT)_U_NARES24A_U_NARES48A_U_MRSA365A_U_$G(NARES24D)_U_$G(NARES48D)_U_MRSACPRD_U_TRANS
 ....D PREV ;Calculate prevalence measures
 Q
PREV ;Calculate prevalence measures (summary report)
 N LOCSUM,SUM,DATA,IND
 S LOCSUM=$G(^TMP($J,"MMRSIPC","DSUM",LOC))
 S SUM=$G(^TMP($J,"MMRSIPC","DSUM"))
 S DATA=$G(^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT))
 I BYADM D
 .I $P(DATA,U,5)=1 D
 ..S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,1)=$P(LOCSUM,U,1)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,1)=$P(SUM,U,1)+1
 ..I NARES24["Y" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,2)=$P(LOCSUM,U,2)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,2)=$P(SUM,U,2)+1
 ..I (NARES48["POS"!(MRSA365["POS")),CULT48'["POS" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,3)=$P(LOCSUM,U,3)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,3)=$P(SUM,U,3)+1
 ..I CULT48["POS" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,4)=$P(LOCSUM,U,4)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,4)=$P(SUM,U,4)+1
 .S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,5)=$P(LOCSUM,U,5)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,5)=$P(SUM,U,5)+1
 .S IND=0
 .I $P($G(^MMRS(104,MMRSDIV,0)),U,2)=1,$P($G(^MMRS(104,MMRSDIV,0)),U,4)=1 S IND=1
 .I $P($G(^MMRS(104,MMRSDIV,0)),U,2)=1,$P($G(^MMRS(104,MMRSDIV,0)),U,4)=0,($P(DATA,U,5)=1!(KNOWMRSA'["POS")) S IND=1
 .I $P($G(^MMRS(104,MMRSDIV,0)),U,2)=0,$P(DATA,U,5)=1 S IND=1
 .S $P(^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT),U,13)=IND ;MIA/LMT - Add if patient was indicated ;3/16/10
 .I IND D
 ..S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,6)=$P(LOCSUM,U,6)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,6)=$P(SUM,U,6)+1
 ..I NARES24["Y" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,7)=$P(LOCSUM,U,7)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,7)=$P(SUM,U,7)+1
 .I (NARES48["POS"!(MRSA365["POS")),CULT48'["POS" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,8)=$P(LOCSUM,U,8)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,8)=$P(SUM,U,8)+1
 .I CULT48["POS" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,9)=$P(LOCSUM,U,9)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,9)=$P(SUM,U,9)+1
 I 'BYADM D
 .I $P(DATA,U,8)=3!($P(DATA,U,8)=2) D
 ..S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,2)=$P(LOCSUM,U,2)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,2)=$P(SUM,U,2)+1
 ..S IND=0
 ..I $P($G(^MMRS(104,MMRSDIV,0)),U,3)=1,$P($G(^MMRS(104,MMRSDIV,0)),U,5)=1 S IND=1
 ..I $P($G(^MMRS(104,MMRSDIV,0)),U,3)=1,$P($G(^MMRS(104,MMRSDIV,0)),U,5)=0,KNOWMRSA'["POS" S IND=1
 ..I $P($G(^MMRS(104,MMRSDIV,0)),U,3)=0,$P($G(^MMRS(104,MMRSDIV,0)),U,5)=0,$P(DATA,U,8)=3,KNOWMRSA'["POS" S IND=1
 ..I $P($G(^MMRS(104,MMRSDIV,0)),U,3)=0,$P($G(^MMRS(104,MMRSDIV,0)),U,5)=1,$P(DATA,U,8)=3 S IND=1
 ..S $P(^TMP($J,"MMRSIPC","D",LOC,INDT,DFN,OUTDT),U,16)=IND ;MIA/LMT - Add if patient was indicated ;3/16/10
 ..I IND=1 D
 ...S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,3)=$P(LOCSUM,U,3)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,3)=$P(SUM,U,3)+1
 ...I NARES24D["Y" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,4)=$P(LOCSUM,U,4)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,4)=$P(SUM,U,4)+1
 .I TRANS="T" S $P(^TMP($J,"MMRSIPC","DSUM",LOC),U,5)=$P(LOCSUM,U,5)+1,$P(^TMP($J,"MMRSIPC","DSUM"),U,5)=$P(SUM,U,5)+1
 Q
GETLAB(DFN,LRMDRO,LRSTART,LREND,LRDTTYP) ;RETURN YES/NO^RESULT
 N LRRSLT,LRTST,TMPRSLT
 S LRRSLT="^"
 I $G(DFN)=""!($G(LRMDRO)="")!($G(LRSTART)="")!($G(LREND)="") Q LRRSLT
 ;GET CH RSLTS
 S LRTST=0 F  S LRTST=$O(^TMP($J,"MMRSIPC","T",LRMDRO,LRTST)) Q:'LRTST  D
 .S TMPRSLT=$$GETCH(DFN,LRMDRO,LRTST,LRSTART,LREND,LRDTTYP)
 .I $P(LRRSLT,U)'="Y" S LRRSLT=TMPRSLT
 .I $P(TMPRSLT,U,2)["POS",(($P(LRRSLT,"^",2)="")!($P($P(LRRSLT,"^",2),";",3)>$P($P(TMPRSLT,"^",2),";",3))) D
 ..S LRRSLT=TMPRSLT
 ;GET MI RSLTS
 S TMPRSLT=$$GETMI(DFN,LRMDRO,LRSTART,LREND,LRDTTYP)
 I $P(LRRSLT,U)'="Y" S LRRSLT=TMPRSLT
 I $P(TMPRSLT,U,2)["POS",(($P(LRRSLT,"^",2)="")!($P($P(LRRSLT,"^",2),";",3)>$P($P(TMPRSLT,"^",2),";",3))) D
 .S LRRSLT=TMPRSLT
 Q LRRSLT
GETCH(DFN,LRMDRO,LRTST,LRSTART,LREND,LRDTTYP) ;RETURN YES^RESULT
 N LRRSLT,LRDFN,LRDATE,LRRADEND,DAS,LRIDT,LRSITE,TSTRSLT,LRRAD
 S LRRSLT="^"
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 Q:'LRDFN LRRSLT
 S LRDATE=LRSTART-.0000001
 I LRDTTYP="RAD" S LRDATE=0,LRRADEND=LREND,LREND=9999999
 F  S LRDATE=$O(^PXRMINDX(63,"PI",DFN,+LRTST,LRDATE)) Q:'LRDATE!(LRDATE>LREND)  D
 .S DAS=0 F  S DAS=$O(^PXRMINDX(63,"PI",DFN,+LRTST,LRDATE,DAS)) Q:'DAS  D
 ..S LRIDT=$P(DAS,";",3)
 ..I LRDTTYP="RAD" S LRRAD=$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,3) I LRRAD<LRSTART!(LRRAD>LRRADEND) Q
 ..Q:$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,3)=""
 ..S LRSITE=$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,5)
 ..;Q:$$SCRNTOP(LRSITE,LRMDRO)
 ..;I $D(^LR(LRDFN,"CH",LRIDT,0)),$P(^LR(LRDFN,"CH",LRIDT,0),U,3) D
 ..S $P(LRRSLT,"^",1)="Y"
 ..S TSTRSLT=$$CHRSLT(LRDFN,LRIDT,LRMDRO,LRTST)
 ..I TSTRSLT["POS",(($P(LRRSLT,"^",2)="")!($P($P(LRRSLT,"^",2),";",3)>LRIDT)) D
 ...S $P(LRRSLT,"^",2)=(TSTRSLT_";"_LRDFN_";"_LRIDT_";CH")
 Q LRRSLT
GETMI(DFN,LRMDRO,LRSTART,LREND,LRDTTYP) ;RETURN YES^RESULT
 N LRRSLT,LRDFN,LRDATE,LRRADEND,DAS,LRIDT,LRSITE,TSTRSLT,LRRAD,LRIEND
 S LRRSLT="^"
 I '$D(^TMP($J,"MMRSIPC","BACT",LRMDRO,"INC_REMARK")),'$D(^TMP($J,"MMRSIPC","ETIOL",LRMDRO)) Q LRRSLT
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 Q:'LRDFN LRRSLT
 S LRIDT=(9999999-LREND)-.0000001
 S LRIEND=9999999-LRSTART
 I LRDTTYP="RAD" S LRIDT=0,LRIEND=99999999
 F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:'LRIDT!(LRIDT>LRIEND)  D
 .I LRDTTYP="RAD" S LRRAD=$P($G(^LR(LRDFN,"MI",LRIDT,0)),U,3) I LRRAD<LRSTART!(LRRAD>LREND) Q
 .;Q:$P($G(^LR(LRDFN,"MI",LRIDT,1)),U,2)'="F"
 .S LRSITE=$P($G(^LR(LRDFN,"MI",LRIDT,0)),U,5)
 .;Q:$$SCRNTOP(LRSITE,LRMDRO)
 .;I $D(^LR(LRDFN,"MI",LRIDT,0)),$P(^LR(LRDFN,"MI",LRIDT,1),U) D
 .S $P(LRRSLT,"^",1)="Y"
 .S TSTRSLT=$$MIRSLT(LRDFN,LRIDT,LRMDRO)
 .I TSTRSLT["POS",(($P(LRRSLT,"^",2)="")!($P($P(LRRSLT,"^",2),";",3)>LRIDT)) D
 ..S $P(LRRSLT,"^",2)=(TSTRSLT_";"_LRDFN_";"_LRIDT_";MI")
 Q LRRSLT
CHRSLT(LRDFN,LRIDT,LRMDRO,LRTST) ;RETURNS 'POS' OR NULL STRING (IF NOT POSITIVE)
 N RESULT,LRLOC,LRND,LRPC,LRRES,LRIND,LRINDVAL,LRSPEC,LRLOW,LRHIG
 S RESULT=""
 S LRLOC=$P($G(^LAB(60,+LRTST,0)),U,5)
 S LRND=$P(LRLOC,";",2) Q:+LRND'>0 RESULT
 S LRPC=$P(LRLOC,";",3) Q:+LRPC'>0 RESULT
 S LRRES=$P($G(^LR(LRDFN,"CH",LRIDT,LRND)),U,LRPC) Q:LRRES="" RESULT
 S LRIND=$P($G(^TMP($J,"MMRSIPC","T",LRMDRO,LRTST,0)),U,1)
 S LRINDVAL=$P($G(^TMP($J,"MMRSIPC","T",LRMDRO,LRTST,0)),U,2)
 Q:LRIND="" RESULT
 I LRIND=1 D  Q RESULT
 .Q:'LRRES
 .S LRSPEC=$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,5) Q:LRSPEC=""
 .Q:'$D(^LAB(60,LRTST,1,LRSPEC,0))
 .S LRLOW=$P(^LAB(60,LRTST,1,LRSPEC,0),U,2),LRHIG=$P(^LAB(60,LRTST,1,LRSPEC,0),U,3)
 .Q:'LRLOW!('LRHIG)
 .I LRRES<LRLOW!(LRRES>LRHIG) S RESULT="POS" Q
 I LRINDVAL="" Q RESULT
 S LRRES=$$UP^XLFSTR(LRRES),LRINDVAL=$$UP^XLFSTR(LRINDVAL)
 I LRIND=2,(LRRES[LRINDVAL) Q "POS"
 I LRIND=3,(LRRES>LRINDVAL) Q "POS"
 I LRIND=4,(LRRES<LRINDVAL) Q "POS"
 I LRIND=5,(LRRES=LRINDVAL) Q "POS"
 Q RESULT
MIRSLT(LRDFN,LRIDT,LRMDRO) ;RETURNS 'POS' OR NULL STRING (IF NOT POSITIVE)
 N RESULT,LRETND,LRETI,LRANTI,LRANTIND,LRANTINV,LRAND,LRRES,BACTRPT,RPTRMRK
 S RESULT=""
 ;Check Etiology
 I $D(^TMP($J,"MMRSIPC","ETIOL",LRMDRO)) D  Q:RESULT="POS" RESULT
 .S LRETND=0 F  S LRETND=$O(^LR(LRDFN,"MI",LRIDT,3,LRETND)) Q:'LRETND!(RESULT="POS")  D
 ..S LRETI=$P($G(^LR(LRDFN,"MI",LRIDT,3,LRETND,0)),U)
 ..Q:+LRETI'>0
 ..I ('$O(^TMP($J,"MMRSIPC","ETIOL",LRMDRO,LRETI,0))) D  Q
 ...I $D(^TMP($J,"MMRSIPC","ETIOL",LRMDRO,LRETI)) S RESULT="POS"
 ..S LRANTI=0 F  S LRANTI=$O(^TMP($J,"MMRSIPC","ETIOL",LRMDRO,LRETI,LRANTI)) Q:'LRANTI  D
 ...S LRANTIND=$P(^TMP($J,"MMRSIPC","ETIOL",LRMDRO,LRETI,LRANTI),U,1)
 ...S LRANTINV=$P(^TMP($J,"MMRSIPC","ETIOL",LRMDRO,LRETI,LRANTI),U,2)
 ...;S LRAND=$P($G(^LAB(62.06,LRANTI,0)),U,2) Q:LRAND=""
 ...S LRAND=$$ABDN^LRPXAPIU(LRANTI) Q:'LRAND
 ...Q:$P($G(^LR(LRDFN,"MI",LRIDT,3,LRETND,LRAND)),U,2)=""
 ...Q:$$UP^XLFSTR($E($P($G(^LR(LRDFN,"MI",LRIDT,3,LRETND,LRAND)),U,2),1,1))="S"
 ...I LRANTIND=""!(LRANTINV="") Q
 ...;S LRRES=$$UP^XLFSTR($E($P($G(^LR(LRDFN,"MI",LRIDT,3,LRETND,LRAND)),U,2),1,1))
 ...S LRRES=$$UP^XLFSTR($P($G(^LR(LRDFN,"MI",LRIDT,3,LRETND,LRAND)),U,2))
 ...S LRANTINV=$$UP^XLFSTR(LRANTINV)
 ...S LRANTIND=$$UP^XLFSTR(LRANTIND)
 ...I LRANTIND=1,(LRRES[LRANTINV) S RESULT="POS" Q
 ...I LRANTIND=2,(LRRES>LRANTINV) S RESULT="POS" Q
 ...I LRANTIND=3,(LRRES<LRANTINV) S RESULT="POS" Q
 ...I LRANTIND=4,(LRRES=LRANTINV) S RESULT="POS" Q
 Q:RESULT="POS" "POS"
 ;Check Bacteriology Report Remarks
 I '$D(^TMP($J,"MMRSIPC","BACT",LRMDRO,"INC_REMARK")) Q RESULT
 S BACTRPT=0 F  S BACTRPT=$O(^LR(LRDFN,"MI",LRIDT,4,BACTRPT)) Q:'BACTRPT!(RESULT="POS")  D
 .S RPTRMRK=$P($G(^LR(LRDFN,"MI",LRIDT,4,BACTRPT,0)),U,1)
 .Q:RPTRMRK=""
 .I $$BACTRPT(LRMDRO,"INC_REMARK",RPTRMRK)&('$$BACTRPT(LRMDRO,"EXC_REMARK",RPTRMRK)) S RESULT="POS"
 Q RESULT
SCRNTOP(LRSITE,LRMDRO) ;CHECK TO SEE IF SCREEN ON SITE
 Q:+LRSITE'>0 0
 I $D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"INC_TOP"))&$D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"EXC_TOP")) Q 0
 I '$D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"INC_TOP"))&'$D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"EXC_TOP")) Q 0
 I ($D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"INC_TOP")))&($D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"INC_TOP",LRSITE))) Q 0
 I ($D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"EXC_TOP")))&('$D(^TMP($J,"MMRSIPC","TOP",LRMDRO,"EXC_TOP",LRSITE))) Q 0
 Q 1
BACTRPT(LRMDRO,RPTTYPE,RPTRMRK) ;Is this comment contained in the parameters
 N RESULT,MMRSI,LRINDVAL
 S RESULT=0
 S MMRSI=0 F  S MMRSI=$O(^TMP($J,"MMRSIPC","BACT",LRMDRO,RPTTYPE,MMRSI)) Q:'MMRSI!(RESULT=1)  D
 .S LRINDVAL=$G(^TMP($J,"MMRSIPC","BACT",LRMDRO,RPTTYPE,MMRSI))
 .I ($$UP^XLFSTR(RPTRMRK))[($$UP^XLFSTR(LRINDVAL)) S RESULT=1
 Q RESULT
