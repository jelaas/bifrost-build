#!/bin/bash

SRC=net-tools-1.60.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=888774accab40217dde927e21979c165

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tazenda.demon.co.uk/phil/net-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/n/net-tools/net-tools-1.60/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/net-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/rootlinux/rootlinux-ports/base/net-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://anduin.linuxfromscratch.org/BLFS/other/net-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.spectrumcontrols.com/OpenSource/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/linux-net-tools/?C=M;O=A"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
