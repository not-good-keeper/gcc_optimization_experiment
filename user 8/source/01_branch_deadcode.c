#include <stdio.h>

int main(void) {
    int x = 10;
    if (x > 0) {
        printf("positive\n");
    } else {
        printf("never\n");
    }

    if (0) {
        printf("dead block\n");
    }
    return 0;
}
