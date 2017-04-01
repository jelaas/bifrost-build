#!/bin/bash

SRC=pciutils-3.2.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fdc92c4665bb169022ffe730b3c08313

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://linux4u.jinr.ru/pub/kernel/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.neolabs.kz/freebsd/ports/local-distfiles/sunpoet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://download.freenas.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.go.jp/archives/Linux/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://eu.archive.parrotsec.org/mirrors/kernel.org/software/utils/pciutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
