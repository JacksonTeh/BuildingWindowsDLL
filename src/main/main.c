/*
   Demonstrates using the function imported from the DLL, in a flexible and
   elegant way.
*/

#include <stdlib.h>
#include <stdio.h>
#include "TestDll.h"

int main(int argc, char** argv)
{
  printf("Ans: %d\n", Add(6, 23));
  /* foo + bar = Add(foo, bar) */
  // printf("%d + %d = %d\n", foo, bar, Add(foo, bar));

  return 0;
}