Copyright 2022 Maria Sfiraiala (maria.sfiraiala@stud.acs.upb.ro)

# Challenge2

Implement the following `C` code in `Assembly (x86)`

```C
#include<stdlib.h>
#include<stdio.h>

int* alloc_array(int n) {
   return malloc(n * 4);
}

void read_array(int n, int *v) {
   for (int i = 0; i < n; ++i) {
       scanf("%d", &v[i]);
   }
}

int sum_array(int n, int *v) {
   int sum = 0;
   for (int i = 0; i < n; ++i) {
       sum += v[i];
   }
   return sum;
}


int main() {
   int n = 5;
   int *v = alloc_array(n);
   read_array(n, v);
   int sum = sum_array(n, v);
   printf("%d\n", sum);
   free(v);
   return 0;
}

```
