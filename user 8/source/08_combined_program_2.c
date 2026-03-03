#include <stdio.h>

#define N 900000

static int p[N], q[N], r[N];

int main(void) {
    long long sum = 0;

    for (int i = 0; i < N; i++) {
        p[i] = i * 2;
    }
    for (int i = 0; i < N; i++) {
        q[i] = i * 8;
    }
    for (int i = 0; i < N; i++) {
        r[i] = p[i] + q[i];
        sum += r[i];
    }

    printf("%lld\n", sum % 1000000);
    return 0;
}
