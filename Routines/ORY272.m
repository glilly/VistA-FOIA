ORY272 ;SLC/JMH - post install routine for patch OR*3*272; ;07/12/10  07:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**272**;Dec 17, 1997;Build 53
 ;
POST ;
 N ORERR
 S ^ORD(100.8,17,0)="DUPLICATE DRUG THERAPY"
 K ^ORD(100.8,"B","DUPLICATE DRUG CLASS ORDER",17)
 S ^ORD(100.8,"B","DUPLICATE DRUG THERAPY",17)=""
 S ^ORD(100.8,17,1,3,0)="is currently receiving a med that is in the same Theraputic "
 S ^ORD(100.8,17,1,4,0)="Category, the order check occurs."
 D EN^XPAR("PKG","ORK PROCESSING FLAG","DUPLICATE DRUG THERAPY","Enabled",.ORERR)
 D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","DUPLICATE DRUG THERAPY","High",.ORERR)
 Q
 ;
