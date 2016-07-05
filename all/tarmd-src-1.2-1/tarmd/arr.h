#define ARRAYSIZE 1024

struct mdfile {
  char filename[256];
  char sha256[64];
};

struct arr {
  struct arr *next;
  int iter;
  int len;
  struct mdfile entry[ARRAYSIZE];
};

struct arrarr {
  struct arr *list;
};

int arr_init(struct arrarr *a);
int arr_ins(struct arrarr *a, struct mdfile *md);

/* sort arrays */
int arr_sort(struct arrarr *a);

/* write next array element to md */
int arr_iter(struct arrarr *a, struct mdfile *md);
