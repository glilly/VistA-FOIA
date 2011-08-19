PRCHDSP5 ;WISC/DJM-PRINT AMENDMENT, ROUTINE #2 ;9/15/95  11:43 AM
V ;;5.1;IFCAP;**21**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
E22 ;LINE ITEM Delete PRINT
 N FIELD,CHANGE,CHANGES,OLD,ITEM,ITEM0,ITEM1,ITEM2,LCNT,DATA,I,UOP
 S FIELD=0 K ITEM D LCNT^PRCHPAM5(.LCNT)
 F  S FIELD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD)) Q:FIELD'>0  D
 .S CHANGE=0 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD,CHANGE)) Q:CHANGE'>0  D
 ..S CHANGES=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,0),OLD=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)
 ..S ITEM=$P(CHANGES,U,4) Q:$D(ITEM(ITEM))  S ITEM(ITEM)=1
 ..S ITEM0=$G(^PRC(442,PRCHPO,2,ITEM,0))
 ..I ITEM0="" Q
 ..S ITEM1=$G(^PRC(442,PRCHPO,2,ITEM,1,1,0))
 ..D LINE^PRCHPAM5(.LCNT,2) S DATA="The following line item has been cancelled:" D DATA^PRCHPAM5(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "
 ..S DATA=DATA_$P(ITEM0,U,5)_"     BOC: "_+$P(ITEM0,U,4)
 ..S DATA=DATA_"   CONTRACT: "_$P($G(^PRC(442,PRCHPO,2,ITEM,2)),U,2)
 ..D DATA^PRCHPAM5(.LCNT,DATA)
 ..D NEW^PRCHDSP6
 ..S UOP=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    Items per "_UOP_": "_$P(ITEM0,U,12)
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_$P(ITEM0,U,13) D DATA^PRCHPAM5(.LCNT,DATA)
 ..I $P(ITEM0,U,6)]"" S DATA="    STK#: "_$P(ITEM0,U,6) D DATA^PRCHPAM5(.LCNT,DATA)
 ..S QTY=$$FETCH(2,ITEM)
 ..S AUC=$$FETCH(5,ITEM)
 ..S UOP=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    "_QTY_" "_UOP_" at $"_$J(AUC,12,4)_" = $"_$J(QTY*AUC,9,2) D DATA^PRCHPAM5(.LCNT,DATA),LCNT1^PRCHPAM5(LCNT)
 Q
 ;
E23 ;LINE ITEM Edit PRINT
 N FIELD,CHANGE,CHANGES,IMF,BOC,OLD,ITEM,ITEM0,ITEM1,ITEMZ,QTY,AUC,UOP,UOP1,NSN,UCF,LCNT,DATA,DES,VAL,PRCHLN,ABC,VSN,CONOLD,CON442
 S FIELD=0 K ITEM D LCNT^PRCHPAM5(.LCNT)
 F  S FIELD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD)) Q:FIELD'>0  D
 .S CHANGE=0 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD,CHANGE)) Q:CHANGE'>0  D
 ..S CHANGES=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,0),OLD=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)
 ..S ITEM=$P(CHANGES,U,4) Q:$D(ITEM(ITEM))  S ITEM(ITEM)=1
 ..S ITEM0=$G(^PRC(442,PRCHPO,2,ITEM,0))
 ..I ITEM0="" Q
 ..I $P(ITEM0,U,2)=0,$P(ITEM0,U,9)=0 Q
 ..S ITEM1=$G(^PRC(442,PRCHPO,2,ITEM,1,1,0))
 ..S (ABC,DES)=$$FETCH(1,ITEM) S PRCHLN=VAL
 ..S IMF=$$FETCH(1.5,ITEM) I IMF'>0 S IMF=$P(ITEM0,U,5)
 ..S BOC=+$$FETCH(3.5,ITEM) I BOC'>0 S BOC=+$P(ITEM0,U,4)
 ..S QTY=$$FETCH(2,ITEM) I QTY'>0 S QTY=$P(ITEM0,U,2)
 ..S AUC=$$FETCH(5,ITEM) I AUC="" S AUC=$P(ITEM0,U,9)
 ..S UOP=$$FETCH(3,ITEM) I UOP'>0 S UOP=$P(ITEM0,U,3)
 ..S NSN=$$FETCH(9.5,ITEM) I NSN="" S NSN=$P(ITEM0,U,13)
 ..S UCF=$$FETCH(3.1,ITEM) I UCF'>0 S UCF=$P(ITEM0,U,12)
 ..S VSN=$$FETCH(9,ITEM) I VSN="" S VSN=$P(ITEM0,U,6)
 ..S CONOLD=$$FETCH(4,ITEM)
 ..S CON442=$P($G(^PRC(442,PRCHPO,2,ITEM,2)),U,2)
 ..I CONOLD="",CON442'="" S CONOLD=CON442
 ..D LINE^PRCHPAM5(.LCNT,2) S DATA="**Currently:"
 ..D DATA^PRCHPAM5(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "
 ..S DATA=DATA_IMF_"     BOC: "_BOC_"   CONTRACT: "_CONOLD
 ..D DATA^PRCHPAM5(.LCNT,DATA)
 ..I $L(ABC)>0 D OLD^PRCHDSP6
 ..I $L(ABC)'>0 S ITEMZ=ITEM1 D NEW^PRCHDSP6
 ..S UOP1=$S($L(UOP)>0:$P($G(^PRCD(420.5,UOP,0)),U),1:"")
 ..S DATA="    Items per "_UOP1_": "_UCF
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_NSN D DATA^PRCHPAM5(.LCNT,DATA)
 ..I $L(VSN)>0 S DATA="    STK#: "_VSN D DATA^PRCHPAM5(.LCNT,DATA)
 ..S UOP1=$S($L(UOP)>0:$P($G(^PRCD(420.5,UOP,0)),U),1:"")
 ..S DATA="    "_QTY_" "_UOP1_" at $"_$J(AUC,12,2)_" = $"_$J(QTY*AUC,9,2) D DATA^PRCHPAM5(.LCNT,DATA)
 ..S DATA="                                                    "
 ..D DATA^PRCHPAM5(.LCNT,DATA)
 ..S DATA=" **Will now be AMENDED to read:" D DATA^PRCHPAM5(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "
 ..S DATA=DATA_$P(ITEM0,U,5)_"     BOC: "_+$P(ITEM0,U,4)
 ..S DATA=DATA_"   CONTRACT: "_CON442
 ..D DATA^PRCHPAM5(.LCNT,DATA)
 ..S:$D(ITEMZ) ITEM1=ITEMZ D NEW^PRCHDSP6
 ..S UOP1=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    Items per "_UOP1_": "_$P(ITEM0,U,12)
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_$P(ITEM0,U,13) D DATA^PRCHPAM5(.LCNT,DATA)
 ..I $P(ITEM0,U,6)]"" S DATA="    STK#: "_$P(ITEM0,U,6) D DATA^PRCHPAM5(.LCNT,DATA)
 ..S UOP1=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    "_$P(ITEM0,U,2)_" "_UOP1_" $"_$J($P(ITEM0,U,9),12,4)_" = $"_$J($P(ITEM0,U,2)*$P(ITEM0,U,9),9,2)
 ..D DATA^PRCHPAM5(.LCNT,DATA),LCNT1^PRCHPAM5(LCNT)
 Q
 ;
FETCH(FIELD,ITEM) ;EXTRINSIC FUNCTION TO RETURN THE 'VALUE' FOR A FIELD FROM 'LINE ITEM
 ;AMENDMENT' OPTIONS.
 N VAL1
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",21,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM S VAL1=0 G EXIT
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",22,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM D  G EXIT
 .S VAL1=^PRC(442,PRCHPO,6,PRCHAM,3,VAL,1,1,0)
 .Q
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",23,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM D  G EXIT
 .S VAL1=^PRC(442,PRCHPO,6,PRCHAM,3,VAL,1,1,0)
 .Q
 S VAL1=""
EXIT Q VAL1
