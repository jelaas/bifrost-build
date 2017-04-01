#!/bin/bash

SRC=libnetfilter_conntrack-1.0.4.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=18cf80c4b339a3285e78822dbd4f08d7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/libnetfilter_conntrack/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/libnetfilter_conntrack/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bindist.wlan-si.net/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://simosnet.com/livecdroom/source/bridge/community/libnetfilter_conntrack/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
