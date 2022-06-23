#include <stdio.h>

int recursive(int n);

int main(void)
{
    int n;
    scanf("%d", &n);

    printf("%d\n", recursive(n));
    return 0;
}