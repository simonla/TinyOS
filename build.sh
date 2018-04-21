#i/bin/sh
echo "assembly..."
nasm -I include/ -o build/mbr.bin src/mbr.S
echo "assembly success..."
nasm -I include/ -o build/loader.bin src/loader.S
echo "write to disk success..."
dd if=build/mbr.bin of=../disk/disk.img bs=512 count=1 conv=notrunc
dd if=build/loader.bin of=../disk/disk.img bs=512 count=2 seek=2 conv=notrunc
echo "all done!"

