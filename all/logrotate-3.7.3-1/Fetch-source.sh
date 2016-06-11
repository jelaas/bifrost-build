#!/bin/bash

SRC=logrotate-3.7.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/logrotate/logrotate-3.7.3.tar.gz/266c48560ba588649f815a0c59edb488/$SRC
