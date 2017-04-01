#!/bin/bash

SRC=vlock-1.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e681cf1ae3ee0619b1183da401e3829b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cthulhu.c3d2.de/~toidinamai/vlock/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
