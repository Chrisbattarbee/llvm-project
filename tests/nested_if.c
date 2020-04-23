#include <stdlib.h>

int main() {
  if (rand() < 10) {
    if (rand() < 5) {
      return 1;
    } else {
      return 2;
    }
  }
  return 3;
}