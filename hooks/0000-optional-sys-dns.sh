#!/bin/bash
set -e

echo_debug "Attempting to set system's DNS settings"


echo_debug "Writing /etc/resolv.conf "
cat <<EOT > ${_CHROOT_ROOT}/etc/resolv.conf
# DNS (by optional-sys-dns)
nameserver ${_DNS1}
nameserver ${_DNS2}
EOT
chmod o+r ${_CHROOT_ROOT}/etc/resolv.conf


#echo_debug "Installing resolvconf"
#chroot_pkginstall resolvconf
#chroot_execute systemctl enable resolvconf.service
#
#
#echo_debug "Updating /etc/resolvconf/resolv.conf.d/head "
#cat <<EOT >> ${_CHROOT_ROOT}/etc/resolvconf/resolv.conf.d/head
#nameserver ${_DNS1}
#nameserver ${_DNS2}
#EOT


echo_debug "Updating /etc/network/interfaces"
cat <<EOT >> ${_CHROOT_ROOT}/etc/network/interfaces

# DNS (by optional-sys-dns)
dns-nameservers ${_DNS1} ${_DNS2}

EOT


test -e "${_CHROOT_ROOT}/etc/dhclient.conf" && {
    echo_debug "Updating /etc/dhclient.conf"
    cat <<EOT >> ${_CHROOT_ROOT}/etc/dhclient.conf

# DNS (by optional-sys-dns)
supersede domain-name-servers ${_DNS1}, ${_DNS2};
EOT
}


test -e "${_CHROOT_ROOT}/etc/dhpc/dhclient.conf" && {
    echo_debug "Uptading /etc/dhpc/dhclient.conf"
    cat <<EOT >> ${_CHROOT_ROOT}/etc/dhpc/dhclient.conf

# DNS (by optional-sys-dns)
supersede domain-name-servers ${_DNS1}, ${_DNS2};
EOT
}


echo_debug " system's DNS settings configured."
