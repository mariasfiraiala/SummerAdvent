#include <stdio.h>
#include <stdlib.h>

int *partition(int n, int k);

int main(void)
{
    int n, k, *v;
    scanf("%d %d", &n, &k);

    v = partition(n, k);

    for (int i = 0; i < n; ++i)
        printf("%d ", v[i]);
    printf("\n");

    free(v);

    return 0;
}