#!/bin/bash

SRC=musl-0.9.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=23b2f609ef3d7a49da77a3c70dda8bfc

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www6.frugalware.org/mirrors/linux/frugalware/frugalware-stable/source/lib-extra/musl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www7.frugalware.org/mirrors/rsync.frugalware.org/frugalware-current/source/lib-extra/musl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
