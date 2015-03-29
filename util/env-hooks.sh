#!/bin/sh

if [ -d /etc/build ]; then
    for i in /etc/build/*.sh; do
        [ -r "${i}" ] && . "${i}"
    done
    unset i
fi
