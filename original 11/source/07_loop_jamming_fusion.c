#include <stdio.h>

int main(void) {
    int a[100], b[100], c[100];
    for (int i = 0; i < 100; i++) {
        a[i] = i;
    }
    for (int i = 0; i < 100; i++) {
        b[i] = i * 2;
    }
    for (int i = 0; i < 100; i++) {
        c[i] = a[i] + b[i];
    }
    printf("%d\n", c[99]);
    return 0;
}
