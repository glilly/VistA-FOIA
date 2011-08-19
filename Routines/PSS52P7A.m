PSS52P7A ;BIR/LDT - API FOR INFORMATION FROM FILE 52.7; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,91**;9/30/97
 ;
 ;
SETZERO ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(PSS52P7(52.7,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSS52P7(52.7,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),1)=$S($G(PSS52P7(52.7,PSS(1),1,"I"))="":"",1:PSS52P7(52.7,PSS(1),1,"I")_"^"_PSS52P7(52.7,PSS(1),1,"E"))
 S ^TMP($J,LIST,+PSS(1),2)=$G(PSS52P7(52.7,PSS(1),2,"I"))
 S ^TMP($J,LIST,+PSS(1),.02)=$G(PSS52P7(52.7,PSS(1),.02,"I"))
 S ^TMP($J,LIST,+PSS(1),7)=$G(PSS52P7(52.7,PSS(1),7,"I"))
 S ^TMP($J,LIST,+PSS(1),9)=$S($G(PSS52P7(52.7,PSS(1),9,"I"))="":"",1:PSS52P7(52.7,PSS(1),9,"I")_"^"_PSS52P7(52.7,PSS(1),9,"E"))
 S ^TMP($J,LIST,+PSS(1),17)=$S($G(PSS52P7(52.7,PSS(1),17,"I"))="":"",1:PSS52P7(52.7,PSS(1),17,"I")_"^"_PSS52P7(52.7,PSS(1),17,"E"))
 S ^TMP($J,LIST,+PSS(1),8)=$S($G(PSS52P7(52.7,PSS(1),8,"I"))="":"",1:PSS52P7(52.7,PSS(1),8,"I")_"^"_PSS52P7(52.7,PSS(1),8,"E"))
 Q
 ;
SETLTS ;
 S ^TMP($J,LIST,+PSSIEN,"ELYTES",+PSS(2),.01)=$S($G(PSS52P7(52.702,PSS(2),.01,"I"))="":"",1:PSS52P7(52.702,PSS(2),.01,"I")_"^"_PSS52P7(52.702,PSS(2),.01,"E"))
 S ^TMP($J,LIST,+PSSIEN,"ELYTES",+PSS(2),1)=$G(PSS52P7(52.702,PSS(2),1,"I"))
 Q
 ;
SETLOOK  ;
 S ^TMP($J,LIST,+PSS(1),.01)=$G(PSS52P7(52.7,PSS(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSS52P7(52.7,PSS(1),.01,"I")),+PSS(1))=""
 S ^TMP($J,LIST,+PSS(1),.02)=$G(PSS52P7(52.7,PSS(1),.02,"I"))
 S ^TMP($J,LIST,+PSS(1),2)=$G(PSS52P7(52.7,PSS(1),2,"I"))
 Q
 ;
LOOP(PSSLOOP) ;
 N CNT,PSSIEN S CNT=0
 S PSSIEN=0  F  S PSSIEN=$O(^PS(52.7,PSSIEN)) Q:'PSSIEN  D @(PSSLOOP)
 S ^TMP($J,LIST,0)=$S(CNT>1:CNT,1:"-1^NO DATA FOUND")
 Q
1 ;
 N CNT2
 I $G(PSSFL) S ND=$P($G(^PS(52.7,+PSSIEN,"I")),U) I ND,+ND'>PSSFL Q
 D GETS^DIQ(52.7,+PSSIEN,".01;1;2;.02;7;8;9;17","IE","PSS52P7") S PSS(1)=0
 F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  D SETZERO S CNT=CNT+1 D
 .K PSS52P7 D GETS^DIQ(52.7,+PSSIEN,"4*","IE","PSS52P7") S (PSS(2),CNT2)=0
 .F  S PSS(2)=$O(PSS52P7(52.702,PSS(2))) Q:'PSS(2)  D SETLTS S CNT2=CNT2+1
 .S ^TMP($J,LIST,+PSSIEN,"ELYTES",0)=$S(CNT2>0:CNT2,1:"-1^NO DATA FOUND")
 Q
 ;
2 ;
 K PSS52P7 D GETS^DIQ(52.7,+PSSIEN,".01;2;.02","IE","PSS52P7") S PSS(1)=0
 F  S PSS(1)=$O(PSS52P7(52.7,PSS(1))) Q:'PSS(1)  D SETLOOK S CNT=CNT+1
 Q
