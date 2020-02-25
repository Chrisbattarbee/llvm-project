//
// Created by chris on 25/02/2020.
//
#include <stdlib.h>
#include <time.h>

int main() {
    srand(time(NULL));
    if (random() < RAND_MAX / 2) {
        return 1;
    } else {
        return 0;
    }
}