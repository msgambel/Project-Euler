//  Structures.h

#ifndef Project_Euler_Structures_h
#define Project_Euler_Structures_h

// Here, we make a structure which will allow us to keep track of the moving
// product. If we hold the numbers of the product, the product itself, and the
// left most location of the product in the overall number.

// Structures to hold the product, the number in the product, and the index.

typedef struct {
  uint index;
  uint product;
  uint numbersInProduct[4];
} MovingProduct4;

typedef struct {
  uint index;
  uint product;
  uint numbersInProduct[5];
} MovingProduct5;

// Return a MovingProduct4 structure populated with 0's.
static const MovingProduct4 MovingProduct4Zeros = {0, 0, {0, 0, 0, 0}};

// Return a MovingProduct5 structure populated with 0's.
static const MovingProduct5 MovingProduct5Zeros = {0, 0, {0, 0, 0, 0, 0}};

// Return a MovingProduct4 structure populated with 1's.
static const MovingProduct4 MovingProduct4Ones = {1, 1, {1, 1, 1, 1}};

// Return a MovingProduct5 structure populated with 1's.
static const MovingProduct5 MovingProduct5Ones = {1, 1, {1, 1, 1, 1, 1}};

// Returns if two MovingProduct4's are equal.
static inline BOOL MovingProduct4AreEqual(MovingProduct4 x, MovingProduct4 y) {
  // Set the default value of the return value.
  BOOL returnValue = YES;
  
  // For all the numbers in the product of both x and y,
  for(int i = 0; i < 4; i++){
    // Check if the number is equal.
    returnValue = returnValue && (x.numbersInProduct[i] == y.numbersInProduct[i]);
  }
  // Return if the above, the indexes, and the products are equal. While the
  // product is redundent, as the numbers should be equal, it makes sure that
  // the product of the values was actually computed properly.
  return (returnValue && (x.index == y.index) && (x.product == y.product));
}

// Returns if two MovingProduct5's are equal.
static inline BOOL MovingProduct5AreEqual(MovingProduct5 x, MovingProduct5 y) {
  // Set the default value of the return value.
  BOOL returnValue = YES;
  
  // For all the numbers in the product of both x and y,
  for(int i = 0; i < 5; i++){
    // Check if the number is equal.
    returnValue = returnValue && (x.numbersInProduct[i] == y.numbersInProduct[i]);
  }
  // Return if the above, the indexes, and the products are equal. While the
  // product is redundent, as the numbers should be equal, it makes sure that
  // the product of the values was actually computed properly.
  return (returnValue && (x.index == y.index) && (x.product == y.product));
}

// Returns a MovingProduct4 with the numbers shifted left.
static inline MovingProduct4 MovingProduct4ShiftLeft(MovingProduct4 x) {
  // Variable to hold the new MovginProduct.
  MovingProduct4 y;
  
  // Set the index of the MovingProduct.
  y.index = x.index;
  
  // Set the product of the MovingProduct.
  y.product = x.product;
  
  // For the first (n-1) numbers in the product (n = 4),
  for(int i = 0; i < 3; i++){
    // Set the current number to the right neighbour of the number in x.
    y.numbersInProduct[i] = x.numbersInProduct[(i + 1)];
  }
  // Set the last number to 1 by default.
  y.numbersInProduct[3] = 1;
  
  // Return the new MovingProduct.
  return y;
}

// Returns a MovingProduct5 with the numbers shifted left.
static inline MovingProduct5 MovingProduct5ShiftLeft(MovingProduct5 x) {
  // Variable to hold the new MovginProduct.
  MovingProduct5 y;
  
  // Set the index of the MovingProduct.
  y.index = x.index;
  
  // Set the product of the MovingProduct.
  y.product = x.product;
  
  // For the first (n-1) numbers in the product (n = 5),
  for(int i = 0; i < 4; i++){
    // Set the current number to the right neighbour of the number in x.
    y.numbersInProduct[i] = x.numbersInProduct[(i + 1)];
  }
  // Set the last number to 1 by default.
  y.numbersInProduct[4] = 1;
  
  // Return the new MovingProduct.
  return y;
}

#endif