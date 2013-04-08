#!/bin/bash

SRCVER=emacs-23.2
PKG=opt-$SRCVER-2 # with build version

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
# Install dependencies:
pkg_install passwd-file-1 || exit 2
pkg_install group-file-1 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install terminfo-5.7-1 || exit 2
pkg_install musl-0.9.9-2 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's/GNU_LINUX/GLIBC_CRAP/' src/print.c

#########
# Configure
B-configure-1 --prefix=/opt/emacs --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no --without-x || exit 1

#########
# Post configure patch
patch -p0 < $PKGDIR/emacs_c_abort.pat || exit 1

#########
# Compile
make
(cd src; musl-gcc `./prefix-args -Xlinker  -z nocombreloc` -static -Wl,-znocombreloc -z muldefs  -o temacs\
 pre-crt0.o /opt/musl/lib/crt1.o /opt/musl/lib/crti.o dispnew.o frame.o scroll.o xdisp.o menu.o  window.o\
 charset.o coding.o category.o ccl.o character.o chartab.o cm.o term.o terminal.o xfaces.o\
 emacs.o keyboard.o macros.o keymap.o sysdep.o buffer.o filelock.o insdel.o marker.o minibuf.o fileio.o\
 dired.o filemode.o cmds.o casetab.o casefiddle.o indent.o search.o regex.o undo.o alloc.o data.o doc.o\
 editfns.o callint.o eval.o floatfns.o fns.o font.o print.o lread.o syntax.o unexelf.o bytecode.o process.o\
 callproc.o region-cache.o sound.o atimer.o doprnt.o strftime.o intervals.o textprop.o composite.o md5.o\
 terminfo.o lastfile.o gmalloc.o ralloc.o vm-limit.o  mktime.o getloadavg.o -lncurses -lm -lc /opt/musl/lib/crtn.o)
make || exit 1

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
rm -rf opt/emacs/share/emacs/23.2/etc/images
rm -rf opt/emacs/share/emacs/23.2/etc/tutorials
rm -rf opt/emacs/share/man opt/emacs/share/icons
rm -rf opt/emacs/var/games
strip opt/emacs/bin/*

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
