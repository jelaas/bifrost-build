#!/bin/bash

SRC=dialog-1.1-20100428.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://invisible-island.net/dialog/$SRC
