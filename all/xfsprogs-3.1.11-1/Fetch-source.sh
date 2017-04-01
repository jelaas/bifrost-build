#!/bin/bash

SRC=xfsprogs-3.1.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=de9f1f45026c2f4e0776058d429ff4b6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://oss.sgi.com/projects/xfs/cmd_tars/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnome.org/mirror/archlinux/other/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.zju.edu.cn/archlinux/other/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.archlinux.org/other/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.free.org/pub/frugalware/frugalware-stable/source/base/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tinycorelinux.net/6.x/armv6/tcz/src/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tisys.org/pub/blfs/7.5/x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yellowfiber.net/archlinux/other/xfsprogs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/fatdog/source/700/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hlsys.org/pub/blfs/7.5/x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
