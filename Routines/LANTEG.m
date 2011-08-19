LANTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;OCT 25, 1994@16:19:45
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;;7.2;OCT 25, 1994@16:19:45
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 G CONT^LANTEG0
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
LA1103 ;;2783225
LAABL3 ;;2008068
LAABL500 ;;2175200
LAACA ;;2620189
LAACA4 ;;2267008
LAAIMX ;;2663037
LAALTA ;;2228642
LAASTRA ;;2584890
LAB ;;4398199
LABALARM ;;1650198
LABCX4B ;;4898600
LABCX4D ;;13092397
LABCX4H ;;2806099
LABCX4I ;;1686962
LABCX4XX ;;9649352
LABERR ;;6644019
LABERRP ;;8870102
LABINIT ;;1234544
LABIOH ;;3367777
LABIOU ;;2914334
LABITKU ;;2821318
LABL330 ;;1722719
LABMD87P ;;2175579
LABTEST ;;5613373
LAC178 ;;1540695
LAC178HP ;;1853069
LACBIO ;;2148068
LACCHEM6 ;;2097015
LACEL8E ;;2264233
LACFARA ;;2918540
LACHEM1 ;;2717606
LACL5500 ;;1539985
LACLNTE ;;1552893
LACLNTEK ;;1673253
LACLT200 ;;1551991
LACLT20P ;;1474233
LACMIRA ;;3311054
LACMIRAS ;;3312103
LACOAGX2 ;;5672263
LACOARA4 ;;1951210
LACOLT ;;2545954
LACOLT1 ;;2654404
LACOLT2 ;;2836496
LACOLT24 ;;1802705
LACOLT3 ;;2164064
LACOLT5 ;;2323809
LACOLT6 ;;2256792
LACOLTSE ;;2430777
LACOLTSS ;;2715542
LACRIT ;;1736540
LACTDMS ;;1465520
LADACOS ;;2166624
LADEKT7B ;;4967221
LADIMD ;;6103418
LADIMPI ;;1405264
LADIMPXX ;;8026120
LADJOB ;;8760268
LADKERM2 ;;1726176
LADKERM3 ;;2978971
LADKERMI ;;6011628
LADMND ;;3072669
LADOWN ;;9920580
LADOWN1 ;;1202585
LAE4A ;;2248577
LAEKT4 ;;2208086
LAEKT7 ;;3350851
LAEKT7B ;;4892440
LAEKT7D ;;4868873
LAEKT7P ;;1708897
LAELT ;;1407224
LAELT8D ;;1959164
LAEPXD ;;6684633
LAEPXPXX ;;2943031
LAERA ;;2063732
LAEXEC ;;2382145
LAFARA2 ;;1982181
LAFUNC ;;8102106
LAGEN ;;8938687
LAH1 ;;1891499
LAH480 ;;1867912
LAH6K ;;1615361
LAH705 ;;2274079
LAH717D ;;3491011
LAH717H ;;1408129
LAH717U ;;3049965
LAH737 ;;2103160
LAH747 ;;4392886
LAHLOG ;;2059494
LAHT1K ;;3366699
LAHT1KD ;;4182105
LAHTCCA ;;3313807
LAHTCCAD ;;7101782
LAHTCCAH ;;1445957
LAHTRK ;;4972157
LAHWATCH ;;9397067
LAJOB ;;9221165
LAJOB1 ;;1554580
LAKDA ;;1509851
LAKDIFF ;;9316350
LAKDIFF1 ;;8917764
LAKDIFF2 ;;9640378
LAKDIFF3 ;;2515859
LAKERM2 ;;1880826
LAKERM3 ;;2978413
LAKERMIT ;;6324167
LAKOAG40 ;;2868887
LAKUR ;;9165972
LAKUR1 ;;9779892
LAL13 ;;1439802
LAL1306 ;;1467621
LAL1312 ;;3502635
LAL508 ;;2285737
LAL943 ;;2023211
LALBG3 ;;2249849
LAMIAUT0 ;;16381256
LAMIAUT1 ;;10322419
LAMIAUT2 ;;8411115
LAMIAUT3 ;;10479359
LAMIAUT4 ;;12090481
LAMIAUT5 ;;3703164
LAMIAUT6 ;;10716148
LAMIAUT7 ;;13571379
LAMIAUT8 ;;10268917
LAMICRA ;;6240705
LAMILL ;;8873545
LAMIV00 ;;5791650
LAMIV10 ;;3260019
LAMIV11 ;;4758588
LAMIV12 ;;3536770
LAMIVT5 ;;6911163
LAMIVT6 ;;6905221
LAMIVTE6 ;;6926973
LAMIVTK ;;6713826
LAMIVTK6 ;;7014176
LAMIVTKC ;;3923165
LAMIVTKD ;;13170264
LAMIVTKU ;;6973867
LAMLA1KC ;;3053010
LAMLA7 ;;1570534
LAMODH ;;3388022
LAMODU ;;3723782
LAMODUT ;;2139931
LAMONARK ;;2238324
LAMSA ;;6011981
LAMSA1 ;;3554365
LAMSBLD ;;3663195
LAMSD ;;7874896
LAMSP ;;621129
LAMSPAN ;;1767497
LAMSTAT ;;2048832
LANOVA ;;1641181
LANOVST ;;1777132
LAPARA ;;1995628
LAPARAP ;;2803252
LAPER ;;2505784
LAPERD ;;3756688
LAPFICH ;;4040500
LAPMAX ;;2197178
LAPMAXD ;;6347878
LAPORTXX ;;4413930
LAPX ;;1763878
LARA1K ;;1874527
