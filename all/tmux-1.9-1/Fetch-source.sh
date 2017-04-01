#!/bin/bash

SRC=tmux-1.9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5f5ed0f03a666279264da45b60075600

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/tmux/tmux-1.9.tar.gz/5f5ed0f03a666279264da45b60075600/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
