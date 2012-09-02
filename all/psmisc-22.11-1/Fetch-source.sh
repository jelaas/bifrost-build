#!/bin/bash

SRC=psmisc-22.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/psmisc/psmisc/Archive/$SRC || wget -O $DST http://downloads.sourceforge.net/project/psmisc/psmisc/$SRC
