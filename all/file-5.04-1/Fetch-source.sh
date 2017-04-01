#!/bin/bash

SRC=file-5.04.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=accade81ff1cc774904b47c72c8aeea0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.astron.com/pub/file/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/file/file-5.04.tar.gz/accade81ff1cc774904b47c72c8aeea0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/f/file/file-5.04/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/file/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/file/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/BSD-ADV/file/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/openwall/Owl/pool/sources/file/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/accade81ff1cc774904b47c72c8aeea0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
