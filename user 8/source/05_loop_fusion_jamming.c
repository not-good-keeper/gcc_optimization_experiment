#include <stdio.h>

#define N 1000000

static int x[N], y[N], z[N];

int main(void) {
    long long total = 0;
    for (int i = 0; i < N; i++) {
        x[i] = i & 127;
    }
    for (int i = 0; i < N; i++) {
        y[i] = (i * 2) & 127;
    }
    for (int i = 0; i < N; i++) {
        z[i] = x[i] + y[i];
        total += z[i];
    }
    printf("%lld\n", total % 1000000);
    return 0;
}
