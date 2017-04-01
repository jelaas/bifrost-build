#!/bin/bash

SRC=iptables-1.4.21.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=536d048c8e8eeebcd9757d0863ebb0c0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.iptables.org/projects/iptables/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/iptables/iptables-1.4.21.tar.bz2/536d048c8e8eeebcd9757d0863ebb0c0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/i/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/7.8/i/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/iptables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/i/iptables/iptables-1.4.21/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.7/i/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.netfilter.org/iptables/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lede.rmgss.net/dl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/i/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
