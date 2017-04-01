#!/bin/bash

SRC=zlib-1.2.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1c9f62f0778697a09d36121ead88e08e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://zlib.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.zlib.net/fossils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
