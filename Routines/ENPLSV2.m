ENPLSV2 ;WISC/SAB-PROJECT COMMUNICATION SERVER (CONTINUED) ;5/26/94
 ;;7.0;ENGINEERING;**11**;Aug 17, 1993
A ;
 L:$G(ENDA)>0 -^ENG("PROJ",ENDA)
 S ENPACT=$P(ENREC,U,2)
 S ENPNBR=$P(ENREC,U,3)
 S ENPTTL=$P(ENREC,U,4)
 ; find project entry
 S DIC=6925,DIC(0)="X",X=ENPNBR D ^DIC S ENDA=+Y L:Y>0 +^ENG("PROJ",ENDA)
 Q
B ;
 S ENPDA1=$P(ENREC,U,2)
 S ENPTI1=$P(ENREC,U,3)
 I ENCTZD'=0 D
 . S ENDT=$$FMADD^XLFDT(ENPDA1-17000000_"."_ENPTI1,"",ENCTZD)
 . S ENPDA1=$P(ENDT,".",1)+17000000
 . S ENPTI1=$P(ENDT,".",2)_$E("000000",1,6-$L($P(ENDT,".",2)))
 S ENPDA2=$P(ENREC,U,4)
 S ENPTI2=$P(ENREC,U,5)
 I ENCTZD'=0 D
 . S ENDT=$$FMADD^XLFDT(ENPDA2-17000000_"."_ENPTI2,"",ENCTZD)
 . S ENPDA2=$P(ENDT,".",1)+17000000
 . S ENPTI2=$P(ENDT,".",2)_$E("000000",1,6-$L($P(ENDT,".",2)))
 S ENPSTA=$P(ENREC,U,6)
 S ENPREV=$P(ENREC,U,7)
 D @(ENRSEG_ENCTYPE_"^ENPLSV3")
 Q
C ;
 S ENPCOM=$P(ENREC,U,5)
 D @(ENRSEG_ENCTYPE)
 Q
CATH ;
 Q
CCON ;
 ; update communication log
 I ENDA>0 D
 .K ENTXT S ENTXT(1)=$E(ENBLANK,1,16)_"because "_ENPCOM
 .D POSTCL^ENPLUTL(ENDA,"ENTXT",0) K ENTXT
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=$E(ENBLANK,1,48)_ENPCOM
 Q
CNVI ;
 ; update communication log
 I ENDA>0 D
 .K ENTXT S ENTXT(1)=$E(ENBLANK,1,16)_ENPCOM
 .D POSTCL^ENPLUTL(ENDA,"ENTXT",0) K ENTXT
 ; update mail message 
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENPCOM
 Q
CRET ;
 ; update communication log
 I ENDA>0 D
 .K ENTXT S ENTXT(1)=$E(ENBLANK,1,16)_ENPCOM
 .D POSTCL^ENPLUTL(ENDA,"ENTXT",0) K ENTXT
 ; update mail message 
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENPCOM
 Q
CDIS ;
 I ENDA>0 D
 .K ENTXT S ENTXT(1)=$E(ENBLANK,1,16)_ENPCOM
 .D POSTCL^ENPLUTL(ENDA,"ENTXT",0) K ENTXT
 ; update mail message
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=$E(ENBLANK,1,13)_ENPCOM
 Q
CSUM ;
 Q
D ;
 D DATH^ENPLSV4
 Q
 ;ENPLSV2
