1000 ' MML Player
1010 ' 2019/05/09 kumagai �����J�n
1020 ' 2019/07/05 kumagai ���@��Ńf�o�b�O
1030 ' 2019/08/15 kumagai �f�o�b�O�E����
1040 ' -----------------------------------------------------------------------------
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
1240 '         �Q�|�U�s�ڂ�VOICE���ߗp�̐����̔z����J���}��؂�Ŏw��B
1250 '
1260 ' �R�}���h�FMML
1270 ' �Ӗ��FMML�̍Đ�
1280 ' �f�[�^�F�Đ�����MML������B�˂ɂU�`�����l�������U�s���w�肷�邱�ƁB
1290 ' -----------------------------------------------------------------------------
1300 ' ������
1310 CLEAR,&H9000
1320 PLAY ALLOC 3000,3000,3000,3000,3000,3000
1330 DEFINT A-Z
1340 OPTION BASE 0
1350 DIM V(4, 9)
1360 DIM MML(6)
1370 ON STOP GOSUB *CLOSECOM
1380 ' �t�@�C���ǂݍ���
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
1550 ' �I��
1560 END
1570 ' -----------------------------------------------------------------------------
1580 ' ���F�ύX
1590 *VC
1600 INPUT #1, VN
1610 FOR I=0 TO 4
1620 INPUT #1,V(I,0),V(I,1),V(I,2),V(I,3),V(I,4),V(I,5),V(I,6),V(I,7),V(I,8),V(I,9)
1630 NEXT
1640 VOICE VN, V
1650 RETURN
1660 '
1670 ' MML�Đ�
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