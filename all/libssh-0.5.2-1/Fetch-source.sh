#!/bin/bash

SRC=libssh-0.5.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=38b67c48af7a9204660a3e08f97ceba6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.libssh.org/files/0.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libssh/libssh-0.5.2.tar.gz/38b67c48af7a9204660a3e08f97ceba6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/libssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libssh/libssh-0.5.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nsysu.edu.tw/FreeBSD/ports/local-distfiles/fluffy/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/libssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-14.0/source/kde/kde-deps-build/libssh/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackware/slackware-current/source/l/libssh/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
