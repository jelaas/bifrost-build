#!/bin/bash

SRC=cpuid-20110305.src.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=c13317518ce5d9ddba07eff9ead8080c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etallen.com/cpuid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
