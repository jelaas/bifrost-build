#!/bin/bash

SRC=sysvinit-2.86.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7d5d61c026122ab791ac04c8a84db967

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/rootlinux/ports/base/sysvinit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/s/sysvinit/sysvinit-2.86/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/puppylinux/sources/s/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/sysvinit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackintosh.workaround.ch/pub/slackintosh/current/source/a/sysvinit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.37/source/a/sysvinit/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/sysvinit/sysvinit-2.86.tar.gz/7d5d61c026122ab791ac04c8a84db967/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
