#!/bin/bash

SRC=uvccapture-0.5.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=2ac901069a35b8954c11b11f6e036989

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://staticwave.ca/source/uvccapture/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
