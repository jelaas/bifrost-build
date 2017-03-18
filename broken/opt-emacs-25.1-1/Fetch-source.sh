#!/bin/bash

SRC=emacs-25.1.tar.gz
DST=/var/spool/src/$SRC
MD5=d74b597503a68105e61b5b9f6d065b44

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/$SRC \
              || wget -O $DST http://ftp.yz.yamagata-u.ac.jp/pub/GNU/emacs/$SRC \
              || wget -O $DST http://slackware.cs.utah.edu/pub/gnu/emacs/$SRC   \
 || ../../wget-finder -O $DST $SRC:$MD5
