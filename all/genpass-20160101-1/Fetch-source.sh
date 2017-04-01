#!/bin/bash

SRC=2016.01.01.tar.gz
DST=/var/spool/src/genpass-"${SRC}"
MD5=fd61f9eec854f2e7983d0ae9c643915d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://github.com/chilicuil/genpass/archive/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
