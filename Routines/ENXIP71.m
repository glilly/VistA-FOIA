ENXIP71 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;5/31/2002
 ;;7.0;ENGINEERING;**71**;Aug 17, 1993
 ;-------------------------------------------------------------------
 ;This routine is a modified copy of ENXIP63 from EN*7*63.
 ;
 ;-------------------------------------------------------------------
PRE ;PRE Install Entry Point.
 ;
 I $$PATCH^XPDUTL("EN*7.0*71") D BMES^XPDUTL("  Skipping pre install since patch was previously installed.") Q
 ;
 ;Check for field #99 entries in 6914 set by EN*7*63.
 ;If $P1 of "RC" node has a value, set it to null
 N ENIEN,ENCNT,ENMSG S (ENIEN,ENCNT)=0
 ;
 S ENMSG="   * Checking for field #99 entries in file 6914."
 D BMES^XPDUTL(ENMSG)
 F  S ENIEN=$O(^ENG(6915.2,"B",ENIEN)) Q:'ENIEN  D
 . QUIT:'$D(^ENG(6914,ENIEN,"RC"))
 . ;
 . I $P(^ENG(6914,ENIEN,"RC"),U)'="" D
 . . S $P(^ENG(6914,ENIEN,"RC"),U)=""
 . . S ENCNT=ENCNT+1
 ;
 S ENMSG="   * "_ENCNT_" field #99 entries were removed in file 6914."
 D MES^XPDUTL("   * Check for field #99 entries in file 6914 completed.")
 I ENCNT>0 D MES^XPDUTL(ENMSG)
 E  D MES^XPDUTL("   * NO field #99 entries found in file 6914.")
 ;
 ;-------------------- D A T A  V A L I D A T I O N ------------------
 ;
 ;Validate data in 6914.  If there is a problem, inform the user and
 ;save problem records in a temp file.
 ;
 K ^XTMP("ENXIP71",0)
 ;
 S (ENIEN,ENCNT)=0,ENMSG=""
 S ^XTMP("ENXIP71",0)=$$FMADD^XLFDT(DT,21)_U_DT
 ;
 S ENMSG="   * Checking for problem records in file 6914."
 D BMES^XPDUTL(ENMSG)
 F  S ENIEN=$O(^ENG(6915.2,"B",ENIEN)) Q:'ENIEN  D
 . ;
 . Q:+$$CHKFA^ENFAUTL(ENIEN)'>0  ;Not currently reported to FA
 . ;
 . ;Data vaildation - No entry in the Equipment File
 . I '$D(^ENG(6914,ENIEN)) D  Q
 . . S ENCNT=ENCNT+1
 . . S ENMSG="     "_ENCNT_". NO ENTRY IN FILE 6914 for IEN "_ENIEN
 . . S ^XTMP("ENXIP71",ENIEN)=ENMSG
 . . D MES^XPDUTL(ENMSG)
 . ;
 . K ENEQ
 . F I=2,8,9 S ENEQ(I)=$G(^ENG(6914,ENIEN,I)) ;Check data from 6914
 . ;
 . ;Data vaildation - Check for missing nodes
 . ;   1. Node 2 has the Total Asset Value
 . ;   2. Node 8 has the Standard General Ledger
 . ;   3. Node 9 has Station no. and Fund no. 
 . ;
 . I ENEQ(2)="" D
 . . S ENCNT=ENCNT+1
 . . S ENMSG="     "_ENCNT_". NODE 2 MISSING IN 6914 for IEN "_ENIEN
 . . S ^XTMP("ENXIP71",ENIEN)=ENMSG
 . . D MES^XPDUTL(ENMSG)
 . . ;
 . I ENEQ(8)="" D
 . . S ENCNT=ENCNT+1
 . . S ENMSG="     "_ENCNT_". NODE 8 MISSING IN 6914 for IEN "_ENIEN
 . . S ^XTMP("ENXIP71",ENIEN)=ENMSG
 . . D MES^XPDUTL(ENMSG)
 . . ;
 . I ENEQ(9)="" D
 . . S ENCNT=ENCNT+1
 . . S ENMSG="     "_ENCNT_". NODE 9 MISSING IN 6914 for IEN "_ENIEN
 . . S ^XTMP("ENXIP71",ENIEN)=ENMSG
 . . D MES^XPDUTL(ENMSG)
 ;
 S ENMSG="   * These problem records will not process with the "
 S ENMSG=ENMSG_"one-time job!"
 D MES^XPDUTL("   * Check for problem records in file 6914 completed.")
 ;
 I ENCNT>0 D MES^XPDUTL(ENMSG) Q
 D MES^XPDUTL("   * NO problem records were found in file 6914.")
 ;
 Q
 ;---------------------------------------------------------------------
POST ;Post Install Entry Point
 N ENI,ENSN
 ;
 ; only perform during 1st install
 I $$PATCH^XPDUTL("EN*7.0*71") D BMES^XPDUTL("  Skipping post install since patch was previously installed.") Q
 I DT>3020724 D BMES^XPDUTL("  Skipping post install since Today is after July 24, 2002.") Q
 ; check if legacy computer system (due to facility consolidation)
 ;   We don't want to generate new FD Documents on the legacy since
 ;   FD Documents are manually entered on Fixed Assets/FMS within
 ;   a month of having the equipment data transferred to the consolidated
 ;   computer system. Any new FD Documents sent from the legacy
 ;   Engineering software would reject in Austin.
 ;
 S ENI=$O(^DIC(6910,0)) ; ien of entry in file 6910 (should be 1)
 S ENSN=$S(ENI:$P($G(^DIC(6910,ENI,0)),U,2),1:"") ; station number
 I $$LEGACY(ENSN) D  Q
 . D BMES^XPDUTL("  Skipping post install because patch is being installed on a legacy system.")
 . D MES^XPDUTL("  Any FD Documents generated by a legacy system would reject in Austin.")
 ;
QTASK ; Queue Task to expense capitalized equipment that does not meet the
 ; new capitalization threshold ($100,000)
 ;   
 S ZTRTN="TASK^ENFACTT"
 S ZTDESC="ENG Capitalization Threshold Task"
 S ZTDTH="3020724.170000"
 S ZTIO=""
 S ZTSAVE("ENIO")=XPDQUES("POS1","B")
 D ^%ZTLOAD
 ;
 I '$G(ZTSK) D
 . D BMES^XPDUTL("ERROR. The one-time task was not successfully queued.")
 . D MES^XPDUTL("Please contact National VISTA Support for assistance.")
 . ; send mail message to developer and installer
 ;
 I $G(ZTSK) D
 . D BMES^XPDUTL("  The one-time task was successfully queued.")
 . D MES^XPDUTL("   1. The task number is "_ZTSK)
 . D MES^XPDUTL("   2. It will start on "_$$HTE^XLFDT(ZTSK("D")))
 . D MES^XPDUTL("   3. After the task completes a summary report will be printed on device:")
 . D MES^XPDUTL("      "_XPDQUES("POS1","B"))
 ;
 Q
 ;----------------------------------------------------------------------
LEGACY(ENSN) ; Legacy Station Extrinsic Function
 ; input ENSN - station number
 ; returns 1 if legacy station or 0 if not legacy station
 ; list updated through calendar year 1999 facility consolidations
 ;
 ; Most up to date listing received 5/16/02. Added additional stations
 ; with information supplied by NDBI
 ;
 N ENRET
 S ENRET=0
 S ENSN=$G(ENSN)
 ;
 I "^599^505^627^641^566^611^685^591^569^513^579^604^645^535^522^680^752^533^592^574^686^617^665^594^525^532^527^"[(U_ENSN_U) S ENRET=1
 ;
 ;New Legacy for EN*7&71
 I "^647^543^609^677^567^452^555^514^670^500^622^597^584^"[(U_ENSN_U) S ENRET=1
 ;
 Q ENRET
 ;
 ;ENXIP71
