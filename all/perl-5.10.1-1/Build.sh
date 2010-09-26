#!/bin/bash

# Builds a dynamically linked perl executable.

SRCVER=perl-5.10.1
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
rm -rf $CDIR/$SRCVER
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
# libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-1 --prefix=/usr || exit 1
#CFLAGS="-march=i586 -Os"
#CONFIG_OPTS="-Ui_db -Duseshrplib -Ulocincpth="
#PERL_PATHS="-Dprefix=/usr -Dvendorprefix=/usr -Dsiteprefix=/usr"
#./Configure -Doptimize="$CFLAGS" -d -e $CONFIG_OPTS $PERL_PATHS || exit 1
#./Configure -d -e -Uusedl -Uuseperlio -Dprefix=/usr -Dcc=cc -Ud_tm_tm_zone -Ud_tm_tm_gmtoff -Dldflags='' -Dnoextensions=IO/Compress -Dso=none -Accflags='-march=i586 -D_SVID_SOURCE' -Dd_usleepproto -Dd_castneg -Ud_u32align
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

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

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
