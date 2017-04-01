#!/bin/bash

SRC=pciutils-3.1.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cdb1e5a95ab7ac67349f10c8f77a6d3c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/pciutils/pciutils-3.1.10.tar.gz/cdb1e5a95ab7ac67349f10c8f77a6d3c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux4u.jinr.ru/pub/kernel/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lug.udel.edu/pub/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.oasis.onnetcorp.com/FreeBSD/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://eu.archive.parrotsec.org/mirrors/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.neolabs.kz/freebsd/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.lunar-linux.org/lunar/cache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://wwww.mirror.yandex.ru/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
