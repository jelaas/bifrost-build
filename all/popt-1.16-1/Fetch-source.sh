#!/bin/bash

SRC=popt-1.16.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3743beefa3dd6247a73f8f7a32c14c33

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://rpm5.org/files/popt/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/popt/popt-1.16.tar.gz/3743beefa3dd6247a73f8f7a32c14c33/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/p/popt/popt-1.16/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.6/p/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/6.x/x86/tcz/src/popt/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.opencompute.org/onie/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdata.psru.ac.th/~pisut/Backup_takpao/distfiles90/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.thekeelecentre.com/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
