#!/bin/bash

SRC=iptables-1.4.21.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.iptables.org/projects/iptables/files/$SRC
