#include <stdio.h>
#include <stdint.h>
#include <string.h>

int64_t print(char* input) {
  printf("%s\n", input);
}

void flush() {
  fflush(stdout);
}

// getchar and exit has been defined.

// ord and chr and not can be defined in Haskell source code space

int64_t size(char* input) {
  return strlen(input);
}

