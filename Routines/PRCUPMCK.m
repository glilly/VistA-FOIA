PRCUPMCK ;CTB/ALTOONA  TEST ROUTINE FOR PURGE MASTER ;10/8/93  12:02 PM
V ;;5.0;IFCAP;;4/21/95
 ;N ETIME
 S ETIME=($P($H,",",2)+120)
 F  Q:$P($H,",",2)>ETIME  H 10
