#!/bin/bash

SRC=emacs-23.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/emacs/$SRC || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/emacs/emacs-23.2a.tar.gz
