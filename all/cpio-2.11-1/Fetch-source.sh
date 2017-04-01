#!/bin/bash

SRC=cpio-2.11.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=20fc912915c629e809f80b96b2e75d7d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/cpio/cpio-2.11.tar.bz2/md5/20fc912915c629e809f80b96b2e75d7d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/gnu/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/ftp.gnu.org/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fireball-public.phys.wvu.edu/mirror/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.cypherpunks.ru/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ussg.iu.edu/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.spinellicreations.com/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.easyname.at/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dvlnx.com/software/gnu/cpio/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/cpio/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
