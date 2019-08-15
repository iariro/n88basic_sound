1000 ' MML Player
1010 ' 2019/05/09 kumagai 実装開始
1020 ' 2019/07/05 kumagai 実機上でデバッグ
1030 ' 2019/08/15 kumagai デバッグ・調整
1040 ' -----------------------------------------------------------------------------
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
1240 '         ２－６行目にVOICE命令用の整数の配列をカンマ区切りで指定。
1250 '
1260 ' コマンド：MML
1270 ' 意味：MMLの再生
1280 ' データ：再生するMML文字列。つねに６チャンネル分＝６行を指定すること。
1290 ' -----------------------------------------------------------------------------
1300 ' 初期化
1310 CLEAR,&H9000
1320 PLAY ALLOC 3000,3000,3000,3000,3000,3000
1330 DEFINT A-Z
1340 OPTION BASE 0
1350 DIM V(4, 9)
1360 DIM MML(6)
1370 ON STOP GOSUB *CLOSECOM
1380 ' ファイル読み込み
1390 INPUT "file name? ", FILE$
1400 OPEN FILE$ FOR INPUT AS #1
1410 LN = 0
1420 LOOP = 1
1430 WHILE LOOP=1 AND (MID$(FILE$, 1, 3)="com" OR EOF(1)=0)
1440 INPUT #1,COMD$
1450 LN = LN + 1
1460 IF MID$(COMD$,1,1) = "'" THEN PRINT MID$(COMD$,2) : GOTO *CONTINUE
1470 IF COMD$ = "VOICE" THEN GOSUB *VC : GOTO *CONTINUE
1480 IF COMD$ = "MML" THEN GOSUB *MML : GOTO *CONTINUE
1490 IF COMD$ = "END" THEN GOTO 1510
1500 PRINT USING "error '@' in ###"; COMD$; LN
1510 LOOP=0
1520 *CONTINUE
1530 WEND
1540 CLOSE #1
1550 ' 終了
1560 END
1570 ' -----------------------------------------------------------------------------
1580 ' 音色変更
1590 *VC
1600 INPUT #1, VN
1610 FOR I=0 TO 4
1620 INPUT #1,V(I,0),V(I,1),V(I,2),V(I,3),V(I,4),V(I,5),V(I,6),V(I,7),V(I,8),V(I,9)
1630 NEXT
1640 VOICE VN, V
1650 RETURN
1660 '
1670 ' MML再生
1680 *MML
1690 FOR I=0 TO 5
1700 INPUT #1,MML$(I)
1710 PRINT I; MML$(I)
1720 NEXT I
1730 PLAY MML$(0),MML$(1),MML$(2),MML$(3),MML$(4),MML$(5)
1740 RETURN
1750 '
1760 *CLOSECOM
1770 CLOSE #1
1780 PRINT "CLOSE #1"
1790 RETURN
