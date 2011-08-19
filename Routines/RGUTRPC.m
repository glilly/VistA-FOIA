RGUTRPC ;CAIRO/DKM - RPC Encapsulations for RGUT routines ;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; RGUTDIC
DIC(RGDATA,RGBM,RGCMD,RGARG) ;
 S RGDATA(0)=$$ENTRY^RGUTDIC(RGBM,RGCMD)
 Q
 ; RGUTSTX
MSYNTAX(RGDATA,RGCODE,RGOPT) ;
 S RGDATA=$$ENTRY^RGUTSTX(RGCODE,.RGOPT)
 Q
 ; Show all entries for a file
FILENT(RGDATA,RGGBL) ;
 N RGZ,RGC
 S:RGGBL=+RGGBL RGGBL=$$ROOT^DILFD(RGGBL,,1)
 S RGC=0,RGDATA=$$TMPGBL^RGCODRPC
 F RGZ=0:0 S RGZ=$O(@RGGBL@(RGZ)) Q:'RGZ  D
 .S @RGDATA@(RGC)=RGZ_U_$P(@RGGBL@(RGZ,0),U),RGC=RGC+1
 Q
 ; Show IEN of next/previous entry in a file
FILNXT(RGDATA,RGGBL,RGIEN) ;
 N RGD
 S:RGGBL=+RGGBL RGGBL=$$ROOT^DILFD(RGGBL,,1)
 I RGIEN<0 S RGIEN=-RGIEN,RGD=-1
 E  S RGD=1
 S RGDATA=+$O(@RGGBL@(RGIEN),RGD)
 Q
