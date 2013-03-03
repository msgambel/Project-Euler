//  Structures.h

#ifndef Project_Euler_Structures_h
#define Project_Euler_Structures_h

#import "Enumerations.h"

// Structure to hold a prime power.
typedef struct {
  uint power;
  uint primeNumber;
}PrimePower;

// Here, we make a structure which will allow us to keep track of the moving
// product. If we hold the numbers of the product, the product itself, and the
// left most location of the product in the overall number.

// Structure to hold the product, the 4 numbers in the product, and the index.
typedef struct {
  uint index;
  uint product;
  uint numbersInProduct[4];
}MovingProduct4;

// Structure to hold the product, the 5 numbers in the product, and the in
typedef struct {
  uint index;
  uint product;
  uint numbersInProduct[5];
}MovingProduct5;

// Structure to hold the number and type of a polygonal number.
typedef struct {
  uint number;
  PolygonalNumberType type;
}PolygonalNumber;

#endif