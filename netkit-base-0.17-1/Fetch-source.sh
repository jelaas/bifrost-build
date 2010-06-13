#!/bin/bash

SRC=netkit-base-0.17.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/$SRC
