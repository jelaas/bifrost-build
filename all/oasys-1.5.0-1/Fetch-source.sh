#!/bin/bash

SRC=oasys-1.5.0.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/dtn/oasys/oasys-1.5.0/$SRC

