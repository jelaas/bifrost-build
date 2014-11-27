#!/bin/bash

SRCVER=ppp-2.4.5
PKG=opt-$SRCVER-3 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 2
pkg_install musl-1.1.5-1 || exit 2 
pkg_install musl-kernel-headers-3.6.0-1 || exit 2
pkg_install groff-1.21-1 || exit 2

export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/patches.pat || exit 1

#sed -i 's/USE_CRYPT=y/#USE_CRYPT=y/' pppd/Makefile.linux
sed -i 's/PLUGIN=y/#PLUGIN=y/' pppd/Makefile.linux

#########
# Configure
B-configure-3 --prefix=/opt/ppp --localstatedir=/var || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log
find . -name Make\*|while read F; do [ -f $F ] && sed -i 's/-O2/-Os -march=i586 -D_XOPEN_SOURCE -D_GNU_SOURCE -D_BSD_SOURCE/' $F; done
find . -name Make\*|while read F; do [ -f $F ] && sed -i 's/-fPIC//' $F; done

#########
# Post configure patch
sed -i 's/DESTDIR = /DESTDIR = $(INSTROOT)/' pppd/plugins/pppol2tp/Makefile
sed -i 's/-o chat/-static -o chat/' chat/Makefile || exit 1
sed -i 's/-O/-static -Os -march=i586/' pppstats/Makefile || exit 1
sed -i 's/-O/-static -Os -march=i586/' pppdump/Makefile || exit 1
sed -i 's/-o pppdump/-static -o pppdump/' pppdump/Makefile || exit 1
sed -i 's/-o pppoe-discovery/-static -o pppoe-discovery/' pppd/plugins/rp-pppoe/Makefile || exit 1

sed -i 's,pppd/plugins;,pppd/plugins; echo ,' Makefile

#########
# Compile
CFLAGS="-Os -march=i586" LDFLAGS="-static" make INSTROOT="$DST"|| exit 1
#make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install INSTROOT=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/opt/ppp
mkdir -p $OPTDIR/etc/config.flags
#mkdir -p $OPTDIR/rc.d
#echo yes > $OPTDIR/etc/config.flags/example
echo $PKG > $OPTDIR/pkgversion
#cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.example
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/ppp/sbin/chat|grep -qs "not a dynamic executable") || exit 1
(ldd opt/ppp/sbin/pppstats|grep -qs "not a dynamic executable") || exit 1
(ldd opt/ppp/sbin/pppdump|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
rm -rf opt/ppp/include
strip opt/ppp/sbin/*

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
