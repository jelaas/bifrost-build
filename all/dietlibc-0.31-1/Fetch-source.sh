#!/bin/bash

SRC=dietlibc-0.31.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/linux/libs/dietlibc/$SRC \
              || wget -O $DST http://mirror.linux.org.au/linux/libs/dietlibc/$SRC   \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/dietlibc/dietlibc-0.31.tar.bz2/acb98d469ee932d902fdf6de07802b7c/$SRC
