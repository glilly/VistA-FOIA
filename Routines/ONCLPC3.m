ONCLPC3 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;05/04/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Tumor Evaluation 
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," TUMOR EVALUATION"
 W !," ----------------"
 S DR(1,165.5,1)="W !,""  7. PULMONARY FUNCTION TESTS:"""
 S DR(1,165.5,2)="1407      FVC (forced vital capacity).."
 S DR(1,165.5,3)="1407.1      FEV (forced expiratory vol).."
 S DR(1,165.5,4)="W !"
 S DR(1,165.5,5)="1408  8. LIVER FUNCTION TESTS.........."
 S DR(1,165.5,6)="W !"
 S DR(1,165.5,7)="W !,""  9. RADIOLOGIC EVALUATION:"""
 S DR(1,165.5,8)="W !"
 ;S DR(1,165.5,8.1)="W !,""     BONE SCAN:"""
 S DR(1,165.5,9)="1409      BONE SCAN...................."
 S DR(1,165.5,10)="I ($G(X)=2)!($G(X)=9) S PIECE=27 D ITEM9^ONCLPC3 S Y=""@1410"""
 ;S DR(1,165.5,11)="I $G(X)=9 S PIECE=27 D ITEM9^ONCLPC3 S Y=""@1410"""
 S DR(1,165.5,12)="1409.1       EMPHYSEMA..................."
 S DR(1,165.5,13)="1409.2       VASCULAR INVASION..........."
 S DR(1,165.5,14)="1409.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,15)="1409.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,16)="1409.5       NUMBER OF TUMORS............"
 S DR(1,165.5,17)="1409.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,18)="@1410"
 S DR(1,165.5,19)="W !"
 ;S DR(1,165.5,20)="W !,""     CT SCAN OF CHEST:"""
 S DR(1,165.5,21)="1410      CT SCAN OF CHEST............."
 S DR(1,165.5,22)="I $G(X)=2 S PIECE=34 D ITEM9^ONCLPC3 S Y=""@1411"""
 S DR(1,165.5,23)="I $G(X)=9 S PIECE=34 D ITEM9^ONCLPC3 S Y=""@1411"""
 S DR(1,165.5,24)="1410.1       EMPHYSEMA..................."
 S DR(1,165.5,25)="1410.2       VASCULAR INVASION..........."
 S DR(1,165.5,26)="1410.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,27)="1410.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,28)="1410.5       NUMBER OF TUMORS............"
 S DR(1,165.5,29)="1410.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,30)="@1411"
 S DR(1,165.5,31)="W !"
 ;S DR(1,165.5,32)="W !,""     CT SCAN OF BRAIN:"""
 S DR(1,165.5,33)="1411      CT SCAN OF BRAIN............."
 S DR(1,165.5,34)="I $G(X)=2 S PIECE=41 D ITEM9^ONCLPC3 S Y=""@1412"""
 S DR(1,165.5,35)="I $G(X)=9 S PIECE=41 D ITEM9^ONCLPC3 S Y=""@1412"""
 S DR(1,165.5,36)="1411.1       EMPHYSEMA..................."
 S DR(1,165.5,37)="1411.2       VASCULAR INVASION..........."
 S DR(1,165.5,38)="1411.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,39)="1411.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,40)="1411.5       NUMBER OF TUMORS............"
 S DR(1,165.5,41)="1411.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,42)="@1412"
 S DR(1,165.5,43)="W !"
 ;S DR(1,165.5,44)="W !,""     MRI SCAN OF CHEST:"""
 S DR(1,165.5,45)="1412      MRI SCAN OF CHEST............"
 S DR(1,165.5,46)="I $G(X)=2 S PIECE=48 D ITEM9^ONCLPC3 S Y=""@1413"""
 S DR(1,165.5,47)="I $G(X)=9 S PIECE=48 D ITEM9^ONCLPC3 S Y=""@1413"""
 S DR(1,165.5,48)="1412.1       EMPHYSEMA..................."
 S DR(1,165.5,49)="1412.2       VASCULAR INVASION..........."
 S DR(1,165.5,50)="1412.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,51)="1412.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,52)="1412.5       NUMBER OF TUMORS............"
 S DR(1,165.5,53)="1412.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,54)="@1413"
 S DR(1,165.5,55)="W !"
 ;S DR(1,165.5,56)="W !,""     MRI SCAN OF BRAIN:"""
 S DR(1,165.5,57)="1413      MRI SCAN OF BRAIN............"
 S DR(1,165.5,58)="I $G(X)=2 S PIECE=55 D ITEM9^ONCLPC3 S Y=""@1414"""
 S DR(1,165.5,59)="I $G(X)=9 S PIECE=55 D ITEM9^ONCLPC3 S Y=""@1414"""
 S DR(1,165.5,60)="1413.1       EMPHYSEMA..................."
 S DR(1,165.5,61)="1413.2       VASCULAR INVASION..........."
 S DR(1,165.5,62)="1413.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,63)="1413.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,64)="1413.5       NUMBER OF TUMORS............"
 S DR(1,165.5,65)="1413.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,66)="@1414"
 S DR(1,165.5,67)="W !"
 ;S DR(1,165.5,68)="W !,""     PET SCAN:"""
 S DR(1,165.5,69)="1414      PET SCAN....................."
 S DR(1,165.5,70)="I $G(X)=2 S PIECE=62 D ITEM9^ONCLPC3 S Y=""@1415"""
 S DR(1,165.5,71)="I $G(X)=9 S PIECE=62 D ITEM9^ONCLPC3 S Y=""@1415"""
 S DR(1,165.5,72)="1414.1       EMPHYSEMA..................."
 S DR(1,165.5,73)="1414.2       VASCULAR INVASION..........."
 S DR(1,165.5,74)="1414.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,75)="1414.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,76)="1414.5       NUMBER OF TUMORS............"
 S DR(1,165.5,77)="1414.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,78)="@1415"
 S DR(1,165.5,79)="W !"
 ;S DR(1,165.5,80)="W !,""     X-RAY OF CHEST:"""
 S DR(1,165.5,81)="1415      X-RAY OF CHEST..............."
 S DR(1,165.5,82)="I $G(X)=2 S PIECE=69 D ITEM9^ONCLPC3 S Y=""@1416"""
 S DR(1,165.5,83)="I $G(X)=9 S PIECE=69 D ITEM9^ONCLPC3 S Y=""@1416"""
 S DR(1,165.5,84)="1415.1       EMPHYSEMA..................."
 S DR(1,165.5,85)="1415.2       VASCULAR INVASION..........."
 S DR(1,165.5,86)="1415.3       MEDIASTINAL LYMPH NODES....."
 S DR(1,165.5,87)="1415.4       SIZE OF DOMINANT TUMOR (mm)."
 S DR(1,165.5,88)="1415.5       NUMBER OF TUMORS............"
 S DR(1,165.5,89)="1415.6       EVIDENCE OF METASTASIS......"
 S DR(1,165.5,90)="@1416"
 S DR(1,165.5,91)="W !"
 S DR(1,165.5,92)="W !,"" 10. PRE-OP LYMPH NODE MAPPING:"""
 S DR(1,165.5,93)="1416      HIGHEST MEDIASTINAL (level 1)"
 S DR(1,165.5,94)="1416.1      UPPER PARATRACHEAL (level 2)."
 S DR(1,165.5,95)="1416.2      PREVASCULAR AND RETROTRACHEAL                                                    (level 3)..................."
 S DR(1,165.5,96)="1416.3      LOWER PARATRACHEAL (level 4)."
 S DR(1,165.5,97)="1416.4      SUBAORTIC (level 5).........."
 S DR(1,165.5,98)="1416.5      PARAORTIC (level 6).........."
 S DR(1,165.5,99)="1416.6      SUBCARINAL (level 7)........."
 S DR(1,165.5,100)="1416.7      PARAESOPHAGEAL (level 8)....."
 S DR(1,165.5,101)="1416.8      PULMONARY LIGAMENT (level 9)."
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K P,PIECE,DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
ITEM9 ;RADIOLOGIC EVALUATION
 F P=1:1:6 S PIECE=PIECE+1,P(P)=PIECE
 I X=2 D  Q
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(1))=8
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(2))=8
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(3))=8
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(4))="000"
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(5))="00"
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(6))=8
 .W !,"       EMPHYSEMA...................: NA, test not performed"
 .W !,"       VASCULAR INVASION...........: NA, test not performed"
 .W !,"       MEDIASTINAL LYMPH NODES.....: NA, test not performed"
 .W !,"       SIZE OF DOMINANT TUMOR (mm).: Test not performed"
 .W !,"       NUMBER OF TUMORS............: Test not performed"
 .W !,"       EVIDENCE OF METASTASIS......: NA, test not performed"
 I X=9 D  Q
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(1))=9
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(2))=9
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(3))=9
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(4))="000"
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(5))="00"
 .S $P(^ONCO(165.5,D0,"LUN1"),U,P(6))=9
 .W !,"       EMPHYSEMA...................: Not documented"
 .W !,"       VASCULAR INVASION...........: Not documented"
 .W !,"       MEDIASTINAL LYMPH NODES.....: Not documented"
 .W !,"       SIZE OF DOMINANT TUMOR (mm).: Test not performed"
 .W !,"       NUMBER OF TUMORS............: Test not performed"
 .W !,"       EVIDENCE OF METASTASIS......: Not documented"
 Q
