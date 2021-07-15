Param([string] $image,
      [string] $rom)

$baseImage = "$PSCommandPath/$image"
$baseRom = "$PSCommandPath/$rom"

#validate parameters
if( $image ) { echo "Right Image: $image$1.png" } else { exit }
if( $image ) { echo "Left Image: $image$2.png" } else { exit }
if( $rom )   { echo "Rom: $rom" }     else { exit }

#do Prep work on Image files
foreach ($n in 1, 2) {
    echo "Preparing $image$n.png \n"
    .\PixelPet.exe Import-Bitmap "$image$n.png" `
        Extract-Palettes --palette-size 16 `
        Generate-Tilemap GBA-4BPP -nr `
        Serialize-Tileset `
        Export-Bytes "$image$n.bin" `
        Convert-Palettes RGBA5551 `
        Serialize-Palettes `
        Export-Bytes "$image$n.pal"

    python3 prep4cmp.py "$image$n.bin"
    .\gba-lz77-compress.exe "$image$n.bin" "$image$n.cmp"
}

#Insert into ROM file
python3 insert.py $rom $image

#Clean up generated files from prep steps
foreach ($n in 1, 2) {
    Remove-Item "$image$n.cmp"
    Remove-Item "$image$n.pal"
    Remove-Item "$image$n.bin"
}