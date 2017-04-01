#!/bin/bash

SRC=hostapd-1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=236247a7bbd4f60d5fa3e99849d1ffc9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hostap.epitest.fi/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.amlogic.com:8000/download/GPL_code_release/ThirdParty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
