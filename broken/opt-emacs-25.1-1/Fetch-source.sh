#!/bin/bash

SRC=emacs-25.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d74b597503a68105e61b5b9f6d065b44

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.syringanetworks.net/gnu/emacs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/gnu/emacs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/emacs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.securehost.com/gnu/gnu/emacs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.si/emacs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ircam.fr/pub/gnu/gnu/emacs/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
