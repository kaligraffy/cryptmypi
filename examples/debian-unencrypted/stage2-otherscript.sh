#!/bin/bash

###################################
# Debian OS stage2-otherscript.sh


# At the time of testing the Debian OS for rpi works on labels, so we attempt to match.
echo 'Setting up partition labels for Debian OS.'
dosfslabel /dev/sdb1 RASPIFIRM
e2label /dev/sdb2 RASPIROOT


# Move our kernel in place of the targets default kernel
__DEBIAN_KERNEL="initrd.img-5.8.0-0.bpo.2-arm64"
echo "Movinng our /boot/initramfs.gz to /boot/${__DEBIAN_KERNEL}."
mv "/boot/${__DEBIAN_KERNEL}" "/boot/${__DEBIAN_KERNEL}-oos"
mv /boot/initramfs.gz "/boot/${__DEBIAN_KERNEL}"