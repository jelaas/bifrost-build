#!/bin/bash

SRC=automake-1.15.tar.gz
DST=/var/spool/src/$SRC
MD5=716946a105ca228ab545fc37a70df3a3

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/automake/$SRC \
              || wget -O $DST http://mirror.cogentco.com/pub/gnu/automake/$SRC \
              || wget -O $DST //ftp.riken.jp/GNU/gnu/automake/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
