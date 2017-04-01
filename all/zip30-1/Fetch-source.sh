#!/bin/bash

SRC=zip30.tgz
DST=/var/spool/src/"${SRC}"
MD5=7b74551e63f8ee6aab6fbc86676c0d37

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.info-zip.org/pub/infozip/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/z/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/infozip-zip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13349/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/svn/z/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
