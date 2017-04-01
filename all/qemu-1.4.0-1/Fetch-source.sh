#!/bin/bash

SRC=qemu-1.4.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=78f13b774814b6b7ebcaf4f9b9204318

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://wiki.qemu-project.org/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/qemu/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.qemu-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/qemu/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
