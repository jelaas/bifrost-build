#include <string.h>
#include <stdlib.h>

#include "arr.h"

static struct arr *_arr_get(struct arrarr *aa)
{
	struct arr *a, *prev = (void*)0;
	for(a = aa->list; a; a = a->next) {
		if(a->len < ARRAYSIZE)
			return a;
		prev = a;
	}
	a = malloc(sizeof(struct arr));
	if(!a) return (void*)0;
	if(prev) {
		prev->next = a;
	} else {
		aa->list = a;
	}
	a->iter = 0;
	a->len = 0;
	a->next = (void*)0;
	
	return a;
}

int arr_init(struct arrarr *aa)
{
	if(!aa) return -1;
	aa->list = (void*) 0;
	return 0;
}

int arr_ins(struct arrarr *aa, struct mdfile *md)
{
	struct arr *a;
	a = _arr_get(aa);
	if(!a) return -1;
	memcpy(&a->entry[a->len], md, sizeof(struct mdfile));
	a->len++;
	return 0;
}

static int _arr_compare(const void *e1, const void *e2)
{
	const struct mdfile *s1 = e1, *s2 = e2;
	return strcmp(s1->filename, s2->filename);
}

/* sort arrays */
int arr_sort(struct arrarr *aa)
{
	struct arr *a;
	
	for(a = aa->list; a; a = a->next) {
		qsort(a->entry, a->len, sizeof(struct mdfile), _arr_compare);
	}
	return 0;
}

/* write next array element to md */
int arr_iter(struct arrarr *aa, struct mdfile *md)
{
	struct arr *a, *next = (void*)0;

	for(a = aa->list; a; a = a->next) {
		if(a->iter == a->len) continue;
		if(!next) {
			next = a;
			continue;
		}
		if(strcmp(next->entry[next->iter].filename, a->entry[a->iter].filename) > 0) {
			next = a;
		}
	}
	if(!next) return 0;

	memcpy(md, &next->entry[next->iter], sizeof(struct mdfile));
	next->iter++;
	
	return 1;
}
