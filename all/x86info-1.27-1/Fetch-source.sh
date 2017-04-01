#!/bin/bash

SRC=x86info-1.27.tgz
DST=/var/spool/src/"${SRC}"
MD5=a618e4ac1b0aba44ee26aacad3611f1a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://codemonkey.org.uk/projects/x86info/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://codemonkey.org.uk/projects/x86info/old/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kobyla.info/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
