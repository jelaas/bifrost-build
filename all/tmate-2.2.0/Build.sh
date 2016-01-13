#!/bin/bash

SRCVER=tmate-2.2.0
PKG=$SRCVER-1 # with build version

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
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install libevent-2.0.22-1 || exit 2
pkg_install zlib-1.2.7-1      || exit 2
pkg_install cmake-2.8.6-1     || exit 2
pkg_install autoconf-2.69-1   || exit 2
pkg_install automake-1.14.1-1 || exit 2
pkg_install pkg-config-0.23-1 || exit 2
pkg_install openssl-1.0.1m-1  || exit 2
pkg_install libtool-2.4-1     || exit 2
pkg_install wget-1.15-3       || exit 2
pkg_install perl-5.10.1-3     || exit 2
pkg_install m4-1.4.17-1       || exit 2
pkg_install gcc-4.6.1-2       || exit 2
pkg_install fake-execinfo_h-2 || exit 2
#pkg_install glib-2.24.2-1     || exit 2
pkg_install file-5.04-1       || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC
#temporal, dev, #delete-me
mv tmate-* "${BUILDDIR}"

#########
# Patch
cd $BUILDDIR
libtool_fix-1
cat > remove-clang-options.sh << 'EOF'
#!/bin/sh
find . -not -path "./debian/*" -type f -print0 | xargs -0 sed -i 's:-Werror::g;s:-Wno-mismatched-tags::g'
EOF
cat > remove-ldl-option.sh << 'EOF'
#!/bin/sh
sed -i 's:-ldl::g' Makefile
EOF
chmod +x remove-clang-options.sh #required to compile msgpack without a clang compatible compiler
chmod +x remove-ldl-option.sh    #this is a static build
sed -i 's:mkdir -p $(MSGPACK)/build:./remove-clang-options.sh; mkdir -p $(MSGPACK)/build:' Makefile.static-build
#sed -i 's:K)/build install:K)/build msgpack-static:' Makefile.static-build
sed -i 's:red.libssh.org/attachments/download/177/$(LIBSSH).tar.xz:git.libssh.org/projects/libssh.git/snapshot/$(LIBSSH).tar.gz:' Makefile.static-build
sed -i 's:wget:wget --no-check-certificate:g' Makefile.static-build
sed -i 's:H)/build install:H)/build ssh_static:' Makefile.static-build
sed -i 's,./configure --enable-static,./configure --enable-static --prefix=/ LIBSSH_CFLAGS="-I$(shell pwd)/libssh-0.7.2/include" LIBSSH_LIBS="-L$(shell pwd)/libssh-0.7.2/build/src -lssh -lutil"; ./remove-ldl-option.sh,' Makefile.static-build
#sed -i '/forkpty-/d'      Makefile.am #forkpty is available in the -lutil library which autoconf don't seem to detect
sed -i 's:, unused:, :' compat/forkpty-aix.c #wtf?
sed -i 's:, unused:, :' compat/setenv.c      #wtf?

#sed -i 's,-flto,,' configure.ac
#sed -i '/AC_CHECK_LIB(dl, dlopen)/d' configure.ac
#sed -i '/-rdynamic/d' Makefile.am
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#./autogen.sh
#B-configure-2 --prefix=/ LIBEVENT_CFLAGS="-I/usr/local/include" LIBEVENT_LIBS="-L/usr/local/lib" LIBNCURSES_CFLAGS="-I/usr/include" LIBNCURSES_LIBS="-L/usr/lib" || exit 1

#########
# Compile
make -f Makefile.static-build || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"  && mkdir -p "${DST}"
chmod +x tmate && cp tmate "${DST}/" || exit 1

#########
# Check result
cd $DST
[ -f tmate ] || exit 1
(file tmate | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
#strip tmate
#[ -d bin ] && strip bin/*

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
