%INDEX ;ISC/REL,GFT,GRK,RWF - INDEX & CROSS-REFERENCE ;08/11/94  13:29
 ;;7.3;TOOLKIT;;Apr 25, 1995
 G ^%INDX6
SEP F I=1:1 S CH=$E(LIN,I) D QUOTE:CH=Q Q:" "[CH
 S ARG=$E(LIN,1,I-1) S:CH=" " I=I+1 S LIN=$E(LIN,I,999) Q
QUOTE F I=I+1:1 S CH=$E(LIN,I) Q:CH=""!(CH=Q)
 Q:CH]""  S ERR=6 G ^%INDX1
ALIVE ;enter here from taskman
 D SETUP^%INDX6 ;Get ready to process
A2 S RTN=$O(^UTILITY($J,RTN)) G ^%INDX5:RTN="" S INDLC=(RTN?1"|"1.4L.NP) D LOAD:'INDLC,BEG G A2
 Q
LOAD S X=RTN,XCNP=0,DIF="^UTILITY("_$J_",1,RTN,0," X ^%ZOSF("TEST") Q:'$T  X ^%ZOSF("LOAD") S ^UTILITY($J,1,RTN,0,0)=XCNP-1
 Q
BEG I $D(ZTQUEUED),$$S^%ZTLOAD S RTN="~",IND("QUIT")=1,ZTSTOP=1 Q
 I 'INDDS,INDLC W !!?10,"Data Dictionaries",! S INDDS=1
 S %=INDLC*5 W:$X+1+%>IOM ! W RTN,$J("",10+%-$L(RTN)) S LC=^UTILITY($J,1,RTN,0,0)
 S LABO=0,LAB=$P($P(^UTILITY($J,1,RTN,0,1,0)," "),"(") I RTN'=LAB S ERR=17 D ^%INDX1
 I 'INDLC,LC>2,$P(^UTILITY($J,1,RTN,0,2,0)," ",2,99)'?1";;".E1N.E S ERR=44 D ^%INDX1
B5 S (IND("DO"),CCN)=0 F TXT=1:1:LC S LIN=^UTILITY($J,1,RTN,0,TXT,0),LN=$L(LIN),CCN=CCN+LN+2 D LN,ST
 S LAB="",LABO=0,^UTILITY($J,1,RTN,0)=CCN_"^"_LC I CCN>5000,'INDLC S ERR=35,ERR(1)=CCN D ^%INDX1
BC S LAB=$O(^UTILITY($J,1,RTN,"I",LAB)),L=LAB G:$E(L,1,2)="@(" BC I LAB="" Q
 S:$E(L,1,2)="$$" L=$E(L,3,99) G BC:L']"",BC:$D(^UTILITY($J,1,RTN,"T",$P(L,"+",1))) S ERR=14 D ^%INDX1 G BC
 ;Proccess one line.
LN K V S (GRB,IND("COM"))="",IND("DO1")=0 I $P(LIN," ",1)="" S LABO=LABO+1 G CD
 S X=$P(LIN," "),(IND("COM"),LAB)=$P(X,"("),GRB=$P($P(X,"(",2),")"),LABO=0,IND("PP")=X?1.8E1"(".E1")"
 I $D(^UTILITY($J,1,RTN,"T",LAB)) S ERR=15 D ^%INDX1 G CD
 S ^UTILITY($J,1,RTN,"T",LAB)="" I 'INDLC,'$$VT^%INDX2(LAB) S ERR=37 D ^%INDX1
CD S ERR=19 D:LN>245 ^%INDX1 S ERR=18 D:LIN'?1.ANP ^%INDX1
 S I=0,LIN=$P(LIN," ",2,999),IND("LCC")=1,ERR=42 G:LIN="" ^%INDX1 ;Watch the scope of I.
 I " ."[$E(LIN) D  S X=$L($E(LIN,1,I),".")-1,LIN=$E(LIN,I,999)
 . F I=1:1:245 Q:". "'[$E(LIN,I)
 . Q
 S:'I IND("DO")=0 I I S ERR=51 D:X>IND("DO") ^%INDX1 S IND("DO")=X
 ;Process commands on line.
EE I LIN="" D ^%INDX2 Q
 S COM=$E(LIN),GK="" I COM=";" S LIN="" G EE
 I COM=" " S ERR=$S(LIN?1." ":13,1:0),LIN=$E(LIN,2,999) S:ERR LIN="" D:ERR ^%INDX1 G EE
 D SEP
 S CM=$P(ARG,":",1),POST=$P(ARG,":",2,999),IND("COM")=IND("COM")_$C(9)_COM,ERR=48 D:ARG[":"&(POST']"") ^%INDX1 S:POST]"" GRB=GRB_$C(9)_POST,IND("COM")=IND("COM")_":"
 I CM?.E1L.E D CASE^%INDX52 S COM=$E(CM) I IND("LCC") S IND("LCC")=0,ERR=47 D ^%INDX1
 I "BCDEFGHIJKLNOQRSUVWXZ"'[COM S ERR=1 G ^%INDX1
 I $L(CM)>1,$E(CM)'="Z",$P($T(CMD),";;",2,999)'[(","_CM_",") S ERR=1 G ^%INDX1
 D SEP I '$L(LIN),CH=" " S ERR=13 D ^%INDX1 ;trailing space
 I ARG="","CGJORSUWX"[COM S ERR=49 G ^%INDX1
 D:"BCDEFGHJKLNOQRSUVWXZ"[COM @COM S:ARG'="" GRB=GRB_$C(9)_ARG G EE
B S ERR=25 G ^%INDX1
C S ERR=29 G ^%INDX1
D G DG1^%INDX4
E Q:ARG=""  S ERR=7 G ^%INDX1
F G:ARG]"" FR^%INDX4 Q
G G DG^%INDX4
H Q:ARG'=""  S ERR=32 G ^%INDX1
J S ERR=36,ARG="" G ^%INDX1
K S ERR=$S(ARG?1"(".E:22,ARG?." ":23,1:0) D:ERR ^%INDX1
 G KL^%INDX3
L G LO^%INDX4
N G NE^%INDX3
O S ERR=34 D ^%INDX1,O^%INDX3 Q
P Q
Q Q:ARG=""  G Q^%INDX4
R S RDTIME=0 G RD^%INDX3
S G S^%INDX3
U S ARG=$P(ARG,":") Q
V S ARG="",ERR=20 G ^%INDX1
W G WR^%INDX4
X G XE^%INDX4
Z S ERR=2 D ^%INDX1 G ZC^%INDX4
CMD ;;,BREAK,CLOSE,DO,ELSE,FOR,GOTO,HALT,HANG,IF,KILL,NEW,LOCK,OPEN,PRINT,QUIT,READ,SET,USE,VIEW,WRITE,XECUTE,
ST S R=LAB_$S(LABO:"+"_LABO,1:"")
 ;Local variable, Global, Marked Items, Naked global, Internal ref, eXternal ref., Tag ref.
 S LOC="" F  S LOC=$O(V(LOC)),S="" Q:LOC=""  F  S S=$O(V(LOC,S)) Q:S=""  D SET
 S ^UTILITY($J,1,RTN,"COM",TXT)=IND("COM") Q
SET S %=0
 I V(LOC,S)]"","!~"[V(LOC,S),$G(^UTILITY($J,1,RTN,LOC,S))'[V(LOC,S) S ^(S)=$G(^(S))_V(LOC,S)
SE2 S ARG=$G(^UTILITY($J,1,RTN,LOC,S,%)) I $L(ARG)>230 S %=%+1 G SE2
 S ^UTILITY($J,1,RTN,LOC,S,%)=ARG_R_V(LOC,S)_"," Q