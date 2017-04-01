#!/bin/bash

SRC=hostapd-0.7.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=91a7c8d0f090b7104152d3455a84c112

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hostap.epitest.fi/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/hostapd/hostapd-0.7.3.tar.gz/91a7c8d0f090b7104152d3455a84c112/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/h/hostapd/hostapd-0.7.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
