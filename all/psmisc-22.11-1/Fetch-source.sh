#!/bin/bash

SRC=psmisc-22.11.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://downloads.sourceforge.net/project/psmisc/psmisc/Archive/$SRC || wget --no-check-certificate -O $DST http://downloads.sourceforge.net/project/psmisc/psmisc/$SRC
