#!/bin/bash

SRC=openssl-1.0.1u.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=130bb19745db2a5a09f22ccbbf7e69d0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.org.uk/slackware/slackware/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://riksun.riken.go.jp/archives/pub/net/OpenSSL/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/OpenSSL/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/security/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.dotsrc.org/slackware/slackware-14.1/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.fi.muni.cz/pub/linux/slackware/slackware64-14.0/patches/source/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.standaloneinstaller.com/openssl/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/openssl-ftp/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://it.archive.ubuntu.com/0/openssl/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/security/OpenSSL/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub2/openssl/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.catn.com/pub/openssl/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1u/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openssl.skazkaforyou.com/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
