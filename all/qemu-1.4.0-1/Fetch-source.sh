#!/bin/bash

SRC=qemu-1.4.0.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://wiki.qemu-project.org/download/$SRC
