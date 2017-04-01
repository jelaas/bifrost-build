#!/bin/bash

SRC=mfs-1.6.19.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=21a86c7a521c8682868eb8c0b330fb58

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://moosefs.org/tl_files/mfscode/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
