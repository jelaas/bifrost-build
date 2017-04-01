#!/bin/bash

SRC=tmux-1.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b9477de2fe660244cbc6e6d7e668ea0e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-1.8.tar.gz/b9477de2fe660244cbc6e6d7e668ea0e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://releases.dyne.org/zshaolin/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp1.fr.freebsd.org/pub/frugalware/frugalware-stable/source/apps-extra/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
