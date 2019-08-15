1000 ' MML Player
1010 ' 2019/05/09 kumagai 実装開始
1020 ' 2019/07/05 kumagai 実機上でデバッグ
1030 ' 2019/08/15 kumagai 文字列定義を実装
1040 ' ------------------------------------------------------------------------
1050 ' 【概要】
1060 ' 指定のファイルの音楽データを再生する。
1070 '
1080 ' 【データ形式】
1090 ' ファイルの形式は以下の通り。
1100 '
1110 ' [コマンド]
1120 ' [データ]
1130 ' 　　：
1140 ' （繰り返し）
1150 ' 　　：
1160 '
1170 ' コマンド：'
1180 ' 意味：コメント
1190 ' データ：なし
1200 '
1210 ' コマンド：VOICE
1220 ' 意味：FM音源の音色変更
1230 ' データ：１行目に音色番号を指定。
1240 '         ２行目に音色名を指定（処理には使用しない）。
1250 '         ３－７行目にVOICE命令用の整数の配列をカンマ区切りで指定。
1260 '
1270 ' コマンド：STRING
1280 ' 意味：MML内の文字列定義
1290 ' データ：１行目に文字列番号を指定。1=S1$ / 2=S2$ / 3=S3$。
1300 '         ２行目に定義したい文字列を指定。MML内でX=S1$;のように使用する。
1310 '
1320 ' コマンド：MML
1330 ' 意味：MMLの再生
1340 ' データ：再生するMML文字列。つねに６チャンネル分＝６行を指定すること。
1350 ' ------------------------------------------------------------------------
1360 ' 初期化
1370 CLEAR,&H9000
1380 PLAY ALLOC 8000,3000,3000,3000,3000,3000
1390 DEFINT A-Z
1400 OPTION BASE 0
1410 DIM V(4, 9)
1420 DIM MML(6)
1430 ON STOP GOSUB *CLOSECOM
1440 ' ファイル読み込み
1450 INPUT "file name? ", FILE$
1460 OPEN FILE$ FOR INPUT AS #1
1470 LN = 0
1480 LOOP = 1
1490 WHILE LOOP=1 AND (MID$(FILE$, 1, 3)="com" OR EOF(1)=0)
1500 INPUT #1,COMD$
1510 LN = LN + 1
1520 IF MID$(COMD$,1,1) = "'" THEN PRINT MID$(COMD$,2) : GOTO *CONTINUE
1530 IF COMD$ = "VOICE" THEN GOSUB *VC : GOTO *CONTINUE
1540 IF COMD$ = "STRING" THEN GOSUB *DSTR : GOTO *CONTINUE
1550 IF COMD$ = "MML" THEN GOSUB *MML : GOTO *CONTINUE
1560 IF COMD$ = "END" THEN GOTO 1580
1570 PRINT USING "error '@' in ###"; COMD$; LN
1580 LOOP=0
1590 *CONTINUE
1600 WEND
1610 CLOSE #1
1620 ' 終了
1630 END
1640 ' ------------------------------------------------------------------------
1650 ' 音色変更
1660 *VC
1670 INPUT #1, VN
1680 INPUT #1, VNAME$
1690 FOR I=0 TO 4
1700 INPUT #1,V(I,0),V(I,1),V(I,2),V(I,3),V(I,4),V(I,5),V(I,6),V(I,7),V(I,8),V(I,9)
1710 NEXT
1720 VOICE VN, V
1730 PRINT "VOICE" : PRINT VN; VNAME$
1740 RETURN
1750 '
1760 ' MML内文字列定義
1770 *DSTR
1780 PRINT "DSTR"
1790 INPUT #1, STRN
1800 IF STRN=1 THEN INPUT #1, S1$ : PRINT " S1$=";S1$
1810 IF STRN=2 THEN INPUT #1, S2$ : PRINT " S2$=";S2$
1820 IF STRN=3 THEN INPUT #1, S3$ : PRINT " S3$=";S3$
1830 RETURN
1840 '
1850 ' MML再生
1860 *MML
1870 PRINT "MML"
1880 FOR I=0 TO 5
1890 INPUT #1,MML$(I)
1900 PRINT I; MML$(I)
1910 NEXT I
1920 PLAY MML$(0),MML$(1),MML$(2),MML$(3),MML$(4),MML$(5)
1930 RETURN
1940 '
1950 *CLOSECOM
1960 CLOSE #1
1970 PRINT "CLOSE #1"
1980 RETURN
