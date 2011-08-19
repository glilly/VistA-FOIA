RMPR5NAE ;HIN/RVD-PROS INVENTORY ADD UTILITY ;2/11/98
 ;;3.0;PROSTHETICS;**33,37,55**;Feb 09, 1996
 ;
 ;RVD   patch #55  - fix the locking problem and don't allow
 ;                   Fileman to use the number entered as an
 ;                   PSAS/ITEM name
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) K DIC("B") Q
 S X="NOW" D ^%DT
LOC ;add location.
 W @IOF,!!,"Adding Item to a Location.....",! K DTOUT,DUOUT,DIC("B")
 S DZ="??",D="B",DIC("S")="I $P(^RMPR(661.3,+Y,0),U,3)=RMPR(""STA"")"
 S DIC="^RMPR(661.3,",DLAYGO=661.3,DIC(0)="AEQL"
 S D="B",DIC("A")="Enter Pros Location: " D MIX^DIC1
 G:$D(DTOUT)!$D(DUOUT)!(Y'>0) EXIT S (DA,RMLODA)=+Y
 L +^RMPR(661.3,+Y,0):2
 I '$T W !,"Record in use. Try again later..." H 3 G LOC
 S RMLOC=$P(^RMPR(661.3,+Y,0),U,1),DIK=DIC
 I $P(^RMPR(661.3,DA,0),U,3)="" S $P(^(0),U,3)=RMPR("STA") D IX1^DIK
 L -^RMPR(661.3,RMLODA,0)
 ;
LIST ;list current HCPCS @ this Location
 K DIR,DIC("S") S DIR(0)="FO",DIR("A")="Select HCPCS to ADD ",DIR("?")="^S RFL=1 D DSP^RMPR5NU1"
 S DIR="^RMPR(661.1," D ^DIR G:(Y="^")!(Y="")!$D(DTOUT)!$D(DUOUT) LOC
 S DIC(0)="EMNZ",DIC("S")="I $P(^RMPR(661.1,+Y,0),U,5)=1"
 S DIC=661.1,DIC(0)="ENMZ" D ^DIC G:$D(DTOUT)!$D(DUOUT) LOC
 G:Y="^" LOC
 I +Y'>0 W !,"** No HCPCS Selected or Unable to Select Inactive HCPCS..." G LIST
 S RMDAHC=+Y,RMHCPC=$P(^RMPR(661.1,RMDAHC,0),U,1)
 S (RMITFLG,RMHCFLG,RMHCDA,RMITDA,RMAV,RMAVA,RMCO,RMBAL)=0
 S DIC(0)="AEMQ",DA(1)=RMDAHC K DIC("S")
ITEM ;ask for PSAS Item to add
 S DIC("A")="Enter Item to Add: "
 S DIC("B")=$O(^RMPR(661.1,RMDAHC,3,"B",0))
 S DIC="^RMPR(661.1,"_DA(1)_",3,",RDIC1=DIC
 S $P(^RMPR(661.1,DA(1),3,0),U,2)="661.12"
 S DIC(0)="ALEMQ",DLAYGO=661.1 D ^DIC
 G:Y'>0!$D(DTOUT)!$D(DUOUT) LIST S (DA,RMDAIT)=+Y K DIC("B"),DLAYGO
 S DIE=DIC,DR=".01R" D ^DIE
 G:'$D(^RMPR(661.1,RMDAHC,3,RMDAIT,0)) LIST
 S RM1=$G(^RMPR(661.1,RMDAHC,3,RMDAIT,0)) G:RM1="" LIST
 S RMAV=$P(RM1,U,2),RMTOBA=$P(RM1,U,3),RMTOCO=$P(RM1,U,4)
 S $P(^RMPR(661.1,RMDAHC,0),U,9)=1
 S RMITEM=$P(^RMPR(661.1,RMDAHC,3,RMDAIT,0),U,1)
 S RMIT=RMHCPC_"-"_RMDAIT,RMHC=RMDAHC
 ;
 ;for HCPCS in 661.3
 K DIC("A") S DA(1)=RMLODA
 I '$D(^RMPR(661.3,RMLODA,1,"B",RMDAHC)) S X=RMDAHC D
 .S $P(^RMPR(661.3,RMLODA,1,0),U,2)="661.31"
 .K DD,DO S DIC="^RMPR(661.3,"_DA(1)_",1,",DIC(0)="L",DLAYGO=661.3
 .D FILE^DICN Q:Y=-1
 S RMHCDA=$O(^RMPR(661.3,RMLODA,1,"B",RMDAHC,0))
 G:'RMHCDA EXIT
 ;
 ;for item in 661.3
 S DA(2)=RMLODA,DA(1)=RMHCDA
 S DIC="^RMPR(661.3,"_DA(2)_",1,"_DA(1)_",1,",RDIC3=DIC
 I '$D(^RMPR(661.3,RMLODA,1,RMHCDA,1,"B",RMIT)) S X=RMIT D
 .S $P(^RMPR(661.3,RMLODA,1,RMHCDA,1,0),U,2)="661.312I"
 .K DD,DO S DLAYGO=661.3,DIC(0)="L" D FILE^DICN Q:Y=-1
 S (DA,RMITDA)=$O(^RMPR(661.3,RMLODA,1,RMHCDA,1,"B",RMIT,0))
 G:'RMITDA EXIT
 L +^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA):2
 I '$T W !!,"Record in use. Try again later..." H 3 G LOC
 S RM3=^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA,0)
 S RMQU=$P(RM3,U,2),RMCO=$P(RM3,U,3) S:'RMQU RMQU=0 S:'RMCO RMCO=0
 ;
UPD ;updates item in 661.3
 S (RMAVA,RMQUD,RMCOD)=0
 S DIE=RDIC3,DR="29R",DIE("NO^")="BACK" D ^DIE
 S DR="22R;23R~TOTAL COST OF QUANTITY;24;25R;26;27"
 S DR=DR_";28//^S X=RMITEM" D ^DIE
 S RM3A=^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA,0)
 S RMQUA=$P(RM3A,U,2),RMCOA=$P(RM3A,U,3),RMAVA=$P(RM3A,U,10),RMSO=$P(RM3A,U,9)
 I (RMSO="C")&(RMCOA<.0001) G LOC
 I RMSO="C" S:(RMAVA<1)&($G(RMQUA)) RMAVA=RMCOA/RMQUA
 I RMCO'=RMCOA S RMCOD=RMCOA-RMCO
 I RMQU'=RMQUA S RMQUD=RMQUA-RMQU
 I RMQUD,'RMCOD S RMCOA=RMAVA*RMQUA
 I 'RMQUD,RMCOD S:RMQUA>0 RMAVA=RMCOA/RMQUA
 I RMQUD,RMCOD S:RMQUA>0 RMAVA=RMCOA/RMQUA
 S $P(^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA,0),U,3)=RMCOA
 S $P(^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA,0),U,8)=RMITEM
 S $P(^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA,0),U,10)=$J(RMAVA,0,2)
 ;
STAT ;create an item statistics for this event.
 G:RMQU=RMQUA&(RMCO=RMCOA) LOC
 D BAL^RMPR5NU1
 L -^RMPR(661.3,RMLODA,1,RMHCDA,1,RMITDA)
 K DD,DO S DIC="^RMPR(661.2,",DIC(0)="L",X=DT,DLAYGO=661.2 D FILE^DICN
 G:$D(DTOUT)!(Y'>0) LOC S DA=+Y
 S RMMESF="Added/Updated by "_$E($P(^VA(200,DUZ,0),U,1),1,15)_": ("
 S RMMESF=RMMESF_$S(RMQUD>0:"+"_RMQUD_")",1:RMQUD_")")
 S ^RMPR(661.2,DA,0)=DT_"^^^"_RMDAHC_"^^^"_DUZ_"^"_RMQUD_"^"_RMIT_"^^^"_RMTOBA_"^"_RMMESF_"^"_$J(RMTOCO,0,2)_"^"_RMPR("STA")_"^"_RMLODA_"^"_$J(RMAVA,0,2) S DIK=DIC D IX1^DIK
 W !!,"** Item ",RMITEM," was ",RMMESF," @ Location ",RMLOC
 H 1 G LIST
 ;
EXIT ;MAIN EXIT POINT
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
