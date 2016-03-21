#!/bin/bash

SRC=socat-1.7.2.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.dest-unreach.org/socat/download/Archive/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/socat/socat-1.7.2.0.tar.gz/0565dd58800e4c50534c61bbb453b771/$SRC \
              || wget -O $DST http://nue.de.packages.macports.org/macports/distfiles/socat/$SRC
