ICDTLB3 ;ALB/EG - GROUPER UTILITY FUNCTIONS ; 9/29/04 3:38pm
 ;;18.0;DRG Grouper;**14**;Oct 20, 2000
DRG164 S ICDRG=$S(ICDPD["X"&(ICDCC):164,ICDPD["X":165,ICDCC:166,1:167) Q
DRG165 S ICDRG=$S(ICDPD["X"&(ICDCC):164,ICDPD["X":165,ICDCC:166,1:167) Q
DRG166 S ICDRG=$S(ICDPD["X"&(ICDCC):164,ICDPD["X":165,ICDCC:166,1:167) Q
DRG167 S ICDRG=$S(ICDPD["X"&(ICDCC):164,ICDPD["X":165,ICDCC:166,1:167) Q
DRG168 S ICDRG=$S(ICDCC:168,1:169) Q
DRG169 S ICDRG=$S(ICDCC:168,1:169) Q
DRG170 S ICDRG=$S(ICDCC:170,1:171) Q
DRG171 S ICDRG=$S(ICDCC:170,1:171) Q
DRG172 S ICDRG=$S(ICDCC:172,1:173) Q
DRG173 S ICDRG=$S(ICDCC:172,1:173) Q
DRG174 S ICDRG=$S(ICDCC:174,1:175) Q
DRG175 S ICDRG=$S(ICDCC:174,1:175) Q
DRG177 S ICDRG=$S(ICDCC:177,1:178) Q
DRG178 S ICDRG=$S(ICDCC:177,1:178) Q
DRG180 S ICDRG=$S(ICDCC:180,1:181) Q
DRG181 S ICDRG=$S(ICDCC:180,1:181) Q
DRG182 S ICDRG=$S(AGE<18:184,ICDCC:182,1:183) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG183 S ICDRG=$S(AGE<18:184,ICDCC:182,1:183) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG184 S ICDRG=$S(AGE<18:184,ICDCC:182,1:183) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG185 S ICDRG=$S(ICDOR["e":187,AGE="":470,AGE<18:186,1:185),ICDRTC=$S(ICDRG=470:3,1:ICDRTC) Q
DRG186 S ICDRG=$S(ICDOR["e":187,AGE="":470,AGE<18:186,1:185),ICDRTC=$S(ICDRG=470:3,1:ICDRTC) Q
DRG187 S ICDRG=$S($D(ICDPDRG(187)):187,$D(ICDPDRG):ICDPDRG,1:"")
 I ICDRG?.N&(+ICDRG>0) Q
 I +ICDRG=0 S ICDRG=470 Q
 S ICDREF=$$RTABLE^ICDREF(+ICDRG,+ICDDATE)
 I ICDRG["^"&($D(ICDREF)) X "D DRG"_+ICDRG_"^"_^ICDREF Q
 S ICDRG=+ICDPDRG
 Q
DRG188 S ICDRG=$S(AGE<18:190,ICDCC:188,1:189) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG189 S ICDRG=$S(AGE<18:190,ICDCC:188,1:189) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG190 S ICDRG=$S(AGE<18:190,ICDCC:188,1:189) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG191 S ICDRG=$S(ICDCC:191,1:192) Q
DRG192 S ICDRG=$S(ICDCC:191,1:192) Q
DRG193 ;
 I ICDOR["T"&(ICDOR'["3"!(ICDOR'["h")) D  Q:"195^196^197^198"[ICDRG
 .I ICDOR["E" S ICDRG=$S(ICDCC:195,1:196) Q
 .I ICDOR'["E" S ICDRG=$S(ICDCC:197,1:198)
 I ICDOR["3"!(ICDOR["E") S ICDRG=$S(ICDCC:193,1:194) Q
 I ICDPD["M"&(ICDOR["h") S ICDRG=199 Q
 I ICDPD'["M"&(ICDOR["h") S ICDRG=200 Q
 I ICDPD["M"&(ICDOR'["h") S ICDRG=203 Q
 S ICDRG=204
 Q
DRG194 D DRG193 Q
DRG195 G:ICDOR["TT" DRG493^ICDTLB6 D DRG193 Q
DRG196 D DRG193 Q
DRG197 S ICDRG=$S(ICDCC:197,1:198) Q
DRG198 S ICDRG=$S(ICDCC:197,1:198) Q
DRG199 D DRG193 Q
DRG200 D DRG193 Q
DRG205 S ICDRG=$S(ICDCC:205,1:206) Q
DRG206 S ICDRG=$S(ICDCC:205,1:206) Q
DRG207 S ICDRG=$S(ICDCC:207,1:208) Q
DRG208 S ICDRG=$S(ICDCC:207,1:208) Q
DRG209 S ICDRG=$S($F($P(ICDOR,"M",2,99),"M"):471,1:209) Q
DRG210 S ICDRG=$S(AGE<18:212,ICDCC:210,1:211) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG211 S ICDRG=$S(AGE<18:212,ICDCC:210,1:211) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG212 S ICDRG=$S(AGE<18:212,ICDCC:210,1:211) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG214 Q
DRG215 Q
DRG218 S ICDRG=$S(AGE<18:220,ICDCC:218,1:219) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG219 S ICDRG=$S(AGE<18:220,ICDCC:218,1:219) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG220 S ICDRG=$S(AGE<18:220,ICDCC:218,1:219) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG221 Q
DRG222 Q
DRG224 S ICDRG=$S(ICDCC:223,1:224) Q
DRG226 S ICDRG=$S(ICDCC:226,1:227) Q
DRG227 S ICDRG=$S(ICDCC:226,1:227) Q
DRG228 S ICDRG=$S(ICDOR["O2":228,ICDCC:228,1:229) Q
DRG229 S ICDRG=$S(ICDOR["O2":228,ICDCC:228,1:229) Q
DRG232 S ICDRG=232 Q
DRG233 S ICDRG=$S(ICDCC:233,1:234) Q
DRG234 S ICDRG=$S(ICDCC:233,1:234) Q
DRG240 S ICDRG=$S(ICDCC:240,1:241) Q
DRG241 S ICDRG=$S(ICDCC:240,1:241) Q
DRG244 S ICDRG=$S(ICDCC:244,1:245) Q
DRG245 S ICDRG=$S(ICDCC:244,1:245) Q
DRG250 S ICDRG=$S(AGE<18:252,ICDCC:250,1:251) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG251 S ICDRG=$S(AGE<18:252,ICDCC:250,1:251) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG252 S ICDRG=$S(AGE<18:252,ICDCC:250,1:251) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG253 S ICDRG=$S(AGE<18:255,ICDCC:253,1:254) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG254 S ICDRG=$S(AGE<18:255,ICDCC:253,1:254) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG255 S ICDRG=$S(AGE<18:255,ICDCC:253,1:254) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG257 I ICDOR'=""&(ICDOR["M") D
 .S ICDRG=$S(ICDPD["r"&(ICDCC):257,ICDSD["r"&(ICDCC):257,ICDPD["r":258,ICDSD["r":258,1:"")
 S:ICDRG="" ICDRG=261
 Q
DRG258 D DRG257 Q
DRG259 I ICDOR'=""&(ICDOR["m") D
 .S ICDRG=$S(ICDPD["r"&(ICDCC):259,ICDSD["r"&(ICDCC):259,ICDPD["r":260,ICDSD["r":260,ICDOR["L":262,1:"")
 .I $D(ICDOP("85.12 "))!$D(ICDOP("85.20 "))!$D(ICDOP("85.21 ")) S ICDRG=262
 S:ICDRG="" ICDRG=261
 Q
DRG260 D DRG259 Q
DRG262 D DRG259 Q
