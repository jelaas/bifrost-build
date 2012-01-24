#!/bin/bash

SRC=dtn-2.8.0.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/dtn/DTN2/dtn-2.8.0/$SRC

