#!/bin/bash

SRCVER=util-linux-2.26.2
PKG=util-linux-bin-2.26.2-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install musl-1.1.8-1  || exit 2

pkg_install group-file-1 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install musl-e2fsprogs-lib-1.42.5-1 || exit 2
pkg_install musl-zlib-1.2.7-1 || exit 2
pkg_install musl-kernel-headers-3.17.0-1 || exit 2
pkg_install musl-console-tools-lib-0.2.3-1 || exit 2

export CC=musl-gcc

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
#patch -p0 < $PKGDIR/util-linux-ng_fstab_d.pat || exit 1
#patch -p0 < $PKGDIR/sysfs.pat || exit 1
patch -p0 < $PKGDIR/mtab.pat || exit 1
patch -p0 < $PKGDIR/fsck.minix.pat || exit 1

echo '#define UL_SCNsA	"%ms"' >> include/c.h
sedit 's/program_invocation_short_name/NULL/' misc-utils/findfs.c
sed -i 's/program_invocation_short_name/"findmnt"/' misc-utils/findmnt.c
sedit 's/program_invocation_short_name/NULL/' misc-utils/namei.c
sed -i 's/program_invocation_short_name/"scriptreplay"/' term-utils/scriptreplay.c
sedit 's/program_invocation_short_name/"wipefs"/' misc-utils/wipefs.c

sedit 's/program_invocation_short_name/"mkfs"/' disk-utils/mkfs.c
sedit 's/program_invocation_short_name/"mkswap"/' disk-utils/mkswap.c
sedit 's/program_invocation_short_name/"mkfs.bfs"/' disk-utils/mkfs.bfs.c
sed -i 's/program_invocation_short_name/"blockdev"/' disk-utils/blockdev.c
sed -i 's/program_invocation_short_name/"swaplabel"/' disk-utils/swaplabel.c
sed -i 's/program_invocation_short_name/"mkfs.cramfs"/' disk-utils/mkfs.cramfs.c
sed -i 's/program_invocation_short_name/"isosize"/' disk-utils/isosize.c
sed -i 's/program_invocation_short_name/"fdformat"/' disk-utils/fdformat.c

sedit 's/extern//' misc-utils/cal.c
sed -i 's/program_invocation_short_name/"cal"/' misc-utils/cal.c
sed -i 's/program_invocation_short_name/"logger"/' misc-utils/logger.c
sed -i 's/program_invocation_short_name/"look"/' misc-utils/look.c
sed -i 's/program_invocation_short_name/"mcookie"/' misc-utils/mcookie.c
sed -i 's/program_invocation_short_name/"whereis"/' misc-utils/whereis.c
sed -i 's/program_invocation_short_name/"uuidgen"/' misc-utils/uuidgen.c
sed -i 's/program_invocation_short_name/"rename"/' misc-utils/rename.c
sed -i 's/program_invocation_short_name/"uuidd"/' misc-utils/uuidd.c

sed -i 's/program_invocation_short_name/"ctrlaltdel"/' sys-utils/ctrlaltdel.c
sedit 's/program_invocation_short_name/NULL/' sys-utils/ipcmk.c
sedit 's/program_invocation_short_name/"fallocate"/' sys-utils/fallocate.c
sed -i 's/program_invocation_short_name/"fsfreeze"/' sys-utils/fsfreeze.c
sedit 's/program_invocation_short_name/"ldattach"/' sys-utils/ldattach.c
sedit 's/program_invocation_short_name/"lscpu"/' sys-utils/lscpu.c
sedit 's/program_invocation_short_name/"setarch"/' sys-utils/setarch.c
sedit 's/program_invocation_short_name/"switch_root"/' sys-utils/switch_root.c
sedit 's/program_invocation_short_name/"unshare.c"/' sys-utils/unshare.c
sed -i 's/program_invocation_short_name/"dmesg"/' sys-utils/dmesg.c
sed -i 's/program_invocation_short_name/"mountpoint"/' sys-utils/mountpoint.c
sed -i 's/program_invocation_short_name/"fsfreeze"/' sys-utils/fsfreeze.c
sed -i 's/program_invocation_short_name/"fstrim"/' sys-utils/fstrim.c
sed -i 's/program_invocation_short_name/"ipcs"/' sys-utils/ipcs.c
sed -i 's/program_invocation_short_name/"renice"/' sys-utils/renice.c
sed -i 's/program_invocation_short_name/"rtcwake"/' sys-utils/rtcwake.c

sed -i 's/program_invocation_short_name/"agetty"/' term-utils/agetty.c
sed -i 's/program_invocation_short_name/"script"/' term-utils/script.c
sed -i 's/program_invocation_short_name/"setterm"/' term-utils/setterm.c
sed -i 's/program_invocation_short_name/"wall"/' term-utils/wall.c
sed -i 's/program_invocation_short_name/"mesg"/' term-utils/mesg.c
sed -i 's/program_invocation_short_name/"mesg"/' term-utils/write.c

sedit 's/extern//' text-utils/column.c
sed -i 's/program_invocation_short_name/"more"/' text-utils/more.c
sed -i 's/program_invocation_short_name/"col"/' text-utils/col.c
sed -i 's/program_invocation_short_name/"colcrt"/' text-utils/colcrt.c
sed -i 's/program_invocation_short_name/"colrm"/' text-utils/colrm.c
sed -i 's/program_invocation_short_name/"column"/' text-utils/column.c
sed -i 's/program_invocation_short_name/"tailf"/' text-utils/tailf.c
sed -i 's/program_invocation_short_name/"rev"/' text-utils/rev.c
sed -i 's/program_invocation_short_name/"ul"/' text-utils/ul.c

sed -i 's/program_invocation_short_name/"ionice"/' schedutils/ionice.c
sed -i 's/program_invocation_short_name/"taskset"/' schedutils/taskset.c

sed -i 's/versionsort/alphasort/' libmount/src/tab_parse.c

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/usr --bindir=/bin --disable-su \
 --enable-kill --enable-last --disable-mesg --enable-partx --enable-raw --disable-login \
 --enable-write --localstatedir=/var/run || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j 3 V=1 || exit 1

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
