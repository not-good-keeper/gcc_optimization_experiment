#include <stdio.h>

static inline int square(int v) {
    return v * v;
}

int main(void) {
    long long sum = 0;
    for (int i = 0; i < 1000000; i++) {
        sum += square(i & 255);
    }
    printf("%lld\n", sum % 1000000);
    return 0;
}
