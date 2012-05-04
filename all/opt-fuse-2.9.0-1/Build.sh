#!/bin/bash

SRCVER=fuse-2.9.0
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
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install groff-1.21-1 || exit 2 

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
sed -i 's/[-]pthread/-lpthread/' configure
sed -i 's/[-]pthread/-lpthread/' util/Makefile.in
patch -p0 < $PKGDIR/posix_memalign.pat || exit 1
patch -p0 < $PKGDIR/dl.pat || exit 1

#########
# Configure
INIT_D_PATH=/opt/fuse/etc/init.d UDEV_RULES_PATH=/opt/fuse/etc/udev/rules.d MOUNT_FUSE_PATH=/opt/fuse/sbin B-configure-1 --prefix=/opt/fuse --without-pic --disable-example --disable-mtab --disable-silent-rules || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
echo '#define HAVE_DLFCN_H 1' >> include/config.h

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/fuse/bin/fusermount|grep -qs "not a dynamic executable") || exit 1
(ldd opt/fuse/bin/ulockmgr_server|grep -qs "not a dynamic executable") || exit 1
(ldd opt/fuse/sbin/mount.fuse|grep -qs "not a dynamic executable") || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Clean up
cd $DST || exit 1
rm -rf opt/fuse/lib opt/fuse/include opt/fuse/etc dev

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
