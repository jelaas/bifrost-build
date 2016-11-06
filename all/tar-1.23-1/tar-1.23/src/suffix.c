/* This file is part of GNU tar.
   Copyright (C) 2007, 2009 Free Software Foundation, Inc.

   Written by Sergey Poznyakoff.

   GNU tar is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 3, or (at your option) any later
   version.

   GNU tar is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
   Public License for more details.

   You should have received a copy of the GNU General Public License along
   with GNU tar.  If not, see <http://www.gnu.org/licenses/>.  */

#include <system.h>
#include "common.h"

struct compression_suffix
{
  const char *suffix;
  size_t length;
  const char *program;
};

static struct compression_suffix compression_suffixes[] = {
#define __CAT2__(a,b) a ## b  
#define S(s,p) #s, sizeof (#s) - 1, __CAT2__(p,_PROGRAM)
  { S(gz,   GZIP) },
  { S(tgz,  GZIP) },
  { S(taz,  GZIP) },
  { S(Z,    COMPRESS) },
  { S(taZ,  COMPRESS) },
  { S(bz2,  BZIP2) },
  { S(tbz,  BZIP2) },
  { S(tbz2, BZIP2) },
  { S(tz2,  BZIP2) },
  { S(lz,   LZIP) },
  { S(lzma, LZMA) },
  { S(tlz,  LZMA) },
  { S(lzo,  LZOP) },
  { S(xz,   XZ) },
#undef S
#undef __CAT2__
};

static int nsuffixes = sizeof (compression_suffixes) /
                        sizeof (compression_suffixes[0]);

static const char *
find_compression_program (const char *name, const char *defprog)
{
  char *suf = strrchr (name, '.');
    
  if (suf)
    {
      int i;
      size_t len;

      suf++;
      len = strlen (suf);

      for (i = 0; i < nsuffixes; i++)
	{
	  if (compression_suffixes[i].length == len
	      && memcmp (compression_suffixes[i].suffix, suf, len) == 0)
	    return compression_suffixes[i].program;
	}
    }
  return defprog;
}

void
set_comression_program_by_suffix (const char *name, const char *defprog)
{
  const char *program = find_compression_program (name, defprog);
  if (program)
    use_compress_program_option = program;
}

