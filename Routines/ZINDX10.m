%INDX10 ;ISC/GRK - assemble DD executable code ;1/9/95  12:16
 ;;7.3;TOOLKIT;;Apr 25, 1995
ASKP K DIC S DIC="^DIC(9.4,",DIC(0)="AEQMZ" D ^DIC S DA=+Y Q
START W !,"The package Data Dictionaries are being processed.",!
 F J=0:0 S J=$O(^DIC(9.4,DA,4,J)) Q:J'>0  I $D(^(J,0)) S INDFN=+^(0),INDRN="|dd"_INDFN,(INDF,INDL)=0 D INSERT
 D ^%INDX11,REMCOMP:'INP(9) K A,B,C,C9,G,H,INDD,INDEL,INDF,INDFN,INDID,INDL,INDN,INDRN,INDSB,INDX,INDXN,INDXRF,DA,DIC,J,INDLC,INDC
 Q
INSERT ;Find executable code in this DD
 I '$D(^DD(INDFN)) W !,"File # ",INDFN," is missing !",*7 Q
 S ^UTILITY($J,INDRN)="",NRO=NRO+1 W !,INDFN," ",$O(^DD(INDFN,0,"NM",0))
 S INDLC=0,INDC=INDRN_" ;DD of the "_$O(^DD(INDFN,0,"NM",0))_$S(INDL:" sub-",1:" ")_"file"_$S(INDL:" of the "_$O(^DD(INDFN(1),0,"NM",0))_" (#"_INDFN(1)_") file.",1:"."),INDX="" D ADD
ID S INDID=-1 F G=0:0 S INDID=$O(^DD(INDFN,0,"ID",INDID)) Q:INDID=""  I $D(^(INDID))#2 S INDC="ID"_INDID_" ; IDENTIFIER CODE FOR "_INDID S INDX=$S(^(INDID)]"":^(INDID),1:"Q") D ADD
W I $D(^DD(INDFN,0,"W"))#2 S INDX=^("W"),INDC="W ; 'W' code ??" D ADD
FLD S INDF=$O(^DD(INDFN,INDF)) I INDF>0 D STRIP W "." G FLD
 S ^UTILITY($J,1,INDRN,0,0)=INDLC Q
STRIP ;
 S A=$P(^DD(INDFN,INDF,0),"^",2) I A D PUSH,INSERT,POP Q
 I A'["W",A'["S" S INDX=$P(^(0),"^",5,99),INDC=INDF_" ; "_$P(^(0),"^",1) D ADD
 I $D(^DD(INDFN,INDF,2))#2 S INDC=INDF_"OT ; OUTPUT TRANSFORM CODE",INDX=^(2) D ADD
 I $D(^DD(INDFN,INDF,4))#2 S INDC=INDF_"HELP ; EXECUTABLE HELP CODE",INDX=^(4) D ADD
 I $D(^DD(INDFN,INDF,12)) S INDC=INDF_"SCR ; "_$E(^(12),1,220) S INDX=$S($D(^(12.1))#2:^(12.1),1:"Q") D ADD
 I $D(^DD(INDFN,INDF,7.5))#2 S INDC=INDF_"TPL ; TRANSFORM DONE PRIOR TO THE DIC LOOK-UP",INDX=^(7.5) D ADD
 I $D(^DD(INDFN,INDF,"AX"))#2 S INDC=INDF_"AX ; EXECUTABLE AUDIT CHECK CODE",INDX=^("AX") D ADD
 F INDEL=9.2:.1:9.9 I $D(^DD(INDFN,INDF,INDEL))#2 S INDC=INDF_"OF"_INDEL_" ; OVERFLOW CODE",INDX=^(INDEL) D ADD
 S INDEL="" F  S INDEL=$O(^DD(INDFN,INDF,"DEL",INDEL)) Q:INDEL=""  I $D(^(INDEL,0))#2 S INDC=INDF_"DEL"_INDEL_" ; DELETE PROTECTION CODE",INDX=^(0) D ADD
 S INDEL="" F G=0:0 S INDEL=$O(^DD(INDFN,INDF,"LAYGO",INDEL)) Q:INDEL=""  I $D(^(INDEL,0))#2 S INDC=INDF_"LAYGO"_INDEL_" ; LAYGO CHECK CODE",INDX=^(0) D ADD
 F INDXRF=0:0 S INDXRF=$O(^DD(INDFN,INDF,1,INDXRF)) Q:INDXRF'>0  S C=$P(^(INDXRF,0),"^",2) F G=0:0 S G=$O(^DD(INDFN,INDF,1,INDXRF,G)) Q:G'>0  D XREFS
 Q
XREFS Q:('$D(^(G))#2)!(G=3)  ;Node 3 is don't delete comment.
 S INDC=INDF_"XRF"_INDXRF_$S(G=1:"S",G=2:"K",1:"n"_G)_" ; "_$S(G<2:"SET",G<3:"KILL",1:"OVERFLOW")_" LOGIC FOR '"_$S(C]"":C,1:INDXRF)_"' XREF",INDX=^(G) D ADD
 Q
ADD ;Put code in UTILITY for processing
 S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=INDC I INDX]"" S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=" "_INDX
 Q
PUSH S INDL=INDL+1 F A="INDFN","INDF","INDLC","INDRN" S @(A_"(INDL)")=@A
 S INDFN=+$P(^DD(INDFN,INDF,0),"^",2),INDRN="|dd"_INDFN,(INDLC,INDF)=0
 Q
POP F A="INDFN","INDF","INDLC","INDRN" S @A=@(A_"(INDL)")
 S INDL=INDL-1 Q
REMCOMP ;Remove compiled template routines from selected list
 S %="dd"
 F J=1:1 S %=$O(^UTILITY($J,%)) Q:%'?1"|dd".NP  S INDFN=+$E(%,4,999) I '$D(^DD(INDFN,0,"UP")) F F="^DIE(","^DIPT(" S F1=F_"""F"_INDFN_""",",%1="" F J=0:0 S %1=$O(@(F1_"%1)")) Q:%1=""  F %2=0:0 S %2=$O(@(F1_"%1,%2)")) Q:%2'>0  D P
 Q
P I $D(@(F_"%2,0)")) S R=$E($S($D(^("ROU")):^("ROU"),$D(^("ROUOLD")):^("ROUOLD"),1:""),2,999) Q:R=""
 I $D(^UTILITY($J,R)) K ^(R)
 S RN=R F J=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN=""!(RN'?@("1"""_R_"""1N.N"))  K ^(RN)
 Q
