#!/usr/bin/env python3

import sys

from struct import pack

fname_out = sys.argv[1]

with open(fname_out, mode='rb') as f:
    data = f.read()

# XXX - hack hack hack hack lols; 4bpp 8x8 = 32 bytes/tile
tiles = int(len(data) / 32)
data = b'\x01\x00\x00\x00' + pack('<I', tiles) + data

with open(fname_out, mode='wb') as f:
    f.write(data)

print("Found {} tiles.".format(tiles))

