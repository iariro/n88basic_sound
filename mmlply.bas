' MML Player
' 2019/05/09
' -----------------------------------------------------------------------------
' �y�T�v�z
' �w��̃t�@�C���̉��y�f�[�^���Đ�����B
'
' �y�f�[�^�`���z
' �t�@�C���̌`���͈ȉ��̒ʂ�B
'
' [�R�}���h]
' [�f�[�^]
' �@�@�F
' �i�J��Ԃ��j
' �@�@�F
'
' �R�}���h�F'
' �Ӗ��F�R�����g
' �f�[�^�F�Ȃ�
'
' �R�}���h�FVOICE
' �Ӗ��FFM�����̉��F�ύX
' �f�[�^�F�P�s�ڂɉ��F�ԍ����w��B
'         �Q�|�U�s�ڂ�VOICE���ߗp�̐����̔z����J���}��؂�Ŏw��B
'
' �R�}���h�FMML
' �Ӗ��FMML�̍Đ�
' �f�[�^�F�Đ�����MML������B�˂ɂU�`�����l�������U�s���w�肷�邱�ƁB
' -----------------------------------------------------------------------------
' ������
clear,&h9000
play alloc 255,255,255,255,255,255
defint a-z
option base 0
dim v(4, 9)
dim mml(6)
' �t�@�C���ǂݍ���
input "file name? ", fn$
open fn$ for input as #1
ln = 0
loop = 1
while loop=1 and eof(1)=0
  input #1,cmd$
  ln = ln + 1
  if cmd$ = "'" then print mid$(cmd$,2) : goto *continue
  if cmd$ = "VOICE" then gosub *vc : goto *continue
  if cmd$ = "MML" then gosub *mml : goto *continue
  print using "error '@' in ###"; cmd$; ln
  loop=0
  *continue
wend
close #1
' �I��
end
' -----------------------------------------------------------------------------
' ���F�ύX
*vc
read #1, vn
for i=0 to 4
  input #1,v(i,0),v(i,1),v(i,2),v(i,3),v(i,4),v(i,5),v(i,6),v(i,7),v(i,8),v(i,9)
next
voice vn, v
return
'
' MML�Đ�
*mml
for i=0 to 5
  input #1,mml$(i)
next i
play mml$(0),mml$(1),mml$(2),mml$(3),mml$(4),mml$(5)
return
