VAFEOHL2 ;ALB/JLU/CAW;generates the HL7 message to be sent(con't);6/29/93
 ;;5.3;Registration;**38**;Aug 13, 1993
 ;
ORC ;sets up the ORC segment and the fields 1 to indicate if new or canceled
 N VAFEDHL
 S VAFEDLCT=VAFEDLCT+1
 S $P(VAFEDHL,HLFS,1)="ORC"
 S $P(VAFEDHL,HLFS,2)=$S($P(VAFEDST1,"^",3)="C":"CA",1:"NW")
 D LOG^VAFEDOHL
 Q
 ;
OBR ;sets up the OBR segment and the fields 4,7,8,9,14,22
 N VAFEDHL
 S VAFEDLCT=VAFEDLCT+1
 S $P(VAFEDHL,HLFS,1)="OBR"
 S $P(VAFEDHL,HLFS,5)=VAFEDDA_$E(HLECH)_"391.51"_$E(HLECH)_"L"
 S $P(VAFEDHL,HLFS,8)=$$HLDATE^HLFNC($P(VAFEDST1,U,1))
 S $P(VAFEDHL,HLFS,9)=HLQ
 S $P(VAFEDHL,HLFS,10)=HLQ
 S $P(VAFEDHL,HLFS,15)=HLQ
 S $P(VAFEDHL,HLFS,23)=$$HLDATE^HLFNC(VAFEDLP)
 D LOG^VAFEDOHL
 Q
 ;
OBX ;this subroutine set up the OBX segments and the fields 3,5
 N X,VAFEDOBX
 S VAFEDOBX=0
 I +$P($G(VAFEDDX(1)),U) D DIAG
 I VAFEDST2]"" D CPT
 Q
 ;
DIAG ;this subroutine will set up the diagnosics in the OBX.
 N VAFEDN,X,VAFEDD,I
 S VAFEDN=+$P(VAFEDDX(1),U)
 F X=2:1 S VAFEDC=$P(VAFEDDX(1),U,X) Q:'VAFEDC  DO
 .S Y=$O(^ICD9("BA",VAFEDC,0))
 .Q:'Y  I '$D(^ICD9(Y,0)) Q
 .S VAFEDD=$P(^ICD9(Y,0),U,3)
 .S VAFEDOBX=VAFEDOBX+1,VAFEDLCT=VAFEDLCT+1
 .S VAFEDHL="OBX"_HLFS_VAFEDOBX_HLFS_"CE"_HLFS_VAFEDC_$E(HLECH)_VAFEDD_$E(HLECH)_"I9"_HLFS_HLFS_HLQ
 .D LOG^VAFEDOHL
 I $D(VAFEDDX(2)) S I=1  F  S I=$O(VAFEDDX(I)) Q:'I  D
 .F X=2:1 S VAFEDC=$P(VAFEDDX(I),U,X) Q:'VAFEDC  DO
 ..S Y=$O(^ICD9("BA",VAFEDC,0))
 ..Q:'Y  I '$D(^ICD9(Y,0)) Q
 ..S VAFEDD=$P(^ICD9(Y,0),U,3)
 ..S VAFEDOBX=VAFEDOBX+1,VAFEDLCT=VAFEDLCT+1
 ..S VAFEDHL="OBX"_HLFS_VAFEDOBX_HLFS_"CE"_HLFS_VAFEDC_$E(HLECH)_VAFEDD_$E(HLECH)_"I9"_HLFS_HLFS_HLQ
 ..D LOG^VAFEDOHL
 Q
 ;
CPT ;this subroutine will set up the OBX with CPT codes.
 N X,VAFEDC,VAFEDD
 F X=1:1 S VAFEDC=$P(VAFEDST2,U,X) Q:'VAFEDC  DO
 .S Y=$O(^ICPT("B",VAFEDC,0))
 .Q:'Y  I '$D(^ICPT(Y,0)) Q
 .S VAFEDD=$P(^ICPT(Y,0),U,2)
 .S VAFEDOBX=VAFEDOBX+1,VAFEDLCT=VAFEDLCT+1
 .S VAFEDHL="OBX"_HLFS_VAFEDOBX_HLFS_"CE"_HLFS_VAFEDC_$E(HLECH)_VAFEDD_$E(HLECH)_"AS4"_HLFS_HLFS_HLQ
 .D LOG^VAFEDOHL
 Q