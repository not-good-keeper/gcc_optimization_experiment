#include <stdio.h>

#define N 1500000

static int a[N], b[N], c[N];

int main(void) {
    long long sum = 0;
    for (int i = 0; i < N; i++) {
        a[i] = i % 100;
    }
    for (int i = 0; i < N; i++) {
        b[i] = (i * 3) % 100;
    }
    for (int i = 0; i < N; i++) {
        c[i] = a[i] + b[i];
        sum += c[i];
    }
    printf("%lld\n", sum % 1000000);
    return 0;
}
