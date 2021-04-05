#!/bin/sh

echo "Deploying Ubuntu Core 20 image to the /dev/sda"

xzcat /root/ubuntu-core-20-amd64.img.xz | dd of=/dev/sda bs=32M; sync

echo "Ubuntu Core succesfully deployed to the /dev/sda..."
echo "Please un-plug the bootable USB Disk and Reboot..."
