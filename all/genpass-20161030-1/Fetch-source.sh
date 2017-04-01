#!/bin/bash

SRC=2016.10.30.tar.gz
DST=/var/spool/src/genpass-"${SRC}"
MD5=363a53dcd7e8e8ca54addd01b8f3a457

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/chilicuil/genpass/archive/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
