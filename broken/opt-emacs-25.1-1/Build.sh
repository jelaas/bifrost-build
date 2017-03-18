#!/bin/bash

SRCVER=emacs-25.1
PKG=opt-$SRCVER-1 # with build version

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
# Install dependencies:
pkg_install passwd-file-1 || exit 2
pkg_install group-file-1 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install terminfo-5.7-1 || exit 2
#pkg_install musl-0.9.9-2 || exit 2
pkg_install musl-1.1.16-1 || exit 2
pkg_install util-linux-bin-2.22.2-1 || exit 2

pkg_install autoconf-2.69-1 || exit 2
pkg_install automake-1.15-1 || exit 2
pkg_install m4-1.4.17-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2

export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/emacs-25.1-musl.patch || exit 2
sed -i 's/GNU_LINUX/GLIBC_CRAP/' src/print.c
sed -i 's/$(RUN_TEMACS)/setarch i386 -R $(RUN_TEMACS)/' src/Makefile.in

#########
# Configure
B-configure-1 --prefix=/opt/emacs --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no --without-x || exit 1

#########
# Post configure patch
sed -i 's/setarch 1/setarch i386/' src/Makefile

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
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/emacs/share/emacs/23.2/etc/images
rm -rf opt/emacs/share/emacs/23.2/etc/tutorials
rm -rf opt/emacs/share/man opt/emacs/share/icons
rm -rf opt/emacs/var/games
strip opt/emacs/bin/*

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
