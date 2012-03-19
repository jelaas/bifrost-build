#!/bin/bash

SRCVER=mysql-5.5.21
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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install zlib-1.2.6-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install procps-3.2.8-2 || exit 2
pkg_install openssl-0.9.8t-1 || exit 2
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install cmake-2.8.5-1 || exit 2
pkg_install bison-2.4.2-1 || exit 2
pkg_install tcp_wrappers-7.6-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/fadv.pat || exit 1
patch -p0 < $PKGDIR/srv0start.pat || exit 1

#########
# Configure
cmake -DCMAKE_INSTALL_PREFIX=/opt/mysql \
-DCMAKE_EXE_LINKER_FLAGS=-static \
-DCMAKE_EXE_LINKER_FLAGS_RELEASE=-static \
-DCMAKE_BUILD_TYPE=Release \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_EMBEDDED_SERVER=1 \
-DWITH_EXTRA_CHARSETS:STRING=utf8 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_SSL=yes \
-DWITH_READLINE=1 \
-DWITH_LIBWRAP=1 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_DATADIR=/var/lib/mysql || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
for f in sql/CMakeFiles/mysqld.dir/link.txt \
 ./client/CMakeFiles/mysqladmin.dir/link.txt \
 ./client/CMakeFiles/mysqlcheck.dir/link.txt \
 ./client/CMakeFiles/mysqlbinlog.dir/link.txt \
 ./client/CMakeFiles/mysqlimport.dir/link.txt \
 ./client/CMakeFiles/mysqltest.dir/link.txt \
 ./client/CMakeFiles/mysqlslap.dir/link.txt \
 ./client/CMakeFiles/mysqlshow.dir/link.txt \
 ./client/CMakeFiles/mysql.dir/link.txt \
 ./tests/CMakeFiles/mysql_client_test.dir/link.txt \
 ./libmysqld/examples/CMakeFiles/mysql_client_test_embedded.dir/link.txt \
 ./libmysqld/examples/CMakeFiles/mysql_embedded.dir/link.txt \
 ./client/CMakeFiles/mysql_plugin.dir/link.txt \
 ./client/CMakeFiles/mysql_upgrade.dir/link.txt \
 ./libmysqld/examples/CMakeFiles/mysqltest_embedded.dir/link.txt \
 ./client/CMakeFiles/mysqldump.dir/link.txt ; do
	if ! [ -f $f ]; then echo $f not found; exit 1; fi
	sed -i 's/-Wl,-Bdynamic//g' $f
	sed -i 's/-Wl,--export-dynamic//g' $f
done

for f in $(find . -name build.make); do
	sed -i 's/-fPIC//g' $f
done

echo 'HAVE_ISNAN:INTERNAL=1' >> CMakeCache.txt
echo '#define HAVE_ISNAN 1' >> include/config.h
echo '#define HAVE_ISNAN 1' >> include/my_config.h

touch Makefile
touch CMakeFiles/cmake.check_cache

#########
# Compile
make VERBOSE=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/opt/mysql
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/mysqld
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.mysqld
chmod +x $OPTDIR/rc.d/rc.mysqld
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/mysql/include opt/mysql/share/man opt/mysql/share/info opt/mysql/lib
strip opt/mysql/bin/*

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
