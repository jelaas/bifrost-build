#!/bin/bash

SRC=ncurses-5.9.tar.gz
DST=/var/spool/src/$SRC
MD5=8cb9c412e5f2d96bc6f459aa8c6282a1

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/pub/gnu/ncurses/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/ncurses/ncurses-5.9.tar.gz/8cb9c412e5f2d96bc6f459aa8c6282a1/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
