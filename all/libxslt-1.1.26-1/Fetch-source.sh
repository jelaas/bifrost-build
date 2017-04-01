#!/bin/bash

SRC=libxslt-1.1.26.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e61d0364a30146aaa3001296f853b2b9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://xmlsoft.org/libxslt/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libxslt/libxslt-1.1.26.tar.gz/e61d0364a30146aaa3001296f853b2b9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://server1.xrdp.org/xrdp/X11R7.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/gnome2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.thzhost.com/directadmin/services/custombuild/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/libxslt/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.embedian.com/oe-downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/4.x/x86/scm/src/midori/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
