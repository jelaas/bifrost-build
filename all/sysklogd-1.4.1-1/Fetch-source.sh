#!/bin/bash

SRC=sysklogd-1.4.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d214aa40beabf7bdb0c9b3c64432c774

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://shlrm.org/sourcemage/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.infodrom.org/projects/sysklogd/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://web.dit.upm.es/~jantonio/m740av/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.vbi.vt.edu/mirrors/linux/slackware/slackware-10.0/source/a/sysklogd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackintosh.workaround.ch/pub/slackintosh/current/source/a/sysklogd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-current/source/a/sysklogd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/sysklogd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-10.2/source/a/sysklogd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
