#!/bin/bash

SRC=wpa_supplicant-1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8650f6aa23646ef634402552d0669640

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hostap.epitest.fi/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fileplanet.com/lfs/pub/blfs/conglomeration/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/w/wpa_supplicant/wpa_supplicant-1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://opkg.familienforum.biz/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/linux/lfs/LFS/conglomeration/wpa_supplicant/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
