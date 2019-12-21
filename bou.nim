# 棒倒し法
import random
import sequtils

randomize()

# 初期設定

# 0を通路、1を壁
# 迷路の大きさ 0から始まるので偶数で入れるとlenが奇数になる
const SIZE = 30

# 迷路の２次元配列
var maze: array[0..SIZE, array[0..SIZE, int]]

# 基本形
var c = 2
for i1, v1 in maze:
  for i2, _ in v1:
    if i1 == 0:
      maze[i1][i2] = 1

    if i1 == SIZE:
      maze[i1][i2] = 1

    if i2 == 0:
      maze[i1][i2] = 1

    if i2 == SIZE:
      maze[i1][i2] = 1

    if i1 != 0 and i1 != SIZE and i2 != 0 and i2 != SIZE:
      if i1 mod 2 == 0 and i2 mod 2 == 0:
        maze[i1][i2] = c
        inc(c)


proc down_bou1(row: int, col: int) =
  var lst = @["up", "down", "left", "right"]

  while lst.len > 0:

    # 倒す方角
    let d = sample(lst)
    # 1つ先
    var r1 = row
    var c1 = col

    if d == "up":
      r1 = r1 - 1
    elif d == "down":
      r1 = r1 + 1
    elif d == "left":
      c1 = c1 - 1
    elif d == "right":
      c1 = c1 + 1

    # 1つ先が 0 なら ok
    if maze[r1][c1] == 0:
      maze[r1][c1] = 1
      maze[row][col] = 1
      return

    # dを削除
    lst = filter(lst, proc (x: string): bool = x != d)


proc down_bou2(row: int, col: int) =
  var lst = @["down", "left", "right"]

  while lst.len > 0:

    # 倒す方角
    let d = sample(lst)
    # 1つ先
    var r1 = row
    var c1 = col

    if d == "down":
      r1 = r1 + 1
    elif d == "left":
      c1 = c1 - 1
    elif d == "right":
      c1 = c1 + 1

    # 1つ先が 0 なら ok
    if maze[r1][c1] == 0:
      maze[r1][c1] = 1
      maze[row][col] = 1
      return

    # dを削除
    lst = filter(lst, proc (x: string): bool = x != d)


# 2以上の場所を見る
for i1, v1 in maze:
  for i2, _ in v1:
    if i1 == 2 and maze[i1][i2] >= 2:
      down_bou1(i1, i2)
    elif i1 > 2 and maze[i1][i2] >= 2:
      down_bou2(i1, i2)


# 表示確認
for v in maze:
  echo ""
  for v2 in v:
    if v2 == 1:
      stdout.write "■"
    else:
      stdout.write "□"

