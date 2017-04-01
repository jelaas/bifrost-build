#!/bin/bash

SRC=ipgrab-0.9.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=bd29f9b108c00261826d1904a9ac77ae

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sunet.dl.sourceforge.net/project/ipgrab/ipgrab/0.9.10/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
