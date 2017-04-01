#!/bin/bash

SRC=fzy-0.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=073dfedc7700b02978f52b465d0223e1

pkg_install wget-1.15-1 || exit 2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/jhawthorn/fzy/archive/0.1.tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
