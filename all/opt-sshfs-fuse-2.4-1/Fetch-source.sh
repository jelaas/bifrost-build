#!/bin/bash

SRC=sshfs-fuse-2.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/fuse/sshfs-fuse/2.4/$SRC
