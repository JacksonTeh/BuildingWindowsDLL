#include "TestDll.h"

/*
   Demonstrates creating a DLL with an exported function in a flexible and
   elegant way.
*/

/* Assign value to exported variables. */
// int foo = 7;
// int bar = 41;

ADDAPI int ADDCALL Add(int a, int b)
// int ADDAPI Add(int a, int b)
{
  return (a + b);
}