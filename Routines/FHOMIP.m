FHOMIP ;Hines OIFO/RTK OUTPATIENT ISOLATION/PRECAUTION EDIT  ;9/22/03  11:15
 ;;5.5;DIETETICS;**2**;Jan 28, 2005
 ;
 D ^FHOMDPA I FHDFN="" Q
 I '$D(^FHPT(FHDFN,0)) W !!,"UNKNOWN SELECTION !" Q
 S FHIPBEF=$P($G(^FHPT(FHDFN,0)),U,5)
 S DIE="^FHPT(",DA=FHDFN,DR="19" D ^DIE
 S FHIP=$P($G(^FHPT(FHDFN,0)),U,5) I FHIP=FHIPBEF Q
 D UPD100
 I FHIP'="" S FHIP=$P($G(^FH(119.4,FHIP,0)),U,1)
 I FHIP="" S FHIP="Cancelled"
 S FHACT="O",FHOPTY="I",(FHDIET,FHLOC,FHMEAL)="" D SETORX^FHOMRO2
 Q
HL7SET ;
 ; Use this to set isolations/precautions received from CPRS via HL7 msg
 ; segments.  Just set the necessary variables.
 S FHOBR=$P(FHX,"|",13),FHIP=$P(FHOBR,"^",4)
 S FHORN=$S($G(FHORN)="":"",1:FHORN)
 I '$D(^FH(119.4,FHIP,0)) S TXT="Invalid I/P" D GETOR^FHWOR,ERR^FHOMWOR Q
 S DIE="^FHPT(",DA=FHDFN,DR="19////^S X=FHIP;20////^S X=FHORN" D ^DIE
 S FILL="I;"_FHIP
 D SEND^FHWOR
 S FHIP=$P($G(^FH(119.4,FHIP,0)),U,1)
 S FHACT="O",FHOPTY="I",(FHDIET,FHLOC,FHMEAL)="" D SETORX^FHOMRO2
 Q
CAN ;
 S DIE="^FHPT(",DA=FHDFN,DR="19////@;20////FHORN" D ^DIE
 S FHACT="O",FHOPTY="I",FHIP="Cancelled",(FHDIET,FHLOC,FHMEAL)=""
 D SETORX^FHOMRO2
 Q
UPD100 ;Backdoor message to update file #100 with a new IP order
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 Q:'DFN  Q:FHIP=""  K MSG D SITE^FH
 S FHOLOC=$O(^FH(119.6,"AL",0)),FHOLOCNM=$P($G(^SC(FHOLOC,0)),U,1)
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 S MSG(3)="PV1||O|"_FHOLOC_"^"_FHOLOCNM_"||||||||||||||||"
 D NOW^%DTC S FHNOW=%,FHODT=$E(%,1,7),FHODT=$$FMTHL7^XLFDT(FHODT)
 S FILL="I;"_FHNOW,FHIPEXT=$P($G(^FH(119.4,FHIP,0)),U,1)
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_FHODT_"^"_FHODT_"||||||||"_FHNOW
 S MSG(5)="OBR||||||||||||^^^"_FHIP_"^"_FHIPEXT
 D EVSEND^FHWOR
 Q
