#include "stdint.h"
#include "stdlib.h"

#define ARRAY_SIZE 1000
int main() {
    uint32_t* array = (uint32_t*) malloc(sizeof(uint32_t) * ARRAY_SIZE);
    uint32_t* index_array = (uint32_t*) malloc(sizeof(uint32_t) * ARRAY_SIZE);

    for (volatile int x = 0; x < ARRAY_SIZE; x ++) {
        array[x] = rand();
        index_array[x] = rand() % ARRAY_SIZE;
    }

    uint64_t sum = 0;
    for (volatile int x = 0; x < ARRAY_SIZE; x ++) {
        sum += array[index_array[x]];
    }
    return sum;
}
