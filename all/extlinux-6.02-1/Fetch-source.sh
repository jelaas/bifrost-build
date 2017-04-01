#!/bin/bash

SRC=syslinux-6.02.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5410b1c2614cc8375bfc92fe308ca5c8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.kernel.org/pub/linux/utils/boot/syslinux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://free.nchc.org.tw/syslinux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/linux/utils/boot/syslinux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/utils/boot/syslinux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stust.edu.tw/pub/Linux/kernel/linux/utils/boot/syslinux/6.xx/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/linux/utils/boot/syslinux/6.xx/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.internode.on.net/pub/ftp.kernel.org/pub/linux/utils/boot/syslinux/6.xx/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/syslinux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/quirky/quirky6/sources/easy/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
