#!/usr/bin/env python3

import sys

rom = sys.argv[1]
base = sys.argv[2]
rom2 = rom.replace('.gba', ' (modified).gba')

def le24(num):
    return bytearray([pos & 0xFF, (pos >> 8) & 0xFF, (pos >> 16) & 0xFF])

with open(rom2, 'xb+') as f:
    with open(rom, 'rb') as j:
        f.write(j.read())

    pos = f.seek(0, 2)
    rightaddr = le24(pos)

    with open(base + '1.cmp', 'rb') as j:
        wrote = f.write(j.read())

    pos = f.seek(0, 2)
    leftaddr = le24(pos)
    with open(base + '2.cmp', 'rb') as j:
        wrote = f.write(j.read())

    f.seek(0x131A00, 0)
    f.write(rightaddr)
    f.seek(0x131A08, 0)
    f.write(leftaddr)

    f.seek(0x2140D4, 0)
    with open(base + '1.pal', 'rb') as j:
        wrote = f.write(j.read())

    f.seek(0x214F10, 0)
    with open(base + '2.pal', 'rb') as j:
        wrote = f.write(j.read())

