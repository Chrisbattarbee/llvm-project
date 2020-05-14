#define LOOP_REPEAT_COUNT 10000
#include "stdlib.h"


int main() {
  int acc = 0; // acc used to make sure we dont optimize the loop away
  for (int x = 0; x < LOOP_REPEAT_COUNT; x ++) {
    if (x < LOOP_REPEAT_COUNT / 2) {
      acc += rand();
    } else {
      acc += 2 * rand();
    }
  }
  return acc;
}