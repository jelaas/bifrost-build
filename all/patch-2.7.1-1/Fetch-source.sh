#!/bin/bash

SRC=patch-2.7.1.tar.gz
DST=/var/spool/src/$SRC

<<<<<<< HEAD
[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/patch/patch-2.7.1.tar.gz
=======
[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/patch/$SRC
>>>>>>> 6db6c7547d7bab1da51e53b5193fa8e9d9509b18
