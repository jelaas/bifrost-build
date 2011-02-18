#!/bin/bash

#
# Non-essential networking support
#

SRCVER=meta-bifrost-net
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

untar arping-2.09-1
untar arpwatch-2.1a15-1
untar conntrack-tools-0.9.14-2
untar curl-7.20.1-1
untar ncftp-3.2.5-1 ./usr/bin/ncftp
untar netperf-2.4.5-1
untar nmap-5.21-1
untar tcpdump-4.1.1-1
untar telnet-bsd-1.2-1
untar vlan.1.9-1
untar wget-1.12-1

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
