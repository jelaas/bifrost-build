#!/bin/bash

V=5.5
VER=net-snmp-"${V}"
SRC=net-snmp-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"

[ -s "${DST}" ] || wget -O "${DST}" http://garr.dl.sourceforge.net/project/net-snmp/net-snmp/5.5/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf "${VER}"
    /opt/git/bin/git clone git://net-snmp.git.sourceforge.net/gitroot/net-snmp/net-snmp "${VER}" || exit 1
    cd "${VER}"
    /opt/git/bin/git checkout v"${V}" || exit 1
    rm -rf .git
    cd /tmp
    tar czf "${DST}" "${VER}"
    rm -rf "${VER}"
fi
