TIUFLP ;SLC/AJB - Print Form Letter Progress Notes ;06Mar07
 ;;1.0;TEXT INTEGRATION UTILITIES;**222**;Jun 20, 1997
DEVICE(TIUFLAG,TIUSPG) ; pick your device
 K IOP S %ZIS="Q" D ^%ZIS I POP K POP G EXIT
 I $D(IO("Q")) K IO("Q") D  G EXIT
 .S ZTRTN="ENTRY1^TIUFLP",ZTSAVE("^TMP(""TIUPR"",$J,")=""
 .S ZTDESC="TIU FORM LETTER PRINT"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .D HOME^%ZIS
 U IO D ENTRY1,^%ZISC
 Q
ENTRY ;
 N TIUSPG
 U IO
ENTRY1 ; Entry point from above
 N TIUERR,D0,DN,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K ^TMP("TIULQ",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 D PRINT^TIUFLP1
EXIT K ^TMP("TIULQ",$J),^TMP("TIUPR",$J)
 Q
