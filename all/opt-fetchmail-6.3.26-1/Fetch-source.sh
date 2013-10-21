#!/bin/bash

SRC=fetchmail-6.3.26.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.berlios.de/fetchmail/fetchmail-6.3.26.tar.bz2
