FHOMSC1 ;Hines OIFO/RTK SPECIAL MEALS CANCEL MEAL  ;4/15/03  8:55
 ;;5.5;DIETETICS;**2**;Jan 28, 2005
 ;
 S FHORN="",STDT=DT,FHS="ADP" D LIST^FHOMSS1 W !
 I NUM=0 W !,"NO SPECIAL MEALS TO CANCEL" Q
 K DIR S DIR("A")="Cancel Which Meal(s)?",DIR(0)="LO^1:"_NUM D ^DIR
 Q:$D(DIRUT)  S FHCLST=Y
 W ! K DIR S DIR("A")="Are you sure? ",DIR(0)="YA",DIR("B")="Y" D ^DIR
 Q:$D(DIRUT)  I Y=0 D END Q
 F A=1:1:NUM S FHC=$P(FHCLST,",",A) Q:FHC=""  S FHCDT=FHLIST(FHC) D CAN,CNSM100^FHOMRC2
 W "  ... done" Q
 Q
CAN ;
 S FHSTAT="C"
 S DA=$P(FHCDT,U,2),FHDA=DA,DA(1)=$P(FHCDT,U,1),FHDFN=DA(1)
 I FHORN="" S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,0)),U,12)
 I '$D(^FHPT(DA(1),"SM",DA,0)) Q
 S DIE="^FHPT("_DA(1)_",""SM"","
 S DR="1////^S X=FHSTAT;14////^S X=FHORN;11.5////^S X=FHSTAT" D ^DIE
 S FHZN=$G(^FHPT(FHDFN,"SM",FHDA,0))
 S FHACT="C",FHOPTY="S",FHOPDT=FHDA D SETSM^FHOMRO2
 Q
END ;
 K FHS,FHSTAT Q
