#!/bin/bash

SRC=automake-1.14.1.tar.gz
DST=/var/spool/src/$SRC
MD5=d052a3e884631b9c7892f2efce542d75

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/automake/$SRC \
              || wget -O $DST http://mirror.cogentco.com/pub/gnu/automake/$SRC \
              || wget -O $DST //ftp.riken.jp/GNU/gnu/automake/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
