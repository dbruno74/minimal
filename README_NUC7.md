# UC20 (FDE) on NUC7 (production)
1. Clone installer ISO 
``git clone https://github.com/dbruno74/minimal.git -b secureboot``

2. Set ``USE_LOCAL_SOURCE`` to ``true`` in ``src/.config``

3. Copy ubuntu xz image on ``minimal/src/source/overlay`` and rename to ``ubuntu-core-20-amd64.img.xz`` (assuming the xz image is on current dir)
``cp pc.img.xz minimal/src/source/overlay/ubuntu-core-20-amd64.img.xz``
	
4. Build installer ISO
``cd minimal/src``
``sudo FORCE_UNSAFE_CONFIGURE=1 ./build_minimal_linux_live.sh``

5. Prepare USB key
``sudo dd if=minimal_linux_live.iso of=/dev/sdc bs=1M status=progress``

6. Insert USB key

7. Power on and enter BIOS (press F2)
*Advanced->Boot->Boot Configuration->OS Selection: Linux*
*Secure Boot->Secure Boot: checked*
*Secure Boot->Install Intel Platform Key: checked*
*Secure Boot->Force Secure Boot Defaults: checked*

8. Press F10, then Yes
In case it fails to install (*device /dev/sda as no proper overlay structure*), try with a different USB key and repeat from step 5 
If successful, Ubuntu Core will be deployed and the TPM instructed to request a clear during next boot (``echo 5 | sudo tee /sys/class/tpm/tpm0/ppi/request``)


9. Reboot without USB key
Type reboot, then press enter
press F12 when asked to clear the TPM: Ubuntu Core will be installed with FDE

# UC20 (FDE) on NUC7 (development)
1. Clone installer ISO 
``git clone https://github.com/dbruno74/minimal.git -b secureboot``

2. Set ``USE_LOCAL_SOURCE`` to ``false`` in ``src/.config``

3. Comment ``IMAGE_URL`` in ``src/minimal_overlay/bundles/image_deploy/.config``

4. Create and xz your uc20 image. Start a web server into the directory which contains the xz file (e.g. ``python3 -m http.server --bind 192.168.1.100 9000``)

5. Edit ``src/minimal_overlay/bundles/image_deploy/99_deploy_uc20.sh`` and replace ip address and port of your web server and the image name right close to the ``wget`` call (e.g. ``cd /tmp && wget http://192.168.1.100:9000/pc.img.xz``)

6. Build installer ISO
``cd minimal/src``
``sudo FORCE_UNSAFE_CONFIGURE=1 ./build_minimal_linux_live.sh``

7. Prepare USB key
``sudo dd if=minimal_linux_live.iso of=/dev/sdc bs=1M status=progress``

8. Insert USB key

9. Power on and enter BIOS (press F2)
*Advanced->Boot->Boot Configuration->OS Selection: Linux*
*Secure Boot->Secure Boot: checked*
*Secure Boot->Install Intel Platform Key: checked*
*Secure Boot->Force Secure Boot Defaults: checked*

10. Press F10, then Yes
In case it fails to install (*device /dev/sda as no proper overlay structure*), try with a different USB key and repeat from step 5 
If successful, Ubuntu Core will be deployed and the TPM instructed to request a clear during next boot (``echo 5 | sudo tee /sys/class/tpm/tpm0/ppi/request``)

11. Reboot without USB key
Type reboot, then press enter
press F12 when asked to clear the TPM: Ubuntu Core will be installed with FDE
