#!/bin/bash

SRC=db-4.7.25.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ec2b87e833779681a0c3a814aa71359e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.oracle.com/berkeley-db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/db4/db-4.7.25.tar.gz/ec2b87e833779681a0c3a814aa71359e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftpmirror.your.org/pub/misc/Berkeley-DB/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/d/db/db-4.7.25/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netinch.com/pub/LFS/conglomeration/db/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxbase.org/pub/lsb/app-battery/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
