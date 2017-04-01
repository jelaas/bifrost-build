#!/bin/bash

SRC=dhcpcd-4.0.15.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=76214893af7427a8e6f204b055b776a6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://roy.marples.name/downloads/dhcpcd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portage.macrolan.co.za/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.jabawok.net/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
