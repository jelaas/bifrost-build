#!/bin/bash

SRC=less-436.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=817bf051953ad2dea825a1cdf460caa4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.greenwoodsoftware.com/less/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/less/less-436.tar.gz/817bf051953ad2dea825a1cdf460caa4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/less/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/less/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.openindiana.org/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://master.us.finkmirrors.net/distfiles/md5/817bf051953ad2dea825a1cdf460caa4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portage.macrolan.co.za/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.jabawok.net/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nara.wide.ad.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
