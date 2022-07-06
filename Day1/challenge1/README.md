Copyright 2022 Maria Sfiraiala (maria.sfiraiala@stud.acs.upb.ro)

# Challenge1

Implement the following `C` code in `Assembly (x86)`

```C
#include <stdio.h>
#include <stdlib.h>

int inc2(int x) {
  return 3 * x + 10;
}

int is_odd(int x) {
  return (x % 2 == 1);
}

int* map(int n, int *v, int (*f)(int)) {
  int *res = malloc(n * sizeof(int));

  for (int i = 0; i < n; ++i) {
     res[i] = f(v[i]);
  }
  return res;
}

int* filter(int *filter_count, int n, int *v, int (*f)(int)) {
  int *res = malloc(n * sizeof(int));

  int count = 0;
  for (int i = 0; i < n; ++i) {
     if (f(v[i])) {
        res[count++] = v[i];
     } 
  }

  res = realloc(res, count * sizeof(int));
  *filter_count = count;
  return res;
} 
 
void print_array(int n, int *v) {
  for (int i = 0; i < n; ++i) {
     printf("%d ", v[i]);
  }
  printf("\n");
}

int main() {
  int n = 5;
  int v[] = {1, 2, 3, 4, 5};
  int *map_v = map(5, v, inc2);

  int filter_count;
  int *filter_v = filter(&filter_count, 5, v, is_odd);

  print_array(n, map_v);
  print_array(filter_count, filter_v);

  free(map_v);
  free(filter_v);

  return 0;
}

```
