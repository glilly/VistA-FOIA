RACTWR3 ; ;09/24/03
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V" S RAXREF="ARES",RARAD=12,RASET="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RARAD,RASET
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V" S RAXREF="ASTF",RARAD=15,RASET="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RARAD,RASEC
 S X=DG(DQ),DIC=DIE
 S:"Vv"'[$E(X) ^RARPT("ASTAT",$E(X,1,30),DA)=""
