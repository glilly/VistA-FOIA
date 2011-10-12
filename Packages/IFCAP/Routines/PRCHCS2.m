PRCHCS2 ;WISC/RHD-BUILD LOG CODE SHEET DATA ;12/1/93  09:51
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
COM ;S PRCHCOM=$S($D(^PRC(441.2,+$P(PRCH2,U,3),0)):$P(^(0),U,4),1:"") Q
 S PRCHCOM=$P($G(^PRC(441.2,+$P(PRCH2,U,3),0)),U,4) Q
NOM S X=$S(PRCHCOM=1:$E($P(PRCHI0,U,2),1,20),PRCHCOM=8:$E($P(PRCHI0,U,2),1,13),1:$E($P(PRCHI0,U,2),1,16)) Q:PRCHCOM'=8
 I PRCHDIET="" W $C(7),!!,"WARNING--DIETETICS COST PERIOD MISSING--WILL BE SET TO 'N'!!" S PRCHDIET="N"
 S Y=X,PRCFLN=13 D RBF^PRCFU S PRCHZ=Y_PRCHDIET_$S($P(PRCH4,U,12):$P(PRCH4,U,12),1:" "),Y=$P(PRCH4,U,13),PRCFLN=5 D LBF^PRCFU S X=PRCHZ_Y K Y,PRCHZ Q
MAX S X="",PRCHCS("MAX")=$P(PRCHIV0,U,9) Q:'PRCHCS("MAX")  S:$P(PRCH0,U,2)>PRCHCS("MAX") X=1 Q
MAND S X="",PRCHCS("MAND")="" Q:'$P(PRCHI0,U,8)  Q:$D(^PRC(440,"AC","S",+$P(PRCHI0,U,8)))
 S PRCHCS("MAND")=$S($D(^PRC(440,+$P(PRCHI0,U,8),2)):$P(^(2),U,2),1:PRCHCS("MAND"))
M2 I PRCHCS("MAND"),$P(PRCH4,U,10),PRCHCS("MAND")'=$P(PRCH4,U,10) W $C(7),!!,"NOTE: Possible Source deviation on line/item "_$P(PRCH0,U,1),!
 Q
DOCID ;SET DOCUMENT IDENTIFIER TO COMMON NO.(PAT) OR REQUISITION NO. IF SOURCE 1 (DEPOT)
 S X="" Q:'$D(^PRC(442,PRCHPO,18))  S X=^(18),X=$P(X,U,3)
 Q
AMT ;SET X=AMOUNT ORDERED INCLUDING TERM & TRADE DISCOUNTS, AND SHIPPING/HANDLING CHARGES.
 S X=$P(PRCH2,U,1)-$P(PRCH2,U,6)
 S X=X-(X*PRCHS("T")) I PRCHEST S X=X+PRCHEST
 S:X<0 X=0 S X=+$J(X,0,2)
 Q
B500 ;POSTED ACQUISITIONS TRX# 630,500,504
 S PRCHTP(1,1)="S X=PRCHPO;5.1",PRCHTP(1,2)="D DOCID^PRCHCS2;344",PRCHTP(1,3)="7;306"
 S PRCHTP(2,1)=".01;300",PRCHTP(2,2)="2;302",PRCHTP(2,3)="S X=$P(PRCHDIC1(2,0),U,13),X=$P(X,""-"",2)_$P(X,""-"",3)_$P(X,""-"",4);308",PRCHTP(2,4)="39;341"
 S PRCHTP(2,5)="S X=$S($P(PRCH4,U,10)=1:"""",1:+PRCH2) D:X AMT^PRCHCS2;301",PRCHTP(2,6)="35;347",PRCHTP(2,7)="36;348",PRCHTP(2,8)="3;303"
 S PRCHTP(2,9)="S Y=$E($P(PRCHI0,U,2),1,15),PRCFLN=15 D RBF^PRCFU S X=Y K Y;310",PRCHTP(2,10)="D MAX^PRCHCS2;349",PRCHTP(2,11)="D MAND^PRCHCS2;359" Q
 Q
B100 ;DLA ACQUISITIONS TRX# 100
 S PRCHTP(1,1)="S X=PRCHPO;5.1",PRCHTP(1,2)="71;313",PRCHTP(1,3)="72;312",PRCHTP(1,4)="80;350",PRCHTP(1,5)="72.4;311",PRCHTP(1,6)=".1;306.2"
 S PRCHTP(1,7)="73;351",PRCHTP(1,8)="S X=$P($P(^PRC(442,PRCHPO,0),U,1),""-"",2);367",PRCHTP(1,9)="102;344",PRCHTP(1,10)="74;352",PRCHTP(1,11)="75;353",PRCHTP(1,12)="76;354",PRCHTP(1,13)="77;355"
 S PRCHTP(1,14)="78;356",PRCHTP(1,15)="7;358",PRCHTP(1,16)="79;357"
 S PRCHTP(2,1)=".01;300",PRCHTP(2,2)="2;302",PRCHTP(2,3)="30;366",PRCHTP(2,4)="S X=$P(PRCHDIC1(2,0),U,13),X=$P(X,""-"",1)_$P(X,""-"",2)_$P(X,""-"",3)_$E($P(X,""-"",4),1,4);307"
 S PRCHTP(2,5)="3;303"
 Q
B501 ;UNPOSTED ACQUISITION--SOURCE 1 (DEPOT) TRX# 501,505,510,514,515
 S PRCHTP(1,1)="S X=PRCHPO;5.1",PRCHTP(1,2)="D DOCID^PRCHCS2;344",PRCHTP(1,3)="7;306",PRCHTP(1,4)="70;330"
 S PRCHTP(2,1)=".01;300",PRCHTP(2,2)="2;302",PRCHTP(2,3)="S X=$P(PRCHDIC1(2,0),U,13),X=$P(X,""-"",2)_$P(X,""-"",3)_$P(X,""-"",4);308",PRCHTP(2,4)="39;341"
 S PRCHTP(2,5)="35;347",PRCHTP(2,6)="36;348"
 Q
B700 ;UNPOSTED ACQUISITION--SOURCE 3 (GSA) TRX# 700
 S PRCHTP(1,1)="S X=PRCHPO;5.1",PRCHTP(1,2)="102;344",PRCHTP(1,3)="7;306",PRCHTP(1,4)="70;330",PRCHTP(1,5)="S X=""G"";340"
 S PRCHTP(2,1)=".01;300",PRCHTP(2,2)="2;302",PRCHTP(2,3)="S X=$P(PRCHDIC1(2,0),U,13),X=$P(X,""-"",2)_$P(X,""-"",3)_$P(X,""-"",4);308",PRCHTP(2,4)="39;341",PRCHTP(2,5)="D AMT^PRCHCS2;301"
 S PRCHTP(2,6)="S X=$S($P(PRCH4,U,1)]"""":""*""_$P(PRCH4,U,1),1:$E($P(PRCHI0,U,2),1,9));310.6",PRCHTP(2,7)="3;303"
 S PRCHTP(2,8)="8;364",PRCHTP(2,9)="35;347",PRCHTP(2,10)="36;348",PRCHTP(2,11)="D COM^PRCHCS2 S X=PRCHCOM;336"
 Q