# include <stdio.h>
# include <stdlib.h>
# include <stdarg.h>
# include <string.h>

#if 1
# define UNBOXED(x)  (((int) (x)) &  0x0001)
# define UNBOX(x)    (((int) (x)) >> 1)
# define BOX(x)      ((((int) (x)) << 1) | 0x0001)
#else
# define UNBOXED(x)  (0)
# define UNBOX(x)    (x)
# define BOX(x)      (x)
#endif

# define STRING_TAG  0x00000001
# define ARRAY_TAG   0x00000003
# define SEXP_TAG    0x00000005

# define LEN(x) ((x & 0xFFFFFFF8) >> 3)
# define TAG(x) (x & 0x00000007)

# define TO_DATA(x) ((data*)((char*)x-sizeof(int)))
# define TO_SEXP(x) ((sexp*)((char*)x-2*sizeof(int)))

typedef struct {
  int tag; 
  char contents[0];
} data; 

typedef struct {
  int tag; 
  data contents; 
} sexp;

int Llength (void *p) {
  data *a = TO_DATA(p);
  return BOX(LEN(a->tag));
}

extern void* Bsexp (int bn, ...) {
  va_list args; 
  int     i;    
  int     ai;  
  size_t *p;  
  sexp   *r;  
  data   *d;  
  int n = bn; //UNBOX(bn);

  r = (sexp*) malloc (sizeof(int) * (n+1));
  d = &(r->contents);
  r->tag = 0;
    
  d->tag = SEXP_TAG | ((n-1) << 3);
  
  va_start(args, bn);
  
  for (i=0; i<n-1; i++) {
    ai = va_arg(args, int);
    
    p = (size_t*) ai;
    ((int*)d->contents)[i] = ai;
  }

  r->tag = va_arg(args, int);

  va_end(args);

  return d->contents;
}

void* Barray (int n0, ...) {
  int     n = n0;
  va_list args; 
  int     i, ai; 
  data    *r; 

  r = (data*) malloc (sizeof(int) * (n+1));

  r->tag = ARRAY_TAG | (n << 3);
  
  va_start(args, n);
  
  for (i = 0; i<n; i++) {
    ai = va_arg(args, int);
    ((int*) r->contents)[i] = ai;
  }
  
  va_end(args);

  return r->contents;
}

void* Bstring (void *p) {
  int   n = strlen (p);
  data *s;
  
  s = (data*) malloc (n + 1 + sizeof (int));
  s->tag = STRING_TAG | (n << 3);

  strncpy (s->contents, p, n + 1);
  return s->contents;
}

void* Belem (void *p, int i0) {
  int i = i0; //UNBOX(i0);
  data *a = TO_DATA(p);
  
  if (TAG(a->tag) == STRING_TAG) {
    return (void*) BOX(a->contents[i]);
  }
  
  return (void*) ((int*) a->contents)[i];
}

void* Bsta (void *x, int i, void *v) {
  if (i != 0x0fffffff) {
    if (TAG(TO_DATA(x)->tag) == STRING_TAG) { ((char*) x)[i] = (char) UNBOX(v); }
    else ((int*) x)[i] = (int) v;

    return v;
  }

  * (void**) x = v;

  return v;
}

void Lwrite (int x) {
  printf ("%d\n", UNBOX (x));
}

int Lread () {
  int result;

  scanf  ("%d", &result);

  return BOX(result);
}

extern int Btag (void *d, char* t, int n) {
  if (UNBOXED(d)) {
    return 0;
  } else {
    data* r = TO_DATA(d);
    data* s = TO_SEXP(d);
    return TAG(r->tag) == SEXP_TAG && LEN(r->tag) == n && strcmp(s->tag, t) == 0;
  }
}

extern void Bfail() {
  printf("failed\n");
  exit(30);
}
