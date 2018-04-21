#i/bin/sh
if [ ! -d "./build" ]; then
  mkdir build/
fi

nasm -I ./src/include/ -o ./build/mbr.bin ./src/boot/mbr.S
nasm -I ./src/include/ -o ./build/loader.bin ./src/boot/loader.S

if [ ! -d "./build/kernel" ]; then
  mkdir build/kernel
fi
gcc -c -o build/kernel/main.o src/kernel/main.c
ld build/kernel/main.o -Ttext 0xc0001500 -e main -o build/kernel/kernel.bin

dd if=./build/mbr.bin of=../disk/disk.img bs=512 count=1 conv=notrunc
dd if=./build/loader.bin of=../disk/disk.img bs=512 count=2 seek=2 conv=notrunc
dd if=./build/kernel/kernel.bin of=../disk/disk.img bs=512 count=200 seek=9 conv=notrunc
