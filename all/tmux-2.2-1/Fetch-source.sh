#!/bin/bash

SRC=tmux-2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=bd95ee7205e489c62c616bb7af040099

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://github.com/tmux/tmux/releases/download/2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fossies.org/linux/misc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://rsync.darwinports.org/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-2.2.tar.gz/md5/bd95ee7205e489c62c616bb7af040099/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cjj.kr.distfiles.macports.org/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.linuxeye.com/oneinstack/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
