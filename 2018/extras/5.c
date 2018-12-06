#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

size_t reduce(char *polymer) {
  size_t readIndex = 0;
  size_t writeIndex = 0;
  while (polymer[readIndex] != 0) {
    if (writeIndex > 0 && abs(polymer[readIndex] - polymer[writeIndex-1]) == 32) {
      writeIndex--;
    } else {
      polymer[writeIndex] = polymer[readIndex];
      writeIndex++;
    }
    readIndex++;
  }

  polymer[writeIndex] = 0;
  return writeIndex;
}

int reduceAndRemove(char *polymer, char c) {
  size_t readIndex = 0;
  size_t writeIndex = 0;
  while (polymer[readIndex] != 0) {
    if (writeIndex > 0 && abs(polymer[readIndex] - polymer[writeIndex-1]) == 32) {
      writeIndex--;
    } else if (polymer[readIndex] != c && polymer[readIndex] != c + 32) {
      polymer[writeIndex] = polymer[readIndex];
      writeIndex++;
    }
    readIndex++;
  }

  polymer[writeIndex] = 0;
  return writeIndex;
}

int main() {
  char *input = malloc(50001);
  FILE *f = fopen("5.in", "rb");
  fread(input, 1, 50000, f);
  fclose(f);
  input[50000] = 0;

  size_t count = reduce(input);
  printf("Part 1: %lu\n", count);

  char *tmp = malloc(count + 1);
  size_t min = count;
  for (char c = 'A'; c <= 'Z'; c++) {
    memcpy(tmp, input, count + 1);
    size_t length = reduceAndRemove(tmp, c);
    min = length < min ? length : min;
  }
  free(tmp);

  printf("Part 2: %lu\n", min);

  free(input);
  return 0;
}
