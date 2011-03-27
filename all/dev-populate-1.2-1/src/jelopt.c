/*
 * jelopt version 2.2 2005-04-21
 * Functions for parsing command options.
 *
 * Copyright: Jens Låås, SLU 2003-2005
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */
#include "jelopt.h"

#include <stdlib.h>
#include <string.h>

#define FOUND_SHORT 1
#define FOUND_LONG 2

#define OPT_VALUE_USED "\001\002\090"

static int find_short_arg(char **argv, int opt_short)
{
  int i;
  for(i=1;argv[i];i++)
    {
      char *a = argv[i];
      if(*a == '-')
	{
	  if(*(a+1) == '-')
	    {
	      if(*(a+2) == 0)
		return -1;
	      continue;
	    }
	  if(strchr(a, opt_short))
	    return i;
	}
    }
  return -1;
}

static int find_long_arg(char **argv, char *opt_long)
{
  int i;
  int len = strlen(opt_long);

  for(i=1;argv[i];i++)
    {
      char *a = argv[i];
      if(*a == '-' && (*(a+1) == '-'))
	{
	  if((*(a+2) == 0)) 
	    return -1;
	  if(strlen(a) < len+2)
	    continue;
	  if(a[len+2] != 0 && a[len+2] != '=')
	    continue;
	  if(strncmp(a+2, opt_long, len) == 0)
	    return i;
	}
    }
  return -1;
}

static int rem_opt(char **argv, int begin, int end)
{
  int i;
  int dist = end-begin+1;
  int last = -1;

  for(i = 0;argv[i]; i++)
    last = i;

  if(last < 0)
    return 0;
  
  for(i = begin;i <= last; i++)
    if((i+dist) > last)
      argv[i] = NULL;
    else
      argv[i] = argv[i+dist];
  
  return 0;
}

static int rem_short_opt(char **argv, int opt_short, int begin, int end)
{
  int i;
  int dist = end-begin+1;
  int last = -1;

  for(i = 0;argv[i]; i++)
    last = i;

  if(last < 0)
    return 0;
  
  if(begin > last)
    return 0;

  if(strlen(argv[begin]) > 2)
    {
      char *s, *sn, *p;
      /* not a lonly opt */
      s = sn = strdup(argv[begin]);
      *s = 0;
      for(p=argv[begin];*p;p++)
	if(*p != opt_short)
	  *s++ = *p;
	else
	  opt_short = -1;
      *s = 0;
      strcpy(argv[begin], sn);
      free(sn);
      return 0;
    }

  for(i = begin;i <= last; i++)
    if((i+dist) > last)
      argv[i] = NULL;
    else
      argv[i] = argv[i+dist];
  
  return 0;
}

static void unquote(char *s)
{
  char *p;
  /* remove any leading '\' */
  if(*s != '\\')
    return;
  for(p=s;*p;p++)
    *p = *(p+1);
}

int jelopt_final(char **argv, int *err)
{
  int i, last=-1;
  
  for(i=1;argv[i];)
    {
      char *a = argv[i];
      if(*a == '-')
	{
	  if(*(a+1) == '-')
	    {
	      if(*(a+2) == 0)
		break;
	      if(err) *err |= ERR_JELOPT_UNKNOWN;
	    }
	  else
	    {
	      if(*(a+1) == 0)
		break;
	      if(err) *err |= ERR_JELOPT_UNKNOWN;
	    }
	}
      if(strcmp(argv[i], OPT_VALUE_USED))
	i++;
      else
	rem_opt(argv, i, i);
    }
  
  for(i = 0;argv[i]; i++)
    last = i;

  for(i=0;argv[i];i++)
    {
      char *a = argv[i];
      if(*a == '-' && *(a+1) == '-' && *(a+2) == 0)
	{
	  rem_opt(argv, i, i);
	  return last;
	}
    }
  return last+1;
}

int jelopt_multi(char **argv, int opt_short, char *opt_long,
		 int count, char **values,
		 int *err)
{
  int j,i = -1;
  int type = 0;

  if(opt_short)
    if( (i = find_short_arg(argv, opt_short)) >= 0)
      type = FOUND_SHORT;
  
  if(!type && opt_long)
    if( (i = find_long_arg(argv, opt_long)) >= 0)
      type = FOUND_LONG;
  
  if(!type)
    return 0;

  if(count < 0)
    {
      if(err) *err |= ERR_JELOPT_COUNT;
      return 0;
    }
  
  if(count && values == NULL)
    {
      if(err) *err |= ERR_JELOPT_COUNT;
      return 0;
    }
  
  if(type == FOUND_SHORT)
    {
      if(count)
	{
	  char *p = strchr(argv[i], opt_short);
	  if(*(p+1))
	    {
	      *values = strdup(p+1);
	      unquote(*values++);
	      count--;
	      *p = 0;
	    }
	}
      for(j=i+1;count--;j++)
	{
	  if(argv[j])
	    {
	      if(strcmp(argv[j], OPT_VALUE_USED))
		*values = strdup(argv[j]);
	      else
		{
		  if(err) *err |= ERR_JELOPT_VALUE_COLLISION;
		  goto err_short;
		}
	    }
	  else
	    {
	      if(err) *err |= ERR_JELOPT_MISSING_VALUE;
	    err_short:
	      rem_short_opt(argv, opt_short, i, i);
	      return 0;
	    }
	  unquote(*values++);
	  argv[j] = OPT_VALUE_USED;
	}
      rem_short_opt(argv, opt_short, i, i);
      if(values) *values++ = 0;
      return 1;
    }
  
  if(type == FOUND_LONG)
    {
      if(count == 0)
	{
	  argv[i] = OPT_VALUE_USED;
	  return 1;
	}
      
      if(strchr(argv[i], '='))
	{
	  *values = strdup(strchr(argv[i], '=')+1);
	  unquote(*values++);
	  count--;
	}
      
      for(j=i+1;count--;j++)
	{
	  if(argv[j])
	    {
	      if(strcmp(argv[j], OPT_VALUE_USED))
		*values = strdup(argv[j]);
	      else
		{
		  if(err) *err |= ERR_JELOPT_VALUE_COLLISION;
		  goto err_long;
		}
	    }
	  else
	    {
	      if(err) *err |= ERR_JELOPT_MISSING_VALUE;
	    err_long:
	      rem_opt(argv, i, i);
	      return 0;
	    }
	  unquote(*values++);
	  argv[j] = OPT_VALUE_USED;
	}
      argv[i] = OPT_VALUE_USED;
      *values++ = 0;
      return 1;
    }
  return 0;
}

int jelopt(char **argv, int opt_short, char *opt_long, char **value, int *err)
{
  char *cvalue[2];
  if(jelopt_multi(argv, opt_short, opt_long, value?1:0, cvalue, err))
    {
      if(value)
	*value = cvalue[0];
      return 1;
    }
  
  return 0;
}

int jelopt_int(char **argv, int opt_short, char *opt_long,
	       int *value, int *err)
{
  char *cvalue;
  if(jelopt(argv, opt_short, opt_long, &cvalue, err))
    {
      *value = atoi(cvalue);
      free(cvalue);
      return 1;
    }
  return 0;
}

#ifdef TEST
#include <stdio.h>
int main(int argc, char **argv)
{
  char *f;
  int i, err = 0;
  char *arr[4];
  
  while(jelopt(argv, 'a', NULL, NULL, &err))
    printf("found opt a\n"); 
  while(jelopt(argv, 'b', NULL, NULL, &err))
    printf("found opt b\n"); 
  while(jelopt(argv, 'c', NULL, NULL, &err))
    printf("found opt c\n");

  while(jelopt(argv, 'f', NULL, &f, &err))
    printf("found opt f = %s\n", f);

  while(jelopt_int(argv, 'i', "int", &i, &err))
    printf("found opt i = %d\n", i);

  while(jelopt_multi(argv, 'm', "multi2", 2, arr, &err))
    printf("found opt arr2 = %s, %s\n", arr[0], arr[1]);
  while(jelopt_multi(argv, 'M', "multi3", 3, arr, &err))
    printf("found opt arr3 = %s, %s, %s\n", arr[0], arr[1], arr[2]);
  
  while(jelopt(argv, 0, "opt1", NULL, &err))
    printf("found opt --opt1\n");
  while(jelopt(argv, 0, "opt2", NULL, &err))
    printf("found opt --opt2\n");

  while(jelopt(argv, 0, "opt3", &f, &err))
    printf("found opt --opt3 = %s\n", f);

  printf("argc = %d\n", jelopt_final(argv, &err));
  if(err) printf("ERROR: %d\n", err);

  for(i=0;argv[i];i++)
    printf("argv %d = %s\n", i, argv[i]);
  
  return 0;
}

#endif

/*

gcc -Wall -o jelopt -DTEST jelopt.c

*/
