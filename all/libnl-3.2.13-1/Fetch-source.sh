#!/bin/bash

SRC=libnl-3.2.13.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5f1c6fcf4f56aafbc4bf13ec6ef80cbf

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://people.suug.ch/~tgr/libnl/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libnl3/libnl-3.2.13.tar.gz/5f1c6fcf4f56aafbc4bf13ec6ef80cbf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.infradead.org/~tgr/libnl/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.v40.net/sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
