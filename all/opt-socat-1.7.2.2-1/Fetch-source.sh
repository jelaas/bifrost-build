#!/bin/bash

SRC=socat-1.7.2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fe70c821a104378a834c3ed1b5971e54

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dest-unreach.org/socat/download/Archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/socat/socat-1.7.2.2.tar.gz/fe70c821a104378a834c3ed1b5971e54/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/minix/distfiles/local/3.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://simosnet.com/livecdroom/source/bridge/extra/socat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.cs.vu.nl/pub/minix/distfiles/local/3.3.0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
