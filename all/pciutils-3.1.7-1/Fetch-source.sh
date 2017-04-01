#!/bin/bash

SRC=pciutils-3.1.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f3e349d22a3714b4272b171649ad5235

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux4u.jinr.ru/pub/kernel/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lug.udel.edu/pub/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ibiblio.org/pub/linux/hardware/!INDEX.short.html"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://buildgear.io/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://eu.archive.parrotsec.org/mirrors/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
