#!/bin/bash

SRC=alpine-2.11.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://slackblog.com/slackware/slackware_source/n/alpine/$SRC \
              || wget -O $DST http://slackbuilds.org/mirror/slackware/slackware-14.1/source/n/alpine/$SRC \
              || wget -O $DST http://ftp.twaren.net/BSD/FreeBSD/distfiles/alpine-2.11/$SRC
