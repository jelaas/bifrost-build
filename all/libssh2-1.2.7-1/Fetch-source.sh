#!/bin/bash

SRC=libssh2-1.2.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a5d78344886f1282e4008c09bf568076

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.libssh2.org/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libssh2/libssh2-1.2.7.tar.gz/a5d78344886f1282e4008c09bf568076/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.us.leaseweb.net/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netcologne.de/xbmc/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.xbmc.org/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ustc.edu.cn/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ayous.org/pub/pub/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cc.uoc.gr/mirrors/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.its.dal.ca/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
