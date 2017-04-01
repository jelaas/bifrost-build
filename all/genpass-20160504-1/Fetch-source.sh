#!/bin/bash

SRC=2016.05.04.tar.gz
DST=/var/spool/src/genpass-"${SRC}"
MD5=cb936bc226b09fae4c7c2bc2c04e80b8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://github.com/chilicuil/genpass/archive/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
