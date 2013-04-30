#!/bin/bash

VER=1.0.25
SRCVER=minidlna-$VER
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/minidlna_${VER}_src.tar.gz
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
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below

pkg_install musl-queue-1 || exit 2

#- libexif
pkg_install musl-libexif-0.6.21-1 || exit 2

#- libjpeg
pkg_install musl-jpeg-9-1 || exit 2

#- libid3tag
pkg_install musl-libid3tag-0.15.1b-1 || exit 2
pkg_install musl-zlib-1.2.7-1 || exit 2

#- libFLAC
pkg_install musl-flac-1.2.1-1 || exit 2

#- libvorbis
pkg_install musl-libvorbis-1.3.3-1 || exit 2
pkg_install musl-libogg-1.3.0-1 || exit 2

#- sqlite3
pkg_install musl-sqlite-autoconf-3071602-1 || exit 2

#- libavformat (the ffmpeg libraries)
pkg_install musl-libav-9.5-1 || exit 2
#- libuuid


# Compile against musl:
pkg_install musl-0.9.10-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's,/usr/include,/opt/musl/include,' genconfig.sh
sed -i 's,/usr/include,/opt/musl/include,g' Makefile
sed -i 's/gcc/musl-gcc/' Makefile
sed -i 's,-Wall,-I/opt/musl/include,' Makefile
sed -i 's,-I/opt/musl/include/libavutil,,' Makefile
sed -i '/minidlna:/s/$(LNXOBJS) $(LIBS)/$(LNXOBJS)/' Makefile

sed -i 's/LIBS = -lpthread -lexif -ljpeg -lsqlite3 -lavformat -lavutil -lavcodec -lid3tag -lFLAC -logg -lvorbis/LIBS = -lvorbis -logg -lm -lsqlite3 -lpthread -lexif -ljpeg -lFLAC -lm -lid3tag -lz -lavformat -lavcodec -lavutil -lm -static/' Makefile

sed -i 's,linux/limits.h,limits.h,' upnpglobalvars.c
sed -i 's,linux/limits.h,limits.h,' utils.c

sed -i 's,#include <time.h>,#include "config.h",' uuid.c
sed -i 's,#include "log.h",#include "../log.h",' tagutils/tagutils-plist.c

for f in *.c; do
	sed -i 's,<avutil.h>,<libavutil/avutil.h>,' $f
done

#########
# Configure
OPTPREFIX=opt/minidlna
#B-configure-3 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
make config.h

echo '#include <locale.h>' >> config.h
echo '#include <limits.h>' >> config.h
echo '#include <time.h>' >> config.h
echo '#include <sys/types.h>' >> config.h

#########
# Compile
make INSTALLPREFIX=$DST/$OPTPREFIX DESTDIR=$DST || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install INSTALLPREFIX=$DST/$OPTPREFIX DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/$OPTPREFIX
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/minidlna
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.minidlna
chmod +x $OPTDIR/rc.d/rc.minidlna
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/minidlna/sbin/minidlna|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
[ -d $OPTPREFIX/bin ] && strip $OPTPREFIX/bin/*
[ -d $OPTPREFIX/sbin ] && strip $OPTPREFIX/sbin/*
[ -d $OPTPREFIX/usr/bin ] && strip $OPTPREFIX/usr/bin/*

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
