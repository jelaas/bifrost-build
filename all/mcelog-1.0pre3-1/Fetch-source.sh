#!/bin/bash

SRC=mcelog-1.0pre3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=dbdf6507eb34ebc4ce7c583ef6c568c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.kernel.org/pub/linux/utils/cpu/mce/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-13.37/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/salix/x86_64/slackware-14.1/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.37/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.metrocast.net/slackware//slackware-13.37/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.crucial.com.au/slackware/slackware-14.1/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.slackware-brasil.com.br/slackware64-14.0/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.slackware-brasil.com.br/slackware64-14.0/source/a/mcelog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/grimoire/kernels/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
