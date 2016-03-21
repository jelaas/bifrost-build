#!/bin/bash

SRC=net-tools-1.60.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tazenda.demon.co.uk/phil/net-tools/$SRC \
              || wget -O $DST http://mirrors.slackware.com/slackware/slackware-13.37/source/n/net-tools/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/net-tools/net-tools-1.60.tar.bz2/888774accab40217dde927e21979c165/$SRC
