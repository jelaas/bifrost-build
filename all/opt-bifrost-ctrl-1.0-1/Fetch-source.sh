#!/bin/bash
V=1.0
VER=bifrost-ctrl-"${V}"
SRC=bifrost-ctrl-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"

[ -s "${DST}" ] && exit 0

pkg_install passwd-file-1 || exit 1
pkg_install git-1.7.1-2 || exit 1
pkg_install openssh-5.5p1-1 || exit 1
cd /tmp
rm -rf "${VER}"
/opt/git/bin/git clone git://github.com/jelaas/bifrost-ctrl.git "${VER}" || exit 1
cd "${VER}"
git checkout "${V}"
cd /tmp
tar czf "${DST}" "${VER}"
rm -rf "${VER}"

