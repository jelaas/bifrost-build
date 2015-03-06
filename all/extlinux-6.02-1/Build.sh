#!/bin/bash

VER=6.02
SRCVER=syslinux-$VER
PKG=extlinux-$VER-1 # with build version

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
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install perl-5.10.1-3 || exit 2
pkg_install nasm-2.08.02-1 || exit 2
pkg_install musl-e2fsprogs-lib-1.42.5-1 || exit 2
pkg_install musl-kernel-headers-3.6.0-1 || exit 2
pkg_install binutils-2.22-1 || exit 2
pkg_install musl-gnu-efi_3.0w-1 || exit 2
pkg_install gcc-4.6.1-2 || exit 2

# Compile against musl:
pkg_install musl-1.1.5-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1

sed -i 's/__uint16_t/uint16_t/' efi/wrapper.h
sed -i 's/__uint32_t/uint32_t/' efi/wrapper.h
sed -i 's/__uint64_t/uint64_t/' efi/wrapper.h

patch -p0 < $PKGDIR/musl.pat || exit 1

sed -i 's,/usr/include,/opt/musl/include,' efi/find-gnu-efi.sh
sed -i 's,/usr/lib,/opt/musl/lib,' efi/find-gnu-efi.sh

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 bios efi32 installer || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make INSTALLROOT=$DST bios efi32 install || exit 1

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf usr/share/syslinux/com32/include usr/man
rm -f usr/bin/mkdiskimage  usr/bin/syslinux2ansi usr/bin/lss16toppm \
      usr/bin/keytab-lilo usr/bin/isohybrid.pl usr/bin/sha1pass usr/bin/ppmtolss16 \
      usr/bin/pxelinux-options usr/bin/md5pass
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
mv usr/share usr/lib
mkdir -p boot/extlinux
cp $BUILDDIR/doc/extlinux.txt boot/extlinux || exit 1
cat > boot/extlinux/extlinux.conf.default <<EOF
PATH /usr/lib/syslinux
DEFAULT menu.c32
PROMPT 0
TIMEOUT 100
MENU TITLE Select Bifrost Kernel
LABEL linux64
  MENU LABEL Bifrost ^64bit kernel
  LINUX /boot/kernel.default-x86_64
  APPEND ro
LABEL linux64s
  MENU LABEL Bifrost ^64bit kernel serialport
  LINUX /boot/kernel.default-x86_64
  APPEND ro console=ttyS0,9600n8 clocksource=tsc
LABEL linux64r
  MENU LABEL Bifrost ^64bit kernel recovery
  LINUX /boot/kernel.default-x86_64
  APPEND ro single
LABEL linux32
  MENU LABEL Bifrost ^32bit kernel
  LINUX /boot/kernel.default-x86_32
  APPEND ro
LABEL linux32s
  MENU LABEL Bifrost ^32bit kernel serialport
  LINUX /boot/kernel.default-x86_32
  APPEND ro console=ttyS0,9600n8 clocksource=tsc
LABEL linux32r
  MENU LABEL Bifrost ^32bit kernel recovery
  LINUX /boot/kernel.default-x86_32
  APPEND ro single
EOF

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
