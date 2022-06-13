#!/bin/sh

echo "Deploying Ubuntu Core 20 image to the /dev/sda"

if [[ -e /root/ubuntu-core-20-amd64.img.xz ]]; then
   xzcat /root/ubuntu-core-20-amd64.img.xz | pv | dd of=/dev/sda bs=32M; sync
else
   cd /tmp && wget http://192.168.1.100:9000/pc.img.xz 
   xzcat /tmp/pc.img.xz | pv | dd of=/dev/sda bs=32M; sync
fi

# In case you need to clear TPM configuration, you could enable the following line
echo 5 > /sys/class/tpm/tpm0/ppi/request

echo "Ubuntu Core succesfully deployed to the /dev/sda..."
echo "Please un-plug the bootable USB Disk and Reboot..."
