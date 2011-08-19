OCXDI00S ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI00T
 ;
 Q
 ;
DATA ;
 ;
 ;;RSUM^34508.331^37078.341^39875.351^39857.351^48740.391^150.21^194.21^150.21^10323.181^150.21^1820.71^16632.221^17455.231^53162.411^137821.671^161224.741^223396.821^150.21^41185.361^21889.281^2339.81^194.21
 ;;RSUM^150.21^10352.181^150.21^3912.101^136073.661^47693.391^81770.511^50141.341^194.21^150.21^3703.111^150.21^28215.281^215980.811^123791.671^477992.1151^97455.551^22341.271^150.21^19100.251^150.21^82457.491
 ;;RSUM^150.21^28630.311^150.21^6518.141^150.21^5193.121^209640.811^1452.61^150.21^76556.471^150.21^3621.101^27666.311^59749.431^39855.351^38487.351^27043.291^12993.211^150.21
 ;;RND^OCXSEND1^8/04/98  13:21
 ;;RTN^OCXSEND2^8/04/98  13:21
 ;;RSUM^150.21^324.31^150.21^150.21^27360.281^150.21^65540.461^241264.881^65120.461^239464.881^150.21^87109.591^12120.201^59101.441^55643.431^273802.951^29219.311^257711.921^195162.801^11381.181^113962.611
 ;;RSUM^83909.531^145234.731^257069.861^68891.471^10491.191^141014.671^279971.981^141676.711^94196.541^63673.451^112887.591^150.21^194.21^150.21^57886.461^150.21^18233.241^150.21^20607.281^5711.131^25460.291
 ;;RSUM^15551.231^150.21^117156.631^179789.801^38297.361^20314.261^150.21^259609.971^59758.441^159348.721^150.21^194.21^150.21^28308.321^150.21^13339.201^11821.191^90522.541^150.21^44834.391^52529.431^77856.511
 ;;RSUM^704689.1551^7539.141^81381.491^69542.451^75662.481^91402.541^80986.511^73034.521^27198.261^31198.321^22973.271^21702.271^98723.581^48489.391^498.41^398016.1171^349919.1111^498.41^549535.1351^350433.1111
 ;;RSUM^498.41^150.21^194.21^13270.201^150.21^3932.101^76933.481^60715.431^18147.261^29321.321^28074.311^26392.301^26426.301^10962.201^482.41^150.21
 ;;RND^OCXSEND2^8/04/98  13:21
 ;;RTN^OCXSEND3^8/04/98  13:21
 ;;RSUM^150.21^1023.61^150.21^38997.321^120457.651^296199.971^106630.581^204121.791^71462.471^333925.1021^157692.701^150.21^4033.101^150.21^10987.181^150.21^16017.211^10424.171^54035.441^48697.411^48057.411
 ;;RSUM^45852.401^65716.471^11347.181^1182.61^9347.171^34644.301^7171.141^120457.651^1439.61^150.21^1467.71^3446.101^69828.461^56688.451^646.41^150.21^8671.161^150.21^33268.301^5255.121^12678.201^35262.331
 ;;RSUM^146271.681^150.21^361982.1091^150.21^26747.291^150.21^194.21^150.21^212769.821^150.21^101002.591^150.21^2605.91^110935.621^40274.391^642.41^150.21^1336.61^151058.641^6319.121^6330.121^750.51^1173.61
 ;;RSUM^750.51^11420.171^750.51^750.51^29813.291^204549.821^116474.621^750.51^5499.111^750.51^860.51^750.51^2670.91^533.41^150.21
 ;;RND^OCXSEND3^8/04/98  13:21
 ;;RTN^OCXSEND4^8/04/98  13:21
 ;;RSUM^150.21^1023.61^150.21^26864.271^71118.441^438550.1181^150.21^26747.291^150.21^103313.581^206761.801^150.21^1439.61^150.21^1336.61^161122.661^6319.121^6330.121^750.51^1173.61^750.51^860.51^750.51^19519.241
 ;;RSUM^750.51^10227.171^750.51^26114.271^750.51^53047.451^41281.371^750.51^118678.581^750.51^38845.371^4004.131^750.51^74134.491^10503.201^184705.751^27435.301^54509.411^750.51^2298.91^750.51^12086.191^750.51
 ;;RSUM^92175.531^750.51^4085.111^750.51^53823.371^120861.611^44352.371^364178.1071^860.51^750.51^34593.321^750.51^57917.411^35084.321^104201.581^317039.931^367962.1051^395159.1071^6498.151^16212.221^157799.701
 ;;RSUM^336207.1061^750.51^2781.91^750.51^24827.271^750.51^180987.801^1912.81^750.51^14718.211^64707.471^60074.431^201203.841^474778.1251^373535.1101^7276.161^118668.641^3300.101^750.51^23174.271^750.51^25263.311
 ;;RSUM^8378.161^30803.321^19769.261^750.51^140705.681^148062.701^25174.291^750.51^275887.1001^68122.471^172302.751^750.51^860.51^750.51^34002.351^750.51^17545.231^129308.651^860.51^750.51^86291.511^750.51
 ;;RSUM^361684.1111^750.51^471.41^533.41^150.21
 ;;RND^OCXSEND4^8/04/98  13:21
 ;;RTN^OCXSEND5^8/04/98  13:21
 ;;RSUM^150.21^1023.61^150.21^26864.271^71118.441^438550.1181^150.21^26747.291^150.21^103370.581^206761.801^150.21^1439.61^150.21^1336.61^161131.661^6319.121^6330.121^750.51^1173.61^750.51^860.51^750.51^750.51
 ;;RSUM^9162.171^750.51^8751.181^750.51^50140.411^750.51^109348.611^750.51^1388.71^750.51^5357.131^750.51^7290.141^5053.121^146339.701^4501.121^44015.401^33054.331^14640.201^74767.521^594186.1311^25868.271
 ;;RSUM^243914.811^34676.321^10594.181^5771.141^121385.631^750.51^3796.101^750.51^14575.211^750.51^42182.341^119674.631^750.51^222544.841^26865.291^21339.261^251781.881^103528.521^84205.491^251739.881^94360.501
 ;1;
 ;
