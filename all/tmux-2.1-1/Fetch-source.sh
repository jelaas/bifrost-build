#!/bin/bash

SRC=tmux-2.1.tar.gz
DST=/var/spool/src/$SRC
MD5=74a2855695bccb51b6e301383ad4818c

[ -s "$DST" ] || wget -O $DST https://github.com/tmux/tmux/releases/download/2.1/$SRC \
              || wget -O $DST http://fossies.org/linux/misc/$SRC \
              || wget -O $DST http://rsync.darwinports.org/tmux/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
