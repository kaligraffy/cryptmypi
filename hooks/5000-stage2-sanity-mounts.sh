#!/bin/bash
set -e
set -u

echo_debug "Attempt to unmount just to be safe "
umount ${_BLKDEV}* || true
umount /mnt/cryptmypi || {
    umount -l /mnt/cryptmypi || true
    umount -f /dev/mapper/${_ENCRYPTED_VOLUME_NAME} || true
}
[ -d /mnt/cryptmypi ] && rm -r /mnt/cryptmypi || true
cryptsetup luksClose ${_ENCRYPTED_VOLUME_NAME} || true