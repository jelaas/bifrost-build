#!/bin/bash

SRC=traceroute-2.0.16.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/traceroute/traceroute-2.0.16.tar.gz/3e84c525cdb4184d64aacaf9225e6503/$SRC
