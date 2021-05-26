#!/bin/sh

image=$1
rom=$2
base=$(basename $image .png)

[ -n $rom ] || break

for i in 1 2; do
    mono PixelPet.exe \
        Import-Bitmap "${base}$i.png" \
        Extract-Palettes --palette-size 16 \
        Generate-Tilemap GBA-4BPP -nr \
        Serialize-Tileset \
        Export-Bytes "${base}$i.bin" \
        Convert-Palettes RGBA5551 \
        Serialize-Palettes \
        Export-Bytes "${base}$i.pal"
    ./prep4cmp.py "${base}$i.bin"
    ./gba-lz77-compress "${base}$i.bin" "${base}$i.cmp"
done
./insert.py "$rom" "$base"

