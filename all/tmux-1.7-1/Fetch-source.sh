#!/bin/bash

SRC=tmux-1.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=2c48fb9beb22eedba7a5de3b78dd0c03

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.7/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://stuff.mit.edu/afs/athena/project/bsd/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-1.7.tar.gz/2c48fb9beb22eedba7a5de3b78dd0c03/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
