NURQUTL2 ;HIRMFO/YH-SURVEY STATISTICS PART 2 ;3/11/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
LIKRTLAB ;print Likert labels and gradient
 S NLFTLBL=$G(^TMP("NURQ3",$J,748.26,NURNUM_","_NURQSVN_",",1)),NRGTLBL=$G(^(2)),NLDIRCT=$G(^(3)) S NLDIRCT=$S(NLDIRCT="ASCENDING":"a",NLDIRCT="DECENDING":"d",1:"") S:NLDIRCT="" NLDIRCT="a" ;default
 S:NLDIRCT="a" NLDIRCT="F Y=1:1:NGRDIENT" S:NLDIRCT="d" NLDIRCT="F Y=NGRDIENT:-1:1" S NLDIRCT=NLDIRCT_" S X=X_Y_""   "",NANS(Y)="""""
 S:NLFTLBL="" NLFTLBL="Poor" S:NRGTLBL="" NRGTLBL="Excellent" ;default
 S X="("_NLFTLBL_")   " X NLDIRCT
 S X=X_"("_NRGTLBL_")"
 W ?(IOM-($L(X))\2),X,!
 K NLDIRCT,X,Y Q
 ;
WP ;WP responses
 F NPART1=0:0 S NPART1=$O(^TMP($J,"QAPZ",NPART1)) Q:NPART1=""!($D(DIRUT))!$G(NUROUT)  K NARRAY D GETS^DIQ(748.31,NURQUES1_","_NPART1_",","2","","NARRAY") W:$O(NARRAY(748.31,NURQUES1_","_NPART1_",",2,0))]"" ?3,"----------",! DO
 .F NQZ=0:0 S NQZ=$O(NARRAY(748.31,NURQUES1_","_NPART1_",",2,NQZ)) Q:NQZ=""!$G(NUROUT)  S NQY=$G(NARRAY(748.31,NURQUES1_","_NPART1_",",2,NQZ)) D:($Y>(IOSL-7)) HDR^NURQRPT0 Q:$G(NUROUT)  W ?3,NQY,!
 W ?3,"----------" Q
