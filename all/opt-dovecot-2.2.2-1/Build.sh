#!/bin/bash

SRCVER=dovecot-2.2.2
PKG=opt-dovecot-2.2.2-1 # with build version

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
pkg_install musl-openssl-0.9.8y-1 || exit 2
pkg_install musl-bzip2-lib-1.0.6-1 || exit 2
pkg_install musl-zlib-1.2.7-1 || exit 2

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
sed -i 's/NO_ADDRESS/NO_DATA/' src/dns/dns-client.c

#########
# Configure
B-configure-3 --prefix=/opt/dovecot --sysconfdir=/opt/dovecot/etc --without-sql\
 --without-pam\
 --without-ldap --without-sqlite\
 --without-gssapi --localstatedir=/var || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

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
OPTDIR=$DST/opt/dovecot
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/dovecot
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.dovecot
chmod +x OPTDIR/rc.d/rc.dovecot
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

mkdir -p $DST/opt/dovecot/etc/dovecot/conf.d
cp $DST/opt/dovecot/share/doc/dovecot/example-config/dovecot.conf $DST/opt/dovecot/etc/dovecot/dovecot.conf.sample
cp $PKGDIR/dovecot.conf.sample-shadow-imap $DST/opt/dovecot/etc/dovecot
for f in $DST/opt/dovecot/share/doc/dovecot/example-config/conf.d/*; do
    [ -f $f ] && cp $f $DST/opt/dovecot/etc/dovecot/conf.d/$(basename $f).sample
done

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/dovecot/share opt/dovecot/include opt/dovecot/lib/dovecot
strip opt/dovecot/bin/* opt/dovecot/sbin/* opt/dovecot/libexec/dovecot/*

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
