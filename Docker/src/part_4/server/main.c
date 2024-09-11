#include <stdio.h>
#include "fcgi_stdio.h"

int main(void) {
  int count = 0;
  while (FCGI_Accept() >= 0) {
    printf("Content-type: text/html\r\n\r\n");
    printf("Hello World!\r\n");
  }
  return 0;
}