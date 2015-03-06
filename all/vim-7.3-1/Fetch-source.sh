#!/bin/bash

SRC=vim-7.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=5b9510a17074e2b37d8bb38ae09edbf2

[ -s "$DST" ] || wget -O $DST ftp://ftp.vim.org/pub/vim/unix/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
