#!/bin/bash

SRC=subversion-1.9.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=243036eb28b50ce517fc228eb3250add

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.mirrors.spacedump.net/subversion/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://es-mirrors.evowise.com/apache/subversion/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/subversion/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.isu.net.sa/pub/apache/subversion/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.belnet.be/subversion/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fileplanet.com/lfs/pub/blfs/conglomeration/subversion/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
