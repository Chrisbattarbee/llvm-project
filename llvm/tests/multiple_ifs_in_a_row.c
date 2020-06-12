#include <stdlib.h>
#include <stdio.h>
#include <time.h>

__attribute__((noinline))
int test() {
    if (rand()  < RAND_MAX / 2) {
        return 2;
    }
    return 1;
}

int main() {
  srand(time(NULL));
  if (rand() < 5) {
    return 1;
  }

  int output;
  for (int x = 0; x < 1000000; x ++) {
    if (rand() < RAND_MAX / 2) {
      output = rand();
    }
  }

  if (rand()  < 100) {
    return 2;
  }
  return test() || output;
}
