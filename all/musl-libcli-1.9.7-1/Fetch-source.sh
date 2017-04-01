#!/bin/bash

SRC=libcli-1.9.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f33e0fdb8ae8e14e66036424704b201b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/dparrish/libcli/archive/v1.9.7.tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
