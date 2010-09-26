#!/bin/bash

SRCVER=util-linux-ng-2.17.2
PKG=util-linux-ng-bin-2.17.2-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_available ncurses-lib-5.7-1 e2fsprogs-lib-1.41.11-1 zlib-1.2.5-1 console-tools-lib-0.2.3-1
pkg_install group-file-1 || exit 1
pkg_install ncurses-lib-5.7-1 || exit 1
pkg_install e2fsprogs-lib-1.41.11-1 || exit 1
pkg_install zlib-1.2.5-1 || exit 1
pkg_install console-tools-lib-0.2.3-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
function sedit {
    sed $1 $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

libtool_fix-1
patch -p0 < $PKGDIR/util-linux-ng_fstab_d.pat

sedit 's/versionsort/alphasort/' mount/lomount.c
echo '#define program_invocation_short_name argv[0]' >> include/c.h
sedit 's/program_invocation_short_name/argv[0]/' shlibs/blkid/samples/partitions.c
sedit 's/program_invocation_short_name/NULL/' misc-utils/findfs.c
sedit 's/program_invocation_short_name/NULL/' misc-utils/namei.c
sedit 's/program_invocation_short_name/"scriptreplay"/' misc-utils/scriptreplay.c
sedit 's/program_invocation_short_name/"wipefs"/' misc-utils/wipefs.c
sedit 's/extern//' misc-utils/cal.c

sedit 's/program_invocation_short_name/NULL/' sys-utils/ipcmk.c
sedit 's/program_invocation_short_name/"fallocate"/' sys-utils/fallocate.c
sedit 's/program_invocation_short_name/"ldattach"/' sys-utils/ldattach.c
sedit 's/program_invocation_short_name/"lscpu"/' sys-utils/lscpu.c
sedit 's/program_invocation_short_name/"setarch"/' sys-utils/setarch.c
sedit 's/program_invocation_short_name/"switch_root"/' sys-utils/switch_root.c
sedit 's/program_invocation_short_name/"unshare.c"/' sys-utils/unshare.c

sedit 's/extern//' text-utils/column.c

sedit 's/program_invocation_short_name/NULL/g' mount/swapon.c

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/usr --bindir=/bin || exit 1

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

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr/lib usr/include lib
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
[ -d usr/sbin ] && strip usr/sbin/*

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

