#!/bin/bash

SRC=wpa_supplicant-0.7.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f516f191384a9a546e3f5145c08addda

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hostap.epitest.fi/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/w/wpa_supplicant/wpa_supplicant-0.7.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://buildgear.io/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.jaleco.com/lfs/pub/blfs/conglomeration/wpa_supplicant/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hummypkg.org.uk/hdrfoxt2/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
