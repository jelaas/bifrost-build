#!/bin/bash

SRC=wireless_tools.29.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e06c222e186f7cc013fd272d023710cb

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://hpl.hp.com/personal/Jean_Tourrilhes/Linux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/wireless_tools.29.tar.gz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/wireless_tools.29.tar.gz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://buildgear.io/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/wireless-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-current/source/n/wireless-tools/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware-13.37/source/n/wireless-tools/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
