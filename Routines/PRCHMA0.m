PRCHMA0 ;WISC/AKS-Amendments to purchase orders and requisitions ;3/5/97  15:05
 ;;5.1;IFCAP;**97**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;Ship to edit
 N DR,DIE,DA,DIE,PRCH0
 S PRCH0=$G(^PRC(443.6,PRCHPO,0))
 S DR=$S($P(PRCH0,U,2)'=4:5.4,1:5.3)
 S DIE="^PRC(443.6,",DA=PRCHPO D ^DIE
 S DELIVER=1 W !
 Q
EN2 ;Line Item add
 N J,%,%A,%B,DIE,DA,DR,D0,D1,PRCHI,PRCHLC,PRCHSTN,NODE0,PRCHI1,PRCHPONO,BFLAG
 N X,Y
 D MV,MVDIS^PRCHMA3 S NODE0=^PRC(443.6,PRCHPO,0),PRCHLC=$P(NODE0,U,14)
 S J=PRCHLC+1,BFLAG=0
 S (I,N,M)=0 F  S N=$O(^PRC(443.6,PRCHPO,2,N)) Q:'N  S I=$P(^(N,0),U),M=N
 S PRCHI=(I+1)_"^"_J S:$P(^PRC(443.6,PRCHPO,2,0),U,3)<M $P(^(0),U,3)=M
 S %=2,%A="     ADD LINE ITEM "_+PRCHI,%B="" D ^PRCFYN
 I %'=1 W ?40,"<NOTHING ADDED>" Q
 K DD,DO S DA(1)=PRCHPO,X=+PRCHI,DIC="^PRC(443.6,"_DA(1)_",2,"
 S DIC(0)="L" D FILE^DICN K DIC Q:+Y'>0
 S PRCHI1=+PRCHI,$P(PRCHI,U)=+Y
 ;S $P(^PRC(443.6,PRCHPO,2,0),U,3)=$P(PRCHI,U),$P(^(0),U,4)=+PRCHI
 S $P(NODE0,U,14)=J
 I $D(^PRC(443.6,PRCHPO,3)) D
 .S N=0 F  S N=$O(^PRC(443.6,PRCHPO,3,N)) Q:'N  S $P(^PRC(443.6,PRCHPO,3,N,0),U,6)=$P(^PRC(443.6,PRCHPO,3,N,0),U,6)+1
 S:$P(NODE0,U,18)]"" $P(NODE0,U,18)=J
 S ^PRC(443.6,PRCHPO,0)=NODE0
 S PRCHEDI=$G(^PRC(440,$P(^PRC(443.6,PRCHPO,1),U),3)) S:PRCHEDI]"" PRCHEDI=$P(PRCHEDI,U,2)
 S PRCHSTN=$P($P(NODE0,U),"-"),PRCHPONO=$P(NODE0,U)
 S DIE="^PRC(443.6,",DA=PRCHPO
 S DR=$S($D(PRCHREQ):"[PRCHRQITM]",1:"[PRCHLINE]"),DIE("NO^")="BACK"
 I $G(PRCHAUTH)=1 S DR="[PRCH PURCHASE CARD AMEND]"
 I $G(PRCHAUTH)=2 S DR="[PRCH DELIVERY ORDER AMEND]"
 S DIE("NO^")="OUTOK"
 D ^DIE K DIE
 I $D(^PRC(443.6,PRCHPO,2,+PRCHI,0))  D
 .S:'$D(^(2)) ^(2)=0
 .I $P(^PRC(443.6,PRCHPO,2,+PRCHI,0),U,2)=""  D
 ..W !,"Line item is being deleted because of incomplete information.",!
 ..S DA=+PRCHI,DA(1)=PRCHPO,DIK="^PRC(443.6,"_DA(1)_",2,",BFLAG=1
 ..D ^DIK
 I BFLAG=0  D
 .S DELIVER=1 W !
 .D ERCHK^PRCHMA1 K ERROR
 .S DA(1)=PRCHPO,DA=PRCHI1 D EN12^PRCHAMXG
 Q
EN3 ;Line Item delete
 N PRCHI,I442,I2Z,DIC,PRCHAREC,DIE,DR,DELIVER,%,%A,%B,PONUM,DIK
 N PONOEXT,PODS,IENDS
 D MV,MVDIS^PRCHMA3 S DA(1)=PRCHPO,DIC="^PRC(443.6,"_DA(1)_",2,",DIC(0)="AEQZ" D ^DIC
 I Y<0 W !?5,"<NOTHING DELETED>" Q
 S PRCHI=Y
 I $P($G(^PRC(443.6,PRCHPO,2,+PRCHI,2)),U,8)>0 D  Q
 .W !?5,"CANNOT DELETE ITEM ",$P(PRCHI,U,2),", IT HAS ALREADY BEEN RECEIVED!",$C(7)
 S %="",%A="   SURE YOU WANT TO DELETE LINE ITEM "_$P(PRCHI,U,2),%B=""
 D ^PRCFYN I %'=1 W ?50,"<NOTHING DELETED>" Q
 S I442=$G(^PRC(442,PRCHPO,2,+PRCHI,0)) I I442="" D  Q
 .S PONUM=$P(^PRC(443.6,PRCHPO,2,+PRCHI,0),U)
 .K ^PRC(443.6,PRCHPO,2,"B",PONUM),^PRC(443.6,PRCHPO,2,"C",PONUM)
 .I $P($G(^PRC(443.6,PRCHPO,2,+PRCHI,0)),U,5)]"" K ^PRC(443.6,PRCHPO,2,"AE",$P(^PRC(443.6,PRCHPO,2,+PRCHI,0),U,5))
 .;
 .;If item was added during amendment process then kill Item/Del. Sch.
 .S PONOEXT=$P(^PRC(443.6,PRCHPO,0),U),PODS=0
 .F  S PODS=$O(^PRC(441.7,"AG",PONOEXT,+PRCHI,PODS)) Q:'PODS  I $D(PODS) S DA=PODS,DIK="^PRC(441.7," D ^DIK
 .;
 .K ^PRC(443.6,PRCHPO,2,+PRCHI)
 .S I2Z=^PRC(443.6,PRCHPO,2,0),$P(I2Z,U,4)=$P(I2Z,U,4)-1
 .S ^PRC(443.6,PRCHPO,2,0)=I2Z
 .S N=0 F I=1:1 S N=$O(^PRC(443.6,PRCHPO,2,N)) Q:'N  D
 ..S $P(^PRC(443.6,PRCHPO,2,N,0),U)=I
 .K ^PRC(443.6,PRCHPO,2,"B"),^PRC(443.6,PRCHPO,2,"C")
 .S DA(1)=PRCHPO,DIK(1)=".01^B^C"
 .S DIK="^PRC(443.6,"_DA(1)_",2," D ENALL^DIK K N,I,DIK
 .S J=$P(^PRC(443.6,PRCHPO,0),U,14)-1
 .S $P(^PRC(443.6,PRCHPO,0),U,14)=J,$P(^(0),U,18)=J
 .I $D(^PRC(443.6,PRCHPO,3)) D
 ..S N=0 F  S N=$O(^PRC(443.6,PRCHPO,3,N)) Q:'N  S $P(^PRC(443.6,PRCHPO,3,N,0),U,6)=$P(^PRC(443.6,PRCHPO,3,N,0),U,6)-1
 I $D(^PRC(443.6,PRCHPO,2,+PRCHI,2)),$P(^(2),U,6)>0 S PRCHAREC=1
 ;
 ;If item already exists then either mark or delete the Del. Sch. 
 I I442]"" D
 .S PONOEXT=$P(^PRC(443.6,PRCHPO,0),U)
 .S POSC=0
 .F  S POSC=$O(^PRC(441.7,"AG",PONOEXT,+PRCHI,POSC)) Q:'POSC  D
 . . S IENDS=$G(^PRC(441.7,POSC,0))
 . . Q:IENDS=""
 . . S PERM=+$P(IENDS,U,7)
 . . I PERM>0 S DR="5////D",DIE="^PRC(441.7,",DA=POSC D ^DIE Q
 . . I PERM'>0 K PRCHNORE S DIK="^PRC(441.7,",DA=POSC D ^DIK  S PRCHNORE=1 Q
 ;
 S DR="5///0;2////0"
 S DA(1)=PRCHPO,DA=+PRCHI
 S DIE="^PRC(443.6,"_DA(1)_",2,"
 D ^DIE K DIE
 S DELIVER=1 W !
 Q
MV ;Move line item information from 442
 Q:$D(^PRC(443.6,PRCHPO,2,0))  Q:$P($G(^(0)),U,4)>0  D WAIT^DICD
 N %X,%Y,N,M,PRCHPO1,OK,PRCHNORE
 S %X="^PRC(442,PRCHPO,2,",%Y="^PRC(443.6,PRCHPO,2," D %XY^%RCR
 S $P(^PRC(443.6,PRCHPO,2,0),U,2)=$P(^DD(443.6,40,0),U,2) K ^("C")
 S PRCHPO1=$P(^PRC(442,PRCHPO,0),"^")
 Q:'$D(^PRC(442.8,"B",PRCHPO1))  Q:$D(^PRC(441.7,"B",PRCHPO1))
 S N=0,M=+$P(^PRC(441.7,0),"^",3)
 F  S N=$O(^PRC(442.8,"B",PRCHPO1,N)) Q:'N  D
MV1 .S M=M+1,OK=$G(^PRC(441.7,M,0)) I OK'="" G MV1
 .S ^PRC(441.7,M,0)=^PRC(442.8,N,0)
 .S $P(^PRC(441.7,M,0),U,7)=N
 .S $P(^PRC(441.7,0),"^",3)=M
 .S $P(^PRC(441.7,0),"^",4)=$P(^(0),"^",4)+1
 .S DIK="^PRC(441.7,",DA=M D IX^DIK K DIK,DA
 .Q
 Q
ONLY ;Make sure only 'Cancel' amendment
 S PRCHON=0
 I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,0)),U,4)>2 D ERR Q
 I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,0)),U,4)=2 D  Q
 .I $P($G(^PRC(443.6,PRCHPO,6,PRCHAM,3,2,0)),U,2)'=34 D ERR Q
 .S PRCHON=1
 S PRCHON=1
 QUIT
ERR ;Error
 ;W !?5,"You can only "_$S($D(PRCHREQ):$P(^PRCD(442.2,15,0),U,2),1:$P(^PRCD(442.2,5,0),U,2))_" if this is the ONLY change you",!?5,"are making to the "_$S($D(PRCHREQ):"requisition.",1:"purchase order.")
 W !?5,"To "_$S($D(PRCHREQ):$P(^PRCD(442.2,15,0),U,2),1:$P(^PRCD(442.2,5,0),U,2))_" it must be the ONLY change you",!?5,"are making on the amendment."
 QUIT
 ;
SUPBOC(QUIETLY) ;compute pre-implied BOC, moved from template PRCHRQITEM, PRCHLINE into this routine and also called in BOC input transform
 N PRCHIDA,SPFCP,PRCHBOCC,ACCT
 S:$G(QUIETLY)=-1 X=$P($G(^PRC(443.6,DA(1),2,DA,0)),U,4)
 Q:'$D(X)
 S PRCHIDA=+$P($G(^PRC(443.6,DA(1),2,DA,0)),U,5),SPFCP=+$P(^PRC(443.6,DA(1),0),U,19)
 I SPFCP=2 D
 . S PRCHN("SFC")=SPFCP,ACCT=$$ACCT^PRCPUX1($E($$NSN^PRCPUX1(PRCHIDA),1,4))
 . D  ;:$D(ACCT)
 . . S PRCHBOCC=$P($G(^PRCD(420.2,$S(ACCT=1:2697,ACCT=2:2698,ACCT=3:2699,ACCT=6:2699,ACCT=8:2696,1:2699),0)),U)
 . . I PRCHBOCC S $P(^PRC(443.6,DA(1),2,DA,0),U,4)=PRCHBOCC D
 . . . I PRCHBOCC'=X,PRCHBOCC W:'$G(QUIETLY) !,?5,"BOC must be ",PRCHBOCC,!,?5,"For a supply fund order, a BOC ",X," is invalid.",! S X=PRCHBOCC
 Q X
 ;
