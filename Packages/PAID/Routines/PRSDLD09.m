PRSDLD09 ;HISC/GWB-PAID INITIAL DOWNLOAD RECORD 9 LAYOUT ;7/8/93  15:42
 ;;4.0;PAID;**34**;Sep 21, 1995
 F CC=1:1 S FLD=$T(RECORD+CC) Q:FLD=""  D LDSET^PRSDSET
 Q
RECORD ;;Record 9;45
 ;;MGCKAD3;CHECK MAILING ADDRESS LINE 3;ADD;3;;;;;;183
 ;;MGCKZIP;CHECK MAILING ADDRESS ZIP CODE;ADD;4;D ZIP^PRSDUTIL;;;;;184
 ;;MGVALTNO;VOLUNTARY ALLOTMENT-2 CTRL NO;VALLOT;5;;;;;;439
 ;;MGVALAMT;VOLUNTARY ALLOTMENT-2 AMT;VALLOT;4;D SIGN^PRSDUTIL S DATA=+DATA;;;;;438
 ;;MGELOPCD;EARNINGS & LEAVE OPTION;ADD;5;;;;;;185
 ;;MLVCS6SB;VCS 601 COST ACCOUNT SUBCODE;VCS;6;D SIGN^PRSDUTIL;;;;;571
 ;;MLVCS301;VCS 301 COST ACCOUNT;VCS;1;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;566
 ;;MLVCS302;VCS 302 COST ACCOUNT;VCS;2;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;567
 ;;MLVCS303;VCS 303 COST ACCOUNT;VCS;3;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;568
 ;;MLVCS304;VCS 304 COST ACCOUNT;VCS;4;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;569
 ;;MLVCS701;VCS 701 COST ACCOUNT;VCS;7;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;572
 ;;MLVCS702;VCS 702 COST ACCOUNT;VCS;8;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;573
 ;;MLVCS703;VCS 703 COST ACCOUNT;VCS;9;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;574
 ;;MLVCS704;VCS 704 COST ACCOUNT;VCS;10;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;575
 ;;MLVCS706;VCS 706 COST ACCOUNT;VCS;11;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;576
 ;;MLVCS709;VCS 709 COST ACCOUNT;VCS;12;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;577
 ;;MLVCS601;VCS 601 COST ACCOUNT;VCS;5;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;570
 ;;MLLVLIB;VCS LEAVE LIABILITY;VCS;19;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;584
 ;;MLPLIFUN;VCS BASIC LIFE INS UNITS;VCS;15;D SIGN^PRSDUTIL S DATA=+DATA;;;;;580
 ;;MLPCOMM;VCS COMMISSION PERCENT;VCS;16;S L=3 D LZ^PRSDUTIL,SIGN^PRSDUTIL,DDD^PRSDUTIL;;;;;581
 ;;MLPHRRAT;VCS HRLY RATE FOR LEAVE/HOL;VCS;17;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;582
 ;;MLPOPTLI;VCS ADDNL OPTIONAL LIFE INS;VCS;13;D SIGN^PRSDUTIL S DATA=+DATA;;;;;578
 ;;MLCOMT-PP1;COMPTIME/CREDIT HRS PPD1 NAME;COMP;10;;;;;;497
 ;;MLCOMT-BAL1;COMPTIME/CREDIT HRS BAL PPD1;COMP;1;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;488
 ;;MLCOMT-PP2;COMPTIME/CREDIT HRS PPD2 NAME;COMP;11;;;;;;498
 ;;MLCOMT-BAL2;COMPTIME/CREDIT HRS BAL PPD2;COMP;2;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;489
 ;;MLCOMT-PP3;COMPTIME/CREDIT HRS PPD3 NAME;COMP;12;;;;;;499
 ;;MLCOMT-BAL3;COMPTIME/CREDIT HRS BAL PPD3;COMP;3;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;490
 ;;MLCOMT-PP4;COMPTIME/CREDIT HRS PPD4 NAME;COMP;13;;;;;;500
 ;;MLCOMT-BAL4;COMPTIME/CREDIT HRS BAL PPD4;COMP;4;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;491
 ;;MLCOMT-PP5;COMPTIME/CREDIT HRS PPD5 NAME;COMP;14;;;;;;501
 ;;MLCOMT-BAL5;COMPTIME/CREDIT HRS BAL PPD5;COMP;5;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;492
 ;;MLCOMT-PP6;COMPTIME/CREDIT HRS PPD6 NAME;COMP;15;;;;;;502
 ;;MLCOMT-BAL6;COMPTIME/CREDIT HRS BAL PPD6;COMP;6;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;493
 ;;MLCOMT-PP7;COMPTIME/CREDIT HRS PPD7 NAME;COMP;16;;;;;;503
 ;;MLCOMT-BAL7;COMPTIME/CREDIT HRS BAL PPD7;COMP;7;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;494
 ;;MLCOMT-PP8;COMPTIME/CREDIT HRS PPD8 NAME;COMP;17;;;;;;504
 ;;MLCOMT-BAL8;COMPTIME/CREDIT HRS BAL PPD8;COMP;8;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;495
 ;;MMPDMS1;MSD ACTION CODE-1;MSD1;1;S:DATA="D" DATA="";;;;;258
 ;;MMDTENT1;MSD DATE ENTERED MIL SVC-1;MSD1;10;D DATE^PRSDUTIL;;;;;267
 ;;MMDTSEP1;MSD DATE SEPARATED MIL SVC-1;MSD1;13;D DATE^PRSDUTIL;;;;;270
 ;;MMBRSV1;MSD BRANCH OF SERVICE-1;MSD1;7;;;;;;264
 ;;MMLOST1;MSD LOST TIME-1;MSD1;16;D SIGN^PRSDUTIL S DATA=+DATA;;;;;273
 ;;MMAMTDU1;MSD AMT DUE THIS PERIOD-1;MSD1;4;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;;;261
 ;;MMPDMS2;MSD ACTION CODE-2;MSD1;2;S:DATA="D" DATA="";;;;;259