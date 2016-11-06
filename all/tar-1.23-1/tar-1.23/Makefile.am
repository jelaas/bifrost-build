# Main Makefile for GNU tar.

# Copyright (C) 1994, 1995, 1996, 1997, 1999, 2000, 2001, 2003, 2007,
# 2009 Free Software Foundation, Inc.

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3, or (at your option)
## any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
## 02110-1301, USA.

ACLOCAL_AMFLAGS = -I m4
EXTRA_DIST = ChangeLog.1 Make.rules
SUBDIRS = doc gnu lib rmt src scripts po tests

dist-hook: 
	$(MAKE) changelog_dir=$(distdir) ChangeLog
	-rm -f $(distdir).cpio
	find $(distdir) | cpio -Hcrc -o | \
          GZIP=$(GZIP_ENV) gzip -c > $(distdir).cpio.gz

distclean-local:
	-rm -f $(distdir).cpio.gz

include Make.rules

gen_start_date = 2009-03-06
prev_change_log = ChangeLog.CVS
changelog_dir = .


