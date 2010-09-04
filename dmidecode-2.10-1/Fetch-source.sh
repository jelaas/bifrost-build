#!/bin/bash

SRC=dmidecode-2.10.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://nongnu.uib.no/dmidecode/$SRC
