#!/bin/bash

SRC=vim-7.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.vim.org/pub/vim/unix/$SRC
