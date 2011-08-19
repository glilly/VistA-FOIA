RMPR5HQ2 ;HCIOFO/RVD - ITEM & HCPCS USAGE REPORT  ; 15 AUG 00
 ;;3.0;PROSTHETICS;**51**;Feb 09, 1996
 ;
MANUAL ;run the USAGE report manually.  User needs to enter the month the
 ;report should be ran.
 N RLN,RMPAGE,R5,REQ,RSL,RMTVAL,RMTCOML,RMTDLEL,RMTUSEL,RHCPC,RMTVAH
 N RMTUSEG,RMTVAG,RMTCOMG,RMTQOHG,RMTVALG,RMGVAL,RGCNT,RLCNT,RSCNT,RFL
 N RLINE,RGRP,RST,RI,RST,RJ,RK,RGRP,RDAT,RMBD,RMED,RPR,RMARRAY,RMTUSEH
 N RMTQOHNL,RMTQOHUL,RMTISNL,RMTISUL,RMTVALNL,RMTVALUL,RMTAVELU
 N RMTQOHNG,RMTQOHUG,RMTISNG,RMTISUG,RMTVALNG,RMTVALUG,RMTCOMH,RMTISUH,RMTISNH
 N RMTVALUH,RMTVALNH,RMTQOHUH,RMTQOHNH,RMTDLEH,RMTDLEG,RMTAVEG,RMGTOT
 N RTAVEGA,RTAVEGC,RTDLEGA,RTDLEGC,RTUSEGA,RTUSEGC,RMGTIU,RMGTIN
 N RTAVELA,RTAVELC,RTDLELA,RTDLELC,RTUSELA,RTUSELC,RMTUSELU,RMTUSELN
 N RTAVEHA,RTAVEHC,RTDLEHA,RTDLEHC,RTUSEHA,RTUSEHC,RMCALDAY,RMTAVELN
 ;
 S X1=RMPREDT,X2=RMPRSDT
 D ^%DTC S RMCALDAY=X+1
 S Y=RMPRSDT D DD^%DT S RMBD=Y S Y=RMPREDT D DD^%DT S RMED=Y
 D NOW^%DTC S Y=% X ^DD("DD") S RMRDATE=Y
 S $P(RLN,"-",IOM)="",RMPAGE=0,R5="RMPR5"
 S $P(REQ,"=",IOM)=""
 S (RMTVAL,RMTCOML,RMTDLEL,RMTUSEL,RMTAVEG,RMGTOT,RMTUSELU,RMGISNG,RMGISUG)=0
 S (RMTQOHNL,RMTQOHUL,RMTISNL,RMTISUL,RMTVALNL,RMTVALUL,RMTAVELU,RMTUSELN)=0
 S (RMTQOHNG,RMTQOHUG,RMTISNG,RMTISUG,RMTVALNG,RMTVALUG,RMTISUH,RMTISNH)=0
 S (RMTUSEG,RMTVAG,RMTCOMG,RMGTOU,RMGTON,RMTVAH,RMTCOMH,RMTVALUH,RMTVALNH,RMTQOHUH)=0
 S (RMGVAL,RGCNT,RLCNT,RSCNT,RFL,RPRINT,RMTQOHNH,RMTUSEH,RMTDLEH)=0
 S (RTAVEGA,RTAVEGC,RTDLEGA,RTDLEGC,RTUSEGA,RTUSEGC,RMGTIU,RMGTIN)=0
 S (RTAVELA,RTAVELC,RTDLELA,RTDLELC,RTUSELA,RTUSELC,RMTAVELN)=0
 S (RTAVEHA,RTAVEHC,RTDLEHA,RTDLEHC,RTUSEHA,RTUSEHC)=0
 S (RLINE,RGRP,RST,RNPGRP,RNPLINE,RHCPC,RMTDLEG)=""
 D GRPARY^RMPR5HQ4(.RMARRAY)
 ;
ITEM ;entry point for Item Detail Usage report
 G:RMPRDET="I" DQ1
 ;
HCPCS ;entry point for HCPCS Summary Usage report.
 I RMPRDET="H" D ^RMPR5HQH G TOT
LINE ;entry point for NPPD LINE Usage report.
 I RMPRDET="L" D ^RMPR5HQL G TOT
 ;
GROUP ;entry point for NPPD GROUP Usage report.
 I RMPRDET="G" D ^RMPR5HQG
 G CLEAN1
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;
DQ1 ;print PIP Report (Item Detail Usage report).
 ;$O the ^TMP( global for all the records
 ;print all records based on the sort criteria given.
 I IOST["C-" W @IOF
 ;
 F RST=0:0 S RST=$O(^TMP($J,R5,RST)) Q:RST'>0  S RSTN=$$STN^RMPR5HQL(RST),RPR=0 F RI=0:0 S RI=$O(^TMP($J,R5,RST,RI)) Q:$G(RFL)  Q:RI'>0  D
 .D:RPR=0 HDRI
 .S RNPGRP=RMARRAY(RI)
 .S RJ=""
 .F  S RJ=$O(^TMP($J,R5,RST,RI,RJ)) Q:$G(RFL)  D:(RLINE'="")&(RLINE'=RJ) SUML1 Q:RJ=""  D
 ..S RLINE=RJ,RNPLINE=$$NPLIN^RMPR5HQ5(RJ)
 ..I RGCNT=0 S RGCNT=RGCNT+1
 ..S RK="" F  S RK=$O(^TMP($J,R5,RST,RI,RJ,RK)) Q:$G(RFL)!(RK="")  D
 ...S RL=""
 ...F  S RL=$O(^TMP($J,R5,RST,RI,RJ,RK,RL)) Q:$G(RFL)!(RL="")  D
 ....S RHCPC=$P(RK,"/",1)
 ....S:RMPRDET="I" RHCPC=RHCPC_"-"_RL
 ....S RNPITEM=$$GETITEM^RMPR5HQ5($P(RK,"/",2),RL)
 ....I RLCNT=0 D GLN1
 ....S RLCNT=RLCNT+1
 ....S RDAT=^TMP($J,R5,RST,RI,RJ,RK,RL)
 ....S RMVA=$P(RDAT,U,1)
 ....S RMCOM=$P(RDAT,U,2)
 ....S RMUSE=$P(RDAT,U,3)
 ....S RMISU=$P(RDAT,U,4)
 ....S RMISN=$P(RDAT,U,5)
 ....S RMAVEN=$P(RDAT,U,6)
 ....S RMDLEN=$P(RDAT,U,7)
 ....S RMQOHU=$P(RDAT,U,8)
 ....S RMQOHN=$P(RDAT,U,9)
 ....S RMVALU=$P(RDAT,U,10)
 ....S RMVALN=$P(RDAT,U,11)
 ....S RMAVEU=$P(RDAT,U,12)
 ....S RMDLEU=$P(RDAT,U,13)
 ....S RMDLEU=$S(RMDLEU>999:">999",1:$J(RMDLEU,7,0))
 ....S RMDLEN=$S(RMDLEN>999:">999",1:$J(RMDLEN,7,0))
 ....S:(RMVA<1)&(RMVALU>0) RMDLEU=">"_RMCALDAY
 ....S:(RMCOM<1)&(RMVALN>0) RMDLEN=">"_RMCALDAY
 ....;total for line item
 ....S RMTVAL=RMTVAL+RMVA
 ....S RMTCOML=RMTCOML+RMCOM
 ....S:RMVA'="" RMTUSELU=RMTUSELU+RMVA
 ....S:RMCOM'="" RMTUSELN=RMTUSELN+RMCOM
 ....S RMTISUL=RMTISUL+RMISU
 ....S RMTISNL=RMTISNL+RMISN
 ....;S RMTAVELU=RMTAVELU+RMAVEU
 ....;S RMTAVELN=RMTAVELN+RMAVEN
 ....S RMTQOHUL=RMTQOHUL+RMQOHU
 ....S RMTQOHNL=RMTQOHNL+RMQOHN
 ....S RMTVALUL=RMTVALUL+RMVALU
 ....S RMTVALNL=RMTVALNL+RMVALN
 ....;total for group
 ....S RMTVAG=RMTVAG+RMVA
 ....S RMTCOMG=RMTCOMG+RMCOM
 ....S RMTUSEG=RMTUSEG+RMVA
 ....S RMTISUG=RMTISUG+RMISU
 ....S RMTISNG=RMTISNG+RMISN
 ....S RMTQOHUG=RMTQOHUG+RMQOHU
 ....S RMTQOHNG=RMTQOHNG+RMQOHN
 ....S RMTVALUG=RMTVALUG+RMVALU
 ....S RMTVALNG=RMTVALNG+RMVALN
 ....S RMGTOU=RMGTOU+RMVALU
 ....S RMGTON=RMGTON+RMVALN
 ....S RMGTIU=RMGTIU+RMISU
 ....S RMGTIN=RMGTIN+RMISN
 ....S:'RMISU RMISU=""
 ....S:'RMISN RMISN=""
 ....S RMVALU=$FN(RMVALU,",",2) S:'RMVALU RMVALU=""
 ....S RMVALN=$FN(RMVALN,",",2) S:'RMVALN RMVALN=""
 ....S:RMVA="" RMVA=0 S:RMISU="" RMISU=0 S:RMCOM="" RMCOM=0
 ....S:RMISN="" RMISN=0
 ....;for used item
 ....W:$G(RMVA)!$G(RMVALU) !,RHCPC,?10,$E(RNPITEM,1,15),?26,$J(RMVA,5),?33,$J($FN(RMISU,",",2),7),?40,"|",?59,"|",?60,$J(RMVA,5),?67,"|",?71,$J(RMAVEU,5,2),?78,"|",?81,$J(RMQOHU,5)
 ....W:$G(RMVA)!$G(RMVALU) ?94,"|",?96,$J(RMDLEU,7),?103,"|",?104,$J(RMVALU,11)
 ....;for new item
 ....W:$G(RMCOM)!$G(RMVALN) !,RHCPC,?10,$E(RNPITEM,1,15),?40,"|",?41,$J(RMCOM,4),?49,$J($FN(RMISN,",",2),9),?59,"|",?60,$J(RMCOM,5),?67,"|",?71,$J(RMAVEN,5,2),?78,"|"
 ....W:$G(RMCOM)!$G(RMVALN) ?87,$J(RMQOHN,6),?94,"|",?96,$J(RMDLEN,7),?103,"|",?116,$J(RMVALN,11)
 ....S (RPRINT,RPR)=1
 ....I $Y+8>IOSL,IOST["C-" K DIR S DIR(0)="E" D ^DIR S:+Y'>0 RFL=1 Q:+Y'>0  W @IOF D HDRI,LBL1
 ....I $Y+8>IOSL,IOST'["C-" W @IOF D HDRI,LBL1
 ;print total for Used and New items (all report type)
TOT G:$G(RFL) CLEAN1
 I '$G(RPRINT) W !!,"No Records to Print !!" G CLEAN1
 W !!,?10,"GRAND TOTAL $ VALUE ISSUED (Used) = ",?38,"$",$J($FN(RMGTIU,",",2),10)
 W ?80,"GRAND TOTAL $ VALUE ON-HAND (Used) = ",?115,"$",$J($FN(RMGTOU,",",2),12)
 W !,?10,"GRAND TOTAL $ VALUE ISSUED (New)  = ",?38,"$",$J($FN(RMGTIN,",",2),10)
 W ?80,"GRAND TOTAL $ VALUE ON-HAND (New)  = ",?115,"$",$J($FN(RMGTON,",",2),12)
 W !,"<End of Report>"
 ;
CLEAN1 ; Clean and EXITS program.
 I $E(IOST)["C",'$D(DUOUT) K DIR S DIR(0)="E" D ^DIR
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 N RMPR,RMPRSITE
 D KILL^XUSCLEAN
 K ^TMP($J)
 Q
 ;
HDRI ;print heading.
 Q:$G(RFL)
 S RMPAGE=RMPAGE+1
 W !,"PROSTHETIC INVENTORY ITEM DETAIL REPORT",?50,"Run Date: ",RMRDATE,?100,"Page: ",RMPAGE
 W !,"STATION: ",$E(RSTN,1,20)
 W ?32,RMBD," - ",RMED,"  [ ",RMCALDAY," calendar days ]"
 Q
 ;
LBL1 ;print column header.
 Q:$G(RFL)
 W !,RLN
 W:RMPRDET="I" !,"HCPCS     PSAS/ITEM"
 W:RMPRDET="H" !,"HCPCS    DESCRIPTION"
 W:RMPRDET="L" !,"NPPD LINE"
 W:RMPRDET="G" !,"NPPD GROUP"
 W ?23,"V.A.(Used)  Total| COM. (New)  Total| Total |Days Ave  |  Stock On-Hand| Days   |Total $ Value On-Hand"
 W !,?23,"Issue     $ Value| Issue     $ Value| Issue |Usage Rate|  Used    New  | On-Hand|   Used        New"
 W:RMPRDET'="G" !,RLN
 Q
 ;
GLN1 ;print NPPD GROUP and LINE header.
 Q:$G(RFL)
 W !!,RJ," ",RNPLINE," [",RNPGRP," ]"
 D LBL1
 Q
 ;
SUML1 ;print summary total for NPPD LINE
 Q:$G(RFL)
 W !,REQ
 S:$G(RMTUSELU) RMTAVELU=RMTUSELU/RMCALDAY
 S:$G(RMTUSELN) RMTAVELN=RMTUSELN/RMCALDAY
 ;S:RMTDLEL>999 RMTDLEL=">999"
 ;next two lines print used total
 W !,?5,"(Used)",?26,$J(RMTVAL,5),?34,$J($FN(RMTISUL,",",2),6),?40,"|",?59,"|",?60,$J(RMTUSELU,5),?67,"|",?71,$J(RMTAVELU,5,2),?78,"|"
 W ?81,$J(RMTQOHUL,5),?94,"|",?103,"|",?104,$J($FN(RMTVALUL,",",2),11)
 ;next two lines print new total
 W !,?5,"(New)",?40,"|",?41,$J(RMTCOML,4),?49,$J($FN(RMTISNL,",",2),9),?59,"|",?60,$J(RMTUSELN,5),?67,"|",?71,$J(RMTAVELN,5,2),?78,"|"
 W ?87,$J(RMTQOHNL,6),?94,"|",?103,"|",?116,$J($FN(RMTVALNL,",",2),11)
 S (RMTVAL,RMTISUL,RMTCOML,RMTISNL,RMTUSEL,RMTAVELU,RMTAVELN,RMTQOHUL,RMTQOHNL,RMTVALUL,RMTVALNL,RLCNT,RMTUSELU,RMTUSELN)=0
 S (RNPLINE,RLINE)=""
 Q
