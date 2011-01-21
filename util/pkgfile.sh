#!/bin/bash
T=/tmp/pkgfile.tmp

for PKG in /var/spool/pkg/*.gz; do
	tar tvf $PKG > $T
	if grep -q "$1" $T; then
		echo -n "$(basename $PKG): "
		grep "$1" $T
	fi
done
rm -f $T
