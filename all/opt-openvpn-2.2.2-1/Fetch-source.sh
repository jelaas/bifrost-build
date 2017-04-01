#!/bin/bash

SRC=openvpn-2.2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=c5181e27b7945fa6276d21873329c5c7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://swupdate.openvpn.org/community/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/openvpn/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/openvpn/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-14.0/source/n/openvpn/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/vectorlinux.com/VL64-7.0/source/sourceVL/openvpn/2.2.2/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.slackware.com/slackware/slackware64-14.0/source/n/openvpn/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware64-14.0/source/n/openvpn/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cucat.org/class_notes/extras/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
