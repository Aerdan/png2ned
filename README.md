png2ned
-------

This is a simple set of scripts for converting PNGs into GBA 4-bits-per-pixel format and inserting them in to Final Fantasy V Advance to replace Neo Exdeath (NED), the final plot boss of the game.

Usage
-----
To use this toolchain, you need:

- two PNG images, with the naming scheme below:
 - `image1.png` should be at most 128x136, with 15 colors and an alpha channel.
 - `image2.png` should be at most 72x104, with 15 colors and an alpha channel.
- a copy of Final Fantasy V Advance, US release.
- [PixelPet](https://github.com/Prof9/PixelPet), placed in the same directory as this toolchain
- [gba-lz77](https://github.com/lunasorcery/gba-lz77), specifically `gba-lz77-compress`, placed in the same directory as this toolchain
- Python 3.x, with `python3` in your `$PATH`

(PixelPet and gba-lz77 need to be compiled.)

    $ ./png2ned.sh base rom.gba

`base` is the common, leading element in the images' filenames. 

Copyright
---------

These scripts are released under the BSD-3-Clause license; see `LICENSE` for details.

