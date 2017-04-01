#!/bin/bash

SRC=git-1.7.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=3da231dbe82ad103373cb530ae7475d5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/kernel.org/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.as35701.net/pub/software/scm/git-core/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/git/git-1.7.1.tar.bz2/md5/3da231dbe82ad103373cb530ae7475d5/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
