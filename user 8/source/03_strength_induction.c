#include <stdio.h>

int main(void) {
    long long acc = 0;
    for (int i = 0; i < 1000000; i++) {
        acc += i * 8;
    }
    printf("%lld\n", acc % 1000000);
    return 0;
}
