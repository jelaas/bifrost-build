#!/bin/bash

SRC=vlock-1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.sourcefiles.org/System/Administration/Miscellaneous/$SRC
