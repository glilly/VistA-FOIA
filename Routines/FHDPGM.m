FHDPGM ;Hines OIFO/RTK/FAI PRINT GUEST MEALS LIST  ;10/20/04  15:15
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
EN S FHSORT="A"
LIST ;
 S EX="",NUM=0 D HDR
 F FHGMDT=STDT:0 S FHGMDT=$O(^FHPT(FHDFN,"GM",FHGMDT)) Q:FHGMDT'>0!(FHGMDT<STDT)!(FHGMDT>ENDT)!(EX=U)  D
 .S NUM=NUM+1,FHNODE=$G(^FHPT(FHDFN,"GM",FHGMDT,0))
 .S FHCL=$P(FHNODE,U,2),FHML=$P(FHNODE,U,3),FHCH=$P(FHNODE,U,4)
 .S FHLPT=$P($G(FHNODE),U,5)
 .S:FHLPT'="" FHLOC=$E($P($G(^FH(119.6,FHLPT,0)),U,1),1,10)
 .S FHCL=$S(FHCL="E":" EMPLOYEE",FHCL="G":"GRATUITOUS",FHCL="O":"   OOD",FHCL="P":"   PAID",1:"VOLUNTEER")
 .D PATNAME^FHOMUTL
 .S FHD=$$FMTE^XLFDT(FHGMDT,"P") W !,?2,$E(FHD,1,12)
 .W ?16,$G(FHLOC),?30,FHML,?36,FHCL,?50,FHCH
 .I $Y>(IOSL-4) D PG I EX=U Q
 .Q
 I NUM=0 W !!,"NO GUEST MEALS FOR THIS DATE RANGE" Q
 Q
END ;
 K FHGMDT,FHML,FHCL,FHCH
 Q
PG ;
 Q:$O(^FHPT(FHDFN,"GM",FHGMDT))'>0
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;
 W:$Y @IOF
 W !?15,"G U E S T   M E A L S"
 W !!?2,"Date",?16,"Location",?30,"Meal"
 W ?36,"Class",?50,"Charge"
 W !?2,"============",?16,"=========="
 W ?30,"====",?36,"=========",?50,"======"
 Q
