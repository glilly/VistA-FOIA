MCARDNK ;WISC/TJK,JA-SCREEN INPUT - KILLS (@) ;5/2/96  12:58
 ;;2.3;Medicine;;09/13/1996
 I V(V)="" S X="" X DJCL W "No data entered",*7 Q
 I V(V)'="" S @$P(DJJ(V),U,2) X XY W DJHIN X XY W V(V),DJLIN
 ;I '$D(^DIC(DJDD,0,"DEL")) G KILL
 ;I DUZ(0)["@" G KILL
 ;I $D(^DD(DJDD,0,"DEL")),DUZ(0)[^DD(DJDD,0,"DEL") G KILL
 G KILL:$P(DJJ(V),U,3)'=.01,KILL:'$D(^DIC(DJDD,0,"DEL")) G KILL:DUZ(0)="@" I $D(^DIC(DJDD,0,"DEL")) G KILL:DUZ(0)[^("DEL")
 X DJCL W *7,DJHIN,"NOT ALLOWED TO DELETE",DJLIN S X=V(V) G HALT
KILL I $D(^DD(DJDD,DJAT,8.5)),DUZ(0)'[^(8.5),DUZ(0)'="@" X DJCL W *7,DJHIN,"NOT ALLOWED TO DELETE",DJLIN S X=V(V) G HALT
ILL I DJ4["R",$P(DJJ(V),U,3)'=.01 X DJCL W *7,DJHIN,"REQUIRED <NOTHING DELETED>",DJLIN S X=V(V) G HALT
 G N:$P(DJJ(V),U,3)'=.01
ILL1 X DJCL S DY=22,DX=0 X XY W DJEOP W *7,"SURE YOU WANT TO DELETE?: NO//" R X:DTIME
 I X["?" D HELP G ILL1
 I X["Y" X DJCP S DY=22,DX=0 X XY W DJEOP S DIE=DIC,DA=DJDN,DR=".01///@" D ^DIE G:'$D(DA) K S X=V(V) G HALT
 S X=V(V) G HALT
N X DJCP X DJCL
N1 S DY=22,DX=0 X XY W DJEOP
 W *7,"SURE YOU WANT TO DELETE?: NO//" R X:DTIME S:$G(X)="" X="N"
 I "Yy"[$G(X) X DJCP S DY=22,DX=0 X XY W DJEOP S DIE=DIC,DR=DJAT_"///@" D ^DIE S X=$S(X'="":V(V),1:"@") Q
 I X["?" D HELP G N1
 S X=V(V) Q
NXT S DJNN=$O(^DD(DJDD,DJAT,DJNN)) S:DJNN="" DJNN=-1 Q:DJNN<0  I $D(^(DJNN,2)) S X=V(V) X ^(2) S X="@" G NXT
 K DJDN Q
K I DJDPL'="DJ.DEF2" K V S V=0 G K1
 S V=5.9 F DJK=6:1:25 K V(DJK)
K1 F DJK=0:0 S V=$O(DJJ(V)) Q:V=""  S @$P(DJJ(V),U,2) X XY S $P(DJDB,".",DJJ(V))="." W DJDB K DJDB
 S V=0,X="@" K DJDN,DJK Q
HALT S YMLH=$O(^MCAR(697.3,DJN,1,"A",V,0)) S:YMLH="" YMLH=-1 I $D(^MCAR(697.3,DJN,1,YMLH,2)) R " Press <RETURN> to Continue",DJX:DTIME Q
 Q
HELP X DJCL W *7,"ANSWER 'YES' OR 'NO'--- RETURN TO CONTINUE " R X:DTIME Q
