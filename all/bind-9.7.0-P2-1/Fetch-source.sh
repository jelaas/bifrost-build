#!/bin/bash

SRC=bind-9.7.0-P2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=47fc341901f00c1d815bef12ab4533de

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.isc.org/isc/bind9/9.7.0-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.arnes.si/pub/packages3/bind/9.7.0-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/src/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/src/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/isc/bind/9.7.0-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.mirrorservice.org/sites/ftp.isc.org/isc/bind/9.7.0-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/bind/bind-9.7.0-P2.tar.gz/47fc341901f00c1d815bef12ab4533de/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
