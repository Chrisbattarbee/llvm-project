/*
int sum() {
  // for each range
  for (int x = range_start; x < range_end; x ++) {
    prefetch(arr + x);
  }


  int sum = 0;
  for (int x = 0; x < size; x++) {
    load arr + x
  }
  return sum;
}


////////////////////////////////////////////////////////////////////////////////
func(x) {
  for (int x = 0; x < size; x++) {
    load arr + x
  }
}
 */

// How to determine a range?
// What is a good cut of point for sum of ranges
// Calculate a most common stride
// Figure out where to place the prefetch loops
// Stretch: Figure out how many ranges I should have because of instruction count bloat