#!/bin/bash

SRC=bash-4.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9800d8724815fd84994d9be65ab5e7b8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/bash/bash-4.1.tar.gz/md5/9800d8724815fd84994d9be65ab5e7b8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.syringanetworks.net/gnu/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.spectrumcontrols.com/OpenSource/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/ports/distfiles/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/distfiles/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.vtx.ch/unix/shell/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/gnu/bash/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/bash/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
