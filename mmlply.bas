1000 ' MML Player
1010 ' 2019/05/09 kumagai �����J�n
1020 ' 2019/07/05 kumagai ���@��Ńf�o�b�O
1030 ' -----------------------------------------------------------------------------
1040 ' �y�T�v�z
1050 ' �w��̃t�@�C���̉��y�f�[�^���Đ�����B
1060 '
1070 ' �y�f�[�^�`���z
1080 ' �t�@�C���̌`���͈ȉ��̒ʂ�B
1090 '
1100 ' [�R�}���h]
1110 ' [�f�[�^]
1120 ' �@�@�F
1130 ' �i�J��Ԃ��j
1140 ' �@�@�F
1150 '
1160 ' �R�}���h�F'
1170 ' �Ӗ��F�R�����g
1180 ' �f�[�^�F�Ȃ�
1190 '
1200 ' �R�}���h�FVOICE
1210 ' �Ӗ��FFM�����̉��F�ύX
1220 ' �f�[�^�F�P�s�ڂɉ��F�ԍ����w��B
1230 '         �Q�|�U�s�ڂ�VOICE���ߗp�̐����̔z����J���}��؂�Ŏw��B
1240 '
1250 ' �R�}���h�FMML
1260 ' �Ӗ��FMML�̍Đ�
1270 ' �f�[�^�F�Đ�����MML������B�˂ɂU�`�����l�������U�s���w�肷�邱�ƁB
1280 ' -----------------------------------------------------------------------------
1290 ' ������
1300 CLEAR,&H9000
1310 PLAY ALLOC 2550,2550,2550,2550,2550,2550
1320 DEFINT A-Z
1330 OPTION BASE 0
1340 DIM V(4, 9)
1350 DIM MML(6)
1360 ' �t�@�C���ǂݍ���
1370 INPUT "file name? ", FILE$
1380 OPEN FILE$ FOR INPUT AS #1
1390 LN = 0
1400 LOOP = 1
1410 WHILE LOOP=1 AND EOF(1)=0
1420 INPUT #1,COMD$
1430 LN = LN + 1
1440 IF MID$(COMD$,1,1) = "'" THEN PRINT MID$(COMD$,2) : GOTO *CONTINUE
1450 IF COMD$ = "VOICE" THEN GOSUB *VC : GOTO *CONTINUE
1460 IF COMD$ = "MML" THEN GOSUB *MML : GOTO *CONTINUE
1470 PRINT USING "error '@' in ###"; COMD$; LN
1480 LOOP=0
1490 *CONTINUE
1500 WEND
1510 CLOSE #1
1520 ' �I��
1530 END
1540 ' -----------------------------------------------------------------------------
1550 ' ���F�ύX
1560 *VC
1570 INPUT #1, VN
1580 FOR I=0 TO 4
1590 INPUT #1,V(I,0),V(I,1),V(I,2),V(I,3),V(I,4),V(I,5),V(I,6),V(I,7),V(I,8),V(I,9)
1600 NEXT
1610 VOICE VN, V
1620 RETURN
1630 '
1640 ' MML�Đ�
1650 *MML
1660 FOR I=0 TO 5
1670 INPUT #1,MML$(I)
1680 NEXT I
1690 PLAY MML$(0),MML$(1),MML$(2),MML$(3),MML$(4),MML$(5)
1700 RETURN
