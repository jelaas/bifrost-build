#!/bin/bash

SRC=musl-0.9.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=26db4a8bfc28b0762f9a0d448bcc80ea

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
