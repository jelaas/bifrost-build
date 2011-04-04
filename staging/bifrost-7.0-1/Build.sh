#!/bin/bash

SRCVER=bifrost-7.0
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
	pkg_build $1
	exit 2
    fi
    [ "$2" ] && [ -e "$2" ] && echo "CONFLICT: \"$2\" from $1 is already installed and will be overwritten!"
    [ "$2" ] || (tar tvf /var/spool/pkg/$1.tar.gz | chk_conflicts $1)
    tar xf /var/spool/pkg/$1.tar.gz $2 || exit 1
}
rm -rf "$DST"
mkdir -p "$DST"
cd $DST
untar bifrost-framework-1.0.7-1

untar kernel-x86_32-2.6.38-rc8-2
untar kernel-x86_64-2.6.38-rc8-2

untar meta-bifrost-admin-1
untar meta-bifrost-hw-1
untar meta-bifrost-native-2
untar meta-bifrost-core-net-1
untar meta-bifrost-net-2
untar meta-bifrost-fileutils-1

untar bash-4.1-1
untar binutils-2.20.1-1 ./usr/bin/size
untar binutils-2.20.1-1 ./usr/bin/objdump
untar binutils-2.20.1-1 ./usr/bin/ar
untar binutils-2.20.1-1 ./usr/bin/strings
untar binutils-2.20.1-1 ./usr/bin/ranlib
untar binutils-2.20.1-1 ./usr/bin/readelf
untar binutils-2.20.1-1 ./usr/bin/nm
untar binutils-2.20.1-1 ./usr/bin/strip
untar coreutils-7.6-1 ./bin/install
untar coreutils-7.6-1 ./bin/uname
untar coreutils-7.6-1 ./bin/chroot
untar coreutils-7.6-1 ./bin/hostid
untar coreutils-7.6-1 ./bin/nice
untar coreutils-7.6-1 ./bin/who
untar coreutils-7.6-1 ./bin/users
untar coreutils-7.6-1 ./bin/uptime
untar coreutils-7.6-1 ./bin/stty
untar coreutils-7.6-1 ./bin/df
untar coreutils-7.6-1 ./bin/[
untar coreutils-7.6-1 ./bin/chgrp
untar coreutils-7.6-1 ./bin/chown
untar coreutils-7.6-1 ./bin/chmod
untar coreutils-7.6-1 ./bin/cp
untar coreutils-7.6-1 ./bin/dd
untar coreutils-7.6-1 ./bin/du
untar coreutils-7.6-1 ./bin/ln
untar coreutils-7.6-1 ./bin/ls
untar coreutils-7.6-1 ./bin/mkdir
untar coreutils-7.6-1 ./bin/mkfifo
untar coreutils-7.6-1 ./bin/mknod
untar coreutils-7.6-1 ./bin/mktemp
untar coreutils-7.6-1 ./bin/mv
untar coreutils-7.6-1 ./bin/nohup
untar coreutils-7.6-1 ./bin/readlink
untar coreutils-7.6-1 ./bin/rm
untar coreutils-7.6-1 ./bin/rmdir
untar coreutils-7.6-1 ./bin/shred
untar coreutils-7.6-1 ./bin/stat
untar coreutils-7.6-1 ./bin/sync
untar coreutils-7.6-1 ./bin/touch
untar coreutils-7.6-1 ./bin/cat
untar coreutils-7.6-1 ./bin/csplit
untar coreutils-7.6-1 ./bin/cut
untar coreutils-7.6-1 ./bin/head
untar coreutils-7.6-1 ./bin/join
untar coreutils-7.6-1 ./bin/groups
untar coreutils-7.6-1 ./bin/md5sum
untar coreutils-7.6-1 ./bin/nl
untar coreutils-7.6-1 ./bin/od
untar coreutils-7.6-1 ./bin/paste
untar coreutils-7.6-1 ./bin/ptx
untar coreutils-7.6-1 ./bin/sha1sum
untar coreutils-7.6-1 ./bin/sha256sum
untar coreutils-7.6-1 ./bin/sha512sum
untar coreutils-7.6-1 ./bin/sort
untar coreutils-7.6-1 ./bin/split
untar coreutils-7.6-1 ./bin/sum
untar coreutils-7.6-1 ./bin/tac
untar coreutils-7.6-1 ./bin/tail
untar coreutils-7.6-1 ./bin/tr
untar coreutils-7.6-1 ./bin/uniq
untar coreutils-7.6-1 ./bin/wc
untar coreutils-7.6-1 ./bin/basename
untar coreutils-7.6-1 ./bin/date
untar coreutils-7.6-1 ./bin/dirname
untar coreutils-7.6-1 ./bin/echo
untar coreutils-7.6-1 ./bin/env
untar coreutils-7.6-1 ./bin/expr
untar coreutils-7.6-1 ./bin/factor
untar coreutils-7.6-1 ./bin/false
untar coreutils-7.6-1 ./bin/id
untar coreutils-7.6-1 ./bin/printf
untar coreutils-7.6-1 ./bin/pwd
untar coreutils-7.6-1 ./bin/seq
untar coreutils-7.6-1 ./bin/sleep
untar coreutils-7.6-1 ./bin/tee
untar coreutils-7.6-1 ./bin/test
untar coreutils-7.6-1 ./bin/timeout
untar coreutils-7.6-1 ./bin/true
untar coreutils-7.6-1 ./bin/truncate
untar coreutils-7.6-1 ./bin/tty
untar coreutils-7.6-1 ./bin/whoami
untar coreutils-7.6-1 ./bin/yes
untar coreutils-7.6-1 ./bin/base64
untar cronie-1.4.4-1
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
untar e2fsprogs-1.41.11-1 ./sbin/uuidd
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext2
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext3
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext4
untar e2fsprogs-1.41.11-1 ./sbin/mkfs.ext4dev
untar e2fsprogs-1.41.11-1 ./sbin/e2label
untar e2fsprogs-1.41.11-1 ./sbin/resize2fs
untar e2fsprogs-1.41.11-1 ./bin/chattr
untar e2fsprogs-1.41.11-1 ./bin/lsattr
untar e2fsprogs-1.41.11-1 ./bin/uuidgen
untar kbd-1.15.2-2
untar kexec-tools-2.0.2-rc2-1
untar libcap-bin-2.19-1
untar logrotate-3.7.3-1
untar module-init-tools-3.12-1
untar ncurses-bin-5.7-1 ./usr/bin/clear
untar numactl-2.0.6-1 ./bin/numactl
untar openssl-0.9.8q-1 ./usr/bin/openssl
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
untar terminfo-5.7-1 ./usr/share/terminfo/n/nxterm
untar terminfo-5.7-1 ./usr/share/terminfo/v/vs100
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-bold
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-color
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-nic
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterm-pcolor
untar terminfo-5.7-1 ./usr/share/terminfo/x/xterms
untar terminfo-5.7-1 ./usr/share/terminfo/v/vt100
untar terminfo-5.7-1 ./usr/share/terminfo/v/vt220
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
untar util-linux-ng-bin-2.17.2-2 ./bin/mount
untar util-linux-ng-bin-2.17.2-2 ./bin/umount
untar vlock-1.4-1 ./usr/bin/vlock && mv usr/bin/vlock bin/lock

echo $SRCVER > etc/.version

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
