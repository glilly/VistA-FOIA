PSGXR310 ; COMPILED XREF FOR FILE #53.1114 ; 08/12/11
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^PS(53.1,DA(1),14,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PS(53.1,DA(1),14,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PS(53.1,DA(1),14,"B",$E(X,1,30),DA)=""
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^PSGXR311
