#!/bin/bash

SRC=nano-2.2.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.nano-editor.org/dist/v2.2/$SRC || wget -O $DST ftp://ftp.gnu.org/pub/gnu/nano/$SRC
