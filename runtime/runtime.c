#define _GNU_SOURCE 1

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <sys/mman.h>
#include <assert.h>

#define NIMPL                                                               \
  fprintf(stderr, "Internal error: "                                        \
                  "function %s at file %s, line %d is not implemented yet", \
          __func__, __FILE__, __LINE__);                                    \
  exit(1);

extern void nimpl(void) { NIMPL }
extern void __pre_gc();
extern void __post_gc();
extern void *alloc(size_t);

/* GC extra roots */
/* All work with extra roots has to be already done */
#define MAX_EXTRA_ROOTS_NUMBER 32
typedef struct
{
  int current_free;
  void **roots[MAX_EXTRA_ROOTS_NUMBER];
} extra_roots_pool;

static extra_roots_pool extra_roots;

void clear_extra_roots(void)
{
  extra_roots.current_free = 0;
}

void push_extra_root(void **p)
{
  if (extra_roots.current_free >= MAX_EXTRA_ROOTS_NUMBER)
  {
    perror("ERROR: push_extra_roots: extra_roots_pool overflow");
    exit(1);
  }
  extra_roots.roots[extra_roots.current_free] = p;
  extra_roots.current_free++;
}

void pop_extra_root(void **p)
{
  if (extra_roots.current_free == 0)
  {
    perror("ERROR: pop_extra_root: extra_roots are empty");
    exit(1);
  }
  extra_roots.current_free--;
  if (extra_roots.roots[extra_roots.current_free] != p)
  {
    perror("ERROR: pop_extra_root: stack invariant violation");
    exit(1);
  }
}

static inline void init_extra_roots(void)
{
  extra_roots.current_free = 0;
}
/* end extra roots */

#define UNBOXED(x) (((int)(x)) & 0x0001)
#define UNBOX(x) (((int)(x)) >> 1)
#define BOX(x) ((((int)(x)) << 1) | 0x0001)

#define STRING_TAG 0x00000001
#define ARRAY_TAG 0x00000003
#define SEXP_TAG 0x00000005
#define CLOSURE_TAG 0x00000007
#define UNBOXED_TAG 0x00000009 // Not actually a tag; used to return from LkindOf

#define LEN(x) ((x & 0xFFFFFFF8) >> 3)
#define TAG(x) (x & 0x00000007)

#define TO_DATA(x) ((data *)((char *)(x) - sizeof(int)))
#define TO_SEXP(x) ((sexp *)((char *)(x) - 2 * sizeof(int)))

#define ASSERT_BOXED(memo, x)                        \
  do                                                 \
    if (UNBOXED(x))                                  \
      failure("boxed value expected in %s\n", memo); \
  while (0)
#define ASSERT_UNBOXED(memo, x)                        \
  do                                                   \
    if (!UNBOXED(x))                                   \
      failure("unboxed value expected in %s\n", memo); \
  while (0)
#define ASSERT_STRING(memo, x)                             \
  do                                                       \
    if (!UNBOXED(x) && TAG(TO_DATA(x)->tag) != STRING_TAG) \
      failure("string value expected in %s\n", memo);      \
  while (0)

typedef struct
{
  int tag;
  char contents[0];
} data;

typedef struct
{
  int tag;
  data contents;
} sexp;

static char *chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'";

extern char *de_hash(int);

char *de_hash(int n)
{
  //  static char *chars = (char*) BOX (NULL);
  static char buf[6] = {0, 0, 0, 0, 0, 0};
  char *p = (char *)BOX(NULL);
  p = &buf[5];

#ifdef DEBUG_PRINT
  indent++;
  print_indent();
  printf("de_hash: tag: %d\n", n);
  fflush(stdout);
#endif

  *p-- = 0;

  while (n != 0)
  {
#ifdef DEBUG_PRINT
    print_indent();
    printf("char: %c\n", chars[n & 0x003F]);
    fflush(stdout);
#endif
    *p-- = chars[n & 0x003F];
    n = n >> 6;
  }

#ifdef DEBUG_PRINT
  indent--;
#endif

  return ++p;
}

int Llength(void *p)
{
  data *a = TO_DATA(p);
  return BOX(LEN(a->tag));
}

extern void *Bsexp(int bn, ...)
{
  va_list args;
  int i;
  int ai;
  size_t *p;
  sexp *r;
  data *d;
  int n = UNBOX(bn);
  __pre_gc();

  r = (sexp *)alloc(sizeof(int) * (n + 1));
  d = &(r->contents);
  r->tag = 0;

  d->tag = SEXP_TAG | ((n - 1) << 3);

  va_start(args, bn);

  for (i = 0; i < n - 1; i++)
  {
    ai = va_arg(args, int);

    p = (size_t *)ai;
    ((int *)d->contents)[i] = ai;
  }

  r->tag = UNBOX(va_arg(args, int));

  va_end(args);
  __post_gc();

  return d->contents;
}

void *Barray(int n0, ...)
{
  int n = UNBOX(n0);
  va_list args;
  int i, ai;
  data *r;

  __pre_gc();

  r = (data *)alloc(sizeof(int) * (n + 1));

  r->tag = ARRAY_TAG | (n << 3);

  va_start(args, n0);

  for (i = 0; i < n; i++)
  {
    ai = va_arg(args, int);
    ((int *)r->contents)[i] = ai;
  }

  va_end(args);
  __post_gc();

  return r->contents;
}

void *Bstring(void *p)
{
  int n = strlen(p);
  data *s;

  __pre_gc();
  push_extra_root(&p);
  s = (data *)alloc(n + 1 + sizeof(int));
  s->tag = STRING_TAG | (n << 3);
  pop_extra_root(&p);

  strncpy(s->contents, p, n + 1);

  __post_gc();
  return s->contents;
}

void *Belem(void *p, int i0)
{
  int i = UNBOX(i0);
  data *a = TO_DATA(p);

  if (TAG(a->tag) == STRING_TAG)
  {
    return (void *)BOX(a->contents[i]);
  }

  return (void *)((int *)a->contents)[i];
}

void *Bsta(void *x, int i, void *v)
{
  if (UNBOXED(i))
  {
    if (TAG(TO_DATA(x)->tag) == STRING_TAG)
      ((char *)x)[UNBOX(i)] = (char)UNBOX(v);
    else
      ((int *)x)[UNBOX(i)] = (int)v;

    return v;
  }

  *(void **)x = v;

  return v;
}

extern int Btag(void *d, int t, int n)
{
  data *r;

  if (UNBOXED(d))
    return BOX(0);
  else
  {
    r = TO_DATA(d);
#ifndef DEBUG_PRINT
    return BOX(TAG(r->tag) == SEXP_TAG && TO_SEXP(d)->tag == UNBOX(t) && LEN(r->tag) == UNBOX(n));
#else
    return BOX(TAG(r->tag) == SEXP_TAG &&
               GET_SEXP_TAG(TO_SEXP(d)->tag) == UNBOX(t) && LEN(r->tag) == UNBOX(n));
#endif
  }
}

extern int Barray_patt(void *d, int n)
{
  data *r;

  if (UNBOXED(d))
    return BOX(0);
  else
  {
    r = TO_DATA(d);
    return BOX(TAG(r->tag) == ARRAY_TAG && LEN(r->tag) == UNBOX(n));
  }
}

static void failure(char *s, ...);

extern int Bstring_patt(void *x, void *y)
{
  data *rx = (data *)BOX(NULL),
       *ry = (data *)BOX(NULL);

  ASSERT_STRING(".string_patt:2", y);

  if (UNBOXED(x))
    return BOX(0);
  else
  {
    rx = TO_DATA(x);
    ry = TO_DATA(y);

    if (TAG(rx->tag) != STRING_TAG)
      return BOX(0);

    return BOX(strcmp(rx->contents, ry->contents) == 0 ? 1 : 0);
  }
}

void Lwrite(int x)
{
  printf("%d\n", UNBOX(x));
}

int Lread()
{
  int result;

  scanf("%d", &result);

  return BOX(result);
}

typedef struct
{
  char *contents;
  int ptr;
  int len;
} StringBuf;

static StringBuf stringBuf;

#define STRINGBUF_INIT 128

static void createStringBuf()
{
  stringBuf.contents = (char *)malloc(STRINGBUF_INIT);
  stringBuf.ptr = 0;
  stringBuf.len = STRINGBUF_INIT;
}

static void deleteStringBuf()
{
  free(stringBuf.contents);
}

static void extendStringBuf()
{
  int len = stringBuf.len << 1;

  stringBuf.contents = (char *)realloc(stringBuf.contents, len);
  stringBuf.len = len;
}

static void vprintStringBuf(char *fmt, va_list args)
{
  int written = 0,
      rest = 0;
  char *buf = (char *)BOX(NULL);

again:
  buf = &stringBuf.contents[stringBuf.ptr];
  rest = stringBuf.len - stringBuf.ptr;
  written = vsnprintf(buf, rest, fmt, args);

  if (written >= rest)
  {
    extendStringBuf();
    goto again;
  }

  stringBuf.ptr += written;
}

static void printStringBuf(char *fmt, ...)
{
  va_list args;

  va_start(args, fmt);
  vprintStringBuf(fmt, args);
}

int is_valid_heap_pointer(void *p)
{
  return 1;
}

static void printValue(void *p)
{
  data *a = (data *)BOX(NULL);
  int i = BOX(0);
  if (UNBOXED(p))
    printStringBuf("%d", UNBOX(p));
  else
  {
    if (!is_valid_heap_pointer(p))
    {
      printStringBuf("0x%x", p);
      return;
    }

    a = TO_DATA(p);

    switch (TAG(a->tag))
    {
    case STRING_TAG:
      printStringBuf("\"%s\"", a->contents);
      break;

    case CLOSURE_TAG:
      printStringBuf("<closure ");
      for (i = 0; i < LEN(a->tag); i++)
      {
        if (i)
          printValue((void *)((int *)a->contents)[i]);
        else
          printStringBuf("0x%x", (void *)((int *)a->contents)[i]);

        if (i != LEN(a->tag) - 1)
          printStringBuf(", ");
      }
      printStringBuf(">");
      break;

    case ARRAY_TAG:
      printStringBuf("[");
      for (i = 0; i < LEN(a->tag); i++)
      {
        printValue((void *)((int *)a->contents)[i]);
        if (i != LEN(a->tag) - 1)
          printStringBuf(", ");
      }
      printStringBuf("]");
      break;

    case SEXP_TAG:
    {
#ifndef DEBUG_PRINT
      char *tag = de_hash(TO_SEXP(p)->tag);
#else
      char *tag = de_hash(GET_SEXP_TAG(TO_SEXP(p)->tag));
#endif

      if (strcmp(tag, "cons") == 0)
      {
        data *b = a;

        printStringBuf("{");

        while (LEN(a->tag))
        {
          printValue((void *)((int *)b->contents)[0]);
          b = (data *)((int *)b->contents)[1];
          if (!UNBOXED(b))
          {
            printStringBuf(", ");
            b = TO_DATA(b);
          }
          else
            break;
        }

        printStringBuf("}");
      }
      else
      {
        printStringBuf("%s", tag);
        if (LEN(a->tag))
        {
          printStringBuf(" (");
          for (i = 0; i < LEN(a->tag); i++)
          {
            printValue((void *)((int *)a->contents)[i]);
            if (i != LEN(a->tag) - 1)
              printStringBuf(", ");
          }
          printStringBuf(")");
        }
      }
    }
    break;

    default:
      printStringBuf("*** invalid tag: 0x%x ***", TAG(a->tag));
    }
  }
}

static void vfailure(char *s, va_list args)
{
  fprintf(stderr, "*** FAILURE: ");
  vfprintf(stderr, s, args); // vprintf (char *, va_list) <-> printf (char *, ...)
  exit(255);
}

static void failure(char *s, ...)
{
  va_list args;

  va_start(args, s);
  vfailure(s, args);
}

static void fix_unboxed(char *s, va_list va)
{
  size_t *p = (size_t *)va;
  int i = 0;

  while (*s)
  {
    if (*s == '%')
    {
      size_t n = p[i];
      if (UNBOXED(n))
      {
        p[i] = UNBOX(n);
      }
      i++;
    }
    s++;
  }
}

extern void Lfailure(char *s, ...)
{
  va_list args;

  va_start(args, s);
  fix_unboxed(s, args);
  vfailure(s, args);
}

extern void Bmatch_failure(void *v, char *fname, int line, int col)
{
  createStringBuf();
  printValue(v);
  failure("match failure at %s:%d:%d, value '%s'\n",
          fname, UNBOX(line), UNBOX(col), stringBuf.contents);
}

/* ======================================== */
/*         GC: Mark-and-Copy                */
/* ======================================== */

/* You are free to change the following code structure if necessary. */

/* Heap is devided on two semi-spaces called active (to-) space and passive (from-) space. */
/* Each space is a continuous memory area (aka pool, see @pool). */
/* Note, it have to be no external fragmentation after garbage collection. */
/* Memory is allocated by function @alloc. */
/* Garbage collection has to be performed by memory allocator if there is not enough space to */
/* allocate the requested size memory area. */

/* The section implements stop-the-world copying garbage collection. */
/* Formally, it consists of 4 stages: */
/* 1. Root set constraction: (see more comments below) */
/* 2. Trace-and-copy */
/*   2.1 move a root object from the active space into the passive space, placing a forward pointer insted */
/*   2.2 iteratively traverse and all its descendants, moving them into the passive space, place */
/*       a forward pointer insted * /
/* 3. Fix pointers */
/* 4. Swap spaces */
/*   I.e. active space becomes passive and vice versa. */
/* In the implementation, the first two steps (1 and 2) are performed simultaneously. */
/* Where root can be found in: */
/* 1) Static area. */
/*   Globals @__gc_data_end and @__gc_data_start are used to idenfity the begin and the end */
/*   of the static data area. They are defined while generating X86 code in src/X86.lama. */
/* 2) Program stack. */
/*   Globals @__gc_stack_bottom and @__gc_stack_top (see runtime/gc_runtime.s) have to be set */
/*   as the begin and the end of program stack or its part where roots can be found. */
/* 3) Traditionally, roots can be also found in registers but our compiler always saves all */
/*   registers on program stack before any external function call. */
/* 4) Extra roots ( @extra_roots ) */
/* You have to implement functions that perform traverse static area (in @gc) */
/* and program stack (in @gc), you also have to check if a word is a valid heap pointer, and, if so, */
/* copy (move the object). */

// The begin and the end of static area (are specified in src/X86.lama fucntion genasm)
extern const size_t __gc_data_end, __gc_data_start;
extern const size_t* __gc_stack_top, *__gc_stack_bottom;

// @L__gc_init is defined in runtime/gc_runtime.s
//   it sets up stack bottom and calls init_pool
//   it is called from the main function (see src/X86.lama function compileX86)
extern void L__gc_init();

// You also have to define two functions @__pre_gc and @__post_gc in runtime/gc_runtime.s.
// These auxiliary functions have to be defined in order to correctly set @__gc_stack_top.
// Note that some of our functions (from runtime.c) activation records can be on top of the
// program stack. These activation records contain usual values and thus we do not have a
// way to distinguish pointers from non-pointers. And some of these values may accidentally be
// equal to pointers into active semi-space but maybe not to the begin of an object.
// Considering such values as pointers leads to undefined behavior.
// Thus, @__gc_stack_top has to point before these activation records.
// Note, you also have to find a correct place(-s) for @__pre_gc and @__post_gc to be called.
// @__pre_gc  sets up @__gc_stack_top if it is not set yet
// NB: make sure you calls __pre_gc everywhere when necessary (see @Bstring for an example)
extern void __pre_gc();
// @__post_gc sets @__gc_stack_top to zero if it was set by the caller
extern void __post_gc();

/* memory semi-space */
typedef struct
{
  size_t *begin;
  size_t *end;
  size_t *current;
  size_t size;
} pool;

static pool from_space; // From-space (active ) semi-heap
static pool to_space;   // To-space   (passive) semi-heap
static size_t* next_unchecked;

static const int WORD = sizeof(int);

// initial semi-space size
static size_t SPACE_SIZE = 1 * WORD; // Less than PAGE_SIZE will be rounded to PAGE_SIZE in mmap
                                     // Small SPACE_SIZE for at least one gc call in tests

static void clear_space(pool* space) {
  space->current = space->begin;
  space->end = space->begin + SPACE_SIZE / WORD;
  space->size = SPACE_SIZE;
}

static void init_space(pool* space) {
  space->begin = mmap(NULL, SPACE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
  clear_space(space);
}

// @free_pool frees memory pool p
int free_pool(pool *p) {
  munmap((void*)p->begin, p->size);
}

// swaps active and passive spaces
static void gc_swap_spaces(void) {
  pool old_from = from_space;
  from_space = to_space;
  to_space = old_from;
}

// checks if @p is a valid pointer to the active (from-) space
#define IS_VALID_HEAP_POINTER(p) \
  (!UNBOXED(p) &&                \
   from_space.begin <= p &&      \
   from_space.end > p)

// checks if @p points to the passive (to-) space
#define IN_PASSIVE_SPACE(p) \
  (to_space.begin <= p &&   \
   to_space.end > p)

// chekcs if @p is a forward pointer
#define IS_FORWARD_PTR(p) \
  (!UNBOXED(p) && IN_PASSIVE_SPACE(p))

// @extend_spaces extends size of both from- and to- spaces
static void extend_spaces(void)
{
  SPACE_SIZE <<= 1;
  from_space.begin = mremap(from_space.begin, from_space.size, SPACE_SIZE, MREMAP_MAYMOVE);
  if (from_space.begin == MAP_FAILED) {
    perror("extend spaces: mremap from_space failed\n");
    exit(1);
  }
  to_space.begin = mremap(to_space.begin, to_space.size, SPACE_SIZE, 0); // move invalidate all pointers
                                                                         // need to write moving of all pointers or call to gc
  if (to_space.begin == MAP_FAILED) {
    perror("extend spaces: mremap to_space failed\n");
    exit(1);
  }
}

// @init_pool is a memory pools initialization function
//   (is called by L__gc_init from runtime/gc_runtime.s)
// two diffent mmaps for flexibility:
// it's allows us to remap free space if required without moving pointers
extern void init_pool(void) {
  init_space(&from_space);
  init_space(&to_space);
}

static size_t round_word(size_t num) {
  return (num + WORD - 1) / WORD;
}

// p in from_space, return pointer in to_space
static void *gc_copy_unchecked(size_t *p) {
  data* obj = TO_DATA(p);
  if (IS_FORWARD_PTR((size_t*)obj->tag)) {
    return (void*)obj->tag;
  }
  switch(TAG(obj->tag)) {
    case ARRAY_TAG: {
      size_t len = LEN(obj->tag);
      memcpy((void*)to_space.current, (void*)obj, (len + 1) * WORD);
      size_t* pos = to_space.current + 1;
      obj->tag = (int)pos;
      to_space.current += 1 + len;
      return pos;
    }
    case SEXP_TAG: {
      sexp* s = TO_SEXP(p);
      size_t len = LEN(obj->tag);
      memcpy((void*)to_space.current, (void*)s, (len + 2) * WORD);
      // Swap to distinguish SEXP on checked step
      *(to_space.current + 1) = s->tag;
      *(to_space.current) = obj->tag;
      size_t* pos = to_space.current + 2;
      obj->tag = (int)pos;
      to_space.current += 2 + len;
      return pos;
    }
    case STRING_TAG: {
      size_t len = LEN(obj->tag);
                                              // [tag, c_str, '\0']
      memcpy((char*)to_space.current, (void*)obj, WORD + len + 1);
      size_t* pos = to_space.current + 1;
      obj->tag = (int)pos;
      to_space.current += 1 + round_word(len);
      return pos;
    }
    default:
      failure("gc copy: tag: 0x%x\n",TAG(obj->tag));
  }
}

static void gc_test_and_copy(size_t **root) {
  if (IS_VALID_HEAP_POINTER(*root)) {
    *root = gc_copy_unchecked(*root);
  }
}

// p in to_space, return pointer to next object
static size_t* gc_check(size_t *p) {
  // fprintf(stderr, "gc_check on 0x%x\n", p);
  data* obj = p;
  size_t len = LEN(obj->tag);
  switch(TAG(obj->tag)) {
    case ARRAY_TAG: {
      size_t* first = p + 1;
      for (size_t* it = first; it < first + len; ++it) {
        gc_test_and_copy(it);
      }
      return p + 1 + len;
    }
    case SEXP_TAG: {
      // Swap back
      size_t tag = *(p + 1);
      *(p + 1) = obj->tag;
      *p = tag;
      size_t* first = p + 2;
      for (size_t* it = first; it < first + len; ++it) {
        gc_test_and_copy(it);
      }
      return p + 2 + len;
    }
    case STRING_TAG: {
      return p + 1 + round_word(len);
    }
    default:
      failure("gc copy: tag: 0x%x\n",TAG(obj->tag));
  }
}

// @gc performs stop-the-world copying garbage collection
//   and extends pools (i.e. calls @extend_spaces) if necessarily
// @size is a size of the block that @alloc failed to allocate
static void gc(size_t size) {
  // fprintf(stderr, "gc called on %d\n", size);
  next_unchecked = to_space.begin;
  // Static data
  for (size_t* i = (size_t*)&__gc_data_start; i < &__gc_data_end; i++) {
    gc_test_and_copy((size_t**)i);
  }
  // Stack
  for (size_t* i = (size_t*)__gc_stack_top; i < __gc_stack_bottom; i++) {
    gc_test_and_copy((size_t**)i);
  }
  // Extra roots
  for (int i = 0; i < extra_roots.current_free; ++i) {
    gc_test_and_copy((size_t**)extra_roots.roots[i]);
  }

  while (next_unchecked != to_space.current) {
    next_unchecked = gc_check(next_unchecked);
  }

  // Equal to avoid empty arrays and sexps (their content == space.end)
  while (to_space.end - to_space.current <= size) {
    extend_spaces();
    to_space.size = SPACE_SIZE;
    to_space.end = to_space.begin + SPACE_SIZE / WORD;
  }
  clear_space(&from_space);
  gc_swap_spaces();
}

// @alloc allocates @size memory words
//   it enables garbage collection if out-of-memory,
//   i.e. calls @gc when @current + @size > @from_space.end
// returns a pointer to the allocated block of size @size
extern void *alloc(size_t size) {
  size = round_word(size);
  // Equal to avoid empty arrays and sexps (their content == space.end)
  if (from_space.current + size >= from_space.end) {
    gc(size);
  }
  size_t *free = from_space.current;
  from_space.current += size;
  return free;
}
