#!/bin/bash

SRC=nilfs-utils-2.0.19.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=f110291fe820f5166b0ce2cc004851dd

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nilfs.sourceforge.net/download/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
