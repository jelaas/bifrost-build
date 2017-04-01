#!/bin/bash

SRC=which-2.20.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=95be0501a466e515422cde4af46b2744

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/which/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/which/which-2.20.tar.gz/95be0501a466e515422cde4af46b2744/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.easthsia.com/gnu/which/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wayne.edu/gnu/which/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/which/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wayne.edu/gnu/which/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
