/* Checkpoint management for tar.

   Copyright (C) 2007 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 3, or (at your option) any later
   version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
   Public License for more details.

   You should have received a copy of the GNU General Public License along
   with this program.  If not, see <http://www.gnu.org/licenses/>. */

#include <system.h>
#include "common.h"

enum checkpoint_opcode
  {
    cop_dot,
    cop_bell,
    cop_echo,
    cop_ttyout,
    cop_sleep,
    cop_exec
  };

struct checkpoint_action
{
  struct checkpoint_action *next;
  enum checkpoint_opcode opcode;
  union
  {
    time_t time;
    char *command;
  } v;
};

/* Checkpointing counter */
static unsigned checkpoint;

/* List of checkpoint actions */
static struct checkpoint_action *checkpoint_action, *checkpoint_action_tail;

static struct checkpoint_action *
alloc_action (enum checkpoint_opcode opcode)
{
  struct checkpoint_action *p = xzalloc (sizeof *p);
  if (checkpoint_action_tail)
    checkpoint_action_tail->next = p;
  else
    checkpoint_action = p;
  checkpoint_action_tail = p;
  p->opcode = opcode;
  return p;
}

static char *
copy_string_unquote (const char *str)
{
  char *output = xstrdup (str);
  size_t len = strlen (output);
  if ((*output == '"' || *output == '\'')
      && output[len-1] == *output)
    {
      memmove (output, output+1, len-2);
      output[len-2] = 0;
    }
  unquote_string (output);
  return output;
}

void
checkpoint_compile_action (const char *str)
{
  struct checkpoint_action *act;
  
  if (strcmp (str, ".") == 0 || strcmp (str, "dot") == 0)
    alloc_action (cop_dot);
  else if (strcmp (str, "bell") == 0)
    alloc_action (cop_bell);
  else if (strcmp (str, "echo") == 0)
    alloc_action (cop_echo);
  else if (strncmp (str, "echo=", 5) == 0)
    {
      act = alloc_action (cop_echo);
      act->v.command = copy_string_unquote (str + 5);
    }
  else if (strncmp (str, "exec=", 5) == 0)
    {
      act = alloc_action (cop_exec);
      act->v.command = copy_string_unquote (str + 5);
    }
  else if (strncmp (str, "ttyout=", 7) == 0)
    {
      act = alloc_action (cop_ttyout);
      act->v.command = copy_string_unquote (str + 7);
    }
  else if (strncmp (str, "sleep=", 6) == 0)
    {
      char *p;
      time_t n = strtoul (str+6, &p, 10);
      if (*p)
	FATAL_ERROR ((0, 0, _("%s: not a valid timeout"), str));
      act = alloc_action (cop_sleep);
      act->v.time = n;
    }
  else
    FATAL_ERROR ((0, 0, _("%s: unknown checkpoint action"), str));
}

void
checkpoint_finish_compile ()
{
  if (checkpoint_option)
    {
      if (!checkpoint_action)
	/* Provide a historical default */
	checkpoint_compile_action ("echo"); 
    }
  else if (checkpoint_action)
    /* Otherwise, set default checkpoint rate */
    checkpoint_option = DEFAULT_CHECKPOINT;
}

char *
expand_checkpoint_string (const char *input, bool do_write, unsigned cpn)
{
  const char *opstr = do_write ? gettext ("write") : gettext ("read");
  size_t opstrlen = strlen (opstr);
  char uintbuf[UINTMAX_STRSIZE_BOUND];
  char *cps = STRINGIFY_BIGINT (cpn, uintbuf);
  size_t cpslen = strlen (cps);
  const char *ip;
  char *op;
  char *output;
  size_t outlen = strlen (input); /* Initial guess */

  /* Fix the initial length guess */
  for (ip = input; (ip = strchr (ip, '%')) != NULL; )
    {
      switch (ip[1])
	{
	case 'u':
	  outlen += cpslen - 2;
	  break;
	  
	case 's':
	  outlen += opstrlen - 2;
	}
      ip++;
    }

  output = xmalloc (outlen + 1);
  for (ip = input, op = output; *ip; )
    {
      if (*ip == '%')
	{
	  switch (*++ip)
	    {
	    case 'u':
	      op = stpcpy (op, cps);
	      break;
	      
	    case 's':
	      op = stpcpy (op, opstr);
	      break;
	      
	    default:
	      *op++ = '%';
	      *op++ = *ip;
	      break;
	    }
	  ip++;
	}
      else
	*op++ = *ip++;
    }
  *op = 0;
  return output;
}

static void
run_checkpoint_actions (bool do_write)
{
  struct checkpoint_action *p;
  FILE *tty = NULL;
  
  for (p = checkpoint_action; p; p = p->next)
    {
      switch (p->opcode)
	{
	case cop_dot:
	  fputc ('.', stdlis);
	  fflush (stdlis);
	  break;

	case cop_bell:
	  if (!tty)
	    tty = fopen ("/dev/tty", "w");
	  if (tty)
	    {
	      fputc ('\a', tty);
	      fflush (tty);
	    }
	  break;
	  
	case cop_echo:
	  {
	    char *tmp;
	    const char *str = p->v.command;
	    if (!str)
	      {
		if (do_write)
		  /* TRANSLATORS: This is a ``checkpoint of write operation'',
 		     *not* ``Writing a checkpoint''.
		     E.g. in Spanish ``Punto de comprobaci@'on de escritura'',
		     *not* ``Escribiendo un punto de comprobaci@'on'' */
		  str = gettext ("Write checkpoint %u");
		else
		  /* TRANSLATORS: This is a ``checkpoint of read operation'',
	             *not* ``Reading a checkpoint''.
		     E.g. in Spanish ``Punto de comprobaci@'on de lectura'',
		     *not* ``Leyendo un punto de comprobaci@'on'' */
		  str = gettext ("Read checkpoint %u");
	      }
	    tmp = expand_checkpoint_string (str, do_write, checkpoint);
	    WARN ((0, 0, "%s", tmp));
	    free (tmp);
	  }
	  break;
	  
	case cop_ttyout:
	  if (!tty)
	    tty = fopen ("/dev/tty", "w");
	  if (tty)
	    {
	      char *tmp = expand_checkpoint_string (p->v.command, do_write,
						    checkpoint);
	      fprintf (tty, "%s", tmp);
	      fflush (tty);
	      free (tmp);
	    }
	  break;
	  
	case cop_sleep:
	  sleep (p->v.time);
	  break;
	  
	case cop_exec:
	  sys_exec_checkpoint_script (p->v.command,
				      archive_name_cursor[0],
				      checkpoint);
	  break;
	}
    }
  if (tty)
    fclose (tty);
}

void
checkpoint_run (bool do_write)
{
  if (checkpoint_option && !(++checkpoint % checkpoint_option))
    run_checkpoint_actions (do_write);
}  

