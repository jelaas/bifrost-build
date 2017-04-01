#!/bin/bash

SRC=strace-4.14.tar.xz
DST=/var/spool/src/"${SRC}"
MD5=1e39b5f7583256d7dc21170b9da529ae

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/strace/strace/4.14/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.polytechnic.edu.na/pub4/sourceforge/s/st/strace/strace/4.14/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/s/project/st/strace/strace/4.14/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
