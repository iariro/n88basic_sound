' MML Player
' 2019/05/09
' -----------------------------------------------------------------------------
' 【概要】
' 指定のファイルの音楽データを再生する。
'
' 【データ形式】
' ファイルの形式は以下の通り。
'
' [コマンド]
' [データ]
' 　　：
' （繰り返し）
' 　　：
'
' コマンド：'
' 意味：コメント
' データ：なし
'
' コマンド：VOICE
' 意味：FM音源の音色変更
' データ：１行目に音色番号を指定。
'         ２－６行目にVOICE命令用の整数の配列をカンマ区切りで指定。
'
' コマンド：MML
' 意味：MMLの再生
' データ：再生するMML文字列。つねに６チャンネル分＝６行を指定すること。
' -----------------------------------------------------------------------------
' 初期化
clear,&h9000
play alloc 255,255,255,255,255,255
defint a-z
option base 0
dim v(4, 9)
dim mml(6)
' ファイル読み込み
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
' 終了
end
' -----------------------------------------------------------------------------
' 音色変更
*vc
read #1, vn
for i=0 to 4
  input #1,v(i,0),v(i,1),v(i,2),v(i,3),v(i,4),v(i,5),v(i,6),v(i,7),v(i,8),v(i,9)
next
voice vn, v
return
'
' MML再生
*mml
for i=0 to 5
  input #1,mml$(i)
next i
play mml$(0),mml$(1),mml$(2),mml$(3),mml$(4),mml$(5)
return
