#!/bin/bash

SRC=tmux-2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=bd95ee7205e489c62c616bb7af040099

[ -s "$DST" ] || wget -O $DST https://github.com/tmux/tmux/releases/download/2.2/$SRC \
              || wget -O $DST http://fossies.org/linux/misc/$SRC \
              || wget -O $DST http://rsync.darwinports.org/tmux/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
