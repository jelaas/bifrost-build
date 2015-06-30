#ifndef JELIST_H
#define JELIST_H

/* Suitable for lists of (or rather ordered sets) of pointers.
   There is no need to add a member in the struct being added to the list.
   
   - A pointer may not be a member of more than one list.
   - A pointer may only occur once in a given list.

   Hashtable will only be shrunk when calling jl_compact().
   Hashtable will automatically expand when needed.
 */

struct jlnode {
  struct jlnode *next;
  struct jlnode *prev;
  struct jlhead *list;
  void *item;
};
struct jlhead {
  struct jlnode *first, *last;
  unsigned int len;
  int(*sortfn)(const void *i1, const void *i2);
};
struct jliter {
  struct jlnode *next;
};

struct jlhead *jl_new();
/* jl_free and jl_freefn always returns NULL. */
/* head and all internal nodes freed */
void *jl_free(struct jlhead *head);
void *jl_freefn(struct jlhead *head, void(*fn)(void *item));
int jl_new_static(struct jlhead *head);
void jl_free_static(struct jlhead *head);
void jl_freefn_static(struct jlhead *head, void(*fn)(void *item));
/* perform compacting of hashtable */
void jl_compact();

void *jl_next(const void *item);
void *jl_prev(const void *item);
void *jl_first(const void *item);
void *jl_last(const void *item);
void *jl_head_first(const struct jlhead *head);
void *jl_head_last(const struct jlhead *head);
void *jl_at(const struct jlhead *head, int pos);

struct jlhead *jl_head(const void *item);
/* number of items in the tail of the list starting from item */
unsigned int jl_len(const void *item);

int jl_del(const void *item);
int jl_ins(struct jlhead *head, const void *newitem);
int jl_append(struct jlhead *head, const void *newitem);
int jl_prepend(struct jlhead *head, const void *newitem);
int jl_add_before(const void *iteminlist, const void *newitem);
int jl_add_after(const void *iteminlist, const void *newitem);
/* newitem may also be in a list, in which case the two items are swapped */
int jl_repl(const void *iteminlist, const void *newitem);

int jl_append_list(struct jlhead *dst, struct jlhead *src);
int jl_prepend_list(struct jlhead *dst, struct jlhead *src);

void jl_foreachfn(struct jlhead *head, void(*fn)(void *item, void *data), void *data);
#define jl_foreach(h,i) for(i=jl_head_first(h);i;i=jl_next(i))

void *jl_iter_init(struct jliter *buf, const struct jlhead *head);
void *jl_iter(struct jliter *buf);

/* if fn() returns i1-i2 then the list is sorted in ascending order */
int jl_sort(struct jlhead *list, int(*fn)(const void *i1, const void *i2));

/* Provide functions for memory management */
void jl_allocator(void*(*fn)(unsigned int size));
void jl_deallocator(void*(*fn)(void *ptr));

#endif

