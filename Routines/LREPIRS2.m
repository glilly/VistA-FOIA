LREPIRS2 ;DALOI/CKA - EPI-PRINT LOCAL REPORT/SPREADSHEET ; 5/14/03
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to X ^DD("DD") supported by IA #10017
 W !?5,"Print Local Report/Spreadsheet Option"
RORS ;REPORT OR SPREADSHEET
 S DIR(0)="SO^1:REPORT;2:SPREADSHEET"
 S DIR("A")="Which one do you wish to print"
 D ^DIR
 G:$D(DIRUT) EXIT
 S LRREP=Y
 K DIR,DIRUT
CHOOSE ;CHOOSE RPT OR SPSHT TO PRINT
 S LRLRDTX=1,LRY=1,LRNODE="LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT"),LRNODE1=LRNODE
 F  S LRNODE=$O(^XTMP(LRNODE)) Q:LRNODE=""!(LRNODE'[LRNODE1)  S LRLRDTX=$E(LRNODE,$S(LRREP=1:14,1:16),$S(LRREP=1:28,1:30))  D
 .Q:LRLRDTX=""
 .I '$D(^XTMP("LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT")_LRLRDTX,"DONE")) Q
 .S Y=LRLRDTX X ^DD("DD") S LRLRDT(LRLRDTX)=Y,LRLRDT(LRY)=LRLRDTX
 .S LRTITLE=$G(^XTMP("LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT")_LRLRDTX,"TITLE"))
 .W !,LRY," ",LRLRDT(LRLRDTX)," ",LRTITLE
 .S LRY=LRY+1
 S LRY=LRY-1
 I LRY=0,'$D(LRTITLE) W !,"No "_$S(LRREP=1:"report ",1:"spreadsheet ")_"is ready for printing." G RORS
 S DIR(0)="NO^1:"_LRY
 S DIR("A")="Choose the number for the "_$S(LRREP=1:"report",LRREP=2:"spreadsheet")_" you wish to print"
 D ^DIR
 G:$D(DIRUT) RORS
 S LRY=Y,LRLRDT=LRLRDT(LRY)
 K DIR,DIRUT
 I LRREP=2 D  D:'$D(LREND) PRIV D:'$D(LREND) READY D:'$D(LREND) SPSHT G EXIT
 .W !!
 .W !?5,"This option will print the selected fields."
 .W !?5,"You will need to capture this printout in a text document."
 .W !?5,"Using a text editor, remove any extraneous lines from the beginning"
 .W !?5,"and the end of the file so that only the data to be imported remains."
 .W !?5,"Save the edited file.  Use this file in the import function of"
 .W !?5,"your spreadsheet program."
 I LRREP=1 D:'$D(LREND) PRIV D:'$D(LREND) REP G EXIT
 W !!
EXIT ;
 D ^%ZISC
 K D0,LRAUTO,LRBEG,LRDT,LREND,LRRNDT,LREPI,LRRPE,LRRPS,ZTSAVE
 K ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK,X,Y,X1,%DT,POP,%ZIS
 K LRLC,LRHDG,LRQUIT,LRHDGLC,LRPAGE,LRY,LRLRDT,LRDTHDG,LRLRDTX,LRNODE,LRNODE1,LRTITLE
 K DIR,DTOUT,DUOUT,DIRUT,I,J,LRMSGLIN,LRREP,LRSPSHT,MSG,MSGLIN
 Q
 ;
SPSHT ;
 S %ZIS="Q" D ^%ZIS Q:POP  I '$D(IO("Q")) U IO D PRTSP Q
 S ZTRTN="PRTSP^LREPIRS2",ZTSAVE("LR*")="",ZTDESC="PRINT EPI LOCAL SPREADSHEET",ZTREQ="@" D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report Cancelled."
 E  W !!?5,"The Task has been queued",!,"Task #",$G(ZTSK) H 5
 D HOME^%ZIS G EXIT
 Q
PRTSP S MSG=0,LRSPSHT="",LRLC=0,LRPAGE=1,LRQUIT=0
 F  S MSG=$O(^XTMP("LREPILOCALSPSHT"_LRLRDT,MSG)) Q:'MSG  S LRMSGLIN=^(MSG) D  Q:LRQUIT
 .W !,LRMSGLIN
 .I $Y>(IOSL-6) D NPG
 K MSGLIN,LRSEG
 Q
READY ;
 K DIR S DIR(0)="Y",DIR("A")="Ready to Capture"
 D ^DIR S:$D(DIRUT) LREND=1
 S:'Y LREND=1
 Q
PRIV ;PRIVACY MESSAGE
 W !!!,"This report will contain Confidential Information."
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue/proceed"
 S DIR("B")="NO"
 D ^DIR S:$D(DIRUT) LREND=1
 S:'Y LREND=1
 Q
REP ;
 S %ZIS="Q" D ^%ZIS Q:POP  I '$D(IO("Q")) U IO D PRT Q
 S ZTRTN="PRT^LREPIRS2",ZTSAVE("LR*")="",ZTDESC="PRINT EPI LOCAL REPORT" D ^%ZTLOAD,HOME^%ZIS G EXIT
 Q
PRT ;Print report
 S MSG=0,LRLC=0,LRPAGE=1,LRQUIT=0
 W !,"***THIS REPORT CONTAINS CONFIDENTIAL INFORMATION.***"
 D HDG
 F  S MSG=$O(^XTMP("LREPILOCALREP"_LRLRDT,MSG)) Q:'MSG  S LRMSGLIN=^(MSG) D  Q:LRQUIT
 .W !,LRMSGLIN
 .S LRLC=LRLC+1
 .I $Y>(IOSL-6) D NPG
 K MSGLIN,LRSEG
 Q
PAUSE ;
 Q:$G(LREND)
 K DIR S DIR(0)="E" D ^DIR
 S:($D(DTOUT))!($D(DUOUT)) LRQUIT=1
 Q
NPG ;NEW PAGE
 D:$E(IOST,1,2)="C-" PAUSE
 Q:$G(LRQUIT)
 W @IOF
 D HDG
 Q
HDG ;
 S LRHDGLC=""
 F  S LRHDGLC=$O(^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)) Q:LRHDGLC=""  D
 .S LRHDG=^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)
 .W !,LRHDG
 .I LRHDGLC=0 W "   PAGE ",LRPAGE
 .S LRLC=LRLC+1
 S LRPAGE=LRPAGE+1
 Q
SAVHDG ;SAVE HEADING WHEN GENERATE REPORT
 ;called from LREPIRS1
 S Y=DT X ^DD("DD")
 S SITE=$$SITE^VASITE
 S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)="         EMERGING PATHOGENS LOCAL REPORT             "_Y
 S LRHDGLC=LRHDGLC+1
 S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)="         FROM STATION "_$P(SITE,U,3)_" "_$P(SITE,U,2)
 S LRHDGLC=LRHDGLC+1
 S LRDTHDG=^TMP("HLS",$J,1)
 S Y=$$CDT^LREPIRP2($P($P($P(LRDTHDG,HLFS,3),LRCS,2)," ",4))
 S MSG=Y
 S Y=$$CDT^LREPIRP2($P($P($P(LRDTHDG,HLFS,3),LRCS,2)," ",6))
 S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)="         PROCESSING PERIOD FROM "_MSG_" THROUGH "_Y
 S LRHDGLC=LRHDGLC+1
 S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)="Reported Local Pathogens:"
 S LRI=0
 F  S LRI=$O(LREPI(LRI))  Q:LRI=""   D
 .S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=^(LRHDGLC)_$P(^LAB(69.5,LRI,0),U)_"  " I $L(^(LRHDGLC))>60 D
 ..S LRHDGLC=LRHDGLC+1
 ..S:'($D(^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC))) ^(LRHDGLC)=$P(^LAB(69.5,LRI,0),U)_"   "
 ..E  S ^(LRHDGLC)=^(LRHDGLC)_"   "_$P(^LAB(69.5,LRI,0),U)
 S LRHDGLC=LRHDGLC+1
 S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=" ",LRHDGLC=LRHDGLC+1
 S LRHDG=""
 I $D(LRSEG("PID",1)) S LRHDG="Set Id"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PID",2)) S LRHDG=LRHDG_"SSN"_$S(LRREP=1:"       ",1:"|")
 I $D(LRSEG("PID",3)) S LRHDG=LRHDG_"MPI"_$S(LRREP=1:$E(LRSP,1,13),1:"|")
 I $D(LRSEG("PID",4)) S LRHDG=LRHDG_"Patient Name"_$S(LRREP=1:$E(LRSP,1,19),1:"|")
 I $D(LRSEG("PID",5)) S LRHDG=LRHDG_"Birth Date"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PID",6)) S LRHDG=LRHDG_"Sex"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PID",7)) S LRHDG=LRHDG_"Race"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("PID",8)) S LRHDG=LRHDG_"Homeless"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PID",9)) S LRHDG=LRHDG_"State"_$S(LRREP=1:$E(LRSP,1,11),1:"|")
 I $D(LRSEG("PID",10)) S LRHDG=LRHDG_"Zip"_$S(LRREP=1:"   ",1:"|")
 I $D(LRSEG("PID",11)) S LRHDG=LRHDG_"County"_$S(LRREP=1:$E(LRSP,1,25),1:"|")
 I $D(LRSEG("PID",12)) S LRHDG=LRHDG_"Ethnicity"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("PID",13)) S LRHDG=LRHDG_"POS"_$S(LRREP=1:"  ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG S LRHDG="" S LRHDGLC=LRHDGLC+1
 I $D(LRSEG("PV1",1)) S LRHDG=LRHDG_"Set Id"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PV1",2)) S LRHDG=LRHDG_"Patient Class"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PV1",3)) S LRHDG=LRHDG_"Hospital Location"_$S(LRREP=1:"   ",1:"|")
 I $D(LRSEG("PV1",4)) S LRHDG=LRHDG_"Discharge Disposition"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("PV1",5)) S LRHDG=LRHDG_"Facility"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PV1",6)) S LRHDG=LRHDG_"Admit Date/Time"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("PV1",7)) S LRHDG=LRHDG_"Discharge Date/Time"_$S(LRREP=1:" ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG S LRHDG="" S LRHDGLC=LRHDGLC+1
 I $D(LRSEG("DG1",1)) S LRHDG=LRHDG_"Set Id"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("DG1",2)) S LRHDG=LRHDG_"Diagnosis Code"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("DG1",3)) S LRHDG=LRHDG_"Diagnosis"_$S(LRREP=1:$E(LRSP,1,31),1:"|")
 I $D(LRSEG("DG1",4)) S LRHDG=LRHDG_"Admission Date"_$S(LRREP=1:" ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG S LRHDG="" S LRHDGLC=LRHDGLC+1
 I $D(LRSEG("NTE",1)) S LRHDG=LRHDG_"Set ID"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("NTE",2)) S LRHDG=LRHDG_"Comment"_$S(LRREP=1:" ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG S LRHDG="" S LRHDGLC=LRHDGLC+1
 I $D(LRSEG("OBR",1)) S LRHDG=LRHDG_"Set ID"_$S(LRREP=1:" ",1:"|")
 I $D(LRSEG("OBR",2)) S LRHDG=LRHDG_"Test Name"_$S(LRREP=1:$E(LRSP,1,12),1:"|")
 I $D(LRSEG("OBR",3)) S LRHDG=LRHDG_"Accession Date"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBR",4)) S LRHDG=LRHDG_"Specimen"_$S(LRREP=1:$E(LRSP,1,13),1:"|")
 I $D(LRSEG("OBR",5)) S LRHDG=LRHDG_"Accession Number"_$S(LRREP=1:"  ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG_$S(LRREP=1:" ",1:"|")_"OBR SUBID" S LRHDG="" S LRHDGLC=LRHDGLC+1
 I $D(LRSEG("OBX",1)) S LRHDG=LRHDG_"Set Id"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",2)) S LRHDG=LRHDG_"Value Type"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",3)) S LRHDG=LRHDG_"Test Name"_$S(LRREP=1:$E(LRSP,1,22),1:"|")
 I $D(LRSEG("OBX",4)) S LRHDG=LRHDG_"LOINC Code"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",5)) S LRHDG=LRHDG_"LOINC Name"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",6)) S LRHDG=LRHDG_"Test Result"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",7)) S LRHDG=LRHDG_"Units"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",8)) S LRHDG=LRHDG_"Flags and Interp"_$S(LRREP=1:"  ",1:"|")
 I $D(LRSEG("OBX",9)) S LRHDG=LRHDG_"Verified Date/Time"_$S(LRREP=1:"  ",1:"|")
 I LRHDG]"" S ^XTMP("LREPILOCALREP"_LRLRDT,"HDG",LRHDGLC)=LRHDG_$S(LRREP=1:" ",1:"|")_"OBX SUBID" S LRHDG="" S LRHDGLC=LRHDGLC+1
 Q
DELETE ;Delete a report or spreadsheet
 W !?5,"Delete a Local Report/Spreadsheet Option"
DRORS ;REPORT OR SPREADSHEET
 S DIR(0)="SO^1:REPORT;2:SPREADSHEET"
 S DIR("A")="Which one do you wish to delete"
 D ^DIR
 G:$D(DIRUT) EXIT
 S LRREP=Y
 K DIR,DIRUT
DCHOOSE ;CHOOSE WHICH REPORT/SPREADSHEET TO DELETE
 S LRLRDTX=1,LRY=1,LRNODE="LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT"),LRNODE1=LRNODE
 F  S LRNODE=$O(^XTMP(LRNODE)) Q:LRNODE=""!(LRNODE'[LRNODE1)  S LRLRDTX=$E(LRNODE,$S(LRREP=1:14,1:16),$S(LRREP=1:28,1:30))  D
 .Q:LRLRDTX=""
 .I '$D(^XTMP("LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT")_LRLRDTX,"DONE")) Q
 .S Y=LRLRDTX X ^DD("DD") S LRLRDT(LRLRDTX)=Y,LRLRDT(LRY)=LRLRDTX
 .S LRTITLE=$G(^XTMP("LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT")_LRLRDTX,"TITLE"))
 .W !,LRY," ",LRLRDT(LRLRDTX)," ",LRTITLE
 .S LRY=LRY+1
 S LRY=LRY-1
 I LRY=0,'$D(LRTITLE) W !,"No "_$S(LRREP=1:"report ",1:"spreadsheet ")_"is ready for printing." G RORS
 S DIR(0)="NO^1:"_LRY
 S DIR("A")="Choose the number for the "_$S(LRREP=1:"report",LRREP=2:"spreadsheet")_" you wish to delete"
 D ^DIR
 G:$D(DIRUT) RORS
 S LRY=Y,LRLRDT=LRLRDT(LRY)
 K DIR,DIRUT
 S LRY=Y
 F I=1:1 Q:$P(LRY,",",I)=""  S LRLRDT=LRLRDT($P(LRY,",",I)) D
 .I LRREP=2 K ^XTMP("LREPILOCALSPSHT"_LRLRDT) W !,"Spreadsheet deleted."
 .I LRREP=1 K ^XTMP("LREPILOCALREP"_LRLRDT) W !,"Report deleted."
 G EXIT
