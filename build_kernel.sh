#!/usr/bin/env bash

# For building android kernel using GCC Toolchain
# Please rename your folders as following:
# Main folder='main' | Kernel Source folder='kernel'
# AnyKernel folder='ak' | Toolchain folder='toolchain'
# ak, toolchain and kernel folders must be INSIDE the main folder

cd
cd main/toolchain

export CROSS_COMPILE=$(pwd)/bin/aarch64-elf-
export ARCH=arm64 && export SUBARCH=arm64

cd
cd main/kernel

make O=out clean
make O=out mrproper
make O=out radioactive_defconfig
make O=out -j$(nproc --all)
 
cd
rm -rf main/ak/Image.gz-dtb
mv main/kernel/out/boot/arm64/Image.gz-dtb main/ak
cd main/ak
zip -r9 kernel.zip *
cd
mv main/ak/kernel.zip Desktop
 
echo "Your kernel has been placed on your desktop."
echo "Press 'enter' to exit..."

read