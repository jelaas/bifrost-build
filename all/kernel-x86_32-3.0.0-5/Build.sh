#!/bin/bash

V=3.0.0
ARCH=x86_32
SRCVER=kernel-$V
BUILDVERSION=5
PKG=kernel-$ARCH-$V-$BUILDVERSION # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DSTS="/var/tmp/install/supported-$PKG" # supported modules
DSTU="/var/tmp/install/unsupported-$PKG" # unsupported modules
DSTW="/var/tmp/install/wireless-$PKG" # wireless modules
DSTF="/var/tmp/install/firmware-$PKG" # firmware binaries
DSTV="/var/tmp/install/vmlinux-$PKG" # uncompress kernel vmlinux and System.map

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
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install passwd-file-1 || exit 2
pkg_install module-init-tools-3.12-1 || exit 2
pkg_install bifrost-initramfs-7 || exit 2
pkg_install bash-4.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
[ -d "$BUILDDIR" ] && rm -rf "$BUILDDIR"
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
function dopatch {
	echo "patch $1 < $2"
	patch $1 < $2 || exit 1
}

cd $BUILDDIR || exit 1
dopatch -p0 $PKGDIR/menuconfig.pat || exit 1
dopatch -p1 $PKGDIR/ixgbe_sfp_override.pat || exit 1
dopatch -p1 $PKGDIR/ixgbe_rss.pat || exit 1
dopatch -p1 $PKGDIR/pktgen-rx.pat || exit 1

dopatch -p1 $PKGDIR/DOM-core-110310.pat || exit 1
dopatch -p1 $PKGDIR/DOM-core-doc-110310.pat || exit 1
dopatch -p1 $PKGDIR/DOM-include-ethtool.pat || exit 1
dopatch -p1 $PKGDIR/DOM-core-ethtool.pat || exit 1
dopatch -p1 $PKGDIR/DOM-igb-110310.pat || exit 1
dopatch -p1 $PKGDIR/DOM-ixgbe.pat || exit 1
dopatch -p1 $PKGDIR/e1000_e1000e_copybreak.pat || exit 1

# dopatch -p1 $PKGDIR/slub_nomerge.pat || exit 1

dopatch -p0 $PKGDIR/dev_c_remove_module_spam.pat || exit 1
dopatch -p0 $PKGDIR/niu_rx_channel.pat || exit 1
dopatch -p0 $PKGDIR/niu_rx_bytes_2.pat || exit 1

# Backported patches


#########
# Configure
cp -f $PKGDIR/config .config
# exit 1 # This is a nice place to break if you want to change the kernel config
sed -i "s/BIFROST/${BUILDVERSION}-bifrost-$ARCH/" .config

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j 3 V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DSTS"
rm -rf "$DSTU"
rm -rf "$DSTW"
rm -rf "$DSTF"
rm -rf "$DSTV"
mkdir -p $DSTS/boot/grub
mkdir -p $DSTV/boot
mkdir -p $DSTU
mkdir -p $DSTW
mkdir -p $DSTF

make INSTALL_MOD_PATH=$DSTS modules_install
cp arch/x86/boot/bzImage $DSTS/boot/$PKG-bifrost
ln -s $PKG-bifrost $DSTS/boot/kernel.default-$ARCH
cp System.map  $DSTV/boot/System.map-$PKG-bifrost
cp vmlinux  $DSTV/boot/vmlinux-$PKG-bifrost
echo "title   $PKG-bifrost" > $DSTS/boot/grub/$PKG-bifrost.grub
echo "root    (hd0,0)" >> $DSTS/boot/grub/$PKG-bifrost.grub
echo "kernel /boot/$PKG-bifrost rhash_entries=131072 rootdelay=10" >> $DSTS/boot/grub/$PKG-bifrost.grub

cd $DSTS

if [ ! -d lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel ]; then
	echo "Modules directory 'lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel' missing!"
	exit 1
fi

export DSTS DSTU DSTW DSTF DSTV
find lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel|bash $PKGDIR/Filter.sh

# firmware to unsupported
mkdir -p $DSTF/lib
mv $DSTS/lib/firmware $DSTF/lib || exit 1

#########
# Check result
cd $DSTS || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DSTS || exit 1
# rm -rf usr/share usr/man

#########
# Make package
cd $DSTS || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-$V-$BUILDVERSION.tar.gz .
cd $DSTU || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-unsup-$V-$BUILDVERSION.tar.gz .
cd $DSTW || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-wireless-$V-$BUILDVERSION.tar.gz .
cd $DSTF || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-firmware-$V-$BUILDVERSION.tar.gz .
cd $DSTV || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-vmlinux-$V-$BUILDVERSION.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DSTS"
[ "$DEVEL" ] || rm -rf "$DSTU"
[ "$DEVEL" ] || rm -rf "$DSTW"
[ "$DEVEL" ] || rm -rf "$DSTF"
[ "$DEVEL" ] || rm -rf "$DSTV"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
