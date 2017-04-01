#!/bin/bash

SRC=iperf-3.0.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1bb10c8144460f1b7ce9a4bba55d8dcd

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://stats.es.net/software/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.es.net/pub/iperf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/iperf3/iperf-3.0.1.tar.gz/1bb10c8144460f1b7ce9a4bba55d8dcd/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://lost-contact.mit.edu/afs/cern.ch/alice/daq/ddl/memorybandwidth/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
