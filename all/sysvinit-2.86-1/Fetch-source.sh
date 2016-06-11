#!/bin/bash

SRC=sysvinit-2.86.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/sysvinit/sysvinit-2.86.tar.gz/7d5d61c026122ab791ac04c8a84db967/$SRC
