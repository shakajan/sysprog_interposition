#include<malloc.h>
#include<stdio.h>

int main() {
    int *p = malloc(32);
    free(p);
    return 0;
}
