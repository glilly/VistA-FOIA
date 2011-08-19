ORCONV2 ; SLC/MKB - Convert protocols/menus to Dialogs cont ;6/10/97  10:40
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**14**;Dec 17, 1997
FH ; -- process Diet PITEM
 ; default Diet Order dialog = FHW1
 N DEFAULT,DIETS,CODE,Z,X,Y,OI,DFLT,I,QUOTE,ERR,INST,CNT,PKG
 I NAME="FHW5" S DITEM=$O(^ORD(101.41,"AB","GMRAOR ALLERGY ENTER/EDIT",0)) Q
 I NAME="FHW6" S DITEM=$O(^ORD(101.41,"AB","GMRCOR CONSULT",0)) Q
 ; G:NAME'?1"FHWD"1.N NONSTD^ORCONVRT ; not a quick order
 S CODE=$G(^ORD(101,PITEM,20)),Z=$F(CODE,"FHOR=")
 S:'Z CODE="S FHOR="_+$E(NAME,5,99),Z=7
 S DIETS=$E(CODE,Z,999),DIETS=$P(DIETS," "),QUOTE=""""
 S:$E(DIETS)=QUOTE DIETS=$P(DIETS,QUOTE,2) ; ="#^^^^"
 S DITEM=$$DIALOG^ORCONVRT(PITEM) G:'DITEM DLG^ORCONVRT
 S DEFAULT=$O(^ORD(101.41,"AB","FHW1",0)),PKG=$O(^DIC(9.4,"C","FH",0))
 S X=^ORD(101.41,DITEM,0),X=X_"^^Q^"_$P(^ORD(101.41,DEFAULT,0),U,5)_U_$S('+$G(^ORD(101,PITEM,101.01)):2,1:0)_U_PKG_"^0^0",^ORD(101.41,DITEM,0)=X
 S:PKG ^ORD(101.41,"APKG",+PKG,DITEM)=""
 K ^ORD(101.41,DITEM,6)
FH1 ; save diet(s) into DIET prompt
 S INST=0 F I=1:1:$L(DIETS,"^") S X=$P(DIETS,U,I) I X D
 . S OI=$O(^ORD(101.43,"ID",X_";99FHD",0)) I 'OI S ERR=1 Q
 . I $$INACTIVE^ORCONVRT(OI) S ERR=1 Q
 . S INST=INST+1 D SET^ORCONVRT("ORDERABLE ITEM",OI,INST)
 S:$G(CNT) ^ORD(101.41,DITEM,6,0)="^101.416^"_CNT_U_CNT
 G:$G(ERR) OI^ORCONVRT ; incomplete OI's
 Q
 ;
LR ; -- process Lab  PITEM
 ; default Lab Order dialog = LR OTHER LAB TESTS
 N DEFAULT,IFN,OI,SAMP,SPEC,DA,CODE,Z,ZZ,X,CNT,PKG
 I TYPE="L" S OI=$$LRTEST(PITEM) G LR1
 S DA=0 F  S DA=$O(^ORD(101,PITEM,10,DA)) Q:DA'>0  S IFN=+$P(^(DA,0),U) D
 . N NAME,FLINK S NAME=$P($G(^ORD(101,IFN,0)),U),FLINK=$P($G(^(5)),U)
 . I NAME?1"LR ".E,FLINK?1.N1";LAB(60," S OI=$$LRTEST(IFN)
 . I NAME?1"LRD ".E,FLINK?1.N1";LAB(62," S SAMP=+FLINK
 . I NAME?1"LRS ".E,FLINK?1.N1";LAB(61," S SPEC=+FLINK
LR1 G:'$D(OI) NONSTD^ORCONVRT
 G:'OI OI^ORCONVRT G:$$INACTIVE^ORCONVRT(OI) OI^ORCONVRT
 S DITEM=$$DIALOG^ORCONVRT(PITEM) G:'DITEM DLG^ORCONVRT
 K ^ORD(101.41,DITEM,6) S PKG=$O(^DIC(9.4,"C","LR",0))
 S DEFAULT=$O(^ORD(101.41,"AB","LR OTHER LAB TESTS",0))
 S X=^ORD(101.41,DITEM,0),X=X_"^^Q^"_$P(^ORD(101.41,DEFAULT,0),U,5)_U_$S('+$G(^ORD(101,PITEM,101.01)):2,1:0)_U_PKG_"^0^0",^ORD(101.41,DITEM,0)=X
 S:PKG ^ORD(101.41,"APKG",+PKG,DITEM)=""
 D SET^ORCONVRT("ORDERABLE ITEM",OI) S CODE=$G(^ORD(101,PITEM,20))
 D  I $G(SAMP) D SET^ORCONVRT("COLLECTION SAMPLE",SAMP)
 . I '$G(SAMP) S Z=$F(CODE,"LRFSAMP=") S:Z SAMP=+$$VALUE^ORCONVRT(CODE,Z)
 . K:'$D(^LAB(62,+$G(SAMP),0)) SAMP
 D  I $G(SPEC) D SET^ORCONVRT("SPECIMEN",SPEC)
 . I '$G(SPEC) S Z=$F(CODE,"LRFSPEC=") S:Z SPEC=$$VALUE^ORCONVRT(CODE,Z)
 . K:'$D(^LAB(61,+$G(SPEC),0)) SPEC
 S Z=$F(CODE,"LRFZX=") I Z S ZZ=$$VALUE^ORCONVRT(CODE,Z) D SET^ORCONVRT("COLLECTION TYPE",ZZ)
 S Z=$F(CODE,"LRFURG=") I Z S ZZ=+$E(CODE,Z,999) D:ZZ SET^ORCONVRT("LAB URGENCY",ZZ)
LR2 S Z=$F(CODE,"LRFDATE=") I Z D  D SET^ORCONVRT("START DATE/TIME",ZZ):$L(ZZ),STRTDT^ORCONVRT:'$L(ZZ)
 . N X,Y,%DT,X1,X2
 . S X=$$VALUE^ORCONVRT(CODE,Z),ZZ="" Q:'$L(X)  S:X="DT" X="TODAY"
 . I X="%",CODE["NOW^%DTC" S X="NOW"
 . S:X="$$NOW^XLFDT" X="NOW" S:X="$$DT^XLFDT" X="TODAY"
 . I X="X",CODE["C^%DTC" S X1=$F(CODE,"X1=") Q:'X1  S X1=$$VALUE^ORCONVRT(CODE,X1) Q:'$S(X1="DT":1,X1="$$DT^XLFDT":1,1:0)  S X2=$F(CODE,"X2=") Q:'X2  S X2=$$VALUE^ORCONVRT(CODE,X2) S:X2>0 X="T+"_(+X2)
 . S %DT="FTX" D ^%DT S:Y>0 ZZ=X ; valid
 S:$G(CNT) ^ORD(101.41,DITEM,6,0)="^101.416^"_CNT_U_CNT
 Q
 ;
LRTEST(TEST) ; -- Returns Orderable Item ptr for protocol TEST
 N PTR,OI
 S PTR=+$G(^ORD(101,TEST,5)),OI=$O(^ORD(101.43,"ID",PTR_";99LRT",0))
 Q +OI
 ;
IV ; -- process IV med PITEM
 N DEFAULT,X,INST,OI,ADD,SOL,RATE,ARRAY,CNT,PROVCOMM,PKG
 S DEFAULT=$O(^ORD(101.41,"AB","PSJI OR PAT FLUID OE",0)),PKG=$O(^DIC(9.4,"C","PSIV",0))
 S DITEM=$$DIALOG^ORCONVRT(PITEM) G:'DITEM DLG^ORCONVRT
 S X=^ORD(101.41,DITEM,0),X=X_"^^Q^"_$P(^ORD(101.41,DEFAULT,0),U,5)_U_$S('+$G(^ORD(101,PITEM,101.01)):2,1:0)_U_PKG_"^0^0",^ORD(101.41,DITEM,0)=X
 S:PKG ^ORD(101.41,"APKG",+PKG,DITEM)=""
 S INST=0 F  S INST=$O(^TMP("PSJQO",$J,"SOL",INST)) Q:INST'>0  S SOL=$G(^(INST,0)) D
 . S OI=$O(^ORD(101.43,"ID",$P(SOL,U)_";99PSP",0)) Q:'OI
 . D SET^ORCONVRT("ORDERABLE ITEM",OI,INST)
 . D SET^ORCONVRT("VOLUME",+$P(SOL,U,2),INST)
 S INST=0 F  S INST=$O(^TMP("PSJQO",$J,"AD",INST)) Q:INST'>0  S ADD=$G(^(INST,0)) D
 . S OI=$O(^ORD(101.43,"ID",$P(ADD,U)_";99PSP",0)) Q:'OI
 . D SET^ORCONVRT("ADDITIVE",OI,INST)
 . D SET^ORCONVRT("STRENGTH PSIV",$P(ADD,U,2),INST)
 . D SET^ORCONVRT("UNITS",$P(ADD,U,3),INST)
 S RATE=$P(^TMP("PSJQO",$J,1),U,7),PROVCOMM=$P(^(1),U,8)
 D:$L(RATE) SET^ORCONVRT("INFUSION RATE",RATE)
 S:PROVCOMM ^ORD(101.41,DITEM,3)="S PSJNOPC=1"
 I $G(^TMP("PSJQO",$J,"PC",0)) D  ; comments
 . S X=^TMP("PSJQO",$J,"PC",0),X="^^"_X_U_DT_U,^(0)=X
 . S ARRAY="^TMP(""PSJQO"","_$J_",""PC"")"
 . D SET^ORCONVRT("WORD PROCESSING 1",ARRAY)
 S:$G(CNT) ^ORD(101.41,DITEM,6,0)="^101.416^"_CNT_U_CNT
 Q
 ;
UD ; -- process Unit Dose PITEM
 N DEFAULT,X,PSOI,OI,ARRAY,CNT,PKG
 S DEFAULT=$O(^ORD(101.41,"AB","PSJ OR PAT OE",0)),PKG=$O(^DIC(9.4,"C","PSJ",0))
 S DITEM=$$DIALOG^ORCONVRT(PITEM) G:'DITEM DLG^ORCONVRT
 S X=^ORD(101.41,DITEM,0),X=X_"^^Q^"_$P(^ORD(101.41,DEFAULT,0),U,5)_U_$S('+$G(^ORD(101,PITEM,101.01)):2,1:0)_U_PKG_"^0^0",^ORD(101.41,DITEM,0)=X
 S:PKG ^ORD(101.41,"APKG",+PKG,DITEM)=""
 S X=$G(^TMP("PSJQO",$J,1)),PSOI=$P(X,U,3),CNT=0
 I PSOI S OI=$O(^ORD(101.43,"ID",PSOI_";99PSP",0)) I OI G:$$INACTIVE^ORCONVRT(OI) OI^ORCONVRT D SET^ORCONVRT("ORDERABLE ITEM",OI)
 I +$G(^TMP("PSJQO",$J,"DD")) D SET^ORCONVRT("DISPENSE DRUG",^("DD"))
 D:$L($P(X,U,6)) SET^ORCONVRT("INSTRUCTIONS",$P(X,U,6))
 D:$P(X,U,4) SET^ORCONVRT("ROUTE",$P(X,U,4))
 D:$L($P(X,U,5)) SET^ORCONVRT("SCHEDULE",$P(X,U,5))
 I $P(X,U,8) S ^ORD(101.41,DITEM,3)="S PSJNOPC=1"
 I $G(^TMP("PSJQO",$J,"PC",0)) D  ; comments
 . S X=^TMP("PSJQO",$J,"PC",0),X="^^"_X_U_DT_U,^(0)=X
 . S ARRAY="^TMP(""PSJQO"","_$J_",""PC"")"
 . D SET^ORCONVRT("WORD PROCESSING 1",ARRAY)
 S:$G(CNT) ^ORD(101.41,DITEM,6,0)="^101.416^"_CNT_U_CNT
 Q
