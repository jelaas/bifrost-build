#!/bin/bash

SRC=bandwidth-0.23a.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://example.com/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
