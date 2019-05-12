' FM音源音色エディタ
'
' 2019/05/10
' kumagai
'
' 00 @      0
' 01
' 02 FB     7
' 03 ALG    7
' 04 WF     5
' 05 SYNC   255
' 06 SPEED  16383
' 07 PD     -127
' 08 AD     -127
' 09 PS     15
' 10
' 11  MSK AR  DR  SR  RR  SL  TL  KS  ML  DT  AS
' 12  0   31  31  31  15  15  127  3  15  -4  15
' 13  0   31  31  31  15  15  127  3  15  -4  15
' 14  0   31  31  31  15  15  127  3  15  -4  15
' 15  0   31  31  31  15  15  127  3  15  -4  15
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
vn = 0
' 音色読み込み
gosub *printvn
'
area=0
cx=0
cy=0
' キー待ち
loop = 1
while loop = 1
' print cursor
  if area=0 then locate 6, 0
  if area=1 then locate 6, 2+cy
  if area=2 then locate 1 + 4*cx, 11+cy
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
' パラメータ表示
*printvn
voice copy vn, vp
locate 0, 0 : print using "@      #"; vn
locate 0, 2 : print using "FB     #"; (vp(0, 0) and &h38) / 8
locate 0, 3 : print using "ALG    #"; vp(0, 0) and &h7
locate 0, 4 : print using "WF     #"; vp(0, 2)
locate 0, 5 : print using "SYNC   ###"; vp(0, 3)
locate 0, 6 : print using "SPEED  #####"; vp(0, 4)
locate 0, 7 : print using "PD     ###"; vp(0, 5)
locate 0, 8 : print using "AD     ###"; vp(0, 6)
locate 0, 9 : print using "PS     ##"; vp(0, 7)
'
locate 11,0 : print " MSK AR  DR  SR  RR  SL  TL  KS  ML  DT  AS"
for i=0 to 4
  for j=0 to 9
    locate 1+4*j, i
    print using "#####"; vp(i, j)
  next j
next i
return
' ------------------------------------------------------------------------------
' 視聴
*pl
voice vn, vp
play "@" + str$(vn) + "c"
return
' ------------------------------------------------------------------------------
' 値UP/DOWN
*updown
stp=0
if k$="u" or k$="U" then stp=1
if k$="d" or k$="D" then stp=-1
on area goto *updown0 *updown1 *updown2
'
*updown0
if (stp=1 and vn<82) or (stp=-1 and vn>0) then vn = vn + stp : gosub *printvn else beep
return
'
*updown1
fb = (vp(0,0) and &h38)/8
alg = (vp(0,0) and &h7)
if cy=0 and ((stp=-1 and fb>vpmin(0,0)) or (stp=1 and fb<vpmax(0,0))) then fb=fb+stp : vp(0,0) = fb*8+vp(0,0) and &h7
if cy=1 and ((stp=-1 and alg>vpmin(0,1)) or (stp=1 and alg<vpmax(0,1))) then alg=alg+stp : vp(0,0) = vp(0,0) and &h38 + alg
if cy>=2 and ((stp=-1 and vp(0,cy)>vpmin(0,cy)) or (stp=1 and vp(0,cy)<vpmax(0,cy))) then vp(0,cy) = vp(0,cy) + stp * vpstp(0,cy)
return
'
*updown2
if cx=0 then *updown21 else *updown22
*updown21
msk=vp(0,1) and (2^cy)
if stp=-1 and msk>0 then msk=0 else if stp=1 and msk=0 then msk=(2^cy) else beep : return
vp(0,1) = (vp(0,1) and (&hf - 2^cy)) + msk
locate 1+4*cx, 11+cy
print using "###"; vp(cx, cy)
return
'
*updown22
if (stp=-1 and vp(cx,cy)>vpmin(cx,cy+1)) or (stp=1 and vp(cx,cy)<vpmax(cx,cy+1)) then vp(cx,cy)=vp(cx,cy)+stp else beep : return
locate 1+4*cx, 11+cy
print using "###"; vp(cx, cy)
return
' ------------------------------------------------------------------------------
' カーソル移動
*move
on area goto *move0 *move1 *move2
*move0
if asc(k$) = 31 then area=1 : locate 6, 0 : print " " else beep
return
'
*move1
cy2=cy
if asc(k$) = 30 then cy2 = cy - 1
if asc(k$) = 31 then cy2 = cy + 1
if cy2=cy then beep : return
locate 6, 2+cy
print " "
if cy2<0 then area=0 : cy2=0
if cy2>7 then area=2 : cy2=0
cy=cy2
return
'
*move2
cx2=cx : cy2=cy
if asc(k$) = 28 and cx<9 then cx2 = cx + 1
if asc(k$) = 29 and cx>0 then cx2 = cx - 1
if asc(k$) = 30 then cy2 = cy - 1
if asc(k$) = 31 and cx<4 then cy2 = cy + 1
if cx2=cx and cy2=cy then beep : return
locate 4*cx, 11+cy
print " "
if cy2<0 then area=1 : cy2=7
cx=cx2 : cy=cy2
return
' ------------------------------------------------------------------------------
' 配列の各値の範囲
data 0, 7, 1
data 0, 7, 1
data 0, 15, 1
data 0, 5, 1
data 0, 255, 1
data 0, 16383, 10
data -127, 127, 1
data -127, 127, 1
data 0, 15, 1
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
