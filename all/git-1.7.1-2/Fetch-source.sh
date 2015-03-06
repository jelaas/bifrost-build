#!/bin/bash

SRC=git-1.7.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=3da231dbe82ad103373cb530ae7475d5

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/software/scm/git/$SRC \
              || wget -O $DST http://mirror.linux.org.au/software/scm/git/$SRC   \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/git/git-1.7.1.tar.bz2/3da231dbe82ad103373cb530ae7475d5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
