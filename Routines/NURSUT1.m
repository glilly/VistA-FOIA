NURSUT1 ;HIRMFO/RM,MD-NURS POSITION CONTROL FILE EDIT UTILITY (CONT) ; 5/16/03 5:10pm
 ;;4.0;NURSING SERVICE;**2,7,13,39**;Apr 25, 1997
EN1 ; ENTRY FROM ASD1 FROM 211.82,.01, ASD2 FROM 211.82,3 AND ASD3 FROM
 ; 211.82,5 CROSSREFERENCES.  THE VARIABLE NUR WILL BE SET TO THE
 ; FOLLOWING:  FIELD NUMBER CALLING XREF^$S(0:KILL LOGIC,1:SET LOGIC)
 N DIK
 S NUR(211.82)=$S($D(^NURSF(211.8,DA(1),1,DA,0)):^(0),1:""),NUR("SDT")=$S(+NUR=.01:X,1:+NUR(211.82)),NUR("VDT")=$S(+NUR=3:X,1:$P(NUR(211.82),"^",6))
 I +NUR=.01 S:$P(NUR,"^",2) ^NURSF(211.8,"ASD",2,DA(1),DA)="" K:'$P(NUR,"^",2) ^NURSF(211.8,"ASD",2,DA(1),DA)
 I +NUR=3 S:$P(NUR,"^",2) ^NURSF(211.8,"ASD",1,DA(1),DA)="" K:'$P(NUR,"^",2) ^NURSF(211.8,"ASD",1,DA(1),DA)
 D EMP Q
EN1B ; ENTRY POINT TO KILL "ASD" X-REF AFTER ADDED TO 213.5 DURING ACT/SEP BATCH JOB
 N DIK
 S NUR(211.82)=$S($D(^NURSF(211.8,DA(1),1,DA,0)):^(0),1:""),NUR("SDT")=$S(+NUR=.01:X,1:+NUR(211.82)),NUR("VDT")=$S(+NUR=3:X,1:$P(NUR(211.82),"^",6))
 I NUR("SDT")'>DT,+NUR=.01 K ^NURSF(211.8,"ASD",2,DA(1),DA)
 I NUR("VDT")'>DT,+NUR=3 K ^NURSF(211.8,"ASD",1,DA(1),DA)
EMP D STTUPD I +NUR=.01!(+NUR=3) S NUR("PE")=NUR D EN1^NURSAPE0
 K NUR
 Q
STTUPD ; CHECK IF UPDATE OF STATUS FIELD IN FILE 210 IS NECESSARY
 S NUR(0)=X D NOW^%DTC S X=NUR(0),NURSDT=%,(NURSEMP,NUR(200))=$P(NUR(211.82),"^",2) G:NUR(200)'>0 QSU  S NUR(200)=$P(NUR(211.82),"^",2)
 S NUR(210)=$O(^NURSF(210,"B",NUR(200),0)) G QSU:NUR(210)'>0 S NUR("OST")=$S($D(^NURSF(210,NUR(210),0)):$P(^(0),"^",2),1:"")
 I NUR("OST")'="A",NUR("OST")'="I",+$$EN1^NURSUT0($G(NURSEMP),$G(NURSDT)) S NUR("NST")="A" D SETST
 I '+$$EN1^NURSUT0($G(NURSEMP),$G(NURSDT)) S NUR(211.9)=$S(+NUR=5:X,1:$P(NUR(211.82),"^",8)),NUR("NST")=$S(NURSTAT:"A",$D(^NURSF(211.9,+NUR(211.9),0)):$P(^(0),"^",3),1:"R") I NUR("NST")'="",NUR("NST")'=NUR("OST") D SETST
QSU Q
SETST ; CHANGE STATUS FIELD OF FILE 210
 N DA,X S DA=$O(^NURSF(210,"B",NUR(200),0)) Q:DA'>0
 I NUR("OST")'="" S X=NUR("OST") K ^NURSF(210,"AC",X,DA)
 I NUR("NST")'="" S X=NUR("NST"),$P(^NURSF(210,DA,0),"^",2)=X,DIK="^NURSF(210," D IX1^DIK
 Q
EN4(NACT,NASK) ; ENTRY POINT FOR BEDSIDE TERMINAL PATIENT LOOK-UP
 I '$D(^NURSC(214.8,0)) S NURBEDSW=0 Q
 S IEN=0,IEN=$O(^NURSC(214.8,"B",ION,IEN)),ROOMBED=$S(+IEN>0:$P(^NURSC(214.8,IEN,0),U,2),1:""),PATIENT=""
 I ROOMBED'="" S IEN=0,IEN=$O(^DPT("RM",ROOMBED,IEN)),PATIENT=$S(+IEN>0:$P(^DPT(IEN,0),U,1),1:"") W !!,?5,"Room-Bed: ",ROOMBED,!,?6,"Patient: ",PATIENT
 S:'(DIC(0)["A") DIC(0)="A"_DIC(0) S:'(PATIENT="") DIC("B")=PATIENT
 S DIC("A")="Select PATIENT NAME: "
 W ! S DFN="",DIC="^DPT(" D ^DIC K DIC S:$L($P(Y,"^",2)) X=$P(Y,"^",2) I $D(DTOUT)!$D(DUOUT) S DFN="" G QUIT
 I +Y>0,NACT,'$D(^NURSF(214,"C","A",+Y)) S Y=-2
 I +Y>0 S DFN=+Y K DIC W ! G QUIT
 I X'["?",(X?1U.UP1","1U.UP) W !!,$C(7),$S('NACT!(NACT&(Y=-1)):"PATIENT not admitted with MAS -- notify MAS",1:"PATIENT is not active in the Nursing system -- notify Nursing ADP coordinator")
QUIT K DTOUT,DUOUT,IEN,LOOP,PATIENT,ROOMBED
 Q
DBL ;CHECK FOR ROOM-BED DUPLICATE ENTRIES
 I X="" K X Q
 S IEN=0,IEN=$O(^NURSC(214.8,"C",X,IEN))
 I +IEN>0 W *7,!!,?5,"That ROOM-BED is already associated with ION VALUE "_$P(^NURSC(214.8,IEN,0),U,1)_"  " K X
 K IEN Q
CLOSE ; CLOSE DEVICE
 W !
 I '+$G(NUROUT) D ENDPG
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
ENDPG ; HANDLE EOP
 I $E($G(IOST))'="C" Q
 K DIR S DIR(0)="E" D ^DIR K DIR S NUROUT=$S(+Y'>0:1,1:0)
 Q
LOCSTAT(NURLOC) ; CHECK FOR ACTIVE EMPLOYEES ON NURS LOCATION
 N NURPOS,NPOSDA S NURACTV=0
 S NURPOS="" F  S NURPOS=$O(^NURSF(211.8,"B",+NURLOC,NURPOS)) Q:NURPOS'>0  S NPOSDA=0 F  S NPOSDA=$O(^NURSF(211.8,NURPOS,1,NPOSDA)) Q:NPOSDA'>0  I $G(^NURSF(211.8,NURPOS,1,NPOSDA,0))'="" D
 .  I $P($G(^NURSF(211.8,NURPOS,1,NPOSDA,0)),U,6)=""!($P($G(^(0)),U,6)'<DT) S NURACTV=1 Q
 .  Q
 Q NURACTV
CHKSTAT ; INPUT TRANSFORM FOR STATUS FIELD OF NURS LOCATION FILE
 N NURLOC S NURLOC=+$G(^NURSF(211.4,+DA,0)),NURLOC(1)=$P(^SC(+$G(^NURSF(211.4,DA,0)),0),"^"),NURLOC(1)=$P(NURLOC(1),"NUR ",2),NURSTAT=0,NURSTAT=$S($G(X)="I":+$$LOCSTAT^NURSUT1(NURLOC),1:0)
 I $G(X)="I",$G(NURSTAT)>0 D
 . W $C(7),!!,NURLOC(1)," HAS ACTIVE STAFF ASSIGNED AND CANNOT BE DEACTIVATED: ",!!,"Generate an FTEE report for this location to identify active staff members",!,"who should be transferred prior to deactivation!" D ENDPG^NURSUT1
 . Q
 Q
BUDCAT(D0) ; COMPUTE BUDGET CATEGORY FTEE FOR A LOCATION
 N D1 S X=0
 S D1=0 F  S D1=$O(^NURSF(211.8,D0,2,D1)) Q:D1'>0  I $D(^NURSF(211.8,D0,2,D1,0)) S X=(X+$P(^(0),U,2))
 Q X
NODATA ; NO DATA ROUTINE FOR LOCATION REPORTS
 W !!,"THERE IS NO DATA FOR ",NL1
 Q
