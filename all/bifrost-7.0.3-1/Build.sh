#!/bin/bash

SRCVER=bifrost-7.0.3
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
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

pkg_install findutils-4.4.2-1 || exit 2

function chk_conflicts {
	local f
	while read f; do
	    [ "$f" ] && [ -e "$f" ] && echo "CONFLICT: \"$f\" from $1 is already installed and will be overwritten!"	
	done
}

#########
# Install into dir under /var/tmp/install
function untar {
    if [ ! -f /var/spool/pkg/$1.tar.gz ]; then
	echo "## Trying to build $1"
	pkg_build $1
    fi
    
    if [ ! -f /var/spool/pkg/$1.tar.gz ]; then
	echo "ERROR: could not find pkg $1"
	exit 1
    fi
    
    [ "$2" ] && [ -e "$2" ] && echo "CONFLICT: \"$2\" from $1 is already installed and will be overwritten!"
    [ "$2" ] || (tar tvf /var/spool/pkg/$1.tar.gz | chk_conflicts $1)
    tar xf /var/spool/pkg/$1.tar.gz $2 || exit 1
}
rm -rf "$DST"
mkdir -p "$DST"
cd $DST

# framework: filesystem structure, scripts, configs etc

untar bifrost-framework-1.0.22-1
cp $PKGDIR/README-bifrost-7.0.3 .
rm -f README.txt
ln -s README-bifrost-7.0.3 README.txt

# admin
untar bc-1.06-1
untar dialog-1.1-20100428-1
untar e3-2.8-1
untar gawk-3.1.8-1
untar ipmask-1
untar nano-2.2.4-1
untar sed-4.2.1-1
untar vim-7.3-1 ./usr/bin/vim && mv usr/bin/vim usr/bin/vi
untar zile-2.3.14-2
untar sysstat-9.0.6.1-1 ./usr/bin/mpstat

# bin64
untar meta-bifrost-bin64-4

# core-net

untar bind-9.7.6-P2-1 ./usr/bin/host
untar bridge-utils-1.4-1
untar dhcp-4.1-ESV-R6-1
untar dhclient-script-1
untar dhcpcd-4.0.15-1
untar dnsmasq-2.52-2
untar ethtool-v2.6.38-3
untar inetutils-1.9.1-1 ./bin/tftp
untar iproute2-2.6.34-2
untar iptables-1.4.8-1
untar iputils-s20100418-2
untar netkit-base-0.17-1 ./sbin/inetd
untar net-tools-1.60-2
untar ntp-4.2.6p2-1
untar openssh-5.5p1-3
untar traceroute-2.0.16-1
untar whois_5.0.10-1
untar wireless_tools.29-1

# fileutils

untar bzip2-bin-1.0.6-1 ./usr/bin/bzip2
untar bzip2-bin-1.0.6-1 ./usr/bin/bzgrep
untar bzip2-bin-1.0.6-1 ./usr/bin/bzmore
untar bzip2-bin-1.0.6-1 ./usr/bin/bzdiff
ln -s /usr/bin/bzip2 ./usr/bin/bunzip2
ln -s /usr/bin/bzip2 ./usr/bin/bzcat
untar diffutils-3.0-1
untar file-5.04-1
untar findutils-4.4.2-1
untar git-1.7.1-3
untar grep-2.6.3-1
untar gzip-1.4-1
untar less-436-1
untar lsof-4.84-1
untar tar-1.23-1
untar which-2.20-1

# hw

untar cpuburn_1_4-1
untar cpuid-20110305-1
untar dmidecode-2.10-1 
untar ipmitool-1.8.11-1
untar lmbench2-1 ./usr/bin/lat_mem_rd
untar mcelog-1.0pre3-1
untar memtest86+-4.10-2
untar pciutils-3.1.9-1
untar sysfsutils-bin-2.1.0-1 ./usr/bin/systool
untar sysfsutils-bin-2.1.0-1 ./usr/bin/dlist_test
untar sysfsutils-bin-2.1.0-1 ./usr/bin/get_device
untar sysfsutils-bin-2.1.0-1 ./usr/bin/get_driver
untar sysfsutils-bin-2.1.0-1 ./usr/bin/get_module
untar usbreset-1
untar usbutils-001-1 ./usr/bin/lsusb
untar usbutils-001-1 ./usr/bin/usbhid-dump
untar usbutils-001-1 ./usr/share/usb.ids.gz
untar usbutils-001-1 ./usr/bin/usb-devices
untar rfcmd-0.1-3

# native

untar allcaps-1-1
untar bifrost-upgrade-3
untar cpuinfo-1.1-1
untar cpu_pkts-1-1
untar dev-populate-1.2-1
untar devtag-1.0.6-1 ./bin/devtag
untar devtag-1.0.6-1 ./bin/devtagns
untar eth-affinity-1.2.7-1
untar ifinfo-1.6-1
untar ifstat2-0.31-1
untar iocethtool-0.2-1
untar loop-1-1
untar make_bifrost-3
untar make-bifrost-image-1
untar nsutil-0.62-1 ./sbin/ns
untar nsutil-0.62-1 ./sbin/nsnetif
untar nsutil-0.62-1 ./sbin/veth
untar nsutil-0.62-1 ./sbin/macvlan
untar remount-2-1
untar rtstat-1
untar schedlat-1.2-1
untar tty_talk-3
untar vers-1-1

# net

untar arping-2.09-1
untar arp-monitor-1.1-1
untar arpwatch-2.1a15-1
untar conntrack-tools-0.9.14-2
untar curl-7.20.1-2
untar ipgrab-0.9.10-1
untar ncftp-3.2.5-1 ./usr/bin/ncftp
untar netperf-2.4.5-1
untar nmap-5.21-2
untar tcpdump-4.1.1-1 ./usr/sbin/tcpdump
mkdir -p bin32
mv ./usr/sbin/tcpdump bin32 || exit 1
untar telnet-bsd-1.2-1
untar vlan.1.9-1
untar wget-1.12-2

# disk

untar parted-3.1-1 ./usr/sbin/partprobe
untar parted-3.1-1 ./usr/sbin/parted
untar multipath-tools-0.4.9-1 ./sbin/kpartx
untar LVM2.2.02.97-1 ./usr/sbin/dmsetup

# core

untar kernel-x86_32-3.0.0-9
untar kernel-x86_64-3.0.0-9

untar bash-4.1-1
untar binutils-2.20.1-1 ./usr/bin/size
untar binutils-2.20.1-1 ./usr/bin/objdump
untar binutils-2.20.1-1 ./usr/bin/ar
untar binutils-2.20.1-1 ./usr/bin/strings
untar binutils-2.20.1-1 ./usr/bin/ranlib
untar binutils-2.20.1-1 ./usr/bin/readelf
untar binutils-2.20.1-1 ./usr/bin/nm
untar binutils-2.20.1-1 ./usr/bin/strip
untar coreutils-7.6-3 ./bin/install
untar coreutils-7.6-3 ./bin/uname
untar coreutils-7.6-3 ./bin/chroot
untar coreutils-7.6-3 ./bin/hostid
untar coreutils-7.6-3 ./bin/nice
untar coreutils-7.6-3 ./bin/who
untar coreutils-7.6-3 ./bin/users
untar coreutils-7.6-3 ./bin/uptime
untar coreutils-7.6-3 ./bin/stty
untar coreutils-7.6-3 ./bin/df
untar coreutils-7.6-3 ./bin/[
untar coreutils-7.6-3 ./bin/chgrp
untar coreutils-7.6-3 ./bin/chown
untar coreutils-7.6-3 ./bin/chmod
untar coreutils-7.6-3 ./bin/cp
untar coreutils-7.6-3 ./bin/dd
untar coreutils-7.6-3 ./bin/du
untar coreutils-7.6-3 ./bin/ln
untar coreutils-7.6-3 ./bin/ls
untar coreutils-7.6-3 ./bin/mkdir
untar coreutils-7.6-3 ./bin/mkfifo
untar coreutils-7.6-3 ./bin/mknod
untar coreutils-7.6-3 ./bin/mktemp
untar coreutils-7.6-3 ./bin/mv
untar coreutils-7.6-3 ./bin/nohup
untar coreutils-7.6-3 ./bin/readlink
untar coreutils-7.6-3 ./bin/rm
untar coreutils-7.6-3 ./bin/rmdir
untar coreutils-7.6-3 ./bin/shred
untar coreutils-7.6-3 ./bin/stat
untar coreutils-7.6-3 ./bin/sync
untar coreutils-7.6-3 ./bin/touch
untar coreutils-7.6-3 ./bin/cat
untar coreutils-7.6-3 ./bin/csplit
untar coreutils-7.6-3 ./bin/cut
untar coreutils-7.6-3 ./bin/head
untar coreutils-7.6-3 ./bin/join
untar coreutils-7.6-3 ./bin/groups
untar coreutils-7.6-3 ./bin/md5sum
untar coreutils-7.6-3 ./bin/nl
untar coreutils-7.6-3 ./bin/od
untar coreutils-7.6-3 ./bin/paste
untar coreutils-7.6-3 ./bin/ptx
untar coreutils-7.6-3 ./bin/sha1sum
untar coreutils-7.6-3 ./bin/sha256sum
untar coreutils-7.6-3 ./bin/sha512sum
untar coreutils-7.6-3 ./bin/sort
untar coreutils-7.6-3 ./bin/split
untar coreutils-7.6-3 ./bin/sum
untar coreutils-7.6-3 ./bin/tac
untar coreutils-7.6-3 ./bin/tail
untar coreutils-7.6-3 ./bin/tr
untar coreutils-7.6-3 ./bin/uniq
untar coreutils-7.6-3 ./bin/wc
untar coreutils-7.6-3 ./bin/basename
untar coreutils-7.6-3 ./bin/date
untar coreutils-7.6-3 ./bin/dirname
untar coreutils-7.6-3 ./bin/echo
untar coreutils-7.6-3 ./bin/env
untar coreutils-7.6-3 ./bin/expr
untar coreutils-7.6-3 ./bin/factor
untar coreutils-7.6-3 ./bin/false
untar coreutils-7.6-3 ./bin/id
untar coreutils-7.6-3 ./bin/printf
untar coreutils-7.6-3 ./bin/pwd
untar coreutils-7.6-3 ./bin/seq
untar coreutils-7.6-3 ./bin/sleep
untar coreutils-7.6-3 ./bin/tee
untar coreutils-7.6-3 ./bin/test
untar coreutils-7.6-3 ./bin/timeout
untar coreutils-7.6-3 ./bin/true
untar coreutils-7.6-3 ./bin/truncate
untar coreutils-7.6-3 ./bin/tty
untar coreutils-7.6-3 ./bin/whoami
untar coreutils-7.6-3 ./bin/yes
untar coreutils-7.6-3 ./bin/base64
untar cronie-1.4.4-2
untar e2fsprogs-1.41.11-1 ./sbin/e2fsck
untar e2fsprogs-1.41.11-1 ./sbin/fsck.ext2
untar e2fsprogs-1.41.11-1 ./sbin/fsck.ext3
untar e2fsprogs-1.41.11-1 ./sbin/fsck.ext4
untar e2fsprogs-1.41.11-1 ./sbin/fsck.ext4dev
untar e2fsprogs-1.41.11-1 ./sbin/mke2fs
untar e2fsprogs-1.41.11-1 ./sbin/badblocks
untar e2fsprogs-1.41.11-1 ./sbin/tune2fs
untar e2fsprogs-1.41.11-1 ./sbin/dumpe2fs
untar e2fsprogs-1.41.11-1 ./sbin/logsave
untar e2fsprogs-1.41.11-1 ./sbin/e2image
untar e2fsprogs-1.41.11-1 ./sbin/e2undo
untar e2fsprogs-1.41.11-1 ./sbin/mklost+found
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext2
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext3
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext4
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext4dev
untar e2fsprogs-1.41.11-1 ./sbin/e2label
untar e2fsprogs-1.41.11-1 ./sbin/resize2fs
untar e2fsprogs-1.41.11-1 ./bin/chattr
untar e2fsprogs-1.41.11-1 ./bin/lsattr
untar kbd-1.15.2-2
untar kexec-tools-2.0.2-rc2-1
untar libcap-bin-2.19-1
untar logrotate-3.7.3-1
untar module-init-tools-3.12-1
untar ncurses-bin-5.7-1 ./usr/bin/clear
untar numactl-2.0.6-1 ./bin/numactl
untar openssl-0.9.8x-1 ./usr/bin/openssl
untar procps-3.2.8-2 ./usr/bin/free
untar procps-3.2.8-2 ./usr/bin/w
untar procps-3.2.8-2 ./usr/bin/top
untar procps-3.2.8-2 ./usr/bin/vmstat
untar procps-3.2.8-2 ./usr/bin/watch
untar procps-3.2.8-2 ./usr/bin/pgrep
untar procps-3.2.8-2 ./usr/bin/slabtop
untar procps-3.2.8-2 ./usr/bin/pkill
untar procps-3.2.8-2 ./bin/ps
untar procps-3.2.8-2 ./sbin/sysctl
untar psmisc-22.11-1
untar shadow-4.1.4.2-1
untar strace-4.5.20-2
untar sysklogd-1.4.1-1
untar sysvinit-2.86-1 ./sbin/init
untar sysvinit-2.86-1 ./sbin/halt
untar sysvinit-2.86-1 ./sbin/shutdown
untar sysvinit-2.86-1 ./sbin/runlevel
untar sysvinit-2.86-1 ./sbin/killall5
untar sysvinit-2.86-1 ./sbin/sulogin
untar sysvinit-2.86-1 ./sbin/bootlogd
untar sysvinit-2.86-1 ./sbin/reboot
untar sysvinit-2.86-1 ./sbin/poweroff
untar sysvinit-2.86-1 ./sbin/telinit
untar sysvinit-2.86-1 ./bin/mountpoint
untar sysvinit-2.86-1 ./bin/pidof
untar sysvinit-2.86-1 ./usr/bin/utmpdump
untar tcp_wrappers-bin-7.6-1 ./sbin/tcpd
untar terminfo-5.7-1 ./usr/share/terminfo/l/linux
untar terminfo-5.7-1 ./usr/share/terminfo/l/linux-basic
untar terminfo-5.7-1 ./usr/share/terminfo/l/linux-c
untar terminfo-5.7-1 ./usr/share/terminfo/l/linux-lat
untar terminfo-5.7-1 ./usr/share/terminfo/l/linux-vt
untar terminfo-5.7-1 ./usr/share/terminfo/n/nxterm
untar terminfo-5.7-1 ./usr/share/terminfo/v/vs100
untar terminfo-5.7-1 ./usr/share/terminfo/v/vt-utf8
untar terminfo-5.7-1 ./usr/share/terminfo/v/vt100
untar terminfo-5.7-1 ./usr/share/terminfo/v/vt220
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-bold
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-color
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-nic
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-pcolor
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterms
untar time-1.7-1
untar util-linux-ng-bin-2.17.2-2 ./sbin/mkfs
untar util-linux-ng-bin-2.17.2-2 ./sbin/mkswap
untar util-linux-ng-bin-2.17.2-2 ./sbin/blockdev
untar util-linux-ng-bin-2.17.2-2 ./sbin/fdisk
untar util-linux-ng-bin-2.17.2-2 ./sbin/sfdisk
untar util-linux-ng-bin-2.17.2-2 ./sbin/cfdisk
untar util-linux-ng-bin-2.17.2-2 ./sbin/agetty
untar util-linux-ng-bin-2.17.2-2 ./sbin/blkid
untar util-linux-ng-bin-2.17.2-2 ./sbin/findfs
untar util-linux-ng-bin-2.17.2-2 ./sbin/ctrlaltdel
untar util-linux-ng-bin-2.17.2-2 ./sbin/pivot_root
untar util-linux-ng-bin-2.17.2-2 ./sbin/hwclock
untar util-linux-ng-bin-2.17.2-2 ./sbin/losetup
untar util-linux-ng-bin-2.17.2-2 ./sbin/swapon
untar util-linux-ng-bin-2.17.2-2 ./sbin/swapoff
untar util-linux-ng-bin-2.17.2-2 ./sbin/fsck
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/isosize
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/getopt
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/last
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/mesg
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/wall
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/ddate
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/logger
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/mcookie
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/script
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/scriptreplay
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/uuidgen
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/setterm
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/rename
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/write
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/chrt
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/ionice
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/taskset
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/flock
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/ipcrm
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/ipcs
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/ipcmk
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/renice
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/setsid
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/setarch
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/lscpu
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/fallocate
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/unshare
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/column
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/hexdump
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/rev
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/line
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/tailf
untar util-linux-ng-bin-2.17.2-2 ./usr/bin/pg
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/uuidd
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/readprofile
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/ldattach
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/rtcwake
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/rdev
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/ramsize
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/vidmode
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/rootflags
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/addpart
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/delpart
untar util-linux-ng-bin-2.17.2-2 ./usr/sbin/partx
untar util-linux-ng-bin-2.17.2-2 ./bin/kill
untar util-linux-ng-bin-2.17.2-2 ./bin/dmesg
untar util-linux-ng-bin-2.17.2-2 ./bin/arch
untar util-linux-ng-bin-2.17.2-2 ./bin/more
untar util-linux-ng-bin-2.17.2-3 ./bin/mount
untar util-linux-ng-bin-2.17.2-3 ./bin/umount
untar vlock-1.4-1 ./usr/bin/vlock && mv usr/bin/vlock bin/lock

echo $SRCVER > etc/.version
echo $PKG > etc/.build

mkdir -p Documentation/pkginfo
find . > Documentation/pkginfo/$PKG

#########
# Clean up
cd $DST

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
