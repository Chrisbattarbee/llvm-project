#include <stdlib.h>

int main() {
  if (rand() < 5) {
    return 1;
  }
  if (rand()  < 100) {
    return 2;
  }
  return 3;
}
