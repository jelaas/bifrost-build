#!/bin/bash

SRC=tmux-2.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=74a2855695bccb51b6e301383ad4818c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://github.com/tmux/tmux/releases/download/2.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fossies.org/linux/misc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://rsync.darwinports.org/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-2.1.tar.gz/74a2855695bccb51b6e301383ad4818c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cjj.kr.distfiles.macports.org/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.linuxeye.com/oneinstack/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.pnl.gov/macports/distfiles/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
