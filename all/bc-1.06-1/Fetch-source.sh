#!/bin/bash

SRC=bc-1.06.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d44b5dddebd8a7a7309aea6c36fda117

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/bc/bc-1.06.tar.gz/d44b5dddebd8a7a7309aea6c36fda117/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.distributed.net/pub/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yzu.edu.tw/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.systemimager.org/stable/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/damnsmall/dslcore/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ibiblio.org/gnu/ftp/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.slackware.com/pub/slackware/slackware-9.0/source/ap/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxfoundation.org/pub/lsb/impl/packages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/archive/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/bc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://jor1k.com/downloads/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
