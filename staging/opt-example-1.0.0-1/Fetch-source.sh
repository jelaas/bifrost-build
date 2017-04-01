#!/bin/bash

SRC=example.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9800d8724815fd84994d9be65ab5e7b8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.on.internet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bifrost-repo/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
