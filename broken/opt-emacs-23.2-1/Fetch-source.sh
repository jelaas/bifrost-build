#!/bin/bash

SRC=emacs-23.2.tar.gz
DST=/var/spool/src/$SRC
MD5=b6691852dae0bc142b3c12749f6b7ade

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/$SRC \
              || wget -O $DST http://ftp.yz.yamagata-u.ac.jp/pub/GNU/emacs/$SRC \
              || wget -O $DST http://slackware.cs.utah.edu/pub/gnu/emacs/$SRC   \
 || ../../wget-finder -O $DST $SRC:$MD5
