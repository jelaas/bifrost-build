#!/bin/bash

SRC=netkit-base-0.17.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sunsite.icm.edu.pl/pub/Linux/distributions/rootlinux/ports/base/netkit/netkit-base-0.17.tar.gz || wget -O $DST ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/$SRC
