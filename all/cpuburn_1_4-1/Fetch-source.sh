#!/bin/bash

SRC=cpuburn_1_4_tar.gz
DST=/var/spool/src/"${SRC}"

[ -s "${DST}" ] || (tar czf "${DST}" cpuburn-1.4)

