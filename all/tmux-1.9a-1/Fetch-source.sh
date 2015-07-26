#!/bin/bash

SRC=tmux-1.9a.tar.gz
DST=/var/spool/src/$SRC
MD5=b07601711f96f1d260b390513b509a2d

[ -s "$DST" ] || wget -O $DST http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.9/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/extras/tmux/tmux-1.9a.tar.gz/b07601711f96f1d260b390513b509a2d/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
