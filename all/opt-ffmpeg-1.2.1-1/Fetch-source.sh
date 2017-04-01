#!/bin/bash

SRC=ffmpeg-1.2.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5071a26cc149f380908ce79ec2a677ef

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.ffmpeg.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/ffmpeg/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/ffmpeg/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
