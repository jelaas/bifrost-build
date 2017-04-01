#!/bin/bash

SRC=ncftp-3.2.5-src.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=b05c7a6d5269c04891f02f43d4312b30

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.ncftp.com/ncftp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/7.5/n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/ncftp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-13.37/source/n/ncftp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www7.frugalware.org/mirrors/rsync.frugalware.org/frugalware-current/source/network-extra/ncftp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/ncftp/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
