#!/bin/bash

V=2.6.38-rc8
ARCH=x86_32
SRCVER=kernel-$V
BUILDVERSION=3
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
pkg_install bifrost-initramfs-2 || exit 2
pkg_install bash-4.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
patch -p0 < $PKGDIR/menuconfig.pat || exit 1
patch -p1 < $PKGDIR/ixgbe_rss.pat || exit 1
patch -p1 < $PKGDIR/pktgen_noconfig.patch || exit 1
patch -p1 < $PKGDIR/DOM-core-110310.pat || exit 1
patch -p1 < $PKGDIR/DOM-igb-110310.pat || exit 1
patch -p1 < $PKGDIR/DOM-ixgbe-110310.pat || exit 1
patch -p1 < $PKGDIR/ixgbe_sfp_override.pat || exit 1
patch -p1 < $PKGDIR/e1000_e1000e_copybreak.pat || exit 1

# Backported patches
patch -p1 < $PKGDIR/backport_net_ipv4_fib_trie.pat || exit 1
patch -p1 < $PKGDIR/backport_net_ipv4_raw.pat || exit 1

#########
# Configure
cp -f $PKGDIR/config .config
sed -i "s/bifrost-$ARCH/${BUILDVERSION}-bifrost-$ARCH/" .config

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j 3 || exit 1

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
echo "kernel /boot/$PKG-bifrost rhash_entries=131072 root=/dev/sda1 rootdelay=10" >> $DSTS/boot/grub/$PKG-bifrost.grub

# Filter out unsupported modules
function filter_modules {
	while read L; do
		n=0
		if [ -d "$L" ]; then
			mkdir -p $DSTU/$L
			mkdir -p $DSTW/$L
			continue
		fi
		for unsup in net/batman-adv net/ceph/libceph.ko block/DAC960.ko block/cciss.ko \
			     drivers/ide; do
			if [[ $L =~ $unsup ]]; then
				mv $L $DSTU/$L || exit 1
			fi
			continue
		done
		for wireless in wireless net/mac80211; do
			if [[ $L =~ $wireless ]]; then
				mv $L $DSTW/$L || exit 1
				n=1
			fi
			continue
		done
		[ $n = 1 ] && continue
		for supported in kernel/arch/ kernel/crypto/ kernel/lib/ kernel/net/ \
				loop.ko ; do
			[[ $L =~ $supported ]] && n=1
		done
		[ $n = 1 ] && continue
		for unsup in /drivers/ata/ /drivers/parport/ /block/paride/ /char/agp/ /i2c/ message/fusion \
				/mfd/ /drivers/ssb /scsi/ /target/ /uio/ /usb/gadget/; do
			if [[ $L =~ $unsup ]]; then
				mv $L $DSTU/$L || exit 1
			fi
			continue
		done

		if [[ $L =~ kernel/drivers/ ]]; then
			[[ $L =~ kernel/drivers/net/ ]] || continue
		fi
		for supported in e1000 igb ixgbe mdio tulip veth macvlan tg3 niu ixgb; do
			[[ $L =~ $supported ]] && n=1
		done
		[ $n = 1 ] && continue
		mv $L $DSTU/$L || exit 1
	done
}
cd $DSTS

[ -d lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel ] || exit 1
find lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel|filter_modules

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
