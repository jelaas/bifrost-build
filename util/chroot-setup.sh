#!/bin/sh

mount proc -t proc /proc
mount -t sysfs sys sys
[ -c /dev/urandom ] || mdev -s

ln -s /proc/self/fd /dev/fd
ln -s /dev/fd/0 /dev/stdin
ln -s /dev/fd/1 /dev/stdout
ln -s /dev/fd/2 /dev/stderr

exec /bin/bash -li
