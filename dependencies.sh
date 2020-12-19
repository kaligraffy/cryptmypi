#!/bin/bash
set -eu
install_dependencies() {
    echo_info "$FUNCNAME[0] started at $(date)"
    apt-get -qq install \
        qemu-user-static \
        binfmt-support \
        coreutils \
        parted \
        zip \
        grep \
        rsync \
        xz-utils \
        pv \
        btrfs-progs;
}
