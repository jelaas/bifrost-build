#!/bin/bash

SRC=open-vm-tools-10.0.5-3227872.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=734eccf6e9e007cb37dc4eb3ed6707b5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/open-vm-tools/open-vm-tools/stable-10.0.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/open-vm-tools/open-vm-tools-10.0.5-3227872.tar.gz/734eccf6e9e007cb37dc4eb3ed6707b5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/o/project/op/open-vm-tools/open-vm-tools/stable-10.0.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.polytechnic.edu.na/pub4/sourceforge/o/op/open-vm-tools/open-vm-tools/stable-10.0.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
