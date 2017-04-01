#!/bin/bash

SRC=Python-2.7.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0e8c9ec32abf5b732bea7d91b38c3339

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.python.org/ftp/python/2.7/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
