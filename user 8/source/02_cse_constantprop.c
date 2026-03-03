#include <stdio.h>

int main(void) {
    int a = 14;
    int b = 6;
    int t1 = (a + b) * (a + b);
    int t2 = (a + b) + 100;
    printf("%d %d\n", t1, t2);
    return 0;
}
