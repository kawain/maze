# 穴掘り法
import random
import sequtils

randomize()

# 初期設定

# 0を通路、1を壁
# 迷路の大きさ 0から始まるので偶数で入れるとlenが奇数になる
const SIZE = 30

# 迷路の２次元配列
var maze: array[0..SIZE, array[0..SIZE, int]]

# 地点変数はシーケンス
var stack: seq[(int, int)]

# 全部1にする
for i1, v1 in maze:
  for i2, _ in v1:
    maze[i1][i2] = 1


# ランダムな奇数の数字rowとcolの二つ作成
var row = rand(1..SIZE-1)
if row mod 2 == 0:
  inc(row)

var col = rand(1..SIZE-1)
if col mod 2 == 0:
  inc(col)

# その地点を 0（通路）にします
maze[row][col] = 0

# 現在の地点として保持
stack.add((row, col))


proc moveAna(row: int, col: int): tuple =
  var rtp: (bool, int, int)
  var lst = @["up", "down", "left", "right"]

  while lst.len > 0:
    let d = sample(lst)

    # 1つ先
    var r1 = row
    var c1 = col

    # 2つ先
    var r2 = row
    var c2 = col

    if d == "up":
      r1 = r1 - 1
      r2 = r2 - 2
    elif d == "down":
      r1 = r1 + 1
      r2 = r2 + 2
    elif d == "left":
      c1 = c1 - 1
      c2 = c2 - 2
    elif d == "right":
      c1 = c1 + 1
      c2 = c2 + 2

    # 2つ先地点が 1（壁）なら ok
    if r2 < SIZE and c2 < SIZE and r2 >= 0 and c2 >= 0:
      if maze[r2][c2] == 1:
        maze[r1][c1] = 0
        maze[r2][c2] = 0
        rtp = (true, r2, c2)
        return rtp

    # dを削除
    lst = filter(lst, proc (x: string): bool = x != d)

  rtp = (false, -1, -1)
  return rtp


while true:
  # stack 全部戻ったら終わり
  if stack.len == 0:
    break

  # 2つ先地点が 1（壁）なら ok
  let f = move_ana(row, col)

  if f[0] == false:
    let p = stack.pop()
    row = p[0]
    col = p[1]
    continue

  row = f[1]
  col = f[2]

  stack.add((row, col))


# 表示確認
for v in maze:
  echo ""
  for v2 in v:
    if v2 == 1:
      stdout.write "■"
    else:
      stdout.write "□"

