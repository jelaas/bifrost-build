/* This file is part of GNU tar. 
   Copyright (C) 2009 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 3, or (at your option) any later
   version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
   Public License for more details.

   You should have received a copy of the GNU General Public License along
   with this program; if not, write to the Free Software Foundation, Inc.,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */

#include <system.h>
#include "common.h"
#include <quotearg.h>

struct deferred_unlink
  {
    struct deferred_unlink *next;   /* Next unlink in the queue */
    char *file_name;                /* Absolute name of the file to unlink */
    bool is_dir;                    /* True if file_name is a directory */
    off_t records_written;          /* Number of records written when this
				       entry got added to the queue */
  };

/* The unlink queue */
static struct deferred_unlink *dunlink_head, *dunlink_tail;

/* Number of entries in the queue */
static size_t dunlink_count;

/* List of entries available for allocation */
static struct deferred_unlink *dunlink_avail;

/* Delay (number of records written) between adding entry to the
   list and its actual removal. */
size_t deferred_unlink_delay = 0;

static struct deferred_unlink *
dunlink_alloc ()
{
  struct deferred_unlink *p;
  if (dunlink_avail)
    {
      p = dunlink_avail;
      dunlink_avail = p->next;
      p->next  = NULL;
    }
  else
    p = xmalloc (sizeof (*p));
  return p;
}

static void
dunlink_reclaim (struct deferred_unlink *p)
{
  free (p->file_name);
  p->next = dunlink_avail;
  dunlink_avail = p;
}

static void
flush_deferred_unlinks (bool force)
{
  struct deferred_unlink *p, *prev = NULL;

  for (p = dunlink_head; p; )
    {
      struct deferred_unlink *next = p->next;
      if (force
	  || records_written > p->records_written + deferred_unlink_delay)
	{
	  if (p->is_dir)
	    {
	      if (rmdir (p->file_name) != 0)
		{
		  switch (errno)
		    {
		    case ENOENT:
		      /* nothing to worry about */
		      break;
		    case ENOTEMPTY:
		      if (!force)
			{
			  /* Keep the record in list, in the hope we'll
			     be able to remove it later */
			  prev = p;
			  p = next;
			  continue;
			}
		      /* fall through */
		    default:
		      rmdir_error (p->file_name);
		    }
		}
	    }
	  else
	    {
	      if (unlink (p->file_name) != 0 && errno != ENOENT)
		unlink_error (p->file_name);
	    }
	  dunlink_reclaim (p);
	  dunlink_count--;
	  p = next;
	  if (prev)
	    prev->next = p;
	  else
	    dunlink_head = p;
	}
      else
	{
	  prev = p;
	  p = next;
	}	  
    }
  if (!dunlink_head)
    dunlink_tail = NULL;
}

void
finish_deferred_unlinks ()
{
  flush_deferred_unlinks (true);
  while (dunlink_avail)
    {
      struct deferred_unlink *next = dunlink_avail->next;
      free (dunlink_avail);
      dunlink_avail = next;
    }
}

void
queue_deferred_unlink (const char *name, bool is_dir)
{
  struct deferred_unlink *p;

  if (dunlink_head
      && records_written > dunlink_head->records_written + deferred_unlink_delay)
    flush_deferred_unlinks (false);
  
  p = dunlink_alloc ();
  p->next = NULL;
  p->file_name = normalize_filename (name);
  p->is_dir = is_dir;
  p->records_written = records_written;
  
  if (dunlink_tail)
    dunlink_tail->next = p;
  else
    dunlink_head = p;
  dunlink_tail = p;
  dunlink_count++;
}
