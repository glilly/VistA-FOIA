RMPFES ;DDC/KAW-ENTER/EDIT STATION ORDERS; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
SELECT S RMPFP="*",(RMPFORD,RMPFTP)="S" D ^RMPFDS1 K RMPFX G ADD:'RMPFCX
 D SEL^RMPFET G END:$D(RMPFOUT),END:RMPFSEL1="",ADD:"Aa"[RMPFSEL1,RMPFSET:'$D(RMPFX)
ADDEDIT S RMPFEDIT="" D ^RMPFDT1 G END:$D(RMPFOUT)
 S RMPFST=$P(^RMPF(791810,RMPFX,0),U,3)
 D ^RMPFET0 G END:$D(RMPFOUT) I $D(RMPFSEL),RMPFSEL="E" G ADD
 I $D(RMPFSEL),"Dd"[RMPFSEL G SELECT
 G ADDEDIT:$D(RMPFSEL)!$D(RMPFQUT),SELECT:'$D(RMPFX)
ADD D ^RMPFET1 G END:$D(RMPFOUT),END:'$D(RMPFX),ADDEDIT
END K RMPFP,RMPFORD,RMPFTP,RMPFX,RMPFOUT,RMPFO,RMPFEDIT,RMPFHAT
 K RMPFQUT,DFN,RMPFNAM,POP,T,DIC,RMPFCX,S1,ZY,X,Y,I,L Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
CONT F I=1:1 Q:$Y>21  W !
CONT1 W !!,"Enter <RETURN> to continue"
 I $O(^RMPF(791810,RMPFX,201,0)) W ", <M>essages"
 W " or <^> to exit: " D READ
 G CONT1:$D(RMPFQUT) Q:Y=""  G CONT1:"^Mm"'[Y
 Q
HEAD W @IOF,!!?18,"REMOTE ORDER/ENTRY STATION ORDER INFORMATION"
 W !,"Station: ",RMPFSTAP,?68,RMPFDAT
 W ! F I=1:1:80 W "-"
 Q