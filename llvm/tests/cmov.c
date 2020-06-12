#include "stdlib.h"

__attribute__((noinline))
int test(int a, int b) {
  for (volatile int x = 0; x < 100000; x ++) {
    a += x > 50000 ? a : b;
  }
  return a;
}

int main() {
  return test(10, rand());
}
