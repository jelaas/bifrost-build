#!/bin/bash

SRC=multipath-tools-0.4.9.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=a6d4b48afc28f1f50f5ee4b1b06d2765

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://christophe.varoqui.free.fr/multipath-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.free.org/pub/frugalware/frugalware-stable/source/base/multipath-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www7.frugalware.org/mirrors/rsync.frugalware.org/frugalware-stable/source/base/multipath-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
