#include <stdio.h>

int main(void) {
    long long sum = 0;
    const int n = 1000000;
    const int factor = 23;
    for (int i = 0; i < n; i++) {
        sum += (i + 7) * factor;
    }
    printf("%lld\n", sum % 1000000);
    return 0;
}
