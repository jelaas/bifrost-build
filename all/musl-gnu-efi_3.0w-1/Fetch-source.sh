#!/bin/bash

SRC=gnu-efi_3.0w.orig.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/gnu-efi/$SRC
