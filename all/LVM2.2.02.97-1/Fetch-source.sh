#!/bin/bash

SRC=LVM2.2.02.97.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sources.redhat.com/pub/lvm2/$SRC
