RTXB8 ; COMPILED XREF FOR FILE #195.9003 ; 10/15/04
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^RTV(195.9,DA(1),"S",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^RTV(195.9,DA(1),"S",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^RTV(195.9,"S",$E(X,1,30),DA(1),DA)=""
 G:'$D(DIKLM) A Q:$D(DISET)
END Q
