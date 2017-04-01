#!/bin/bash

SRC=psmisc-22.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b864c33285c059bf1e0bcac76bd1f33e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/psmisc/psmisc/Archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
