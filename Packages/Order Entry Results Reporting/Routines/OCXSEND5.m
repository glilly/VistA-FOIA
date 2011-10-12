OCXSEND5 ;SLC/RJS,CLA - BUILD RULE TRANSPORTER ROUTINES (Build Library Routine 1) ;2/01/01  09:56
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,96,105,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN() ;
 ;
 N R,LINE,TEXT,NOW,RUCI
 S NOW=$$NOW^OCXSEND3,RUCI=$$NETNAME^OCXSEND
 F LINE=1:1:999 S TEXT=$P($T(TEXT+LINE),";",2,999) Q:TEXT  S TEXT=$P(TEXT,";",2,999) S R(LINE,0)=$$CONV^OCXSEND3(TEXT)
 ;
 M ^TMP("OCXSEND",$J,"RTN")=R
 ;
 S DIE="^TMP(""OCXSEND"","_$J_",""RTN"",",XCN=0,X=$$RNAME^OCXSEND3(1,1)
 W !,X X ^%ZOSF("SAVE") K ^TMP("OCXSEND",$J,"RTN")
 ;
 Q " "
 ;
TEXT ;
 ;;|$$RNAME^OCXSEND3(1,1)| ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE |OCXPATCH| ;|NOW|
 ;;|OCXLIN2|
 ;;|OCXLIN3|
 ;; ;
 ;;S ;
 ;; ;
 ;; Q
 ;; ;
 ;; ;
 ;;COMPARE(L,R) ;
 ;; ;
 ;; Q:$$RES("R") 1
 ;; ;
 ;; Q:'$L($O(L(""))) $$ADDREC^|$$RNAME^OCXSEND3(2,1)|("R")
 ;; ;
 ;; N C,OCXDD M C=L,C=R S OCXDD=$O(C("")) Q $$MULT("C",OCXDD)
 ;; ;
 ;; Q 0
 ;; ;
 ;;RES(REF) ;
 ;; ;
 ;; N QUIT,SUB
 ;; S QUIT=0
 ;; S SUB="" F  S SUB=$O(@REF@(SUB)) Q:'$L(SUB)  I (SUB[":") D  Q:QUIT
 ;; .N DD,DA
 ;; .S DD=$P(SUB,":",1),DA=$P(SUB,":",2)
 ;; .I $L(DA),'(DA=+DA) D  Q:QUIT
 ;; ..N DANEW,SUBNEW
 ;; ..S DANEW=$O(^OCXS($P(DA,U,2),"B",$P(DA,U,1),0))
 ;; ..I 'DANEW W !!,$P($G(^OCXS(+$P(DA,U,2),0)),U,1),": ",$P(DA,U,1),"  could not resolve name.",!!,"    End Transport." S QUIT=1 Q
 ;; ..S SUBNEW=DD_":"_DANEW
 ;; ..I $D(@REF@(SUBNEW)) W !!," multiple #",DANEW," already existed." S QUIT=1 Q
 ;; ..M @REF@(SUBNEW)=@REF@(SUB)
 ;; ..K @REF@(SUB)
 ;; ..S SUB=""
 ;; .I $L(SUB),($D(@REF@(SUB))>9) S QUIT=$$RES($NA(@REF@(SUB)))
 ;; ;
 ;; Q QUIT
 ;; ;
 ;;MULT(CREF,OCXDD) ;
 ;; ;
 ;; N OCXSUB,LREF,RREF,QUIT,OCXFLD
 ;; S LREF="L"_$E(CREF,2,$L(CREF)),RREF="R"_$E(CREF,2,$L(CREF))
 ;; ;
 ;; S QUIT=0,OCXFLD="" F  S OCXFLD=$O(@CREF@(OCXDD,OCXFLD)) Q:'$L(OCXFLD)  D  Q:QUIT
 ;; .I (OCXFLD[":") D  Q:QUIT
 ;; ..Q:$$EXFLD(+OCXFLD,0)
 ;; ..I '$D(@LREF@(OCXDD,OCXFLD,.01,"E")) D  M @LREF@(OCXDD,OCXFLD)=@RREF@(OCXDD,OCXFLD)
 ;; ...D WARN("Missing multiple:",CREF,OCXDD,OCXFLD)
 ;; ...S QUIT=$$ADDMULT^|$$RNAME^OCXSEND3(3,1)|(CREF,OCXDD,OCXFLD)
 ;; ..I '$D(@RREF@(OCXDD,OCXFLD,.01,"E")) D  M @RREF@(OCXDD,OCXFLD)=@LREF@(OCXDD,OCXFLD)
 ;; ...D WARN("Extra multiple:",CREF,OCXDD,OCXFLD)
 ;; ...S QUIT=$$DELMULT^|$$RNAME^OCXSEND3(3,1)|($$APPEND(CREF,OCXDD),OCXFLD)
 ;; .;
 ;; .I (OCXFLD=+OCXFLD),'$$EXFLD(+OCXDD,OCXFLD) D
 ;; ..I ($O(@CREF@(OCXDD,OCXFLD,""))="E") D  Q
 ;; ...I $L($G(@RREF@(OCXDD,OCXFLD,"E"))),'$L($G(@LREF@(OCXDD,OCXFLD,"E"))) D  Q
 ;; ....D WARN("Data Value Missing in "_$$NETNAME^OCXSEND,CREF,OCXDD,OCXFLD,"E")
 ;; ....S QUIT=$$EDITFLD^|$$RNAME^OCXSEND3(4,1)|(CREF,OCXDD,OCXFLD,"E")
 ;; ...I $L($G(@LREF@(OCXDD,OCXFLD,"E"))),'$L($G(@RREF@(OCXDD,OCXFLD,"E"))) D  Q
 ;; ....D WARN("Extra Data Value in "_$$NETNAME^OCXSEND,CREF,OCXDD,OCXFLD,"E")
 ;; ....S QUIT=$$DELFLD^|$$RNAME^OCXSEND3(4,1)|(CREF,OCXDD,OCXFLD,"E")
 ;; ...I '(@LREF@(OCXDD,OCXFLD,"E")=@RREF@(OCXDD,OCXFLD,"E")) D
 ;; ....D WARN("Inconsistent Data",CREF,OCXDD,OCXFLD,"E")
 ;; ....S QUIT=$$EDITFLD^|$$RNAME^OCXSEND3(4,1)|(CREF,OCXDD,OCXFLD,"E")
 ;; ..S OCXSUB=0 F  Q:QUIT  S OCXSUB=$O(@CREF@(OCXDD,OCXFLD,OCXSUB)) Q:'OCXSUB  I '($G(@RREF@(OCXDD,OCXFLD,OCXSUB))=$G(@LREF@(OCXDD,OCXFLD,OCXSUB))) D  Q
 ;; ...D WARN("Inconsistent word Data",CREF,OCXDD,OCXFLD,OCXSUB)
 ;; ...S QUIT=$$LOADWORD^|$$RNAME^OCXSEND3(2,1)|(RREF,OCXDD,OCXFLD,OCXSUB)
 ;; .;
 ;; .I 'QUIT,(OCXFLD[":") S QUIT=$$MULT($$APPEND(CREF,OCXDD),OCXFLD)
 ;; Q QUIT
 ;; ;
 ;;APPEND(ARRAY,OCXSUB) ;
 ;; S:'(OCXSUB=+OCXSUB) OCXSUB=""""_OCXSUB_""""
 ;; Q:'(ARRAY["(") ARRAY_"("_OCXSUB_")"
 ;; Q $E(ARRAY,1,$L(ARRAY)-1)_","_OCXSUB_")"
 ;; ;
 ;;EXFLD(FILE,OCXFLD) ;
 ;; N OCXFNAM
 ;; S OCXFNAM=$$FIELD^OCXSENDD(FILE,OCXFLD,"LABEL")
 ;; I (OCXFNAM["UNIQUE OBJECT IDENTIFIER") Q 1
 ;; I (FILE=860.2),(OCXFLD=.02) Q 1
 ;; I (FILE=860.22),(OCXFLD=4) Q 1
 ;; I (FILE=860.3),(OCXFLD=3) Q 1
 ;; I (FILE=860.9),(OCXFLD=1) Q 1
 ;; I (FILE=860.91) Q 1
 ;; I (FILE=860.801) Q 1
 ;; I (FILE=860.81) Q 1
 ;; I (FILE=861.01) Q 1
 ;; I (FILE=863.02) Q 1
 ;; I (FILE=863.54) Q 1
 ;; I (FILE=863.61) Q 1
 ;; I (FILE=863.72) Q 1
 ;; I (FILE=863.81) Q 1
 ;; I ($E(OCXFNAM,1)="*") Q 1
 ;; Q 0
 ;; ;
 ;;WARN(MSG,CREF,OCXDD,OCXFLD,OCXSUB) ;
 ;; ;
 ;; Q:$G(OCXAUTO)
 ;; ;
 ;; N D0,DASH,OCXDDPTH,OCXDPTR,FILE,FILEID,LREF,OCXPTR,RREF
 ;; ;
 ;; S DASH="",$P(DASH,"-",(55-$L(MSG)))="-"
 ;; W !!,"------------",MSG,DASH
 ;; D DSPHDR(CREF,OCXDD,OCXFLD)
 ;; I $D(OCXSUB) D DSPFLD(CREF,OCXDD,OCXFLD,OCXSUB)
 ;; I '$D(OCXSUB) D DSPREC(CREF,OCXDD,OCXFLD)
 ;; ;
 ;; W ! Q
 ;; ;
 ;;DSPREC(CREF,OCXDD,OCXFLD) ;
 ;; ;
 ;; N OCXDPTR,OCXDDPTH,LEVL,OCXCREF,OCXSUB
 ;; S OCXCREF=$$APPEND($$APPEND(CREF,OCXDD),OCXFLD)
 ;; S OCXDDPTH=$P($P(OCXCREF,"(",2),")",1),LEVL=$L(OCXDDPTH,",")
 ;; S OCXSUB="" F  S OCXSUB=$O(@OCXCREF@(OCXSUB)) Q:'$L(OCXSUB)  D
 ;; .;
 ;; .I '(OCXSUB[":"),'((OCXSUB=.01)&$O(@OCXCREF@(OCXSUB))) D
 ;; ..N LINE
 ;; ..Q:$$EXFLD(+OCXFLD,OCXSUB)
 ;; ..I OCXFLD W !,?(5+((LEVL)*4)),$$FIELD^OCXSENDD(+OCXFLD,OCXSUB,"LABEL"),": ",$G(@OCXCREF@(OCXSUB,"E"))
 ;; ..S LINE=0 F  S LINE=$O(@OCXCREF@(OCXSUB,LINE)) Q:'LINE  D
 ;; ...W !,?(5+(LEVL*4)),$J(LINE,3),">",@OCXCREF@(OCXSUB,LINE)
 ;; .;
 ;; .I (OCXSUB[":") D
 ;; ..N D0,OCXDD,FILENAME
 ;; ..S D0=+$P(OCXSUB,":",2),OCXDD=+OCXSUB
 ;; ..S FILENAME=$$FILENAME^OCXSENDD(OCXDD)
 ;; ..I $L(FILENAME) W !,?(5+($L(LEVL)*4)),FILENAME
 ;; ..E  W !!,?(5+(LEVL*4)),FILENAME
 ;; ..W " ",D0,": ",$G(@OCXCREF@(OCXSUB,.01,"E"))
 ;; ..D DSPREC($$APPEND(CREF,OCXDD),OCXFLD,OCXSUB)
 ;; ;
 ;; Q
 ;; ;
 ;;DSPHDR(CREF,OCXDD,OCXFLD) ;
 ;; ;
 ;; N D0,FILE,FILEID,OCXPTR,OCXDDPTH
 ;; S OCXDDPTH=$P($P($$APPEND($$APPEND(CREF,OCXDD),OCXFLD),"(",2),")",1)
 ;; S FILE="" F OCXPTR=1:1:$L(OCXDDPTH,",") D
 ;; .N OCXDD,D0,FILEID
 ;; .S FILEID=$P(OCXDDPTH,",",OCXPTR)
 ;; .I (FILEID[":") D
 ;; ..S D0=+$P(FILEID,":",2),OCXDD=+$E(FILEID,2,$L(FILEID))
 ;; ..W !,?(5+(OCXPTR*4)),$$FILENAME^OCXSENDD(OCXDD)
 ;; ..S:$L(FILE) FILE=FILE_"," S FILE=FILE_FILEID
 ;; ..I $D(@("L("_FILE_",.01,""E"")")) W ": ",@("L("_FILE_",.01,""E"")") W:D0 " [",D0,"]"
 ;; ..E  I $D(@("R("_FILE_",.01,""E"")")) W ": ",@("R("_FILE_",.01,""E"")") W:D0 " [",D0,"]"
 ;; ;
 ;; Q
 ;; ;
 ;;DSPFLD(CREF,OCXDD,OCXFLD,OCXSUB) ;
 ;; ;
 ;; N OCXDPTR,LREF,RREF,OCXDDPTH
 ;; ;
 ;; S OCXDDPTH=$P($P($$APPEND(CREF,OCXDD),"(",2),")",1)
 ;; S LREF="L("_OCXDDPTH_")",RREF="R("_OCXDDPTH_")"
 ;; W !,?(5+(($L(OCXDDPTH,",")+1)*4)),$$FIELD^OCXSENDD(OCXDD,OCXFLD,"LABEL")," field [",OCXFLD,"]"
 ;; I OCXSUB W " Line #",OCXSUB
 ;; ;
 ;; W:($D(@RREF@(OCXFLD,OCXSUB))) !,?(5+(($L(OCXDDPTH,",")+2)*4)),"(R) |RUCI|: ",@RREF@(OCXFLD,OCXSUB)
 ;; W:($D(@LREF@(OCXFLD,OCXSUB))) !,?(5+(($L(OCXDDPTH,",")+2)*4)),"(L) ",$$NETNAME^OCXSEND,": ",@LREF@(OCXFLD,OCXSUB)
 ;; ;
 ;; Q
 ;; ;
 ;; W !,?10 Q 0 Q $$PAUSE
 ;; ;
 ;;PAUSE() W "  Press Enter " R X:DTIME W ! Q (X[U)
 ;; ;
 ;;NOW() N X,Y,%DT S X="N",%DT="T" D ^%DT S Y=$$DATE^OCXSENDD(Y) S:(Y["@") Y=$P(Y,"@",1)_" at "_$P(Y,"@",2) Q Y
 ;; ;
 ;;$
 ;1;
 ;