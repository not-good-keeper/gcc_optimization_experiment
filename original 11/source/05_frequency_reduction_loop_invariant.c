#include <stdio.h>

int main(void) {
    int sum = 0;
    int n = 10;
    for (int i = 0; i < n; i++) {
        sum += i * n;
    }
    printf("%d\n", sum);
    return 0;
}
