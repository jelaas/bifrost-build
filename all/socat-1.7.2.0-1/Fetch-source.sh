#!/bin/bash

SRC=socat-1.7.2.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0565dd58800e4c50534c61bbb453b771

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dest-unreach.org/socat/download/Archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/socat/socat-1.7.2.0.tar.gz/0565dd58800e4c50534c61bbb453b771/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nue.de.packages.macports.org/macports/distfiles/socat/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
