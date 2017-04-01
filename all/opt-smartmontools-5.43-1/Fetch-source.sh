#!/bin/bash

SRC=smartmontools-5.43.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a1cb2c3d8cc2de377037fe9e7cef40a9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/smartmontools/smartmontools/5.43/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/smartmontools/smartmontools-5.43.tar.gz/a1cb2c3d8cc2de377037fe9e7cef40a9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/s/smartmontools/smartmontools-5.43/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp1.fr.freebsd.org/pub/frugalware/frugalware-current/source/apps/smartmontools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kobyla.info/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.v40.net/sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
