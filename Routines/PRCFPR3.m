PRCFPR3 ;WISC/LDB-QUEUED PRINT OF STACK DOCUMENTS ;8/7/92  2:16 PM [ 08/07/92  3:32 PM ]
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DQ ;Called from PRCFA STACK DOCUMENTS PRINT option to print entries
 ;in file 421.8 by date as background job
 D DT^DICRW,NOW^%DTC S U="^",PRCDT=+$E(%,1,12)
 I ALL S DATE1=DATE1-.0001 F  S DATE1=$O(^PRC(421.8,"AB",TYPE,DATE1)) Q:'DATE1!(DATE1>(DATE2+.9999))  S PRCD0=0 F  S PRCD0=$O(^PRC(421.8,"AB",TYPE,DATE1,PRCD0)) Q:'PRCD0  D
 .S PRCDA=0 F  S PRCDA=$O(^PRC(421.8,"AB",TYPE,DATE1,PRCD0,PRCDA)) Q:'PRCDA  D:$S(PRNT:1,'PRNT&'$P($G(^PRC(421.8,PRCDA,0)),U,7):1,1:"") PROC
 I 'ALL S PRCD0=0 F  S PRCD0=$O(^TMP("PRCREC",$J,PRCD0)) Q:'PRCD0  S PRCDA=0 F  S PRCDA=$O(^TMP("PRCREC",$J,PRCD0,PRCDA)) Q:'PRCDA  D PROC
 K ALL,PRCDA,PRCD0,PRCHNRQ,RTN,TYPE,VAR,^TMP("PRCREC",$J) Q
PROC S VAR=0 F  S VAR=$O(^PRC(421.8,PRCDA,1,VAR)) Q:'VAR  I $P($G(^(VAR,0)),U)'="",$P(^(0),U)'="DUZ" S @$P(^(0),U)=$P(^(0),U,2)
 S RTN=$TR($P(^PRC(421.8,PRCDA,0),"^",3),"*","^")
 I $D(PRCHXXD1) S D1=PRCHXXD1
 N DATE1,DATE2,TYPE,ALL S D0=PRCD0 N PRCD0
 D @RTN K PRCHNRQ,D0,D1,DA
 S DA=PRCDA,DIE="^PRC(421.8,",DR="8////^S X=PRCDT" D ^DIE
 S VAR=0 F  S VAR=$O(^PRC(421.8,PRCDA,1,VAR)) Q:'VAR  I $P($G(^(VAR,0)),U)'="",$P(^(0),U)'="DUZ" K @($P($G(^(0)),U))
END Q
