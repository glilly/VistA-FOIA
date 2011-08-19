PSOTPPOS ;BIR/RTR-Patch 145 Post Install routine ;07/27/03
 ;;7.0;OUTPATIENT PHARMACY;**145**;DEC 1997
 ;Reference to SDPHARM supported by DBIA 4193
 ;Reference to SDPBE supported by DBIA 4194
 ;Reference to DIC(19 supported by DBIA 2246
 ;Reference to DIC(4 supported by DBIA 2251
 ;
 G FILE
 N PSOTPLLZ,PSOTPFLG
 S PSOTPFLG=0
 S PSOTPLLZ="" F  S PSOTPLLZ=$O(^PS(53,"B","NON-VA",PSOTPLLZ)) Q:PSOTPLLZ=""  D
 .I $P($G(^PS(53,PSOTPLLZ,0)),"^")="NON-VA" S $P(^(0),"^",6)=5,PSOTPFLG=PSOTPFLG+1
 I '$G(PSOTPFLG) D BMES^XPDUTL("Could not find a NON-VA entry in the RX PATIENT STATUS file.") D MES^XPDUTL("Please contact National Vista Support!")
 I $G(PSOTPFLG)>1 D BMES^XPDUTL("Found multiple entries of NON-VA in the RX PATIENT STATUS file.") D MES^XPDUTL("Please contact National Vista Support!")
 ;
FILE ;Populate TPB file
 ;N VARIABLE
 ;S ZTDTH=""
 ;I $D(ZTQUEUED) S ZTDTH=$H
 L +^XTMP("SDPSO145"):0 I '$T D  Q
 .D BMES^XPDUTL("Post-Init for patch PSO*7*145 is already running.  Halting..")
 ;I ZTDTH="" D
 ;.D BMES^XPDUTL("Auto-Populate TPB ELIGIBILITY (#52.91) File.")
 ;.D BMES^XPDUTL("If no start date/time is entered when prompted, the background job will ")
 ;.D MES^XPDUTL("be queued to run NOW.")
 ;.D GETDATE
 ;.D BMES^XPDUTL("Queuing background job to populate TPB ELIGIBILITY (#52.91) File.")
 ;S ZTDTH=@XPDGREF@("PSOPINIT")
 I '$G(^XTMP("SDPSO145","PSOTINIT")) D BMES^XPDUTL("Install aborted, cannot determine post-install task time..") Q
 S ZTDTH=$G(^XTMP("SDPSO145","PSOTINIT")) L -^XTMP("SDPSO145")
 S ZTRTN="START^PSOTPPOS",ZTIO="",ZTDESC="Populate TPB ELIGIBILITY FILE" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 I $D(ZTSK)&('$D(ZTQUEUED)) D BMES^XPDUTL("Task Queued!")
 Q
START ;Build TPC Eligibility file
 I '$G(DT) S DT=$$DT^XLFDT
 S U="^"
 N PSOACTRX,PSOENRLD,PSOLPQT,PSONODAD,PSOTG1,PSOTG2,PSOTG3,PSOETOT,PSOITOT,PSOTLOCK,PSOTPSNM,PSOSTATI
 S (PSOETOT,PSOITOT)=0
 S PSOTLOCK=0
 L +^XTMP("SDPSO145"):0 I '$T S PSOTLOCK=1 D MAIL S:$D(ZTQUEUED) ZTREQ="@" Q
 K ^XTMP("SDPSO145")
 S X1=DT,X2=+60 D C^%DTC S ^XTMP("SDPSO145",0)=$G(X)_"^"_DT K X1,X2
 D NOW^%DTC S Y=% D DD^%DT S ^XTMP("SDPSO145","START")=$G(Y)
 D ^SDPHARM
 D ^SDPBE
 I '$D(^XTMP("SDPSO145","PAT")) G PASS
 S PSOTG1="" F  S PSOTG1=$O(^XTMP("SDPSO145","PAT","E",PSOTG1)) Q:PSOTG1=""  D
 .I $D(^PS(52.91,PSOTG1,0)) Q  ;Multiple Installs check
 .S PSOLPQT=0
 .S PSOTG2="" F  S PSOTG2=$O(^XTMP("SDPSO145","PAT","E",PSOTG1,PSOTG2)) Q:PSOTG2=""!(PSOLPQT)  S PSOTG3="" F  S PSOTG3=$O(^XTMP("SDPSO145","PAT","E",PSOTG1,PSOTG2,PSOTG3)) Q:PSOTG3=""!(PSOLPQT)  D
 ..S PSONODAD=$G(^XTMP("SDPSO145","PAT","E",PSOTG1,PSOTG2,PSOTG3))
 ..I $P($G(^PS(52.91,PSOTG1,0)),"^",5),'PSONODAD D  Q  ;Entry exists, if this date is sooner, replace, if you get a Station Number
 ...I PSOTG3'<$P($G(^PS(52.91,PSOTG1,0)),"^",5) Q
 ...I PSOTG2=$P($G(^PS(52.91,PSOTG1,0)),"^",8) K DIE,DA,DR S DIE="^PS(52.91,",DA=PSOTG1,DR="4////"_PSOTG3 D ^DIE K DIE,DA,DR Q
 ...K PSOTPSNM,PSOSTATI,DIC,DIQ,DD,DR S DIC=4,DR="99",DA=+PSOTG2,DIQ(0)="I",DIQ="PSOSTATI" D EN^DIQ1 S PSOTPSNM=$G(PSOSTATI(4,+PSOTG2,99,"I")) K DIC,DIQ,DR,DA,PSOSTATI
 ...I $G(PSOTPSNM)="" K PSOTPSNM Q
 ...K DA,DIE,DR S DIE="^PS(52.91,",DA=PSOTG1,DR="4////"_PSOTG3_";6////"_PSOTPSNM_";7////"_PSOTG2 D ^DIE K DA,DIE,DR
 ...K PSOTPSNM
 ..I $D(^PS(52.91,PSOTG1,0)),'PSONODAD D  Q
 ...I PSOTG2=$P($G(^PS(52.91,PSOTG1,0)),"^",8) K DIE,DA,DR S DIE="^PS(52.91,",DA=PSOTG1,DR="4////"_PSOTG3 D ^DIE K DIE,DA,DR Q
 ...K PSOTPSNM,PSOSTATI,DIC,DIQ,DD,DR S DIC=4,DR="99",DA=+PSOTG2,DIQ(0)="I",DIQ="PSOSTATI" D EN^DIQ1 S PSOTPSNM=$G(PSOSTATI(4,+PSOTG2,99,"I")) K DIC,DIQ,DR,DA,PSOSTATI
 ...I $G(PSOTPSNM)="" K PSOTPSNM Q
 ...K DA,DIE,DR S DIE="^PS(52.91,",DA=PSOTG1,DR="4////"_PSOTG3_";6////"_PSOTPSNM_";7////"_PSOTG2 D ^DIE K DA,DIE,DR
 ...K PSOTPSNM
 ..I $D(^PS(52.91,PSOTG1,0)) Q
 ..K PSOENRLD S PSOENRLD=$$ENR^PSOTPCRX(PSOTG1,3030725) I '$G(PSOENRLD) S ^XTMP("SDPSO145","NOTEN",PSOTG1)="",PSOLPQT=1 Q
 ..K PSOACTRX S PSOACTRX=$$RX^PSOTPCRX(PSOTG1) I $G(PSOACTRX) D EWL^PSOTPCRX S PSOLPQT=1 Q
 ..K PSOTPSNM
 ..K PSOSTATI,DIC,DIQ,DD,DR S DIC=4,DR="99",DA=+PSOTG2,DIQ(0)="I",DIQ="PSOSTATI" D EN^DIQ1 S PSOTPSNM=$G(PSOSTATI(4,+PSOTG2,99,"I")) K DIC,DIQ,DR,DA,PSOSTATI
 ..I $G(PSOTPSNM)="" S ^XTMP("SDPSO145","PROB1",PSOTG1)="" K PSOTPSNM Q
 ..I '$D(^PS(52.91,PSOTG1,0)) K DIC S DIC="^PS(52.91,",DIC(0)="L",(X,DINUM)=PSOTG1,DIC("DR")="1////"_DT_";5////"_"E"_";6////"_PSOTPSNM_";7////"_PSOTG2 S:'$G(PSONODAD) DIC("DR")=DIC("DR")_";4////"_PSOTG3 D
 ...K DD,DO D FILE^DICN K DD,DO,DIE,X,DINUM
 ...I Y'>0 S ^XTMP("SDPSO145","PROB",PSOTG1)="" Q
 ...S PSOETOT=PSOETOT+1
 ...K ^XTMP("SDPSO145","PROB",PSOTG1)
 ...K ^XTMP("SDPSO145","PROB1",PSOTG1)
 ;LOOP THROUGH SCHEDULING XTMP HERE
 D SCH^PSOTPCRX
PASS ;
 S ^XTMP("SDPSO145","ELIG")=+$G(PSOETOT)
 S ^XTMP("SDPSO145","INEL")=+$G(PSOITOT)
 D EN^PSO145PS
 D NOW^%DTC S Y=% D DD^%DT S ^XTMP("SDPSO145","STOP")=$G(Y) K Y
 ;***need HL7 routine name  (moved to phase 2)
 ;I '$$PATCH^XPDUTL("PSO*7.0*145") S ZTRTN="NAME^EXTRACT",ZTIO="",ZTDESC="TPB EIGIBILITY FILE EXTRACT",ZTDTH=$H D ^%ZTLOAD K ZTRTN,ZTIO,ZTDESC,ZTDTH
 D MAIL
 L -^XTMP("SDPSO145")
 K DA,DIE,DR S DA=$O(^DIC(19,"B","PSO TPB PATIENT ENTER/EDIT",0)) I DA S DIE="^DIC(19,",DR="2////"_"@" D ^DIE K DIE,DA,DR
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MAIL ;
 N PSOTUCI,PSOTUCI1,XMTEXT,XMSUB,XMDUZ,XMY,PSOMLIN,PSOMLINN,PSOTDEL,PSOMNAME,PSOMLLP,PSOMLCT,PSOSTEXT,PSOQTIME,X,Y,%
 S PSOMLINN="" S PSOMLIN=$P($G(^XMB(1,1,"XUS")),"^",17) I PSOMLIN'>0 S PSOMLIN=$G(DUZ(2))
 I PSOMLIN S PSOMLINN=$P($G(^DIC(4,PSOMLIN,0)),"^")
 S XMSUB=$S($G(PSOMLINN)="":"Unknown Institution",1:$G(PSOMLINN)_" ("_$G(PSOMLIN)_")")_" TPB FILE BUILD"
 S XMDUZ="Patch PSO*7*145 Post Install" I $G(DUZ) S XMY(DUZ)=""
 X ^%ZOSF("UCI") S PSOTUCI=$P($G(Y),",") S PSOTUCI1=$P($G(^%ZOSF("PROD")),",") I PSOTUCI=PSOTUCI1 D
 .S XMY("TEMPLETON,SHANNON@FORUM.VA.GOV")=""
 .S XMY("BROCKERT,JUDITH@FORUM.VA.GOV")=""
 .S XMY("CHOW,ANGELA@FORUM.VA.GOV")=""
 .S XMY("RUZBACKI,RON@FORUM.VA.GOV")=""
 .S XMY("BARRON,LUANNE@FORUM.VA.GOV")=""
 .S XMY("WASHINGTON,JANET P@FORUM.VA.GOV")=""
 I $G(PSOTLOCK) D  G MAILX
 .D NOW^%DTC S Y=% X ^DD("DD") S PSOQTIME=Y
 .K PSOSTEXT S PSOSTEXT(1)="The TPB ELIGIBILITY file building, and other post-install functions of",PSOSTEXT(2)="patch PSO*7*145, queued to run at "_$G(PSOQTIME)_",",PSOSTEXT(3)="was NOT run, because the XTMP patient global was locked."
 .S PSOSTEXT(4)="This Post-Install may have been queued by another user. Please contact",PSOSTEXT(5)="Customer Support."
 S PSOSTEXT(1)="The Post-Init from Patch PSO*7.0*145 is complete. The TPB ELIGIBILITY",PSOSTEXT(2)="File (#52.91) has been populated.",PSOSTEXT(3)=" "
 S PSOSTEXT(4)="The job started at "_$G(^XTMP("SDPSO145","START")),PSOSTEXT(5)="The job ended at "_$G(^XTMP("SDPSO145","STOP")),PSOSTEXT(6)=" "
 S PSOSTEXT(7)="Total number of eligible patients added to file = "_$G(^XTMP("SDPSO145","ELIG")),PSOSTEXT(8)="Total number of ineligible patients added to file = "_$G(^XTMP("SDPSO145","INEL")),PSOSTEXT(9)=" "
 S PSOMLCT=10
 S PSOTDEL="" F  S PSOTDEL=$O(^XTMP("SDPSO145","PROB",PSOTDEL)) Q:PSOTDEL=""  I $D(^PS(52.91,PSOTDEL,0)) K ^XTMP("SDPSO145","PROB",PSOTDEL)
 S PSOTDEL="" F  S PSOTDEL=$O(^XTMP("SDPDO145","PROB1",PSOTDEL)) Q:PSOTDEL=""  I $D(^PS(52.91,PSOTDEL,0)) K ^XTMP("SDPSO145","PROB1",PSOTDEL)
 I $O(^XTMP("SDPSO145","PROB",0)) D
 .S PSOSTEXT(PSOMLCT)="The following patients qualify for the Transitional Pharmacy",PSOMLCT=PSOMLCT+1,PSOSTEXT(PSOMLCT)="Benefit, but were unable to be added to the file for unknown reasons:",PSOMLCT=PSOMLCT+1
 .S PSOMLLP="" F  S PSOMLLP=$O(^XTMP("SDPSO145","PROB",PSOMLLP)) Q:PSOMLLP=""  D
 ..D PNM
 ..S PSOSTEXT(PSOMLCT)=$G(PSOMNAME)_$G(^XTMP("SDPSO145","PROB",PSOMLLP)),PSOMLCT=PSOMLCT+1
 I PSOMLCT>10 S PSOSTEXT(PSOMLCT)=" ",PSOMLCT=PSOMLCT+1
 I $O(^XTMP("SDPSO145","PROB1",0)) D
 .S PSOSTEXT(PSOMLCT)="The following patients qualify for the Transitional Pharmacy",PSOMLCT=PSOMLCT+1,PSOSTEXT(PSOMLCT)="Benefit, but were unable to be added to the file because a Station Number",PSOMLCT=PSOMLCT+1
 .S PSOSTEXT(PSOMLCT)="could not be found for the Institution associated with the patient:",PSOMLCT=PSOMLCT+1
 .S PSOMLLP="" F  S PSOMLLP=$O(^XTMP("SDPSO145","PROB1",PSOMLLP)) Q:PSOMLLP=""  D
 ..D PNM
 ..S PSOSTEXT(PSOMLCT)=$G(PSOMNAME)_$G(^XTMP("SDPSO145","PROB1",PSOMLLP)),PSOMLCT=PSOMLCT+1
MAILX ;
 I $O(XMY(""))'="" S XMTEXT="PSOSTEXT(" N DIFROM D ^XMD
 K PSOSTEXT,XMTEXT,XMSUB,XMDUZ,XMY
 Q
GETDATE ;
 N PSONOW,PSOTODAY,X,Y,PSOSAVEY,PSOSAVEX,PSOXXX
 S ZTDTH="",PSONOW=0
 D NOW^%DTC S (Y,PSOTODAY)=% D DD^%DT
 D BMES^XPDUTL("At the following prompt, enter a starting date@time")
 D MES^XPDUTL("or enter NOW to queue the job immediately.")
 D BMES^XPDUTL("If this prompting is during patch installation, you may not see what you type.")
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue TPB Eligibility File building job for what Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W "Task will be queued to run NOW" S ZTDTH=$H,PSONOW=1
 S PSOSAVEY=Y
 I 'PSONOW,PSOSAVEY>0 D
 .S Y=PSOSAVEY D DD^%DT
 .S PSOSAVEX=Y
 I 'PSONOW,$G(PSOSAVEY)<0 K PSOXXX,PSOSAVEX,PSOSAVEY,X,Y,PSONOW,PSOTODAY G GETDATE
ASK ;
 D BMES^XPDUTL("Task will be queued to run "_$S(PSONOW:"NOW",1:PSOSAVEX)_". Is that correct? ")
 R PSOXXX:300 S:'$T!($G(PSOXXX)="") PSOXXX="Y" S PSOXXX=$$UP^XLFSTR(PSOXXX) I PSOXXX'="Y",PSOXXX'="YES",PSOXXX'="N",PSOXXX'="NO" W "Enter Y or N" G ASK
 I PSOXXX'="Y",PSOXXX'="YES" K PSOXXX,PSOSAVEX,PSOSAVEY,X,Y,PSONOW,PSOTODAY G GETDATE
 I PSOSAVEY>0,ZTDTH="" S ZTDTH=PSOSAVEY
 I ZTDTH="" S ZTDTH=$H
 Q
PNM ;
 N DFN,VADM,VA,VAERR
 K PSOMNANE,VADM
 S DFN=+$G(PSOMLLP) I 'DFN Q
 D DEM^VADPT I $G(VADM(1))="" K VADM Q
 S PSOMNAME=$G(VADM(1))
 K VADM
 K VA,VAERR S DFN=+$G(PSOMLLP) D PID^VADPT6
 S PSOMNAME=PSOMNAME_" "_"("_$G(VA("BID"))_")"
 K VA,VAERR
 Q
