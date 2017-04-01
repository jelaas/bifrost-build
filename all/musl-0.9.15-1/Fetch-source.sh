#!/bin/bash

SRC=musl-0.9.15.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=06f590a38c85722ee9343db2416425f4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror2.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
