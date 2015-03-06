#!/bin/bash

SRC=rsync-3.0.8.tar.gz
DST=/var/spool/src/$SRC
MD5=0ee8346ce16bdfe4c88a236e94c752b4

[ -s "$DST" ] || wget -O $DST http://rsync.samba.org/ftp/rsync/src/$SRC \
              || wget -O $DST http://www.mirrorservice.org/sites/rsync.samba.org/src/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/rsync/rsync-3.0.8.tar.gz/0ee8346ce16bdfe4c88a236e94c752b4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
