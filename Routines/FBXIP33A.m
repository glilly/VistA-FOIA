FBXIP33A ;WCIOFO/MJE-IMPORT DOL MOD LVL TAB ;9/18/2001
 ;;3.5;FEE BASIS;**33**;JAN 30, 1995
 Q
 ;
LOADA ;
 ; process modifiers in table
 N FBI,MOD,MODDATA,X
 D BMES^XPDUTL("--Updating file 162.98")
 F FBI=1:1 S MODDATA=$P($T(DATA+FBI),";;",2) Q:MODDATA="END"  D
 . S MOD=$P(MODDATA,"^",2)
 . I '$O(^FB(162.98,"B",$P(MODDATA,"^"),0)) D BMES^XPDUTL("TABLE YEAR NOT IN FILE SKIPPING INPUT RECORD "_FBI) Q
 . S DA(1)=+($O(^FB(162.98,"B",$P(MODDATA,"^"),0)))
 . S DA=$O(^FB(162.98,DA(1),"M","B",MOD,0))
 . I DA'>0 D  Q:DA'>0
 . . S DIC="^FB(162.98,"_DA(1)_",""M"",",DIC(0)="L",DIC("P")="162.981A"
 . . S X=MOD
 . . K DD,DO D FILE^DICN I Y'>0 D BMES^XPDUTL("ERROR ADDING MOD "_MOD_" in "_$P(MODDATA,"^"))
 . . K DIC,DLAYGO
 . . S DA=+Y
 . ;
 . S DIE="^FB(162.98,"_DA(1)_",""M"","
 . S DR=".02///^S X="""_$P(MODDATA,"^",3)_""""
 . D ^DIE K DIE
 D BMES^XPDUTL("---Update of file 162.98 complete")
 Q
 ;
DATA ;This is the DOL MOD LVL data tablenumber^mod^%
 ;;2001-55^P1^100
 ;;2001-55^P2^125
 ;;2001-55^P3^150
 ;;2001-55^P4^165
 ;;2001-55^P5^175
 ;;2001-55^P6^100
 ;;2001-55^QX^75
 ;;2001-55^QZ^75
 ;;2001-60^51^100
 ;;2001-60^76^100
 ;;2001-60^77^100
 ;;2001-60^78^100
 ;;2001-60^79^100
 ;;2001-80^RR^11
 ;;2001-80^UE^75
 ;;END
 ;
 ;FBXIP33A
