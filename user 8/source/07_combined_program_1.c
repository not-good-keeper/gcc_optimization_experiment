#include <stdio.h>

#define N 800000

static int a[N], b[N];

int main(void) {
    long long total = 0;
    for (int i = 0; i < N; i++) {
        a[i] = i * 4;
        b[i] = i + 3;
    }

    for (int i = 0; i < N; i++) {
        int t = (a[i] + b[i]);
        total += t + (a[i] + b[i]);
    }

    printf("%lld\n", total % 1000000);
    return 0;
}
