#!/bin/bash

SRC=flex-2.5.35.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/flex/flex-2.5.35.tar.bz2/10714e50cea54dc7a227e3eddcd44d57/$SRC