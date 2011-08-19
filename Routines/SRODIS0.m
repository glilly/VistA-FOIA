SRODIS0 ;BIR/ADM - LIST OF OPERATIONS BY DISPOSITION ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**48,50**;24 Jun 93
 U IO S (SRHDR,SRQ)=0,PAGE=1,SRINST=SRSITE("SITE") K ^TMP("SRLIST",$J),^TMP("SRSS",$J)
 N SRFRTO S Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y,Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 S SRD=SRSD-.0001,SRED1=SRED+.9999,SRSOUT=0 F  S SRD=$O(^SRF("AC",SRD)) Q:SRD=""!(SRD>SRED1)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRD,SRTN)) Q:SRTN=""  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D UTIL
 S SRP="" I SRORD F  S SRP=$O(^TMP("SRLIST",$J,SRP)) Q:SRP=""!(SRQ)  S SRSS="" F  S SRSS=$O(^TMP("SRLIST",$J,SRP,SRSS)) Q:SRSS=""!(SRQ)  D SPEC
 I SRORD,SRSP S SRSS="" F  S SRSS=$O(SRSP(SRSS)) Q:SRSS=""!SRQ  I '$D(^TMP("SRSS",$J,SRSS)) D NONE
 I 'SRORD F  S SRP=$O(^TMP("SRLIST",$J,SRP)) Q:SRP=""!(SRQ)  D HDR^SRODIS Q:SRQ  D ALL
 I 'SRSP,'$D(^TMP("SRLIST",$J)) S SRP=$S(SRDISP'="ALL":SRDISP,1:"") D HDR^SRODIS W $$NODATA^SROUTL0()
END I 'SRQ,$E(IOST)'="P" W !!,"Press RETURN to continue or '^' to quit. " R X:DTIME
 W:$E(IOST)="P" @IOF K ^TMP("SRLIST",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRIO,SRTN
 Q
UTIL ; set ^TMP("SRLIST",$J
 Q:$P($G(^SRF(SRTN,.2)),"^",12)=""
 S SRP=$P($G(^SRF(SRTN,.4)),"^",6) S:SRP="" SRP="ZZ" I SRDISP'="ALL",SRP'=SRDISP Q
 S S(0)=^SRF(SRTN,0),SRSS=$P(S(0),"^",4) S:SRSS="" SRSS="ZZ" I SRSP,'$D(SRSP(SRSS)) Q
 S ^TMP("SRSS",$J,SRSS)="" I SRORD S ^TMP("SRLIST",$J,SRP,SRSS,SRD,SRTN)="" Q
 S ^TMP("SRLIST",$J,SRP,SRD,SRTN)=""
 Q
SPEC S SRSPEC=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"NO SPECIALTY ENTERED") D HDR^SRODIS Q:SRQ
 S (TOTAL,SRD)=0 F  S SRD=$O(^TMP("SRLIST",$J,SRP,SRSS,SRD)) Q:'SRD!(SRQ)  S SRTN=0 F  S SRTN=$O(^TMP("SRLIST",$J,SRP,SRSS,SRD,SRTN)) Q:'SRTN!(SRQ)  S TOTAL=TOTAL+1 D CASE
 Q:SRQ  I $Y+5>IOSL D HDR^SRODIS I SRQ Q
 W !!!,"TOTAL ",SRSPEC,": ",TOTAL
 Q
NONE S SRSPEC=$P(^SRO(137.45,SRSS,0),"^") D HDR^SRODIS Q:SRQ
 W !!,"TOTAL ",SRSPEC,": 0"
 Q
ALL S (SRD,TOTAL)=0 F  S SRD=$O(^TMP("SRLIST",$J,SRP,SRD)) Q:'SRD!(SRQ)  S SRTN=0 F  S SRTN=$O(^TMP("SRLIST",$J,SRP,SRD,SRTN)) Q:'SRTN!(SRQ)  D CASE S TOTAL=TOTAL+1
 Q:SRQ  I $Y+5>IOSL D HDR^SRODIS I SRQ Q
 W !!!,"TOTAL "_$S(SRP:$P(^SRO(131.6,SRP,0),"^"),1:"DISPOSITION NOT ENTERED")_": ",TOTAL
 Q
CASE ; print individual case
 I $Y+7>IOSL D HDR^SRODIS I SRQ Q
 S S(0)=^SRF(SRTN,0),DFN=$P(S(0),"^") D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),SROD=$P(S(0),"^",9),(SRSUR,SRFST,SRTWO)=""
 S Y=$P(S(0),"^",12),C=$P(^DD(130,.011,0),"^",2) D Y^DIQ S SRIO=$S(Y="":"NOT ENTERED",1:Y)
 I 'SRORD S SRSS=$P(S(0),"^",4),SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"NO SPECIALTY ENTERED")
 S S(.1)=$G(^SRF(SRTN,.1)) S SRSUR=$P(S(.1),"^",4),SRFST=$P(S(.1),"^",5),SRTWO=$P(S(.1),"^",6) S:SRSUR'="" SRSUR=$P(^VA(200,SRSUR,0),"^")
 S:SRFST'="" SRFST=$P(^VA(200,SRFST,0),"^") S:SRTWO'="" SRTWO=$P(^VA(200,SRTWO,0),"^")
OPS K SROPERS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F  S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 K SROPS,MM,MMM S:$L(SROPER)<50 SROPS(1)=SROPER I $L(SROPER)>49 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SROT=0 I $D(^SRF(SRTN,.2)),$P(^(.2),"^",2)]"",$P(^(.2),"^",3)]"" S X=$P(^SRF(SRTN,.2),"^",2),X1=$P(^(.2),"^",3) D MINS^SRSUTL2 S SROT=X
 D TECH^SROPRIN
 S SRANES=$S($D(SRTECH):SRTECH,1:""),SRABORT=$S($P($G(^SRF(SRTN,30)),"^"):"*ABORTED*",1:"")
PRINT ;
 W !!,?1,$E(SROD,4,5)_"/"_$E(SROD,6,7)_"/"_$E(SROD,2,3),?13,$E(SRNM,1,26),?38,SROPS(1)
 W ?90,$E(SRSUR,1,23),?114,$E(SRANES,1,14),!,?1,SRTN,?13,VA("PID") W:$D(SROPS(2)) ?38,SROPS(2) W ?90,$E(SRFST,1,23),?114,SRIO,!,SRABORT
 W:'SRORD ?13,"(",$P(SRSS,"("),")" W:$D(SROPS(3)) ?38,SROPS(3) W ?90,$E(SRTWO,1,23),?114,SROT," MIN."
 I $D(SROPS(4)) W !,?38,SROPS(4) I $D(SROPS(5)) W !,?38,SROPS(5) I $D(SROPS(6)) W !,?38,SROPS(6)
 Q
LOOP ; break procedure if greater than 50 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<50  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
