#!/bin/bash

SRC=musl-0.9.9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=bb658954abedc04efe365a9ef44741f7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
