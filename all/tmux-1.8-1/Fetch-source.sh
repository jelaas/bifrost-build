#!/bin/bash

SRC=tmux-1.8.tar.gz
DST=/var/spool/src/$SRC
MD5=b9477de2fe660244cbc6e6d7e668ea0e

[ -s "$DST" ] || wget -O $DST http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.8/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-1.8.tar.gz/b9477de2fe660244cbc6e6d7e668ea0e/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
