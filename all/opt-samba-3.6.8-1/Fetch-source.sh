#!/bin/bash

SRC=samba-3.6.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fbb245863eeef2fffe172df779a217be

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.samba.org/samba/ftp/stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/samba/samba/stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/samba/samba-3.6.8.tar.gz/fbb245863eeef2fffe172df779a217be/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/samba/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.mirrorservice.org/sites/ftp.samba.org/stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/samba/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apt2.dilos.org/dilos/srcarch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-bayreuth.de/netsoftware/samba/stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://lfs.rtin.bz/BLFS/conglomeration/samba/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ring.ksc.gr.jp/archives/net/samba/stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/v2014.12/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
