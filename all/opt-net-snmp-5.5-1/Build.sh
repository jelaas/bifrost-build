#!/bin/bash

SRCVER=net-snmp-5.5
PKG=opt-net-snmp-5.5-1 # with build version

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

#########
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install openssl-0.9.8n-2 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/utent.pat

#########
# Configure
#B-configure-1 --prefix=/opt/snmp --enable-ucd-snmp-compatibility\
# --with-persistent-directory=/var/state/ucd-snmp --with-defaults|| exit 1

LIBS="-lpthread" $PKGDIR/B-configure-1 --enable-ipv6 --with-nl --without-pic\
 --prefix=/opt/snmp --enable-applications --disable-manuals\
 --disable-debugging --disable-deprecated --disable-set-support\
 --disable-snmptrapd-subagent --disable-embedded-perl --without-root-access\
 --disable-shared --without-rpm\
 --with-sys-contact=root@localhost --with-sys-location=unknown\
 --with-default-snmp-version=3 --with-logfile=/var/log/snmpd.log\
 --with-persistent-directory=/var/snmp --enable-ucd-snmp-compatibility\
 --with-mnttab="/etc/mtab"

# --with-mib-modules="mibII/interfaces"

# ucd-snmp/lmSensors need lm_sensors pkg if we want to use it

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

cd $DST
cp $PKGDIR/snmpd.conf opt/snmp/share/snmp
mkdir -p opt/snmp/etc/config.flags
echo yes > opt/snmp/etc/config.flags/snmp
mkdir -p opt/snmp/etc/rc.d
cp $PKGDIR/rc.snmp opt/snmp/etc/rc.d

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/snmp/sbin/snmpd|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST

for f in opt/snmp/bin/net-snmp-config opt/snmp/bin/snmpgetnext opt/snmp/bin/snmpset opt/snmp/bin/snmpusm\
 opt/snmp/bin/snmpbulkwalk opt/snmp/bin/snmptable opt/snmp/bin/snmpbulkget\
 opt/snmp/bin/snmptranslate opt/snmp/bin/snmpstatus opt/snmp/bin/snmpdelta\
 opt/snmp/bin/snmptest opt/snmp/bin/encode_keychange opt/snmp/bin/snmpdf\
 opt/snmp/bin/snmpvacm opt/snmp/bin/snmpnetstat opt/snmp/bin/snmpinform; do
	rm -f $f
done
rm -rf opt/snmp/lib opt/snmp/include opt/snmp/share/snmp/snmp_perl_trapd.pl
strip opt/snmp/bin/* opt/snmp/sbin/*
mkdir -p opt/snmp/share/snmp/mibs

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
