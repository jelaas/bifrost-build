#!/bin/sh

[ -d /proc/1 ] || mount proc -t proc /proc
[ -d /sys/class ] || mount -t sysfs sys /sys
[ -c /dev/urandom ] || mdev -s

[ -d /proc/self/fd ] && ln -s /proc/self/fd /dev/fd
[ -L /dev/fd/0 ] && ln -s /dev/fd/0 /dev/stdin
[ -L /dev/fd/1 ] && ln -s /dev/fd/1 /dev/stdout
[ -L /dev/fd/2 ] && ln -s /dev/fd/2 /dev/stderr

exec /bin/bash -li
