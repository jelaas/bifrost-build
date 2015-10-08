#!/bin/bash

SRC=dovecot-2.2.19.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.2/$SRC
