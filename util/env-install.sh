#!/bin/sh

[ -d /proc/1 ]      || mount proc -t proc /proc
[ -d /sys/class ]   || mount -t sysfs sys /sys
[ -c /dev/urandom ] || mdev -s

[ -d /proc/self/fd ] && [ ! -e /dev/fd ] && ln -s /proc/self/fd /dev/fd
[ -L /dev/fd/0 ] && [ ! -e /dev/stdin ]  && ln -s /dev/fd/0 /dev/stdin  2>/dev/null
[ -L /dev/fd/1 ] && [ ! -e /dev/stdout ] && ln -s /dev/fd/1 /dev/stdout 2>/dev/null
[ -L /dev/fd/2 ] && [ ! -e /dev/stderr ] && ln -s /dev/fd/2 /dev/stderr 2>/dev/null

[ -f /bin/env-hooks.sh ] && . /bin/env-hooks.sh

for arg; do #parse options
    case "${arg}" in
        -b|--blob|--binary) binary="true" && shift ;;
    esac
done

if [ "${binary}" ] && [ ! -f /var/spool/pkg/"${1}".tar.gz ]; then
    [ ! -f /var/spool/pkg/tar-1.23-1.tar.gz ] && \
        /var/lib/build/static-get -f gz -d /var/spool/pkg "tar-1.23-1" > /dev/null
   /var/lib/build/static-get -f gz -d /var/spool/pkg "${1}" >/dev/null
fi

[ -f /var/spool/pkg/"${1}".tar.gz ] || /var/lib/build/pkg_build "${1}"
exec /var/lib/build/pkg_install --permanent "${1}"
