#!/bin/bash

SRC=dietlibc-0.32.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/dietlibc/dietlibc-0.32.tar.bz2/0098761c17924c15e21d25acdda4a8b5/$SRC || wget -O $DST http://www.kernel.org/pub/linux/libs/dietlibc/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/kernel.org/linux/libs/dietlibc/$SRC
