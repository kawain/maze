# 穴掘り法

import random

# 迷路の大きさ 奇数でお願い
SIZE = 31

# 迷路の２次元配列
maze = [[1] * SIZE for i in range(SIZE)]

# 地点用
stack = []

# ランダムな奇数の数字rowとcolの二つ作成
row = random.randrange(1, SIZE, 2)
col = random.randrange(1, SIZE, 2)

# その地点を 0（通路）にします
maze[row][col] = 0

# 現在の地点として保持
stack.append((row, col))


def move_ana(row, col):
    lst = ["up", "down", "left", "right"]

    while len(lst) > 0:
        # 進む方向を上下左右からランダムに選ぶ
        d = random.choice(lst)

        # 1つ先
        r1 = row
        c1 = col

        # 2つ先
        r2 = row
        c2 = col

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
                return True, r2, c2

        # dを削除
        lst.remove(d)

    return False, -1, -1


while True:
    # stack 全部戻ったら終わり
    if len(stack) == 0:
        break

    # 2つ先地点が 1（壁）なら ok
    f = move_ana(row, col)
    # print(f)

    if f[0] is False:
        p = stack.pop()
        row = p[0]
        col = p[1]
        continue

    row = f[1]
    col = f[2]

    stack.append((row, col))


# 表示確認
for v in maze:
    print()
    for v2 in v:
        if v2 == 1:
            print("■", end="")
        else:
            print("□", end="")

# print(stack)
