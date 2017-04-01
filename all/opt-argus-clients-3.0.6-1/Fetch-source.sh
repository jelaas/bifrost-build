#!/bin/bash

SRC=argus-clients-3.0.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=f6289cbe33eb78818a6a7eef3b7f5662

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://qosient.com/argus/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.nic.funet.fi/index/CERT/ftp.cert.dfn.de/pub/tools/audit/argus/src/archive/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.macports.org/argus-clients/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/argus-clients/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ustc.edu.cn/macports/distfiles/argus-clients/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yandex.ru/macports/distfiles/argus-clients/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
