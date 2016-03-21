#!/bin/bash

SRC=emacs-23.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/emacs/emacs-23.2a.tar.gz \
              || wget -O $DST http://ftp.yz.yamagata-u.ac.jp/pub/GNU/emacs/$SRC \
              || wget -O $DST http://slackware.cs.utah.edu/pub/gnu/emacs/$SRC
