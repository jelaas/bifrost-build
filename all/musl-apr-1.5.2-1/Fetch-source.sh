#!/bin/bash

SRC=apr-1.5.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=4e9769f3349fe11fc0a5e1b224c236aa

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://archive.apache.org/dist/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.heanet.ie/mirrors/www.apache.org/dist/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.jax.hugeserver.com/apache/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.catn.com/pub/apache/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xenia.sote.hu/ftp/mirrors/www.apache.org/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.meisei-u.ac.jp/mirror/apache/dist/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.webhostingreviewjam.com/mirror/apache/apr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.mirror.anlx.net/apr/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
