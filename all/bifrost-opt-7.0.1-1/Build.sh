#!/bin/bash

SRCVER=bifrost-opt-7.0
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
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

pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

pkg_install opt-apache-2.2.19-1 || exit 2
pkg_install opt-dovecot-2.0.12-2 || exit 2
pkg_install opt-exim-4.72-1 || exit 2
pkg_install opt-emacs-23.2-1 || exit 2
pkg_install opt-gnuplot-4.4.0-1 || exit 2
pkg_install opt-gpsd-2.95-1 || exit 2
pkg_install opt-mfs-1.6.20-1 || exit 2
pkg_install opt-minicom-2.4-2 || exit 2
pkg_install opt-netperf-2.4.5-1 || exit 2
pkg_install opt-net-snmp-5.5-1 || exit 2
pkg_install opt-quagga-0.99.17-2 || exit 2
pkg_install opt-squid-3.1.7-1 || exit 2
pkg_install opt-wpa_supplicant-0.7.3-1 || exit 2

exit 0
