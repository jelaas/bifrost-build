#!/bin/bash

SRC=tmux-1.7.tar.gz
DST=/var/spool/src/$SRC
MD5=2c48fb9beb22eedba7a5de3b78dd0c03

[ -s "$DST" ] || wget -O $DST http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.7/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-1.7.tar.gz/2c48fb9beb22eedba7a5de3b78dd0c03/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
