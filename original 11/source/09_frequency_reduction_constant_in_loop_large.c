#include <stdio.h>

int main(void) {
    volatile long long sum = 0;
    int n = 5000000;
    for (int i = 0; i < n; i++) {
        sum += i * 17;
    }
    printf("%lld\n", sum % 1000000);
    return 0;
}
