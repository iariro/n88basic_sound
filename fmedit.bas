' FM音源音色エディタ
'
' 2019/05/10
' kumagai
'
' 00 @     0
' 01
' 02 FB    7
' 03 ALG   7
' 04 WF    5
' 05 SYNC  255
' 06 SPEED 16383
' 07 PD    -127
' 08 AD    -127
' 09 PS    15
' 10
' 11 MSK AR  DR  SR  RR  SL  TL  KS  ML  DT  AS
' 12 0   31  31  31  15  15  127  3  15  -4  15
' 13 0   31  31  31  15  15  127  3  15  -4  15
' 14 0   31  31  31  15  15  127  3  15  -4  15
' 15 0   31  31  31  15  15  127  3  15  -4  15
'
' ------------------------------------------------------------------------------
' 初期化
clear,&h9e00
play alloc 255
'
defint a-z
option base 0
dim vp(4, 9)
dim vpmax(4, 10)
dim vpmin(4, 10)
dim vpstp(4, 10)
'
' 値の範囲読み込み
for i=0 to 7
  read vpmin(0, i), vpmax(0, i), vpstp(0, i)
next i
'
for i=0 to 10
  read min, max, stp
  for j=1 to 4
    vpmin(j, i) = min
    vpmax(j, i) = max
    vpstp(j, i) = stp
  next j
next i
'
' 音色選択
input "voice number", vn
cls
' 音色読み込み
voice copy vn, vp
' パラメータ表示
locate 0, 0 : print using "@     #"; vn
locate 0, 2 : print using "FB    #"; (vp(0, 0) & &h38) / 8
locate 0, 3 : print using "ALG   #"; vp(0, 0) & &h7
locate 0, 4 : print using "WF    #"; vp(0, 2)
locate 0, 5 : print using "SYNC  ###"; vp(0, 3)
locate 0, 6 : print using "SPEED #####"; vp(0, 4)
locate 0, 7 : print using "PD    ###"; vp(0, 5)
locate 0, 8 : print using "AD    ###"; vp(0, 6)
locate 0, 9 : print using "PS    ##"; vp(0, 7)
'
locate 11,0 : print "MSK AR  DR  SR  RR  SL  TL  KS  ML  DT  AS"
for i=0 to 4
  for j=0 to 9
    locate 4*j, i
    print using "#####"; vp(i, j)
  next j
next i
'
cx=0
cy=0
' キー待ち
loop = 1
while loop = 1
' print cursor
  locate 6*cx, cy
  print "*"
' key wait
  k$ = ""
  while k$=""
    k$=inkey$
  wend
'
' Esc to end
  if asc(k$) = 27 then loop=0 : goto *cont
' cursor to move *
  if asc(k$) >= 28 and asc(k$) <= 31 then gosub *move : goto *cont
' P to play
  if k$="p" or k$="P" then gosub * pl : goto *cont
' u/d to up/down
  if k$="u" or k$="d" or k$="U" or k$="D" then gosub *updown : goto *cont
  gosub *move
*cont
wend
end
' ------------------------------------------------------------------------------
' 視聴
*pl
play "@" + str$(vn) + "c"
return
' ------------------------------------------------------------------------------
' 値UP/DOWN
*updown
nvp = vp(cx, cy)
if k$="u" or k$="U" then nvp = nvp + vpstp(cx, cy)
if k$="d" or k$="D" then nvp = nvp - vpstp(cx, cy)
if nvp < vpmin(cx, cy) or nvp > vpmax(cx, cy) then return
vp(cx, cy) = nvp
locate 1+6*cx, cy
print using "#####"; vp(cx, cy)
return
' ------------------------------------------------------------------------------
' カーソル移動
*move
cx2=cx : cy2=cy
if asc(k$) = 28 and cx<9 then cx2 = cx + 1
if asc(k$) = 29 and cx>0 then cx2 = cx - 1
if asc(k$) = 30 and cx>0 then cy2 = cy - 1
if asc(k$) = 31 and cx<4 then cy2 = cy + 1
if cx2=cx and cy2=cy then beep : return
locate 6*cx, cy
print " "
cx=cx2 : cy=cy2
return
' ------------------------------------------------------------------------------
' 配列の各値の範囲
data 0, 63, 1
data 0, 15, 1
data 0, 5, 1
data 0, 255, 1
data 0, 16383, 10
data -127, 127, 1
data -127, 127, 1
data 0, 15, 1
data 0, 0, 1
data 0, 0, 1
'
data 0, 31, 1
data 0, 31, 1
data 0, 31, 1
data 0, 15, 1
data 0, 15, 1
data 0, 127, 1
data 0, 3, 1
data 0, 15, 1
data -4, 3, 1
data 0, 15, 1
' ------------------------------------------------------------------------------
