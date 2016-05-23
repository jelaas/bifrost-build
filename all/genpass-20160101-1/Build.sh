#!/bin/bash

SRCVER=genpass-2016.01.01
PKG=genpass-20160101-1 # with build version

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
#pkg_install pkg-version-build || exit 2
pkg_install  file-5.04-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd genpass-*
sed 's/-fstack-protector/-fno-stack-protector/g' libscrypt/Makefile > \
    libscrypt/Makefile.sed
mv  libscrypt/Makefile.sed libscrypt/Makefile
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-2 --prefix=/ --mandir="/" || exit 1

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "${DST}/bin"
chmod +x genpass-static getpass
cp genpass-static "${DST}/bin/genpass"
cp getpass        "${DST}/bin/getpass"

#########
# Check result
cd $DST
[ -f bin/genpass ] || exit 1
[ -f bin/getpass ] || exit 1
(file bin/genpass | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
[ -d bin ] && strip bin/genpass

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
