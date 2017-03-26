#!/bin/bash

SRCVER=fdupes-1.51
PKG="${SRCVER}"-1 # with build version

PKGDIR="${PKGDIR:-/var/lib/build/all/$PKG}"
SRC=/var/spool/src/"${SRCVER}".tar.gz
BUILDDIR=/var/tmp/src/"${SRCVER}"
DST=/var/tmp/install/"${PKG}"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
sedit() {
    sed "${1}" "${2}" > /tmp/sedit."${$}"
    cp /tmp/sedit."${$}" "${2}"
    rm /tmp/sedit."${$}"
}

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
cd "$(dirname "${BUILDDIR}")"; tar xf "${SRC}"

#########
# Patch
cd "${SRCVER}"
sedit "s:= /usr/local:= ${DST}:g" Makefile || exit 2
sedit 's:-Wall -O -g:-Wall -O -g -static:g' Makefile || exit 2
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-2 --prefix=/ --mandir="/" || exit 1

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "${DST}"
make install || exit 1

#########
# Check result
cd "${DST}"
[ -f bin/fdupes ]   || exit 1
(file bin/fdupes | grep "statically linked" >/dev/null 2>&1) || exit 1

#########
# Clean up
cd "${DST}"
[ -d bin ] && strip bin/fdupes
rm -rf man/

#########
# Make package
cd "${DST}"
tar czf /var/spool/pkg/"${PKG}".tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "${DEVEL}" ] || rm -rf "${DST}"
[ "${DEVEL}" ] || rm -rf "${BUILDDIR}"
pkg_uninstall
exit 0
