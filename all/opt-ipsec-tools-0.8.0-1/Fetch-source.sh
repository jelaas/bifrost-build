#!/bin/bash

SRC=ipsec-tools-0.8.0.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sunet.dl.sourceforge.net/project/ipsec-tools/ipsec-tools/0.8.0/$SRC
