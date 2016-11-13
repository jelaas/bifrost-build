#!/bin/bash

SRCVER=exim-4.87
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
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
pkg_install pcre-8.39-1 || exit 2
pkg_install gawk-3.1.8-1 || exit 2
pkg_install openssl-1.0.1t-1 || exit 2
pkg_install passwd-file-1 || exit 2
pkg_install group-file-1 || exit 2
pkg_install gdbm-1.8.3-1 || exit 2
pkg_install libiconv-1.13.1-1 || exit 2
pkg_install tcp_wrappers-7.6-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-1 --prefix=/opt/$PKG --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log
mkdir  -p  Local
grep  -v  "EXIM_MONITOR="  src/EDITME  >  Local/Makefile
echo  "USE_TCP_WRAPPERS=yes"  >> Local/Makefile
echo  "SUPPORT_TLS=yes"          >>  Local/Makefile
echo  "TLS_LIBS=-lssl -lcrypto" >> Local/Makefile
echo  "HAVE_IPV6=yes"  >>  Local/Makefile
echo  "SUPPORT_MAILDIR=yes"  >>  Local/Makefile
echo  "SUPPORT_MAILSTORE=yes"  >>  Local/Makefile
echo  "SUPPORT_MBX=yes"  >>  Local/Makefile
echo  "LOOKUP_PASSWD=yes"  >>  Local/Makefile
echo  "AUTH_CRAM_MD5=yes"  >>  Local/Makefile
echo  "AUTH_PLAINTEXT=yes"  >>  Local/Makefile
echo  "BIN_DIRECTORY=/opt/exim/bin"          >>  Local/Makefile
echo  "CONFIGURE_FILE=/opt/exim/etc/exim.conf"    >>  Local/Makefile
echo  "SPOOL_DIRECTORY=/var/spool/mail"  >>  Local/Makefile
echo  "LOG_FILE_PATH=/var/log/exim_%s:"  >>  Local/Makefile
echo  "CFLAGS=-static -Os -march=i586"   >>  Local/Makefile
echo  "LDFLAGS=-static"                  >>  Local/Makefile
echo  "LFLAGS=-static"                  >>  Local/Makefile
echo  "EXIM_UID=`id -u exim`"            >>  Local/Makefile
echo  "EXIM_GID=`id -g exim`"            >>  Local/Makefile
echo  "EXIM_USER=exim"                   >>  Local/Makefile
echo  "EXIM_GROUP=exim"                  >>  Local/Makefile
echo  "PCRE_LIBS=-lpcre"                 >> Local/Makefile
echo  "EXTRALIBS=-lwrap -liconv"	 >>  Local/Makefile
echo "DBMLIB=-lgdbm" >> Local/Makefile
echo "USE_GDBM=yes" >> Local/Makefile

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
FULLECHO='' make -e || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

OPTDIR=$DST/opt/exim
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
mv $OPTDIR/etc/exim.conf $OPTDIR/etc/config.preconf/exim.conf.default || exit 1
echo yes > $OPTDIR/etc/config.flags/exim
cp src/aliases.default $DST/opt/exim/etc/config.preconf/aliases.default || exit 1
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.exim
chmod a+x $OPTDIR/rc.d/rc.exim
echo $PKG > $OPTDIR/pkgversion
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/exim/bin/exim|grep -qs "not a dynamic executable") || exit 1
(ldd opt/exim/bin/exim_lock|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
# rm -rf usr/share usr/man
strip opt/exim/bin/*

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
