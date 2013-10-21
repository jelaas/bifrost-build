#!/bin/bash

SRC=libtorrent-0.13.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://libtorrent.rakshasa.no/downloads/libtorrent-0.13.2.tar.gz
