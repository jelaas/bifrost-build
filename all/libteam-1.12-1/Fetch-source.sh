#!/bin/bash

VER=1.12
SRC=libteam-"${VER}".tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a454da993ec83a7b88a6ea9f472f929b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/jpirko/libteam/archive/v"${VER}".tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
