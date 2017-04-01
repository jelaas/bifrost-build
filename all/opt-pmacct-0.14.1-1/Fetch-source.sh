#!/bin/bash

SRC=pmacct-0.14.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a1a9805af114df913470933873bba594

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.pmacct.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
