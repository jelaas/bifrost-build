#!/bin/bash

SRC=unzip60.tgz
DST=/var/spool/src/"${SRC}"
MD5=62b490407489521db863b523a7f86375

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.info-zip.org/pub/infozip/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/unzip/unzip60.tar.gz/62b490407489521db863b523a7f86375/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/u/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://depot.galaxyproject.org/package/sourceforge/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://librecmc.org/librecmc/downloads/sources/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/unzip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www7.frugalware.org/mirrors/rsync.frugalware.org/frugalware-current/source/apps/unzip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.embeddedarm.com/ftp/mirror/yocto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/62b490407489521db863b523a7f86375/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
