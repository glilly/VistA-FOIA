PSGWADP1 ;BHAM ISC/PTD,CML-Print Data for AMIS Stats - CONTINUED ; 30 Aug 93 / 10:13 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
PRINT S PSGWPG=1,OUT=0 D HDR G:OUT END
 F PSGWTY=0:0 Q:OUT  S PSGWTY=$O(^TMP("PSGWADP",$J,PSGWTY)),PSGWNM=0 G:PSGWTY=9999 ONDM G:'PSGWTY DONE D:$Y+5>IOSL HDR I 'OUT D WRTYPE F J=0:0 S PSGWNM=$O(^TMP("PSGWADP",$J,PSGWTY,PSGWNM)) Q:PSGWNM=""!(OUT)  D
 .D:$Y+5>IOSL HDR I 'OUT W !!?5,PSGWNM D WRTDATA
 ;
ONDM I 'OUT S PSGWNM=0 D:$Y+5>IOSL HDR I 'OUT D WRTYPE F J=0:0 S PSGWNM=$O(^TMP("PSGWADP",$J,9999,PSGWNM)) Q:PSGWNM=""!(OUT)  I '$D(^TMP("PSGWADP",$J,"DN",PSGWNM)) D:$Y+5>IOSL HDR I 'OUT W !!?5,PSGWNM D WRTDATA
 ;
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST)="C"&('OUT) W !!,"Press RETURN to continue: " R AUTO:DTIME
END K ^TMP("PSGWADP",$J),I,J,K,PSGWAOU,PSGWDR,PSGWITM,PSGWNM,PSGWTY,PSGWPG,LOC,LOC1,LOC2,OUPTR,OUNIT,PSGWIO,ZTSK,PSGWDT,%,%I,%H,DA,ZTIO,%DT,IO("Q"),X,Y,AUTO,OUT
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
HDR ;PRINT REPORT HEADING
 I $E(IOST)="C"&(PSGWPG>1) S DIR(0)="E" D ^DIR K DIR I Y'=1 S OUT=1 Q
 W:$Y @IOF S %DT="",X="T" D ^%DT X ^DD("DD") W !!,"PAGE: ",PSGWPG,?110,"DATE: ",Y,!?50,"DATA FOR AR/WS AMIS STATS",!!,"TYPE",?47,"ORDER",?59,"PRICE PER",?73,"DISPENSE UNITS",?90,"PRICE PER",?105,"AMIS",?120,"AMIS CONV.",!
 W ?5,"DRUG NAME",?47,"UNIT",?59,"ORDER UNIT",?73,"PER ORDER UNIT",?90,"DISPENSE UNIT",?105,"CATEGORY",?120,"NUMBER",!
 F J=1:1:132 W "="
 S PSGWPG=PSGWPG+1
 Q
 ;
WRTYPE W !!,$S((PSGWTY'=9999)&($D(^PSI(58.16,PSGWTY,0))):$P(^PSI(58.16,PSGWTY,0),"^"),1:"** UNCLASSIFIED BY TYPE: ") Q
 ;
WRTDATA S LOC=^TMP("PSGWADP",$J,PSGWTY,PSGWNM) F J=1:1:6 I $P(LOC,"^",J)="" S $P(LOC,"^",J)="NO DATA"
 W ?47,$P(LOC,"^"),?61,$P(LOC,"^",2),?75,$P(LOC,"^",3),?90,$P(LOC,"^",4),?105,$P(LOC,"^",5),?120,$P(LOC,"^",6)
 Q
