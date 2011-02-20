#!/bin/bash

SRCVER=meta-bifrost-native
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

untar allcaps-1-1
untar cpuinfo-1.1-1
untar cpu_pkts-1-1
untar eth-affinity-1.2.5-1
untar ifinfo-1.6-1
untar loop-1-1
untar make_bifrost-1
untar remount-2-1
untar schedlat-1.2-1

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
