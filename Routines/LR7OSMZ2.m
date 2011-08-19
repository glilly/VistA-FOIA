LR7OSMZ2 ;slc/dcm - Silent Micro rpt - BACTERIA, SIC/SBC, MIC ;8/11/97
 ;;5.2;LAB SERVICE;**121,244,392**;Sep 27, 1994;Build 6
ANTI ;from LR7OSMZ1
 I $P(^LR(LRDFN,"MI",LRIDT,14,0),U,4)>0 D LINE,LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(28,CCNT,"Antibiotic Level(s):") D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"ANTIBIOTIC")_$$S^LR7OS(20,CCNT,"CONC RANGE (ug/ml)")_$$S^LR7OS(42,CCNT,"DRAW TIME")
 . S B=0
 . F  S B=$O(^LR(LRDFN,"MI",LRIDT,14,B)) Q:B<1  S X=^(B,0) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$P(X,U))_$$S^LR7OS(20,CCNT,$P(X,U,3))_$$S^LR7OS(42,CCNT,$$EXTERNAL^DILFD(63.42,1,"",$P(X,U,2)))
 Q
BACT ;from LR7OSMZ1
 I '$L($P(^LR(LRDFN,"MI",LRIDT,1),U)) Q:'$D(LRWRDVEW)  Q:LRSB'=1
 D BUG
 I $D(^LR(LRDFN,"MI",LRIDT,2,0)) D FH^LR7OSMZU Q:LREND  D GRAM
 I $D(^LR(LRDFN,"MI",LRIDT,25,0)) D FH^LR7OSMZU Q:LREND  D BSMEAR
 I $D(^LR(LRDFN,"MI",LRIDT,3,0)) D FH^LR7OSMZU Q:LREND  D BRMK Q:LREND  D BACT^LR7OSMZ5 Q:LREND
 I $D(^LR(LRDFN,"MI",LRIDT,4,0)),$P(^(0),U,4)>0 D FH^LR7OSMZU Q:LREND  D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"Bacteriology Remark(s):") S B=0 D
 . F  S B=+$O(^LR(LRDFN,"MI",LRIDT,4,B)) Q:B<1  D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(3,CCNT,^LR(LRDFN,"MI",LRIDT,4,B,0))
 Q
BUG S X=^LR(LRDFN,"MI",LRIDT,1),LRTUS=$P(X,U,2),DZ=$P(X,U,3),LRUS=$P(X,U,6),LRNS=$P(X,U,5),Y=$P(X,U)
 D D^LRU,LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"* BACTERIOLOGY "_$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")_" REPORT => "_Y_"   TECH CODE: "_DZ)
 S LRPRE=19
 D PRE^LR7OSMZU
 I $L(LRUS) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"URINE SCREEN: "_$S(LRUS="N":"Negative",LRUS="P":"Positive",1:LRUS))
 I $L(LRNS) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"SPUTUM SCREEN:  "_LRNS)
 Q
GRAM ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"GRAM STAIN:"),LRGRM=0
 F  S LRGRM=+$O(^LR(LRDFN,"MI",LRIDT,2,LRGRM)) Q:LRGRM<1  S X=^(LRGRM,0) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(3,CCNT,X)
 Q
BSMEAR ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"BACTERIOLOGY SMEAR/PREP:") S LRMYC=0
 F  S LRMYC=+$O(^LR(LRDFN,"MI",LRIDT,25,LRMYC)) Q:LRMYC<1  S X=^(LRMYC,0) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(5,CCNT,X)
 Q
BRMK ;
 S (LRBUG,LR2ORMOR)=0
 F LRAX=1,2 S LRBUG=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  S:LRAX=2 LR2ORMOR=1
 I LRAX'=1 S (LRBUG,LRTSTS)=0 F LRAX=1:1 S LRBUG=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  D LST
 Q
LST ;
 S (LRBUG(LRAX),LRORG)=$P(^LR(LRDFN,"MI",LRIDT,3,LRBUG,0),U),LRQU=$P(^(0),U,2),LRSSD=$P(^(0),U,3,8),LRORG=$P(^LAB(61.2,LRORG,0),U)
 I LRSSD'?."^" S LRSIC1=$P(LRSSD,U),LRSBC1=$P(LRSSD,U,2),LRDRTM1=$P(LRSSD,U,3),LRSIC2=$P(LRSSD,U,4),LRSBC2=$P(LRSSD,U,5),LRDRTM2=$P(LRSSD,U,6),LRSSD=1
 I LRAX=1 D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"CULTURE RESULTS: ")
 I LRAX>1 D LN^LR7OSMZ1 S ^TMP("LRC",$J,GCNT,0)=""
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(18,CCNT,$S(LR2ORMOR:LRBUG_". ",1:"")_LRQU_LRORG)
 I LRSSD D FH^LR7OSMZU Q:LREND  D SSD
 S:$D(^LR(LRDFN,"MI",LRIDT,3,LRBUG,2)) LRTSTS=LRTSTS+1
 I $D(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,0)),$P(^(0),U,4)>0 D MIC
 I $D(^LR(LRDFN,"MI",LRIDT,3,LRBUG,1,0)),$P(^(0),U,4)>0 D CMNT
 Q
SSD ;
 D LINE
 S LRDRTM1=$S(LRDRTM1="P":"PEAK",LRDRTM1="T":"TROUGH",1:LRDRTM1),LRDRTM2=$S(LRDRTM2="P":"PEAK",LRDRTM2="T":"TROUGH",1:LRDRTM2)
 I $L(LRSIC1) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SIT ") S:$L(LRDRTM1) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM1_")") S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSIC1)
 I $L(LRSBC1) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SBT ") S:$L(LRDRTM1) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM1_")") S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSBC1)
 I $L(LRSIC2) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SIT ") S:$L(LRDRTM2) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM2_")") S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSIC2)
 I $L(LRSBC2) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SBT ") S:$L(LRDRTM2) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM2_")") S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSBC2)
 Q
MIC ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(18,CCNT,"Antibiotic"),B=0
 F  S B=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  I $L($P(^(B,0),U,2,3))>0 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(35,CCNT,"MIC (ug/ml)")_$$S^LR7OS(50,CCNT,"MBC (ug/ml)") Q
 S B=0
 F  S B=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  S X=^(B,0) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(18,CCNT,$P(X,U))_$$S^LR7OS(35,CCNT,$J($P(X,U,2),7))_$$S^LR7OS(50,CCNT,$J($P(X,U,3),7))
 Q
CMNT ;
 S LRPC=0
 F A=0:1 S LRPC=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,1,LRPC)) Q:LRPC<1  S X=^(LRPC,0) D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(3,CCNT,"")
 . S:A=0 ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"Comment: ")
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(12,CCNT,X)
 Q
LINE ;
 D LINE^LR7OSUM4
 Q
