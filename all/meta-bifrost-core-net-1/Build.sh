#!/bin/bash

SRCVER=bifrost-core-net
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

untar bind-9.7.0-P2-1 ./bin/host
untar bridge-utils-1.4-1
untar dhcp-4.1.1-1
untar dhcpcd-4.0.15-1
untar dnsmasq-2.52-1
untar ethtool-v2.6.35-2
untar iproute2-2.6.34-1
untar iptables-1.4.8-1
untar iputils-s20100418-2
untar netkit-base-0.17-1 ./sbin/inetd
untar net-tools-1.60-2
untar ntp-4.2.6p2-1
untar openssh-5.5p1-1
untar traceroute-2.0.16-1
untar whois_5.0.10-1
untar wireless_tools.29-1

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
