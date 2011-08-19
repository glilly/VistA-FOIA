DGADTTM5 ;ALB/RMM-CREATE NEW-STYLE XREF ;1:35 PM  24 May 2005
 ;;5.3;REGISTRATION;**665**;Aug 13,1993
 ;
 ; This routine adds the new style cross-reference ADTTM4 which triggers
 ; an update for the E-CONTACT CHANGE DATE/TIME field (#.33012) in
 ; the PATIENT File #2.
 ;
 N DGENXR,DGENRES,DGENOUT
 S DGENXR("FILE")=2
 S DGENXR("NAME")="ADTTM5"
 S DGENXR("TYPE")="MU"
 S DGENXR("USE")="A"
 S DGENXR("EXECUTION")="R"
 S DGENXR("ACTIVITY")=""
 S DGENXR("SHORT DESCR")="E-CONTACT Cross-Reference"
 S DGENXR("DESCR",1)="This cross-reference will update the E-CONTACT CHANGE DATE/TIME field when"
 S DGENXR("DESCR",2)="the Emergency Contact data changes for a patient."
 S DGENXR("SET")="D ECON^DGDDDTTM"
 S DGENXR("KILL")="D ECON^DGDDDTTM"
 S DGENXR("VAL",1)=.331
 S DGENXR("VAL",1,"COLLATION")="F"
 S DGENXR("VAL",2)=.332
 S DGENXR("VAL",2,"COLLATION")="F"
 S DGENXR("VAL",3)=.333
 S DGENXR("VAL",3,"COLLATION")="F"
 S DGENXR("VAL",4)=.334
 S DGENXR("VAL",4,"COLLATION")="F"
 S DGENXR("VAL",5)=.335
 S DGENXR("VAL",5,"COLLATION")="F"
 S DGENXR("VAL",6)=.336
 S DGENXR("VAL",6,"COLLATION")="F"
 S DGENXR("VAL",7)=.337
 S DGENXR("VAL",7,"COLLATION")="F"
 S DGENXR("VAL",8)=.338
 S DGENXR("VAL",8,"COLLATION")="F"
 S DGENXR("VAL",9)=.3305
 S DGENXR("VAL",9,"COLLATION")="F"
 S DGENXR("VAL",10)=.2201
 S DGENXR("VAL",10,"COLLATION")="F"
 D CREIXN^DDMOD(.DGENXR,"W",.DGENRES,"DGENOUT")
 Q
