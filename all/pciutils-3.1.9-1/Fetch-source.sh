#!/bin/bash

SRC=pciutils-3.1.9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e958f5ffb93b12972964381c38f27eb3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/pciutils/pciutils-3.1.9.tar.gz/e958f5ffb93b12972964381c38f27eb3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lug.udel.edu/pub/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.free.fr/mirrors/ftp.kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.proserve.nl/kernel/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://wwww.mirror.yandex.ru/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
