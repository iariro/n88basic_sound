1000 ' MML Player
1010 ' 2019/05/09 kumagai �����J�n
1020 ' 2019/07/05 kumagai ���@��Ńf�o�b�O
1030 ' 2019/08/15 kumagai �������`������
1040 ' ------------------------------------------------------------------------
1050 ' �y�T�v�z
1060 ' �w��̃t�@�C���̉��y�f�[�^���Đ�����B
1070 '
1080 ' �y�f�[�^�`���z
1090 ' �t�@�C���̌`���͈ȉ��̒ʂ�B
1100 '
1110 ' [�R�}���h]
1120 ' [�f�[�^]
1130 ' �@�@�F
1140 ' �i�J��Ԃ��j
1150 ' �@�@�F
1160 '
1170 ' �R�}���h�F'
1180 ' �Ӗ��F�R�����g
1190 ' �f�[�^�F�Ȃ�
1200 '
1210 ' �R�}���h�FVOICE
1220 ' �Ӗ��FFM�����̉��F�ύX
1230 ' �f�[�^�F�P�s�ڂɉ��F�ԍ����w��B
1240 '         �Q�s�ڂɉ��F�����w��i�����ɂ͎g�p���Ȃ��j�B
1250 '         �R�|�V�s�ڂ�VOICE���ߗp�̐����̔z����J���}��؂�Ŏw��B
1260 '
1270 ' �R�}���h�FSTRING
1280 ' �Ӗ��FMML���̕������`
1290 ' �f�[�^�F�P�s�ڂɕ�����ԍ����w��B1=S1$ / 2=S2$ / 3=S3$�B
1300 '         �Q�s�ڂɒ�`��������������w��BMML����X=S1$;�̂悤�Ɏg�p����B
1310 '
1320 ' �R�}���h�FMML
1330 ' �Ӗ��FMML�̍Đ�
1340 ' �f�[�^�F�Đ�����MML������B�˂ɂU�`�����l�������U�s���w�肷�邱�ƁB
1350 ' ------------------------------------------------------------------------
1360 ' ������
1370 CLEAR,&H9000
1380 PLAY ALLOC 8000,3000,3000,3000,3000,3000
1390 DEFINT A-Z
1400 OPTION BASE 0
1410 DIM V(4, 9)
1420 DIM MML(6)
1430 ON STOP GOSUB *CLOSECOM
1440 ' �t�@�C���ǂݍ���
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
1620 ' �I��
1630 END
1640 ' ------------------------------------------------------------------------
1650 ' ���F�ύX
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
1760 ' MML���������`
1770 *DSTR
1780 PRINT "DSTR"
1790 INPUT #1, STRN
1800 IF STRN=1 THEN INPUT #1, S1$ : PRINT " S1$=";S1$
1810 IF STRN=2 THEN INPUT #1, S2$ : PRINT " S2$=";S2$
1820 IF STRN=3 THEN INPUT #1, S3$ : PRINT " S3$=";S3$
1830 RETURN
1840 '
1850 ' MML�Đ�
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