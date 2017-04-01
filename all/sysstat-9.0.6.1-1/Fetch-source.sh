#!/bin/bash

SRC=sysstat-9.0.6.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=2f9c5f53480215c11a6489b5c3ce6c39

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sebastien.godard.pagesperso-orange.fr/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.cs.utah.edu/pub/slackware/slackware-13.37/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pieskovisko.sk/slackwareX/slackware-current/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-current/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://spout.ussg.indiana.edu/linux/slackware/slackware-14.1/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns2.autopilotas.lt/slackware64-14.0/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://x.ultranet.biz/slackware/slackware64-14.1/source/ap/sysstat/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
