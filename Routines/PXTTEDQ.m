PXTTEDQ ;ISL/DLT - PCE Reminder/Maintenance Inquiry ;11/21/95  14:55
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 S U="^",DIC="^AUTTEDT(",DIC(0)="AEMQ",DIC("A")="Select PCE Education Topic: " D ^DIC K DIC("A") G:Y=-1 END S (FR,TO)=$P(Y,U,2),PXY=+Y
 S BY=.01,DHD="PCE EDUCATION TOPIC INQUIRY",FLDS="[PXTT EDUCATION TOPIC DETAIL]",L=0 D EN1^DIP K PXY
END Q
