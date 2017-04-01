#!/bin/bash

SRC=procps-3.2.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9532714b6846013ca9898984ba4cd7e0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://procps.sourceforge.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/procps/procps-3.2.8.tar.gz/9532714b6846013ca9898984ba4cd7e0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/clfs/conglomeration/procps/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/procps/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.free.org/pub/frugalware/frugalware-stable/source/base/procps/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackintosh.workaround.ch/pub/slackintosh/current/source/a/procps/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
