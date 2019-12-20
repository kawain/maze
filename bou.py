# 棒倒し法

import random

# 迷路の大きさ 奇数でお願い
SIZE = 31

# 迷路の２次元配列
maze = [[0] * SIZE for i in range(SIZE)]

# 基本形
c = 2
for i1, v1 in enumerate(maze):
    for i2, v2 in enumerate(v1):
        if i1 == 0:
            maze[i1][i2] = 1

        if i1 == SIZE-1:
            maze[i1][i2] = 1

        if i2 == 0:
            maze[i1][i2] = 1

        if i2 == SIZE-1:
            maze[i1][i2] = 1

        if i1 != 0 and i1 != SIZE-1 and i2 != 0 and i2 != SIZE-1:
            if i1 % 2 == 0 and i2 % 2 == 0:
                maze[i1][i2] = c
                c += 1


def down_bou1(row, col):
    lst = ["up", "down", "left", "right"]

    while len(lst) > 0:
        # 倒す方角
        d = random.choice(lst)
        # 1つ先
        r1 = row
        c1 = col

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
        lst.remove(d)


def down_bou2(row, col):
    lst = ["down", "left", "right"]

    while len(lst) > 0:
        # 倒す方角
        d = random.choice(lst)
        # 1つ先
        r1 = row
        c1 = col

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
        lst.remove(d)


# 2以上の場所を見る
for i1, v1 in enumerate(maze):
    for i2, v2 in enumerate(v1):
        if i1 == 2 and maze[i1][i2] >= 2:
            down_bou1(i1, i2)
        elif i1 > 2 and maze[i1][i2] >= 2:
            down_bou2(i1, i2)


# 表示確認
for v in maze:
    print()
    for v2 in v:
        if v2 == 1:
            print("■", end="")
        else:
            print("□", end="")
