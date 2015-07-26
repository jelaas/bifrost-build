#!/bin/bash

SRC=tmux-1.6.tar.gz
DST=/var/spool/src/$SRC
MD5=3e37db24aa596bf108a0442a81c845b3

[ -s "$DST" ] || wget -O $DST http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.6/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/tmux/tmux-1.6.tar.gz/3e37db24aa596bf108a0442a81c845b3/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
