GMPLHSPL ; SLC/MKB -- Problem List HS Component Driver (for export) ;11/23/93  10:36
 ;;2.0;Problem List;;Aug 25, 1994
GMTSPLST ; SLC/DJP -- Problem List HS Component Driver ;5/27/93  15:35
 ;;2.5;Health Summary;;
ACTIVE ;
 S STATUS="A" D MAIN,KILL Q
INACT S STATUS="I" D MAIN,KILL Q
ALL S STATUS="ALL" D MAIN,KILL Q
MAIN ;Driver
 D CKP^GMTSUP Q:$D(GMTSQIT)  I 'GMTSNPG D BREAK^GMTSUP
 D ^GMPLHS
 I '$D(^TMP("GMPLHS",$J)) D NOPROBS Q
 W ! D SUBHDR
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D WRT
 Q
 ;
KILL D KILL^GMPLHS
 Q
 ;
NOPROBS ;Indicates problems not on file for patient
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "No data available.",!
 Q
SUBHDR ; Subheader for Problem List Component
 N NUM S NUM=GMPCOUNT S:GMPTOTAL>GMPCOUNT NUM=NUM_" of "_GMPTOTAL
 S NUM=NUM_$S(STATUS="A":" Active",STATUS="I":" Inactive",1:"")_" Problems"
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 W ?56,NUM,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 W ?6,"PROBLEM",?46,"LAST MOD",?56,"SERVICE/PROVIDER",!
 Q
 ;
WRT ; Writes Problem List Component
 S GMPI=0 F GMPI=0:0  S GMPI=$O(^TMP("GMPLHS",$J,STATUS,GMPI)) Q:GMPI'>0  D LINE
 Q
 ;
LINE ;Prints individual line
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 N PROBLEM,TEXT,I,PROB,MAX
 S PROBLEM=$G(^TMP("GMPLHS",$J,STATUS,GMPI,0))
 S PROB=$P(PROBLEM,U,2),MAX=38 D WRAP^GMPLX(PROB,MAX,.TEXT)
 I STATUS="ALL" W ?3,$P(PROBLEM,"^",1)
 W ?6,TEXT(1),?46,$P(PROBLEM,"^",3),?56,$P(PROBLEM,"^",4),!
 I TEXT>1 F I=2:1:TEXT W ?8,TEXT(I),!
 Q
