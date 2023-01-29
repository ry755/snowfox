#!/bin/sh

if [ ! -e disk_images/snowfox.img ]; then
    echo ">>> Creating new floppy image..."
    mkdir -p disk_images
    mkdosfs -C disk_images/snowfox.img 1440 || exit
fi

echo ">>> Assembling mlib..."

cd mlib/src
nasm -f elf -o ../mlib.a mlib.asm || exit
cd ../..

echo ">>> Assembling bootloader..."

nasm -O0 -w+orphan-labels -f bin -o bootload/bootload.bin bootload/bootload.asm || exit

echo ">>> Assembling kernel..."

cd kernel
nasm -O0 -w+orphan-labels -f bin -o kernel.bin kernel.asm || exit
cd ..

echo ">>> Assembling programs..."

cd programs
for i in *.asm; do
    nasm -O0 -w+orphan-labels -f bin $i -o `basename $i .asm`.bin || exit
done
for i in *.c; do
    smlrcc -I ../mlib/include -Wall -flat16 -origin 32768 -o `basename $i .c`.bin $i ../mlib/mlib.a || exit
done
cd ..

echo ">>> Adding bootloader to floppy image..."

dd status=noxfer conv=notrunc if=bootload/bootload.bin of=disk_images/snowfox.img || exit

echo ">>> Copying kernel and programs..."

rm -rf tmp-loop
mkdir tmp-loop && sudo mount -o loop -t vfat disk_images/snowfox.img tmp-loop && sudo cp kernel/kernel.bin tmp-loop/
sudo cp programs/*.bin programs/*.bas programs/sample.pcx programs/vedithlp.txt programs/gen.4th programs/hello.512 tmp-loop
sleep 0.2

echo ">>> Unmounting loopback floppy..."

sudo umount tmp-loop || exit
rm -rf tmp-loop

echo ">>> Done!"
