#!/bin/bash

SRC=keepalived-1.3.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=744025d57c7f065c42fe925b0283897e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.keepalived.org/software/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.voidlinux.eu/keepalived-1.3.2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
