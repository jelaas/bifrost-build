#!/bin/bash

SRC=daq-0.6.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6ea8aaa6f067f8b8ef6de45b95d55875

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.procyonlabs.com/mirrors/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.psu.ac.th/pub/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/d/daq/daq-0.6.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://val.bmstu.ru/unix/snort/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
