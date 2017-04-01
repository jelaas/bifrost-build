#!/bin/bash

SRC=alpine-2.11.tar.xz
DST=/var/spool/src/"${SRC}"
MD5=a3bba218787691080d706b36215eec06

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackblog.com/slackware/slackware_source/n/alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackbuilds.org/mirror/slackware/slackware-14.1/source/n/alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/BSD/FreeBSD/distfiles/alpine-2.11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/alpine/alpine-2.11.tar.xz/522b582855fed048d3dea2c5fe1e23a4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ponce.cc/mirrors/slackware-14.1/source/n/alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-14.1/source/n/imapd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.belnet.be/packages/slackware/slackware/source/n/alpine/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.slackware.com/pub/slackware/slackware-14.1/source/n/imapd/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
