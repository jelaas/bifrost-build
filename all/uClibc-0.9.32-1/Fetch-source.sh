#!/bin/bash

SRC=uClibc-0.9.32.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=cfcb6c25d8ebe12817499d8749ee8ae1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://uclibc.org/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/u/uClibc/uClibc-0.9.32/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://master.revosec.net/sources/1.21/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
