#include <stdio.h>

int power(short a, short b);

int main(void)
{
    short a, b;
    scanf("%hd %hd", &a, &b);

    printf("%d\n", power(a, b));
    return 0;
}