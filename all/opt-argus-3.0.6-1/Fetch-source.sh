#!/bin/bash

SRC=argus-3.0.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=dbdf8f0c4807fa33dc02b3708987fb10

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://qosient.com/argus/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://qosient.com/argus/dev/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://qosient.com/argus/src/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/argus/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
