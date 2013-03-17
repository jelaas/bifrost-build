#!/bin/bash

# Builds a statically linked perl executable.
# Includes CPAN module XML-Parser, and SSL support

SRCVER=perl-5.10.1
PKG=$SRCVER-3 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install expat-2.0.1-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install openssl-0.9.8y-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
rm -rf $CDIR/$SRCVER
cd $CDIR; tar xf $SRC

# unpack extensions
cd $CDIR/$SRCVER/ext; tar xf /var/spool/src/XML-Parser-2.36.tar.gz || exit 1
cd $CDIR/$SRCVER/ext; tar xf /var/spool/src/Net-SSLeay-1.36.tar.gz || exit 1
cd $CDIR/$SRCVER/ext; tar xf /var/spool/src/IO-Socket-SSL-1.84.tar.gz || exit 1
cd $CDIR/$SRCVER; mv ext/Net-SSLeay-1.36 ext/Net-SSLeay

#########
# Patch
cd $CDIR/$SRCVER
# libtool_fix-1
patch -p0 < $PKGDIR/ssleay.pat || exit 1

#########
# Configure
# -D_SVID_SOURCE makes things BORK!
./Configure -d -e -Uusedl -Uuseperlio -Dprefix=/usr -Dcc=cc -Ud_tm_tm_zone -Ud_tm_tm_gmtoff -Dldflags='' -Dnoextensions=IO/Compress -Dso=none -Accflags='-march=i586' -Dd_usleepproto -Dd_castneg -Ud_u32align -Dvendorprefix=/usr -Dsiteprefix=/usr
# remove stack-protector crap
sed 's/-fstack-protector//g' config.sh > /tmp/config.$$; cp -f /tmp/config.$$ config.sh
sed "s/castflags='139'/castflags='0'/g" config.sh > /tmp/config.$$; cp -f /tmp/config.$$ config.sh
sed "s/d_Gconvert='sprintf((b),\"%.*g\",(n),(x))'/d_Gconvert='gcvt((x),(n),(b))'/g" config.sh > /tmp/config.$$; cp -f /tmp/config.$$ config.sh
sed "s/d_charvspr='define'/d_charvspr='undef'/g" config.sh > /tmp/config.$$; cp -f /tmp/config.$$ config.sh
sed "s/c99_variadic_macros='undef'/c99_variadic_macros='define'/g" config.sh > /tmp/config.$$; cp -f /tmp/config.$$ config.sh
sh ./config.sh

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
#cp $PKGDIR/perl-uclibc-config.h config.h

#########
# Compile
make || exit 1

# Install main perl
rm -rf "$DST"
make install DESTDIR=$DST

cd ext/XML-Parser-2.36
perl Makefile.PL OPTIMIZE="-static -march=i586 -Os"
make
make perl

#########
# Install into dir under /var/tmp/install
make -f Makefile.aperl inst_perl MAP_TARGET=perl DESTDIR=$DST

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -f *.0
rm -rf usr/lib/perl5/5.10.1/pod
# rm -rf usr/share usr/man
#[ -d bin ] && strip bin/*
#[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
