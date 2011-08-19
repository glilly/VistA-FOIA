IBDFU2B ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(copying blocks - continued from IBDFU2) ; 08-JAN-1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38**;APR 24, 1997
 ;
CPYSLCTN(SLCTN,GRP,NEWGRP,LIST,NEWLIST,FROMFILE,TOFILE) ;
 Q:('$G(SLCTN))!('$G(GRP))!('$G(NEWGRP))!('$G(LIST))!('$G(NEWLIST))!('$G(FROMFILE))!('$G(TOFILE))
 Q:(FROMFILE'=357.3)&(FROMFILE'=358.3)
 Q:(TOFILE'=357.3)&(TOFILE'=358.3)
 N NODE,NAME,NEWSLCTN,SC,CNT,I
 S NEWSLCTN=""
 S NODE=$G(^IBE(FROMFILE,SLCTN,0)) Q:NODE=""
 I ($P(NODE,"^",3)'=LIST)!($P(NODE,"^",4)'=GRP) K DA S DA=SLCTN,DIK="^IBE("_FROMFILE_"," D IX^DIK K DIK Q
 S NAME=$P(NODE,"^",1),$P(NODE,"^",3)=NEWLIST,$P(NODE,"^",4)=NEWGRP
 Q:NAME=""
 K DIC,DD,DINUM,DO S DIC="^IBE("_TOFILE_",",X=NAME,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S NEWSLCTN=$S(+Y<0:"",1:+Y)
 Q:'NEWSLCTN
 S ^IBE(TOFILE,NEWSLCTN,0)=NODE
 ;
 ; -- now copy the subcolumn value multiple
 ; -- When copying selections but not same list definition (i.e.
 ;    when copying selections from one list to another)
 ;    find old sub columns, in 357.2 for list
 ;    find and match to new sub columns in 357.2 for new list
 ;
 S (SC,CNT,LAST)=0
 ;S NODE=$G(^IBE(FROMFILE,SLCTN,1,0)) I NODE'=""  S ^IBE(TOFILE,NEWSLCTN,1,0)=NODE 
 F  S SC=$O(^IBE(FROMFILE,SLCTN,1,SC)) Q:'SC  S NODE=$G(^IBE(FROMFILE,SLCTN,1,SC,0)) D:$D(IBDFCPYF)  S:NODE'="" ^IBE(TOFILE,NEWSLCTN,1,+NODE,0)=NODE,CNT=CNT+1,LAST=+NODE
 .N K,IBDFI
 .S K=0,IBDFI=+NODE
 .Q:$G(IBDFNEW(IBDFI))=$G(IBDFOLD(IBDFI))
 .F  S K=$O(IBDFNEW(K)) Q:K=""  I IBDFNEW(K)=$G(IBDFOLD(+IBDFI)) S $P(NODE,"^",1)=K,NODE=NODE Q
 .Q
 S ^IBE(TOFILE,NEWSLCTN,1,0)=$S(TOFILE=357.3:"^357.31IA^",1:"^358.31IA^")_$G(LAST)_"^"_CNT
 ; -- now copy 2 node if it exists
 S NODE=$G(^IBE(FROMFILE,SLCTN,2))
 I NODE'="" S ^IBE(TOFILE,NEWSLCTN,2)=NODE
 ;
 ; -- now copy 3 node if it exists (CPT MODIFIERS)
 ;
 I $D(^IBE(FROMFILE,SLCTN,3)) D
 . S ^IBE(TOFILE,NEWSLCTN,3,0)=^IBE(FROMFILE,SLCTN,3,0)
 . F I=0:0 S I=$O(^IBE(FROMFILE,SLCTN,3,I)) Q:'I  D
 .. S:$D(^IBE(FROMFILE,SLCTN,3,I,0)) ^IBE(TOFILE,NEWSLCTN,3,I,0)=^(0)
 ;
 ; -- now re-index file entry
 ;
 K DIK,DA S DIK="^IBE("_TOFILE_",",DA=NEWSLCTN
 D IX1^DIK
 K DIK,DA
 Q
 ;
GETMA(MA,FROMFILE,TOFILE) ;copys marking area=ma from file=FROMFILE to file=TOFILE if it does not already exist
 ;returns the ien of the marking area existing in TOFILE
 Q:($G(FROMFILE)'=357.91)&($G(FROMFILE)'=358.91) ""
 Q:($G(TOFILE)'=357.91)&($G(TOFILE)'=358.91) ""
 Q:'$G(MA) ""
 Q:FROMFILE=TOFILE MA ;files are the same!
 N NODE,NAME,NEWMA
 S NEWMA=""
 S NODE=$G(^IBE(FROMFILE,MA,0)) Q:NODE="" ""
 S NAME=$P(NODE,"^",1)
 Q:NAME="" ""
 S NEWMA=$O(^IBE(TOFILE,"B",NAME,0)) Q:NEWMA NEWMA ;quit if it already exists
 K DIC,DO,DINUM,DD S DIC="^IBE("_TOFILE_",",X=NAME,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S NEWMA=$S(+Y<0:"",1:+Y)
 Q:'NEWMA ""
 S ^IBE(TOFILE,NEWMA,0)=NODE
 K DIK,DA S DIK="^IBE("_TOFILE_",",DA=NEWMA
 D IX1^DIK K DIK,DA
 Q NEWMA
 ;
GETPI(PI,FROMFILE,TOFILE) ;copies the package interface=PI from file=FROMFILE to file=TOFILE if it doesn't already exist
 ;returns the ien of the package interface in the TOFILE
 Q:($G(FROMFILE)'=357.6)&($G(FROMFILE)'=358.6) ""
 Q:($G(TOFILE)'=357.6)&($G(TOFILE)'=358.6) ""
 Q:'$G(PI) ""
 Q:FROMFILE=TOFILE PI
 N NODE,NEWPI,SUB1,SUB2,RTN,ENTRYPT,TYPE
 S NEWPI=""
 S NODE=$G(^IBE(FROMFILE,PI,0)) Q:NODE="" ""
 S NAME=$P(NODE,"^"),ENTRYPT=$P(NODE,"^",2),RTN=$P(NODE,"^",3),TYPE=$P(NODE,"^",6)
 S NEWPI=$$LOOKUP(NAME,RTN,ENTRYPT,TOFILE,TYPE)
 Q:NEWPI NEWPI ;quit if copy is not needed
 K DIC,DO,DINUM,DD S DIC="^IBE("_TOFILE_",",X=$P(NODE,"^"),DIC(0)=""
 Q:X="" "" ;corrupted data!
 D FILE^DICN K DIC,DIE,DA
 S NEWPI=$S(+Y<0:"",1:+Y)
 Q:'NEWPI ""
 ;
 ;for display or selection interfaces, if the entry point does not exist the new package interface should be marked as unavailable
 I (TYPE=2)!(TYPE=3) D
 .I RTN="" S $P(NODE,"^",9)=0 Q
 .I RTN'="" D
 ..I ENTRYPT]"" I '$L($T(@ENTRYPT^@RTN)) S $P(NODE,"^",9)=0
 ..I ENTRYPT="" I '$L($T(^@RTN)) S $P(NODE,"^",9)=0
 ;
 S ^IBE(TOFILE,NEWPI,0)=NODE
 S:$P(NODE,"^",13) $P(NODE,"^",13)=$$GETPI($P(NODE,"^",13),$S(FROMFILE[358:358.6,1:357.6),$S(TOFILE[358:358.6,1:357.6))
 S ^IBE(TOFILE,NEWPI,0)=NODE
 F SUB1=2,3,4,5,8,9,10,11,12,14,17,18,19,20,21 S NODE=$G(^IBE(FROMFILE,PI,SUB1)) I NODE'="" S ^IBE(TOFILE,NEWPI,SUB1)=NODE
 S NODE=$G(^IBE(FROMFILE,PI,16)) I NODE'="" D
 .N TYPEDATA
 .S TYPEDATA=$P(NODE,"^",2)
 .I TYPEDATA S $P(NODE,"^",2)=$$GETADE(TYPEDATA,$S(FROMFILE[358:358.99,1:359.1),$S(TOFILE[358:358.99,1:359.1))
 .S TYPEDATA=$P(NODE,"^",6)
 .I TYPEDATA S $P(NODE,"^",6)=$$GETADE(TYPEDATA,$S(FROMFILE[358:358.99,1:359.1),$S(TOFILE[358:358.99,1:359.1))
 .S ^IBE(TOFILE,NEWPI,16)=NODE
 F SUB1=1,6,7,15 S NODE=$G(^IBE(FROMFILE,PI,SUB1,0)) D
 .I NODE'="" S ^IBE(TOFILE,NEWPI,SUB1,0)=NODE S SUB2=0 F  S SUB2=$O(^IBE(FROMFILE,PI,SUB1,SUB2)) Q:'SUB2  S NODE=$G(^IBE(FROMFILE,PI,SUB1,SUB2,0)) I NODE'="" S ^IBE(TOFILE,NEWPI,SUB1,SUB2,0)=NODE
 ;
 D CPYQLFRS(FROMFILE,PI,TOFILE,NEWPI)
 ;
 K DIK,DA S DIK="^IBE("_TOFILE_",",DA=NEWPI
 D IX1^DIK K DIK,DA
 Q NEWPI
 ;
CPYQLFRS(FROMFILE,PI,TOFILE,NEWPI) ;copy allowable qualifiers from the package interface=PI in NEWPI to the package interface=NEWPI in TOFILE
 ;
 N NODE,SUB,VARPTR
 K ^IBE(TOFILE,NEWPI,13)
 S NODE=$G(^IBE(FROMFILE,PI,13,0)) I NODE'="" S ^IBE(TOFILE,NEWPI,13,0)=NODE S SUB=0 F  S SUB=$O(^IBE(FROMFILE,PI,13,SUB)) Q:'SUB  D
 .S NODE=$G(^IBE(FROMFILE,PI,13,SUB,0)),VARPTR=$P(NODE,"^") I +VARPTR D  I +VARPTR S $P(NODE,"^")=VARPTR,^IBE(TOFILE,NEWPI,13,SUB,0)=NODE
 ..I VARPTR["IBE" S $P(VARPTR,";")=$$GETADE(+VARPTR,$S(FROMFILE[358:358.99,1:359.1),$S(TOFILE[358:358.99,1:359.1)),$P(VARPTR,"(",2)=$S(TOFILE[358:358.99,1:359.1)_"," Q
 ..I VARPTR["IBD" S $P(VARPTR,";")=$$GETQLFR(+VARPTR,$S(FROMFILE[358:358.98,1:357.98),$S(TOFILE[358:358.98,1:357.98)),$P(VARPTR,"(",2)=$S(TOFILE[358:358.98,1:357.98)_","
 Q
 ;
LOOKUP(NAME,RTN,ENTRYPT,TOFILE,TYPE) ;return 1 if the package interface already exists in TOFILE, 0 otherwise
 N PI,LOOKNODE,QUIT
 Q:NAME="" ""
 S (QUIT,PI)=0 F  S PI=$O(^IBE(TOFILE,"B",$E(NAME,1,30),PI)) Q:'PI  S LOOKNODE=$G(^IBE(TOFILE,PI,0)) I LOOKNODE'="" D  Q:QUIT
 .I NAME=$P(LOOKNODE,"^"),RTN=$P(LOOKNODE,"^",3),ENTRYPT=$P(LOOKNODE,"^",2),TYPE=$P(LOOKNODE,"^",6) S QUIT=1 Q  ;matches!
 Q PI
 ;
GETQLFR(QLFR,FROMFILE,TOFILE) ;copys qualifier=QLFR from file=FROMFILE to file=TOFILE if it does not already exist
 ;returns the ien of the qualifier existing in TOFILE
 Q:($G(FROMFILE)'=357.98)&($G(FROMFILE)'=358.98) ""
 Q:($G(TOFILE)'=357.98)&($G(TOFILE)'=358.98) ""
 Q:'$G(QLFR) ""
 Q:FROMFILE=TOFILE QLFR ;files are the same!
 N NODE,NAME,NEWQLFR
 S NEWQLFR=""
 S NODE=$G(^IBD(FROMFILE,QLFR,0)) Q:NODE="" ""
 S NAME=$P(NODE,"^",1)
 Q:NAME="" ""
 ;does it already exist?
 S NEWQLFR=0 F  S NEWQLFR=$O(^IBD(TOFILE,"B",$E(NAME,1,30),NEWQLFR)) Q:'NEWQLFR  Q:$P($G(^IBD(TOFILE,NEWQLFR,0)),"^")=NAME
 Q:NEWQLFR NEWQLFR ;quit if it already exists
 K DIC,DO,DINUM,DD S DIC="^IBD("_TOFILE_",",X=NAME,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S NEWQLFR=$S(+Y<0:"",1:+Y)
 Q:'NEWQLFR ""
 S ^IBD(TOFILE,NEWQLFR,0)=NODE
 K DIK,DA S DIK="^IBD("_TOFILE_",",DA=NEWQLFR
 D IX1^DIK K DIK,DA
 Q NEWQLFR
 ;
GETADE(ADE,FROMFILE,TOFILE) ;copys AICS Data Element=ADE from file=FROMFILE to file=TOFILE if it does not already exist
 ;returns the ien of the qualifier existing in TOFILE
 Q:($G(FROMFILE)'=359.1)&($G(FROMFILE)'=358.99) ""
 Q:($G(TOFILE)'=359.1)&($G(TOFILE)'=358.99) ""
 Q:'$G(ADE) ""
 Q:FROMFILE=TOFILE ADE ;files are the same!
 N NODE,NAME,NEWADE,SUB
 S NEWADE=""
 S NODE=$G(^IBE(FROMFILE,ADE,0)) Q:NODE="" ""
 S NAME=$P(NODE,"^",1)
 Q:NAME="" ""
 S NEWADE=$O(^IBE(TOFILE,"B",NAME,0)) Q:NEWADE NEWADE ;quit if it already exists
 K DIC,DO,DINUM,DD S DIC="^IBE("_TOFILE_",",X=NAME,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S NEWADE=$S(+Y<0:"",1:+Y)
 Q:'NEWADE ""
 S ^IBE(TOFILE,NEWADE,0)=NODE
 ;
 ; -- 9/28/95 add 10 node to be moved for moved fields 
 F SUB=1,2,3,10 S NODE=$G(^IBE(FROMFILE,ADE,SUB)) I NODE'="" S ^IBE(TOFILE,NEWADE,SUB)=NODE
 K DIK,DA S DIK="^IBE("_TOFILE_",",DA=NEWADE
 D IX1^DIK K DIK,DA
 Q NEWADE
