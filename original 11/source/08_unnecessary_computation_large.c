#include <stdio.h>

int main(void) {
    volatile long long sink = 0;
    for (int i = 0; i < 2000000; i++) {
        int x = i;
        int y = i;
        sink += x * y;
    }
    printf("%lld\n", sink % 1000000);
    return 0;
}
