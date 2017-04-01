#!/bin/bash

SRC=avrdude-5.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=69b082683047e054348088fd63bad2ff

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nongnu.askapache.com/avrdude/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nchc.org.tw/Unix/NonGNU/avrdude/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/v2012.12/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://packages.mysmartgrid.de/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://archive.is/AnjZ9"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
