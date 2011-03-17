/*
 * File: jelist.c
 * Implements: pseudo list handling functionality.
 * Restricted list of ordered sets of pointers.
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */
#include "jelist.h"
#ifndef JELISTINT_H
#define JELISTINT_H

struct listentry {
  union {
    struct jlnode node;
    struct jlhead head;
  } t;
};

struct bucket {
  struct listentry *item;
  struct bucket *next;
};

int _jl_hash_store(struct listentry *entry,const void *key);
struct listentry *_jl_hash_get(const void *key);
int _jl_hash_del(const void *key);
struct jlnode *_jl_node_new(const void *key);

void *jl_malloc(unsigned int size);
void jl_dealloc(void *ptr);

#endif
/*
 * File: jl_add_after.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


int jl_add_after(const void *jlnode, const void *newnode)
{
  struct jlnode *old, *n;

  old = (struct jlnode *) _jl_hash_get(jlnode);
  if(!old) return -1;
  n = _jl_node_new(newnode);
  if(!n) return -1;
  n->item = (void*) newnode;
  n->list = old->list;
  n->next = old->next;
  n->prev = old;
  
  if(old->next)
    old->next->prev = n;
  else
    n->list->last = n;
  old->next = n;
  n->list->len++;
  return 0;
}
/*
 * File: jl_add_before.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


int jl_add_before(const void *jlnode, const void *newnode)
{
  struct jlnode *old, *n;

  old = (struct jlnode *) _jl_hash_get(jlnode);
  if(!old) return -1;
  n = _jl_node_new(newnode);
  if(!n) return -1;
  n->item = (void*) newnode;
  n->list = old->list;
  n->next = old;
  n->prev = old->prev;
  
  if(old->prev)
    old->prev->next = n;
  else
    n->list->first = n;
  old->prev = n;
  n->list->len++;
  return 0;
}
/*
 * File: jl_append.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>

int jl_append(struct jlhead *head, const void *node)
{
  struct jlnode *n;
  
  if(!head) return -1;
  
  n = _jl_node_new(node);
  if(!n) return -1;
  n->item = (void*) node;
  n->list = head;
  n->next = NULL;
  n->prev = head->last;
  
  if(!head->first) head->first = n;
  if(head->last) head->last->next = n;
  
  head->last = n;
  head->len++;
  return 0;
}
/*
 * File: jl_append_list.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>

int jl_append_list(struct jlhead *dst, struct jlhead *src)
{
  struct jlnode *n;

  if(!dst) return -1;
  if(!src) return 0;
  
  if(!src->first)
    return 0;
  for(n=src->first;n;n=n->next)
    n->list = dst;
  if(!dst->first)
    {
      dst->first = src->first;
      dst->last = src->last;
      dst->len = src->len;
      goto out;
    }
  src->first->prev = dst->last;
  dst->last->next = src->first;
  dst->last = src->last;
  
  dst->len += src->len;

 out:
  src->first = src->last = NULL;
  src->len = 0;
  return 0;
}
/*
 * jelist version 1.3 2006-03-24
 * Functions for parsing command options.
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>
#include <string.h>

int hashsize=0; /* size is 2^hashsize buckets */
int hashcount=0;
struct bucket **listhash;
/* hashkey: fold pointer so that the bits for pagenumber are used.
   logic and with size. */

/*
 all nodes are stored in a hash.
 the key to the hash is the pointer to the struct that you wish to add to the list.
 a given data element may only belong to one list.
 jl_next() will lookup the keynode in the hash and return n->next->item.
*/

static unsigned int _hash(const void *key)
{
  unsigned int k = (unsigned int) key;
  k ^= (k >> 3);
  /* k ^= (k >> 9); */
  return k & ((1 << hashsize)-1);
}

static int _alloc_jelist()
{
  hashsize += 2;
  listhash = jl_malloc(sizeof(void*)*(1<<hashsize));
  memset(listhash, 0, sizeof(void*)*(1<<hashsize));
  return 0;
}

int _hash_put_bkt(struct bucket **hash, struct bucket *bkt)
{
  int idx;

  idx = _hash(bkt->item->t.node.item);
  if(hash[idx])
    {
      bkt->next = hash[idx];
      hash[idx] = bkt;
    }
  else
    {
      hash[idx] = bkt;
      bkt->next = NULL;
    }
  return 0;
}

static int _realloc_jelist()
{
  struct bucket **nhash, *bkt, *nbkt;
  int oldsize = hashsize;
  int i, count=0;
  
  if(hashcount > (1<<(hashsize+1)))
    hashsize += 2;
  else
    {
      while( (hashsize > 2) &&
	     (hashcount < (1<<(hashsize+1))) )
	hashsize -= 1;

      if(hashsize == oldsize)
	return 0;
    }

  nhash = jl_malloc(sizeof(void*)*(1<<hashsize));
  if(!nhash)
    {
      hashsize = oldsize;
      return -1;
    }
  
  memset(nhash, 0, sizeof(void*)*(1<<hashsize));
  
  /* reinsert all buckets */

  for(i=0;i<(1<<oldsize);i++)
    {
      bkt = listhash[i];
      while(bkt)
	{
	  nbkt = bkt->next;
	  _hash_put_bkt(nhash, bkt);
	  count++;
	  bkt=nbkt;
	}
    }

  if(count != hashcount)
    {
#ifdef TESTJELIST
      printf("error: realloc count %d != %d\n", count, hashcount);
#endif
    }

  jl_dealloc(listhash);
  listhash = nhash;

  return 0;
}

int _jl_hash_store(struct listentry *entry, const void *key)
{
  struct bucket *lbkt, *nbkt;

  if(!listhash)
    _alloc_jelist();
  if(hashcount > (1<<(hashsize+1)))
    _realloc_jelist();

  nbkt = jl_malloc(sizeof(struct bucket));
  if(!nbkt) return -1;
  nbkt->item = entry;
  
  lbkt = listhash[_hash(key)];
  if(!lbkt)
    {
      nbkt->next = NULL;
      listhash[_hash(key)] = nbkt;
      hashcount++;
      return 0;
    }
  
  nbkt->next = lbkt;
  listhash[_hash(key)] = nbkt;
  hashcount++;
  return 0;
}

struct listentry *_jl_hash_get(const void *key)
{
  struct bucket *bkt;
  
  if(!listhash)
    _alloc_jelist();

  bkt = listhash[_hash(key)];
  if(bkt)
    {
      for(;bkt;bkt=bkt->next)
	if(bkt->item->t.node.item == key)
	  return bkt->item;
    }
  return NULL;
}

int _jl_hash_del(const void *key)
{
  struct bucket *bkt, *prev=NULL;
  
  bkt = listhash[_hash(key)];
  if(bkt)
    {
      for(;bkt;bkt=bkt->next)
	{
	  if(bkt->item->t.node.item == key)
	    {
	      if(prev)
		prev->next = bkt->next;
	      else
		listhash[_hash(key)] = bkt->next;
	      jl_dealloc(bkt);
	      hashcount--;
	      return 0;
	    }
	  prev=bkt;
	}
    }
  return -1;
}

void jl_compact()
{
  if((1<<hashsize) > hashcount)
    _realloc_jelist();
}

struct jlnode *_jl_node_new(const void *key)
{
  struct jlnode *node;

  if(_jl_hash_get(key)) return NULL;

  node = jl_malloc(sizeof(struct listentry));
  if(!node) return NULL;
  memset(node, 0, sizeof(struct listentry));
  
  if(_jl_hash_store((struct listentry *) node, key))
    {
      jl_dealloc(node);
      return NULL;
    }

  return node;
}

#ifdef TESTJELIST

#include <jelio.h>

#define NITEMS 4000

int hashstat()
{
  int i;
  int empty=0;
  
  for(i=0;i<(1<<hashsize);i++)
    {
      if(!listhash[i]) empty++;
      // else printf("%p ", listhash[i]);
    }
  printf("\nsize: %d bkts: %d empty: %d\n", 1<<hashsize, hashcount, empty);

  return 0;
}

int intsort(void *i1, void *i2)
{
  return i1-i2;
}

int main(int argc, char **argv)
{
  void *array[NITEMS];
  struct jlhead *h;
  void *p;
  int i;

  h = jl_new();

  jl_prepend(h, (void*)1);
  jl_prepend(h, (void*)111);
  jl_prepend(h, (void*)222);

  jl_append(h, (void*)666);

  printf("done\n");

  printf("first %p\n", h->first);
  printf("first item %lu [222]\n", (unsigned long) h->first->item);
  printf("second item %lu [111]\n", (unsigned long) jl_next(h->first->item));

  jl_repl((void*)222, (void*)666);
  if(jl_head_first(h) != 666)
    printf("ERR first != 666 %lu\n", (unsigned long) jl_head_first(h));

  for(p=jl_head_first(h);p;p=jl_next(p))
    printf("node %lu\n", (unsigned long) p);

  if(jl_del((void*)111))
    printf("error jl_del(111)\n");
  if(jl_del((void*)222))
    printf("error jl_del(222)\n");
  if(jl_del((void*)1))
    printf("error jl_del(1)\n");
  
  for(p=jl_head_first(h);p;p=jl_next(p))
    printf("ONCE: node %lu\n", (unsigned long)p);
  
  if(jl_del((void*)666))
    printf("error jl_del(666)\n");

  for(i=1;i<=NITEMS;i++)
    jl_append(h, (void*)i);
  i=0;
  for(p=jl_head_first(h);p;p=jl_next(p))
    i++;
  if(i != jl_len((void*)1)) printf("ERROR: jl_len() mismatch! %d != %d\n", i, jl_len((void*)1));
  if(i != h->len) printf("ERROR: h->len() mismatch! %d != %d\n", i, h->len);
  if(i != NITEMS) printf("ERROR: jl_next count mismatch! %d != %d\n",i,NITEMS);
  for(i=1;i<=NITEMS;i++)
    if(jl_head((void*)i)!=h)
      printf("error item %d does not exist in hash\n", i);

  hashstat();

  for(i=1;i<=NITEMS;i++)
    {
      if(jl_del((void*)i))
	printf("error jl_del(%d)\n", i);
      jl_compact();
    }
  printf("hashcount: %d\n", hashcount);

  printf("** Pointer test starts **\n");
  for(i=0;i<NITEMS;i++)
    {
      array[i] = malloc(4000);
      jl_append(h, array[i]);
    }
  hashstat();

  jl_free(h);
  h = jl_new();
  
  if(argc > 1)
    {
      char buf[64];
      while(bugets(0,NULL,sizeof(buf),buf)>0)
	if(atoi(buf)) jl_append(h, atoi(buf));

      jl_sort(h, intsort);
      
      printf("Sorted:\n");
      jl_foreach(h,p)
	{
	  printf("%lu\n", (unsigned long)p);
	}

    }
  
  return 0;
}

#endif

/*
gcc -g -Wall -D TESTJELIST -o jelist jelist.c
*/
/*
 * File: jl_del.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


int jl_del(const void *node)
{
  struct jlnode *n;
  
  n = (struct jlnode *) _jl_hash_get(node);
  if(n)
    {
      if(n->prev)
	n->prev->next = n->next;
      if(n->next)
	n->next->prev = n->prev;
      
      if(n->list->first == n)
	n->list->first = n->next;
      if(n->list->last == n)
	n->list->last = n->prev;
      n->list->len--;
      if(_jl_hash_del(node))
	return -1;
      jl_dealloc(n);
      return 0;
    }
  return -1;
}
/*
 * File: jl_first.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_first(const void *node)
{
  struct jlnode *n;

  n = (struct jlnode *) _jl_hash_get(node);
  if(n) return n->list->first->item;
  return NULL;
}

void *jl_last(const void *node)
{
  struct jlnode *n;

  n = (struct jlnode *) _jl_hash_get(node);
  if(n) return n->list->last->item;
  return NULL;
}
/*
 * File: jl_foreachfn.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


void jl_foreachfn(struct jlhead *head, void(*fn)(void *item, void *data), void *data)
{
  struct jlnode *n, *next;
  
  if(head)
    {
      n=head->first;
      while(n)
	{
	  next = n->next;
	  fn(n->item, data);
	  n = next;
	}
    }
}
/*
 * File: jl_free.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>
#include <string.h>


/* free the whole list. call fn for each item. Do not free head. */
void jl_freefn_static(struct jlhead *head, void(*fn)(void *item))
{
  struct jlnode *n, *nn;
  if(head)
    {
      n=head->first;
      while(n)
	{
	  nn=n->next;
	  if(fn) fn(n->item);
	  _jl_hash_del(n->item);
	  jl_dealloc(n);
	  n=nn;
	}
      memset(head, 0, sizeof(struct listentry));
    }
}

/* free the whole list. call fn for each item. Also free head. */
void *jl_freefn(struct jlhead *head, void(*fn)(void *item))
{
  if(head)
    {
      jl_freefn_static(head, fn);
      jl_dealloc(head);
    }
  return NULL;
}

void *jl_free(struct jlhead *head)
{
  jl_freefn(head, NULL);
  return NULL;
}

void jl_free_static(struct jlhead *head)
{
  jl_freefn_static(head, NULL);
}
/*
 * File: jl_head.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


struct jlhead *jl_head(const void *node)
{
  struct jlnode *n;

  n = (struct jlnode *) _jl_hash_get(node);
  if(n) return n->list;
  return NULL;
}
/*
 * File: jl_head_first.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_head_first(const struct jlhead *head)
{
  if(head && head->first)
    return head->first->item;
  return NULL;
}

void *jl_head_last(const struct jlhead *head)
{
  if(head && head->last)
    return head->last->item;
  return NULL;
}
/*
 * File: jl_iter.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_iter_init(struct jliter *buf, const struct jlhead *head)
{
  struct jlnode *n;
  
  if(!head) return NULL;
  
  n = head->first;
  if(n) buf->next = n->next;
  else
    {
      buf->next = NULL;
      return NULL;
    }
  return n->item;
}

void *jl_iter(struct jliter *buf)
{
  void *item;
  if(buf->next)
    {
      item = buf->next->item;
      buf->next = buf->next->next;
    }
  else
    item = NULL;
  return item;
}
/*
 * File: jl_len.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


unsigned int jl_len(const void *item)
{
  struct jlnode *n;
  int count=0;
  for(n = (struct jlnode *) _jl_hash_get(item);n;n=n->next)
    count++;
  return count-1;
}
/*
 * File: jl_new.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>
#include <string.h>


int jl_new_static(struct jlhead *head)
{
  memset(head, 0, sizeof(struct listentry));
  return 0;
}

/* initialize a new list. */
struct jlhead *jl_new()
{
  struct jlhead *head;
  head = jl_malloc(sizeof(struct listentry));
  if(!head) return NULL;
  if(jl_new_static(head))
    {
      jl_dealloc(head);
      return NULL;
    }
  
  return head;
}
/*
 * File: jl_next.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_next(const void *node)
{
  struct jlnode *n;

  n = (struct jlnode *) _jl_hash_get(node);
  if(n)
    {
      n = n->next;
      if(n) return n->item;
    }
  return NULL;
}
/*
 * File: jl_prepend.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


int jl_prepend(struct jlhead *head, const void *node)
{
  struct jlnode *n;

  if(!head) return -1;

  n = _jl_node_new(node);
  if(!n) return -1;
  n->item = (void*) node;
  n->list = head;
  n->next = head->first;
  n->prev = NULL;
  if(!head->last) head->last = n;
  if(head->first) head->first->prev = n;

  head->first = n;
  head->len++;
  return 0;
}
/*
 * File: jl_prepend_list.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


int jl_prepend_list(struct jlhead *dst, struct jlhead *src)
{
  struct jlnode *n;

  if(!dst) return -1;
  if(!src) return 0;
  
  if(!src->first)
    return 0;
  for(n=src->first;n;n=n->next)
    n->list = dst;
  if(!dst->first)
    {
      dst->first = src->first;
      dst->last = src->last;
      dst->len = src->len;
      goto out;
    }
  src->last->next = dst->first;
  dst->first->prev = src->last;
  dst->first = src->first;
  
  dst->len += src->len;

 out:
  src->first = src->last = NULL;
  src->len = 0;
  return 0;
}
/*
 * File: jl_prev.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_prev(const void *node)
{
  struct jlnode *n;

  n = (struct jlnode *) _jl_hash_get(node);
  if(n)
    {
      n = n->prev;
      if(n) return n->item;
    }
  return NULL;
}
/*
 * File: jl_repl.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


/* newitem may also by in a list, in which case the two items are swapped */
int jl_repl(const void *iteminlist, const void *newitem)
{
  struct jlnode *n, *nn;
  
  n = (struct jlnode *) _jl_hash_get(iteminlist);
  nn = (struct jlnode *) _jl_hash_get(newitem);
  
  if(n)
    {
      _jl_hash_del(n->item);
      n->item = (void*) newitem;
      if(nn)
	{
	  _jl_hash_del(nn->item);
	  nn->item = (void*) iteminlist;
	}
      _jl_hash_store((struct listentry*)n, newitem);
      if(nn) _jl_hash_store((struct listentry*)nn, iteminlist);
      return 0;
    }
  return -1;
}
/*
 * File: jl_sort.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */


#define INSERTIONSORT

/* if fn() returns i1-i2 then the list is sorted in ascending order */
int jl_sort(struct jlhead *list, int(*fn)(const void *i1, const void *i2))
{
#ifdef BUBBLESORT
  void *n, *nn;
  int f=1;
  
  if(!fn) fn = list->sortfn;
  if(fn)
  while(f)
    jl_foreach(list, n)
    {
      nn = jl_next(n);
      if(nn && (fn(n, nn) > 0))
	{
	  f=1;
	  jl_repl(n, nn);
	}
    }
#endif

#ifdef INSERTIONSORT
  void *n, *nn;
  struct jliter iter;
  
  if(!fn) fn = list->sortfn;
  if(fn)
  for(n=jl_iter_init(&iter,list);n;n=jl_iter(&iter))
    {
      while(1)
	{
	  nn=jl_prev(n);
	  if(!nn) break;
	  if(fn(n,nn)>=0) break;
	  
	  jl_repl(n,nn);
	}
      
    }

#endif
  list->sortfn = fn;
  return 0;
}
/*
 * File: jl_ins.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>

#define insdbg 0

int jl_ins(struct jlhead *head, const void *node)
{
  struct jlnode *n, *ln;
  int f,l,pos,opos,i,rc,after=0;
  
  if(!head) return -1;

  //if(insdbg) printf("jl_ins(%p)\n", node);
  
  n = _jl_node_new(node);
  if(!n) return -1;
  n->item = (void*) node;
  n->list = head;
  
  if( (!head->sortfn) || (head->len == 0))
    {
      n->next = NULL;
      n->prev = head->last;
  
      if(!head->first) head->first = n;
      if(head->last) head->last->next = n;
  
      head->last = n;
      head->len++;
      return 0;
    }
  
  /* perform binary sort on the list to find the right insertion position */

  f = 0;
  l = head->len - 1;
  
  pos = (f+l)/2;
  ln = head->first;
  for(i=0;i<pos;i++) ln = ln->next;
  
  while(1)
    {
      rc = head->sortfn(node, ln->item);
      /*if(insdbg) printf("%d = fn(%p,%p) f=%d l=%d pos=%d\n",
			rc, node, ln->item,
			f,l,pos);*/
      if(rc == 0)
	{
	  after = 1;
	  break;
	}
      if(rc > 0)
	{
	  if( (l-f) == 0)
	    {
	      after = 1;
 	      break;	      
	    }
	  opos = pos;
	  if(f == pos) pos++;
	  f = pos;
	  pos = (f+l)/2;
	  //if(insdbg) printf("advance %d\n", pos - opos);
	  for(i=0;i<(pos-opos);i++) ln = ln->next;
	  continue;
	}

      if( (l-f) == 0)
	{
	  break;	      
	}
      opos = pos;
      l = pos;
      pos = (f+l)/2;
      //if(insdbg) printf("backup %d\n", opos - pos);
      for(i=0;i<(opos-pos);i++) ln = ln->prev;
    }

  if(after)
    {
      n->next = ln->next;
      n->prev = ln;
      
      if(ln->next)
	ln->next->prev = n;
      else
	n->list->last = n;
      ln->next = n;
    }
  else
    {
      n->next = ln;
      n->prev = ln->prev;
      
      if(ln->prev)
	ln->prev->next = n;
      else
	n->list->first = n;
      ln->prev = n;
    }
  head->len++;
  return 0;
}
/*
 * File: jl_at.c
 * Implements:
 *
 * Copyright: Jens Låås, SLU 2006
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>


void *jl_at(const struct jlhead *head, int pos)
{
  struct jlnode *n;
  
  if(head && (pos < head->len) && (pos >= 0))
    {
      for(n=head->first;n && pos;n=n->next) pos--;
      if(n && (pos == 0))
	return n->item;
    }
  return NULL;
}
/*
 * File: jl_allocator.c
 * Implements: hooks for external memory management
 *
 * Copyright: Jens Låås, SLU 2007
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>

static void*(*allocfn)(unsigned int size);
static void*(*deallocfn)(void *ptr);

void jl_allocator(void*(*fn)(unsigned int size))
{
  allocfn = fn;
}

void jl_deallocator(void*(*fn)(void *ptr))
{
  deallocfn = fn;
}

void *jl_malloc(unsigned int size)
{
  if(allocfn)
    return allocfn(size);
  return malloc(size);
}

void jl_dealloc(void *ptr)
{
  if(deallocfn)
    {
      deallocfn(ptr);
      return;
    }
  free(ptr);
}
