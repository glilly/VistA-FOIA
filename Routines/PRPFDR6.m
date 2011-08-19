PRPFDR6 ;BAYPINES/MJE  VPFS DATA MIGRATION ROUTINE 6 ;05/15/03
 ;;3.0;PATIENT FUNDS DIAG V5.9;**15**;JUNE 1, 1989
 ;ENTRY AT LINETAG ONLY
 Q
XSUM1 ;THIS ENTRY POINT FOR SUMMARY INFO
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#33    RESTRCT AMT ER  Restrict Mnthly amount < weekly amt             "_CNTERR(33)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#34    MINIMUM BAL     Minimum balance #1 invalid or < $0 or > $99,999 "_CNTERR(34)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#35    MAXIMUM BAL     Maximum balance #1 invalid or < $0 or > $99,999 "_CNTERR(35)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#36    NO BALANCE REC  Balance record missing for account              "_CNTERR(36)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#37    INCOME PAYEE    Income payee blank, Income source present       "_CNTERR(37)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#38    INCOME AMOUNT   Income amount error, Income source present      "_CNTERR(38)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#39    INCOME AMOUNT   Income amount < $1 or > $99,999                 "_CNTERR(39)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#40    INCOME FREQCY   Income frequency not D,W,M,Y,X,V,O,Blank="_PRPFBC40_$P("      "," ",1,6-$L(PRPFBC40))_"  "_CNTERR(40)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#41    STATION ID      Station ID blank or unassigned                  "_CNTERR(41)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #42    STATION ID      Station ID invalid                              "_CNTERR(42)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#43    SUSPENSE DATE   Suspense date has invalid date                  "_CNTERR(43)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#44    SUSPENSE ID     Suspense ID has Invalid data                    "_CNTERR(44)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#45    SUSPENSE TEXT   Suspense text is < 1 or > 255 characters        "_CNTERR(45)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#46    DEFERRED TRANS  There are "_PRPFDEFR_" deferred transactions               "_PRPFDEFR
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#47    TRANSACTION REC Transaction record missing, blank or ID invalid "_CNTERR(47)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#48    PATIENT NAME    Patient name does not match deferred trans      "_CNTERR(48)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#49    PATIENT TRANS # Patient transaction # invalid                   "_CNTERR(49)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#50    DEFR AMOUNT     Deferred amount invalid                         "_CNTERR(50)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#51    TRANSACTN DATE  Transaction date Invalid                        "_CNTERR(51)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#52    DT TRAN ENTD    Date transaction entered Invalid                "_CNTERR(52)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#53    REFERENCE       Reference Invalid < 1 or > 10 in length         "_CNTERR(53)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#54    DEPOSIT/WTHDRWL Deposit/Withdrawal status Invalid               "_CNTERR(54)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#55    CASH/CHECK/OTR  Cash/Check/Other status Invalid                 "_CNTERR(55)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#56    SOURCE          Transaction source invalid                      "_CNTERR(56)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#57    FORM            Form does not match                             "_CNTERR(57)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#58    PRVT SOURCE AMT Private source amount invalid or < 0 or > 99999 "_CNTERR(58)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#59    GRATUITOUS AMT  Gratuitous amount invalid or < 0 or > 99999     "_CNTERR(59)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#60    PFUNDS CLERK    PFunds clerk invalid                            "_CNTERR(60)
 D SEG^PRPFDR3
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**************************************************************************#DETAIL#"
 D SEG^PRPFDR3
 Q
