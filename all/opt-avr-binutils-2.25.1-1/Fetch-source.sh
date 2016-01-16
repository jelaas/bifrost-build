#!/bin/bash

SRC=binutils-2.25.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=ac493a78de4fee895961d025b7905be4

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/binutils/$SRC \
              || wget -O $DST http://ftp.uni-kl.de/pub/gnu/binutils/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/binutils/binutils-2.25.1.tar.bz2/ac493a78de4fee895961d025b7905be4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
