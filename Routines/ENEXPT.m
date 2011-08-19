ENEXPT ;WISC/DH,SAB-Engineering Equipment Export ;1/18/96
 ;;7.0;ENGINEERING;**20,27**;Aug 17, 1993
MAIN ;
 S ENSND=$P($G(^DIC(6910,1,0)),U,2),ENST=$E(1000+$E(ENSND,1,3),2,4)
 I 'ENST W !,"Please enter Station Number (field 1) in the Eng Init Paramters File (6910)." Q
 ;
 D ASK^ENEXPT1 D ^DIR K DIR G:$D(DIRUT) KILL I Y D EN^ENEXPT1
 W ! S DIR(0)="Y",DIR("A")="Should equipment data be transmitted to NESC"
 D ^DIR K DIR G:$D(DIRUT)!'Y KILL
 ;
QUE ;
 S %DT="AEFRSX",%DT("B")="NOW",%DT(0)="NOW"
 S %DT("A")="Enter a future date and time to queue this export: "
 D ^%DT
 I Y<1!$D(DTOUT) G KILL
 S ZTRTN="IN^ENEXPT",ZTIO="",ZTDTH=Y
 S ZTSAVE("ENSND")="",ZTSAVE("ENST")="",ZTSAVE("DUZ")=""
 S ZTDESC="Equipment Export Transmission",ZTSAVE("ZTREQ")="@"
 D ^%ZTLOAD
 W !,$S($D(ZTSK):"Task "_ZTSK_" queued.",1:"Job Cancelled")
KILL ;
 K ZTSK,ZTSAVE,ZTRTN,ZTIO,ZTDESC,ZTDTH,ENSND,ENST,%DT,DIRUT,DTOUT,X,Y
 Q
IN ;
 K ^TMP($J)
 D COUNT
 S ENDA=0,ENMSG=0,ENITEM=0
 D HEADER
 F  S ENDA=$O(^TMP($J,2,ENDA)) Q:ENDA'>0  D
 .S ENOD0=$G(^ENG(6914,ENDA,0)) Q:ENOD0=""
 .S ENITEM=ENITEM+1
 .S ENOD1=$G(^ENG(6914,ENDA,1))
 .S ENOD2=$G(^ENG(6914,ENDA,2))
 .S ENOD3=$G(^ENG(6914,ENDA,3))
 .S ENOD7=$G(^ENG(6914,ENDA,7))
 .S ENOD8=$G(^ENG(6914,ENDA,8))
 .D PACK
 .I (ENITEM#90=0) D SEND,HEADER
 D:(ENITEM#90'=0) SEND
 Q
EXIT ;
 K ^TMP($J),XMDUZ,XMY,XMSUB,XMTEXT,XMZ
 K ENDA,ENOD0,ENOD1,ENOD2,ENOD3,ENOD7,ENOD8,ENHEAD,ENTIME,ENDATE,ENL
 K ENSA,ENSB,ENSC,ENSD,ENSE,ENSF,ENITEM,ENMXSEQ,ENMSG,ENST,ENITEM,%DT
 K ENLCPT,ENLOC,ENFNCTPT,ENHO89PT,ENFNCT,ENH089,ENSN,ENSND
 Q
COUNT ;
 S ENDA=0,ENITEM=0
 F  S ENDA=$O(^ENG(6914,ENDA)) Q:ENDA'>0  D
 .S ENOD0=$G(^ENG(6914,ENDA,0)),ENOD3=$G(^ENG(6914,ENDA,3))
 .I $P(ENOD0,U,4)="NX",("^4^5^"'[(U_$P(ENOD3,U,1)_U)) S ENITEM=ENITEM+1,^TMP($J,2,ENDA)=""
 S ENMXSEQ=ENITEM+89\90
 Q
PACK ;
 D NODE0
 D:ENOD1'="" NODE1
 D:ENOD2'="" NODE2
 D:ENOD3'="" NODE3
 D:ENOD7'="" NODE7
 D:ENOD8'="" NODE8
 Q
NODE0 ;
 S ENL=ENL+1
 S ENSN=$P($G(^ENG(6914,ENDA,9)),U,5) S:ENSN="" ENSN=ENSND
 S ENSA="A^"_ENSN_U_$P(ENOD0,U)_U_$P(ENOD0,U,2)_U
 S ENSA=ENSA_$S($P(ENOD0,U,3)>0:$P($G(^ENG(6914,$P(ENOD0,U,3),0)),U),1:"")_"^|"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSA
 Q
NODE1 ;
 S ENSB="B^"
 S ENSB=ENSB_$S($P(ENOD1,U)>0:$P($G(^ENG(6911,$P(ENOD1,U,1),0)),U),1:"")
 S ENSB=ENSB_U_$P(ENOD1,U,2)_U
 S ENSB=ENSB_$S($P(ENOD1,U,4)>0:$P($G(^ENG("MFG",$P(ENOD1,U,4),0)),U),1:"")_"^|"
 S:ENSB'="B^^^^|" ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSB
 Q
NODE2 ;
 S ENSC="C^"_$P(ENOD2,U,3)_U_$$XFDT($P(ENOD2,U,4),"D")_U
 S ENSC=ENSC_$$XFDT($P(ENOD2,U,5),"D")_U_$P(ENOD2,U,6)_U_$P(ENOD2,U,7)_U
 S ENSC=ENSC_$S($P(ENOD2,U,8)>0:$P($G(^ENCSN(6917,$P(ENOD2,U,8),0)),U),1:"")
 S ENSC=ENSC_U_$S($P(ENOD2,U,9)>0:$E($P($G(^ENG(6914.1,$P(ENOD2,U,9),0)),U),1,5),1:"")
 S ENSC=ENSC_U_$$XFDT($P(ENOD2,U,10),"D")_U_$P(ENOD2,U,12)_U
 S ENSC=ENSC_$$XFDT($P(ENOD2,U,13),"D")_"^|"
 S:ENSC'="C^^^^^^^^^^^|" ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSC
 Q
NODE3 ;
 S ENSD="D^"_$P(ENOD3,U)_U
 S ENSD=ENSD_$S($P(ENOD3,U,2)>0:$P($G(^DIC(49,$P(ENOD3,U,2),0)),U),1:"")
 S ENSD=ENSD_U_$P(ENOD3,U,4)_U
 S ENLCPT=$P(ENOD3,U,5)
 S ENLOC=$S(ENLCPT>0:$P($G(^ENG("SP",ENLCPT,0)),U),1:"")
 S ENFNCTPT=$S(ENLCPT>0:$P($G(^ENG("SP",ENLCPT,4)),U),1:"")
 S ENHO89PT=$S(ENLCPT>0:$P($G(^ENG("SP",ENLCPT,9)),U,2),1:"")
 S ENFNCT=$S(ENFNCTPT'="":$P($G(^ENG(6928.1,ENFNCTPT,0)),U),1:"")
 S ENH089=$S(ENHO89PT'="":$P($G(^OFM(7336.6,ENHO89PT,0)),U),1:"")
 S ENSD=ENSD_ENLOC_U_ENFNCT_U_ENH089_U_$P(ENOD3,U,7)_U_$P(ENOD3,U,9)_"^|"
 S:ENSD'="D^^^^^^^^^|" ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSD
 Q
NODE7 ;
 S ENSE="E^"_$P(ENOD7,U)_U_$P(ENOD7,U,2)_"^|"
 S:ENSE'="E^^^|" ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSE
 Q
NODE8 ;
 S ENSF="F^"_$S($P(ENOD8,U)=1:"Y",$P(ENOD8,U)=0:"N",1:"")_U
 S ENSF=ENSF_$S($P(ENOD8,U,2)=1:"Y",$P(ENOD8,U,2)=0:"N",1:"")_U
 S ENSF=ENSF_$P(ENOD8,U,8)_U_$P(ENOD8,U,9)_"^|"
 S:ENSF'="F^^^^^|" ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENSF
 Q
HEADER ;
 Q:ENMSG=ENMXSEQ
 S ENMSG=ENMSG+1,ENL=1
 S XMDUZ=DUZ,XMSUB="Seq # "_ENMSG_" from Site "_ENST_" Equipment Extract"
 D XMZ^XMA2
 I XMZ<1 G EXIT
 D:'$D(DT) DT^DICRW
 D NOW^%DTC
 S ENHEAD="ENG^"_ENST_"^EQUIP^"_$$XFDT(%)_U
 S ENHEAD=ENHEAD_$$LTZ^ENPLUTL_$E("   ",1,3-$L($$LTZ^ENPLUTL))_U
 S ENHEAD=ENHEAD_$E(1000+ENMSG,2,4)_U_$E(1000+ENMXSEQ,2,4)_"^002^|"
 S ^XMB(3.9,XMZ,2,ENL,0)=ENHEAD
 K %
 Q
SEND ;
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=$S(ENMSG=ENMXSEQ:"$",1:"~")
 S XMY("G.ACTIVATION EQUIPMENT@NESC.MED.VA.GOV")="",XMY(DUZ)=""
 S XMY("S.ACTEQUIP@NESC.MED.VA.GOV")=""
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_ENL_U_ENL_U_DT
 D ENT1^XMD
 K XMDUZ,XMY,XMSUB,XMTEXT
 Q
XFDT(ENDTI,ENDONLY) ;Convert FileMan Date/Time to YYYYMMDD^HHMMSS
 ; ENDTI - FileMan date/time
 ; ENDONLY - contains "D" to just return date
 Q:$G(ENDTI)']""&($G(ENDONLY)["D") ""
 Q:$G(ENDTI)']"" "00000000^000000"
 Q:$G(ENDONLY)["D" 17000000+ENDTI\1
 Q 17000000+ENDTI\1_"^"_$P(ENDTI,".",2)_$E("000000",1,6-$L($P(ENDTI,".",2)))
 ;ENEXPT
