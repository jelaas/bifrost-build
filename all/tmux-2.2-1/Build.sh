#!/bin/bash

SRCVER=tmux-2.2
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install libevent-2.0.22-1 || exit 2
pkg_install file-5.04-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/01-make-utf-errors-non-terminal.patch || exit 2
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-2 --prefix=/ --mandir="/" CFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib" || exit 1
#LIBS="-lssl" B-configure-2 --prefix=/ --mandir="/usr/share/man" \
    #--oldincludedir=/opt/musl/include --includedir=/opt/musl/include || exit 1
#CPPFLAGS="-I/opt/musl/include/ncursesw/ -I/opt/musl/include/event2/ -I/opt/musl/include/" LDFLAGS="-L/opt/musl/lib/"  LIBS="-lncurses" B-configure-3 --prefix=/ --mandir="/usr/share/man" || exit 1

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
[ -f bin/tmux ] || exit 1
(file bin/tmux | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
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
