#!/bin/bash

SRC=libnfnetlink-1.0.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=016fdec8389242615024c529acc1adb8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/libnfnetlink/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/libnfnetlink/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-stable/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://roadster.agcl.us/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://arny.tjps.eu/OpenWrt/EasyBox904xDSL/oem-firmware-info/AT904X-03.10_source_20140310/dl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.kfki.hu/linux/netfilter/ftp/libnfnetlink/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://f.archlinuxvn.org/slitaz/sources/packages-stable/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/GPL/libnfnetlink/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
