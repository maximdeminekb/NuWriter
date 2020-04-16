#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

IMAGE_PATH=/<CHANGE_THIS>/NuWriter/spi

echo "Enter the NuWriter directory"
cd ../ 

echo "Erase SPI"
./nuwriter -m spi -d NUC972DF62Y.ini -e 0xffffffff
echo "Erase complete"

echo "Burn u-boot.bin to SPI"
./nuwriter -m spi -d NUC972DF62Y.ini -t uboot -a 0xE00000 -w $IMAGE_PATH/u-boot.bin -v
echo "Burn env.txt to SPI"
./nuwriter -m spi -d NUC972DF62Y.ini -t env -a 0x80000 -w $IMAGE_PATH/env.txt -v
echo "Burn kernel image to SPI"
./nuwriter -m spi -d NUC972DF62Y.ini -t data -a 0x200000 -w $IMAGE_PATH/uImage -v
echo "Burning complete"
exit 0




