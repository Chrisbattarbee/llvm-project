#define LOOP_REPEAT_COUNT 10000
#include "stdlib.h"


int main() {
  int acc = 0; // acc used to make sure we dont optimize the loop away
  for (int x = 0; x < LOOP_REPEAT_COUNT; x ++) {
    if (x < LOOP_REPEAT_COUNT / 2) {
      srand(3);
      acc += rand();
    } else {
      srand(4);
      acc += rand();
    }
		acc += x < LOOP_REPEAT_COUNT % x ? rand() : 5;
  }
  return acc;
}
