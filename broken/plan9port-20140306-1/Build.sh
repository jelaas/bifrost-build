#!/bin/bash

SRCVER=plan9port-20140306
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tgz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Fetch sources
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install musl-0.9.9-2 || exit 2
#pkg_install musl-1.1.5-1 || exit 2
pkg_install musl-kernel-headers-3.6.0-1 || exit 2
export CC9=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC && cd plan9port

#########
# Patch
sed -i '/sys\/termios.h/d' src/lib9/readcons.c
sed -i 's:9c:9c -march=i586 -Os -g -I/opt/musl/include:g' src/mkmk.sh
sed -i 's:gcc lib/linux-isnptl.c:musl-gcc lib/linux-isnptl.c:g' INSTALL
sed -i 's:#if defined(__linux__:#if defined(__GLIBC__:g' src/lib9/dirread.c
sed -i 's:#elif defined(__sun__) || defined(__NetBSD__):#elif defined(__sun__) || defined(__NetBSD__) || defined(__linux__):g' src/lib9/dirread.c
sed -i 's:9l:9l -static:g' src/mkmk.sh
sed -i '/longjmp/i \
#undef longjmp \
#define longjmp p9longjmp' include/libc.h
sed -i '/stdio.h/a\
#include <sys/types.h>' lib/linux-isnptl.c
sed -i 's:verbose=false:verbose=true:g' bin/9l

#########
# Configure
# No X support
printf "%s\\n" 'CXXFLAGS="-march=i586 -Os -g -I/opt/musl/include"'  > LOCAL.config
printf "%s\\n" 'CFLAGS="-march=i586   -Os -g -I/opt/musl/include"' >> LOCAL.config
printf "%s\\n" 'LDFLAGS="-static"'   >> LOCAL.config
printf "%s\\n" "WSYSTYPE=nowsys"     >> LOCAL.config
#printf "%s\\n" "SYSVERSION=2.6.x"    >> LOCAL.config

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
./INSTALL -b || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "${DST}"/usr/lib/plan9
./INSTALL -c -r /usr/lib/plan9/ || exit 1
cp -r bin/* "${DST}"/usr/lib/plan9 || exit 1
#make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
(ldd bin/mk  |grep -qs "not a dynamic executable") || exit 1
(ldd bin/grep|grep -qs "not a dynamic executable") || exit 1
(ldd bin/sed |grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr
[ -d bin ] && strip bin/*

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
