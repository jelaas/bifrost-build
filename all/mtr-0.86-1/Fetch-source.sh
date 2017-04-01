#!/bin/bash

SRC=mtr-0.87.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fbc82d6784c4292ff79651e21ecd649f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.bitwizard.nl/mtr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/OpenBSD/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp5.de.freebsd.org/macports/distfiles/mtr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/m/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.snake.de/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mir0.gentoo-fr.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://eu.archive.parrotsec.org/mirrors/macports-distfiles/mtr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/pub/unix/net/mtr/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
