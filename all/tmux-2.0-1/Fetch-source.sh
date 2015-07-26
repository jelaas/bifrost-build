#!/bin/bash

SRC=tmux-2.0.tar.gz
DST=/var/spool/src/$SRC
MD5=9fb6b443392c3978da5d599f1e814eaa

[ -s "$DST" ] || wget -O $DST http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-2.0/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/extras/tmux/tmux-2.0.tar.gz/9fb6b443392c3978da5d599f1e814eaa/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
