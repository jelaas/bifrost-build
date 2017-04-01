#!/bin/bash

SRC=dialog-1.1-20100428.tgz
DST=/var/spool/src/"${SRC}"
MD5=519c0a0cbac28ddb992111ec2c3f82aa

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://invisible-island.net/dialog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dialog/dialog-1.1-20100428.tgz/md5/519c0a0cbac28ddb992111ec2c3f82aa/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://invisible-mirror.net/archives/dialog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.mirrorservice.org/sites/lynx.isc.org/dialog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
