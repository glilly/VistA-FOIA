PRSEED2 ;HISC/JH/MD-LOG EMPLOYEE ATTENDANCE INTO TRACKING FILE ;2/11/92
 ;;4.0;PAID;;Sep 21, 1995
LOG S PRSESOR=$P(PRSEY,U,3),PRSETYP=$P(PRSEY,U,5),PRSEGOV=$P(PRSEY,U,7),PRSEACC=$P(PRSEY,U,8),PRSEHOUR=$P(PRSEY,U,9),PRSECAT=$P(PRSEY,U,10)
 S PRSEPOS=$P(PRSEY,U,12),PRSECEU=$P(PRSEY,U,13),PRSEDCOS=$P(PRSEY,U,19),PRSEICOS=$P(PRSEY,U,20),III=PRSEDA,DA(2)=III,DA(1)=PRSEDA1
EMP W !,"Enter EMPLOYEE NAME: " R X:DTIME G Q:'$T!(X="")!(X="U") S DIC(0)="EMZ"
 I $O(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,0)) S DIC="^PRSE(452.8,PRSEDA,3,PRSEDA1,1," D ^DIC G Q:$D(DUOUT)!$D(DTOUT)!(X=""),EMP:X="?" S DA=+Y,I=DA,II=I I I'=-1 S PRSEEMP=$P(Y,U,2) G CON
 S DIC="^VA(200," D ^DIC G Q:$D(DUOUT)!$D(DTOUT)!(X=""),EMP:X="?" S II=Y S:II'=-1 PRSEEMP=$P(Y,U) I II=-1 D STUD^PRSEED6
 E  S PRSESSN=$P($G(^VA(200,PRSEEMP,1)),U,9),PRDA=PRSEEMP,PRSESER=$P($G(^PRSP(454.1,+$$EN3^PRSEUTL3($G(PRDA)),0)),U) D ADD^PRSEED6 K II S II=DA
CON S PRSESER=$P($G(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,II,0)),U,3),PRSESSN=$P($G(^(0)),U,4)
 S DLAYGO=452,DIC="^PRSE(452,",DIC(0)="LN",X=PRSEEMP K DD,DO D FILE^DICN S DIE=DIC,DA=+Y K DIC
 S DR="1////"_PRSEPROG_";2////"_PRSEDAT_";3////"_PRSESOR_";4////"_PRSECAT_";5////"_PRSETYP_";6///"_PRSEGOV_";8////"_PRSEACC_";9////"_PRSEHOUR_";9.1////"_PRSECEU_"" D ^DIE
 S DR="10////"_PRSESSN_";12////"_PRSESER_";13////"_PRSEEDAT_";13.5////"_PRSELOC_";14////"_PRSEPOS_";18////"_PRSEDCOS_";19////"_PRSEICOS_"" D ^DIE
 I $P($G(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,II,1,0)),U,3)'="" D  ;MOVE MI REVIEW GROUP TO TRACKING FILE
 .  S:'$D(^PRSE(452,DA,2,0)) ^(0)="^452.044P^^" S DA(2)=$P($G(^PRSE(452,DA,2,0)),U,3)+1,DA(3)=$P($G(^(0)),U,4)+1,PRSESWP=0 F J=0:0 S PRSESWP=$O(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,II,1,PRSESWP)) Q:PRSESWP'>0  D
 ..  S ^PRSE(452,DA,2,DA(2),0)=$P($G(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,II,1,PRSESWP,0)),U)_U_PRSEEMP
 ..  S $P(^PRSE(452,DA,2,0),U,3)=DA(2),$P(^(0),U,4)=DA(3),DA(2)=DA(2)+1,DA(3)=DA(3)+1
 ..  Q
 I $P($G(^PRSE(452.8,PRSEDA,2,0)),U,3)'="" D  ;MOVE SERVICE REASONS FOR CLASS TO TRACKING FILE
 .  S:'$D(^PRSE(452,DA,1,0)) ^(0)="^452.033PA^^" S DA(2)=$P($G(^PRSE(452,DA,1,0)),U,3)+1,DA(3)=$P($G(^(0)),U,4)+1,PRSESWP=0 F J=0:0 S PRSESWP=$O(^PRSE(452.8,PRSEDA,2,PRSESWP)) Q:PRSESWP'>0  D
 ..  S ^PRSE(452,DA,1,DA(2),0)=$G(^PRSE(452.8,PRSEDA,2,PRSESWP,0))
 ..  S $P(^PRSE(452,DA,1,0),U,3)=DA(2),$P(^(0),U,4)=DA(3),DA(2)=DA(2)+1,DA(3)=DA(3)+1
 ..  Q
 .  S DIK="^PRSE(452,DA,1,",DIK(1)=".01" D EN1^DIK Q
 S DA=II,DA(1)=PRSEDA1,DA(2)=PRSEDA,DIK="^PRSE(452.8,DA(2),3,DA(1),1," D ^DIK
 I $P($G(^PRSE(452.8,PRSEDA,3,PRSEDA1,1,0)),U,4)>0 D QQ G EMP
 ;S X=$O(^PRSE(452.8,PRSEDA,3,"C",9999999-PRSEDAT,0)),XX=$G(^PRSE(452.8,PRSEDA,3,X,0)),$P(XX,U)="",$P(XX,U,3)="",^PRSE(452.8,II,3,X,0)=XX
Q K %TG,%W,%Y1,III,D,DA,PRSEACC,PRSECAT,PRSESW,PRSECOM,PRSECEU,PRSEDA1,PRSEDAA,PRSEEND,PRSEGOV,PRSEHOUR,PRSEPOS,PRSERES,PRSESER,PRSESOR,PRSESSN,PRSETYP,DIC,DIE,DIK,DR,DTOUT,DUOUT,X,Y
QQ K J,PRSESSN,PRSEEMP,PRSESER,PRSESWP Q
