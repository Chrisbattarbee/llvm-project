__attribute__((noinline))
int test(int a, int b) {
  return a > b ? a : b;
}

int main() {
  return test(10, 5);
}