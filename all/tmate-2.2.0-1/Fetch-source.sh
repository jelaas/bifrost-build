#!/bin/bash

SRC=tmate-2.2.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=2b6d14008d352723ad23deb7a8a07481

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tmate/2.2.0.tar.gz/2b6d14008d352723ad23deb7a8a07481/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/tmate-io/tmate/archive/2.2.0.tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
