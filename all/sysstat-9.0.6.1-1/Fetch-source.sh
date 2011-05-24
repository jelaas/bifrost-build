#!/bin/bash

SRC=sysstat-9.0.6.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sebastien.godard.pagesperso-orange.fr/$SRC
