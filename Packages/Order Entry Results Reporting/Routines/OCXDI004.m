OCXDI004 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI005
 ;
 Q
 ;
DATA ;
 ;
 ;;RSUM^32723.311^6732.141^14263.201^14904.201^16691.211^28324.281^14912.201^11235.171^25095.261^20482.241^14920.201^11243.171^15322.211^12736.181^14937.201^24666.261^16506.211^18963.231^9521.161^11009.171
 ;;RSUM^25201.261^14980.201^18647.231^16730.211^14970.201^36863.321^25199.261^14987.201^24306.261^16746.211^33661.301^45092.351^13409.191^11299.171^34771.311^22466.251^14918.201^533.41^150.21
 ;;RND^OCXBDTD^8/04/98  13:21
 ;;RTN^OCXDEBUG^10/29/98  12:37
 ;;RSUM^150.21^2237.81^150.21^7552.141^150.21^152205.631^150.21^15336.221^351280.1051^77151.501^150.21^435701.1111^194.21^150.21^243293.801^150.21^147358.611^150.21^9729.171^31485.301^150.21^152205.631^33858.321
 ;;RSUM^150.21^434.41^45912.381^50632.421^15336.221^351280.1051^77151.501^150.21^10805.171^66148.411^64767.411^66224.441^239398.861^48953.371^2540.81^18614.231^194.21^150.21^2386.81^6872.141^133228.611^91284.561
 ;;RSUM^121325.631^151077.701^117908.651^156072.741^167805.711^968.61^194.21^150.21^38325.331^150.21^129564.641^150.21^12970.191^150.21^25040.271^150.21^53472.421^150.21^6168.131^76927.511^14376.221^24248.291
 ;;RSUM^150.21^25657.301^17652.231^18539.231^5572.121^97325.571^7577.141^23301.291^28129.301^100277.571^12275.191^59384.411^7366.151^876.61^121031.611^53416.391^43530.371^17074.221^150.21^28206.311^43522.351
 ;;RSUM^97325.571^43387.371^42748.391^41841.381^7366.151^43604.351^43530.371^150.21^28537.311^33296.301^97325.571^43387.371^42748.391^41841.381^7366.151^83728.491^43530.371^150.21^28559.311^19586.231^97325.571
 ;;RSUM^43387.371^42748.391^41841.381^7366.151^61352.421^43530.371^194.21^150.21^8652.161^150.21^3621.101^34463.331^34810.341^11833.211^113657.661^5734.131^6442.151^150.21^4051.111^3749.101^1882.71^50506.411
 ;;RSUM^114970.621^294070.1001^194.21^150.21^145326.641^150.21^16396.211^25720.251^105677.471^87613.441^193475.631^128792.511^62263.361^139294.541^150.21^300312.981^150.21^194.21^150.21^33701.311^57533.391
 ;;RSUM^11108.191^7863.151^30831.311^30899.311^29883.321^1992.71^70433.471^646.41^150.21^1251.61^150.21^61292.411^150.21^120108.631^36843.341^32923.331^17809.251^28340.321^115224.651^48786.391^23636.291^17836.251
 ;;RSUM^28367.321^115351.651^39670.351^62390.411^49549.391^150.21^124313.541^99289.571^18689.251^35017.291^33359.331^283238.891^150.21^194.21^150.21
 ;;RND^OCXDEBUG^10/29/98  12:37
 ;;RTN^OCXF20^10/29/98  12:37
 ;;RSUM^194.21^150.21^150.21^28801.291^150.21^111230.621^150.21^24680.271^150.21^111126.621^150.21^16695.221^150.21^111178.621^150.21^61183.421^150.21^90266.591^150.21^82954.521^150.21^61365.421^150.21^90266.591
 ;;RSUM^150.21^80315.511^150.21
 ;;RND^OCXF20^10/29/98  12:37
 ;;RTN^OCXF21^10/29/98  12:37
 ;;RSUM^194.21^150.21^150.21^150.21^27960.291^150.21^104216.571^150.21^31912.311^150.21^95969.551^150.21^17246.231^150.21^79231.501^150.21^82835.491^150.21^237348.861^150.21^83029.491^150.21^237824.861^150.21
 ;;RND^OCXF21^10/29/98  12:37
 ;;RTN^OCXF22^10/29/98  12:37
 ;;RSUM^194.21^150.21^150.21^1990.81^20915.291^5811.141^150.21^58792.411^150.21^205623.841^150.21^46788.371^150.21^378528.1141^150.21^45606.361^150.21^111282.621^150.21^150.21^47535.371^150.21^112738.621^150.21
 ;;RSUM^94749.521^150.21^112734.621^150.21^150.21^99339.531^150.21^112842.621^150.21^84536.491^150.21^111178.621^150.21^118406.581^150.21^145393.701^150.21^117413.581^150.21^114123.631^150.21^82913.491^150.21
 ;;RSUM^90266.591^150.21^94393.551^150.21^83143.491^150.21^90266.591^150.21^90209.541^150.21^49594.401^150.21^102121.541^150.21^40291.361^150.21^91003.511^150.21^42685.371^150.21^77851.471^150.21^37884.351
 ;;RSUM^150.21^114095.571^150.21^60371.441^150.21^114373.571^150.21^60417.441^150.21^125048.611^150.21^28956.301^150.21^118554.591^150.21^30992.311^150.21
 ;;RND^OCXF22^10/29/98  12:37
 ;;RTN^OCXF23^10/29/98  12:37
 ;;RSUM^194.21^150.21^150.21^5950.141^150.21^92804.581^150.21^5135.131^150.21^92559.581^150.21^3072.101^150.21^29081.331^150.21^3743.111^150.21^27603.321^150.21^4449.121^150.21^29081.331^150.21
 ;;RND^OCXF23^10/29/98  12:37
 ;;RTN^OCXFMGR^8/04/98  16:08
 ;;RSUM^194.21^150.21^4550.131^150.21
 ;;RND^OCXFMGR^8/04/98  16:08
 ;;RTN^OCXGENE^3/1/99  12:37
 ;;RSUM^150.21^150.21^194.21^37864.331^150.21^11918.171^27492.331^19228.241^51762.381^194.21^33183.311^150.21^19599.221^27492.331^4773.121^51762.381^93867.501^127853.621^15376.241^194.21^150.21^45587.361^150.21
 ;1;
 ;