SPNPRTAR ;HIRMFO/WAA- PRINT ADHOC REGISTRY ; 8/21/96
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
 ;This routines is to store ADHOC REGISTRY into a file.
 ; 
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE S SPNPAGE=1
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 D PRINT
 D EXIT
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 Q
PRINT ; Print main Body
 D ^SPNADR ; Adhoc Report Generator for Registry 
 Q
