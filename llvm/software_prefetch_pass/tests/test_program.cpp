#include "stdint.h"
#include "stdlib.h"
#include <time.h>

#define ARRAY_SIZE 255
int main() {
    uint32_t* array = (uint32_t*) malloc(sizeof(uint32_t) * ARRAY_SIZE);
    uint32_t* index_array = (uint32_t*) malloc(sizeof(uint32_t) * ARRAY_SIZE);

  srand(time(NULL));

    for (volatile int x = 0; x < ARRAY_SIZE; x ++) {
        array[x] = rand();
        index_array[x] = rand() % ARRAY_SIZE;
    }

    uint64_t sum = 0;
    for (int x = 0; x < ARRAY_SIZE; x ++) {
        sum += array[index_array[x]];
    }
    return sum;
}
