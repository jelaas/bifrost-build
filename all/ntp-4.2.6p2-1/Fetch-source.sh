#!/bin/bash

SRC=ntp-4.2.6p2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cf73cd85f248232c62f8029e6eb05938

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/networking/ntp/ntp4/ntp-4.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/n/ntp/ntp-4.2.6p2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/3.x/tcz/src/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repo.telikin.com/source/distro/tinycorelinux/3.x/tcz/source/ntp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
