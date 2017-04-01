#!/bin/bash

SRC=alpine-2.10.clean.tar.lzma
DST=/var/spool/src/"${SRC}"
MD5=727a6eaa577857b98ea74fac6ea42a25

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://patches.freeiz.com/alpine/patches/alpine-2.10/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/727a6eaa577857b98ea74fac6ea42a25/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/alpine/alpine-2.10.clean.tar.lzma/727a6eaa577857b98ea74fac6ea42a25/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
