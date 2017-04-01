#!/bin/bash

SRC=openssl-0.9.8zf.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=c69a4a679233f7df189e1ad6659511ec

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-0.9.8zf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.boulder.ibm.com/sar/CMA/TIA/05adw/1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware64-13.0/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.bokxing.nl/mirror/slackware64-13.1/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackmirror.cbpf.br/pub/slackware/slackware-13.37/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/unix/software/mirrors/ftp.openssl.org/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
