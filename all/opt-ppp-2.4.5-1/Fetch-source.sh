#!/bin/bash

SRC=ppp-2.4.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=4621bc56167b6953ec4071043fe0ec57

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.samba.org/pub/ppp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/ppp/ppp-2.4.5.tar.gz/4621bc56167b6953ec4071043fe0ec57/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/samba/ppp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.9/p/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/ppp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages-stable/p/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
