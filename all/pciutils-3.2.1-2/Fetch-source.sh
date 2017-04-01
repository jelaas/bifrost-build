#!/bin/bash

SRC=pciutils-3.2.1.tar.gz
DST=/var/spool/src/"${SRC}"

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.neolabs.kz/freebsd/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.oasis.onnetcorp.com/FreeBSD/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
