#!/bin/bash

SRCVER=meta-bifrost-hw
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed "$1" $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:

#########
# Install into dir under /var/tmp/install
function untar {
    if [ ! -f /var/spool/pkg/$1.tar.gz ]; then
	pkg_build $1
	exit 2
    fi
	tar xvf /var/spool/pkg/$1.tar.gz $2
}
rm -rf "$DST"
mkdir -p "$DST"
cd $DST

untar cpuburn_1_4-1
untar dmidecode-2.10-1 
untar ipmitool-1.8.11-1
untar mcelog-1.0pre3-1
untar pciutils-3.1.7-1
untar sysfsutils-2.1.0-1 ./usr/bin/systool
untar sysfsutils-2.1.0-1 ./usr/bin/dlist_test
untar sysfsutils-2.1.0-1 ./usr/bin/get_device
untar sysfsutils-2.1.0-1 ./usr/bin/get_driver
untar sysfsutils-2.1.0-1 ./usr/bin/get_module
untar usbutils-001-1 ./usr/bin/lsusb
untar usbutils-001-1 ./usr/bin/usbhid-dump
untar usbutils-001-1 ./usr/share/usb.ids.gz
untar usbutils-001-1 ./usr/bin/usb-devices

#########
# Clean up
cd $DST

function p {
    while read F; do
	basename $F
    done
}

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
