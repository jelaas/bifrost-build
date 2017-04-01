#!/bin/bash

SRC=numactl-2.0.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e84a6351312ec786a4b7978fea76f92b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://oss.sgi.com/www/projects/libnuma/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://attic-distfiles.pld-linux.org/distfiles/by-md5/e/8/e84a6351312ec786a4b7978fea76f92b/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
