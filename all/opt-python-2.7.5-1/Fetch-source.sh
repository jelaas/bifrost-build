#!/bin/bash

SRC=Python-2.7.5.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=6334b666b7ff2038c761d7b27ba699c1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.python.org/ftp/python/2.7.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://alien.slackbook.org/slackbuilds/calibre/build/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/people/alien/slackbuilds/calibre/build/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.sohu.com/python/2.7.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/0linux/archives_sources/python/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.slackware.com/~alien/slackbuilds/calibre/build/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
