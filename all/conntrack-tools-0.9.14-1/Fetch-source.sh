#!/bin/bash

SRC=conntrack-tools-0.9.14.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=7e9344fe85bb68bcf65c35034add6655

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/conntrack-tools/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.netfilter.org/pub/conntrack-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/linux-netfilter/conntrack-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://attic-distfiles.pld-linux.org/by-md5/7/e/7e9344fe85bb68bcf65c35034add6655/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
