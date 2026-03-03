#include <stdio.h>

#define N 2000000

static int arr[N];

int main(void) {
    long long sum = 0;
    for (int i = 0; i < N; i++) {
        arr[i] = i & 255;
    }
    for (int i = 0; i < N; i++) {
        sum += arr[i];
    }
    printf("%lld\n", sum % 1000000);
    return 0;
}
