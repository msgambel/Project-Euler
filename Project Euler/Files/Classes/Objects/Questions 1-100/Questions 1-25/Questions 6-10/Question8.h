//  Question8.h

#import "QuestionAndAnswer.h"

// Here, we make a structure which will allow us to keep track of the moving
// product. If we hold the numbers of the product, the product itself, and the
// left most location of the product in the overall number.

#define NumberOfDigitsInProduct 5

// Structure to hold the product, the number in the product, and the index.
typedef struct {
  uint index;
  uint product;
  uint numbersInProduct[NumberOfDigitsInProduct];
} MovingProduct;

// Returns if two MovingProduct's are equal.
static inline BOOL MovingProductAreEqual(MovingProduct x, MovingProduct y) {
  // Set the default value of the return value.
  BOOL returnValue = YES;
  
  // For all the numbers in the product of both x and y,
  for(int i = 0; i < NumberOfDigitsInProduct; i++){
    // Check if the number is equal.
    returnValue = returnValue && (x.numbersInProduct[i] == y.numbersInProduct[i]);
  }
  // Return if the above, the indexes, and the products are equal. While the
  // product is redunent, as the numbers should be equal, it makes sure that
  // the product of the values was actually computed properly.
  return (returnValue && (x.index == y.index) && (x.product == y.product));
}

// Return a MovingProduct structure populated with 0's.
static const MovingProduct MovingProductZeros = {0, 0, {0, 0, 0, 0, 0}};

// Return a MovingProduct structure populated with 1's.
static const MovingProduct MovingProductOnes = {1, 1, {1, 1, 1, 1, 1}};

// Returns a MovingProduct with the numbers shifted left.
static inline MovingProduct MovingProductShiftLeft(MovingProduct x) {
  // Variable to hold the new MovginProduct.
  MovingProduct y;
  
  // Set the index of the MovingProduct.
  y.index = x.index;
  
  // Set the product of the MovingProduct.
  y.product = x.product;
  
  // For the first (n-1) numbers in the product,
  for(int i = 0; i < (NumberOfDigitsInProduct - 1); i++){
    // Set the current number to the right neighbour of the number in x.
    y.numbersInProduct[i] = x.numbersInProduct[(i + 1)];
  }
  // Set the last number to 1 by default.
  y.numbersInProduct[(NumberOfDigitsInProduct - 1)] = 1;
  
  // Return the new MovingProduct.
  return y;
}

@interface Question8 : QuestionAndAnswer {
  
}

@end