//  Question61.m

#import "Question61.h"
#import "Global.h"

@interface Question61 (Private)

- (BOOL)lastTwoDigitsOfNumber:(uint)aFirstNumber isEqualToFirstTwoDigitsOfNumber:(uint)aSecondNumber;

@end

@implementation Question61

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"16 January 2004";
  self.hint = @"Store all the polygonal numbers in an array before checking.";
  self.text = @"Triangle, square, pentagonal, hexagonal, heptagonal, and octagonal numbers are all figurate (polygonal) numbers and are generated by the following formulae:\n\nTriangle	P3,n=n(n+1)/2	1, 3, 6, 10, 15, ...\nSquare P4,n=n²1, 4, 9, 16, 25, ...\nPentagonal P5,n=n(3n-1)/2 1, 5, 12, 22, 35, ...\nHexagonal P6,n=n(2n-1) 1, 6, 15, 28, 45, ...\nHeptagonal P7,n=n(5n-3)/2 1, 7, 18, 34, 55, ...\nOctagonal P8,n=n(3n-2) 1, 8, 21, 40, 65, ...\n\nThe ordered set of three 4-digit numbers: 8128, 2882, 8281, has three interesting properties.\n\nThe set is cyclic, in that the last two digits of each number is the first two digits of the next number (including the last number with the first).\n\nEach polygonal type: triangle (P3,127=8128), square (P4,91=8281), and pentagonal (P5,44=2882), is represented by a different number in the set.\n\nThis is the only set of 4-digit numbers with this property.\n\nFind the sum of the only ordered set of six cyclic 4-digit numbers for which each polygonal type: triangle, square, pentagonal, hexagonal, heptagonal, and octagonal, is represented by a different number in the set.";
  self.isFun = NO;
  self.title = @"Cyclical figurate numbers";
  self.answer = @"28684";
  self.number = @"61";
  self.rating = @"5";
  self.keywords = @"triangle,square,pentagonal,hexagonal,heptagonal,octagonal,cyclic,set,numbers,polygonal,different,number,formulae,represented,set,figurate,generated";
  self.solveTime = @"90";
  self.difficulty = @"Easy";
  self.completedOnDate = @"02/03/13";
  self.solutionLineCount = @"87";
  self.estimatedComputationTime = @"0.033";
  self.estimatedBruteForceComputationTime = @"0.033";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute all of the polygonal numbers using Macros, and
  // store them all in an array. We then loop through all of the polygonal
  // numbers, and using a helper method, we check if the last two digits of the
  // first polygonal number are equal to the first two digits of the second
  // polygonal number.
  //
  // Then, we store the index of the second polygonal number in order to come
  // back to it if it does NOT yield a set of six cyclic polygonal numbers.
  //
  // We then repeat the process, adding polygonal numbers into the set of six
  // cyclic polygonal numbers, and storing the indices, and if we find that the
  // current set does NOT yield a set of six cyclic polygonal numbers, we remove
  // the last one, reset the index to the one we stored, and repeat.
  //
  // Once we have found six polygonal numbers that are cyclic, we check that the
  // last and first polygonal numbers also share the digits property. If they
  // do, we mark that we have found the set of six cyclic polygonal numbers, and
  // break out of the loop. We then sum them up, and set them to the answer!
  
  // Variable to mark if we have found the six cyclic polygonal numbers.
  BOOL isFound = NO;
  
  // Variable to hold if the current type of polygonal number we are looking at
  // in the array is NOT the same as a previous type.
  BOOL isNewType = NO;
  
  // Variable to hold the index of the current cyclic polygonal number we are
  // looking at.
  uint index = 0;
  
  // Variable to hold the maximum polygonal number to look at.
  uint maxSize = 200;
  
  // Variable to hold the current polygonal number.
  uint polygonalNumber = 0;
  
  // Variable to hold the current polygonal numbers index.
  uint polygonalNumberIndex = 0;
  
  // Variable to hold the sum of the cyclic polygonal numbers.
  uint sumOfCyclicPolygonalNumbers = 0;
  
  // Variable array to hold the start indices to return to if the current
  // polygonal number does NOT belong in the required 6 cyclic polygonal number.
  uint startIndex[6] = {0};
  
  // Variable array to hold all the polygonal numbers (regardless of type).
  PolygonalNumber polygonalNumbers[400];
  
  // Variable array to hold the six cyclic polygonal numbers. Also used when
  // testing the polygonal numbers to see if they are indeed cyclic.
  PolygonalNumber cyclicPolygonalNumbers[6];
  
  // Variable array to hold the types of the current polygonal numbers.
  PolygonalNumberType typesUsed[6] = {PolygonalNumberType_None};
  
  // For all of the different types of polygonal numbers,
  for(PolygonalNumberType type = PolygonalNumberType_Triangle; type <= PolygonalNumberType_Octagonal; type++){
    // For all the polygonal numbers up to the maximum size,
    for(int n = 1; n < maxSize; n++){
      // Based on the type of the polygonal number,
      switch(type){
          // If the type of polygonal number is Triangle,
        case PolygonalNumberType_Triangle:
          // Compute the Triangle number using a Macro.
          polygonalNumber = TriangleNumber(n);
          break;
          // If the type of polygonal number is Square,
        case PolygonalNumberType_Square:
          // Compute the Square number using a Macro.
          polygonalNumber = SquareNumber(n);
          break;
          // If the type of polygonal number is Pentagonal,
        case PolygonalNumberType_Pentagonal:
          // Compute the Pentagonal number using a Macro.
          polygonalNumber = PentagonalNumber(n);
          break;
          // If the type of polygonal number is Hexagonal,
        case PolygonalNumberType_Hexagonal:
          // Compute the Hexagonal number using a Macro.
          polygonalNumber = HexagonalNumber(n);
          break;
          // If the type of polygonal number is Heptagonal,
        case PolygonalNumberType_Heptagonal:
          // Compute the Heptagonal number using a Macro.
          polygonalNumber = HeptagonalNumber(n);
          break;
          // If the type of polygonal number is Octagonal,
        case PolygonalNumberType_Octagonal:
          // Compute the Octagonal number using a Macro.
          polygonalNumber = OctagonalNumber(n);
          break;
        default:
          break;
      }
      // If the polygonal number has more than 5 digits,
      if(polygonalNumber >= 10000){
        // Break out of the loop.
        break;
      }
      // If the polygonal number has exactly 4 digits,
      else if(polygonalNumber >= 1000){
        // Add the polygonal number to the array of polygonal numbers.
        polygonalNumbers[polygonalNumberIndex] = PolygonalNumberMake(polygonalNumber, type);
        
        // Increment the number of polygonal numbers by 1.
        polygonalNumberIndex++;
      }
    }
  }
  // For all of the cyclic polygonal numbers,
  for(int i = 0; i < 6; i++){
    // Set them to 0 by default.
    cyclicPolygonalNumbers[i] = PolygonalNumberZero;
  }
  // For all the starting polygonal numbers in the set of six cyclic polygonal
  // numbers,
  for(int i = 0; i < polygonalNumberIndex; i++){
    // For all of the cyclic polygonal numbers,
    for(int n = 0; n < 6; n++){
      // Reset the types used to None.
      typesUsed[n] = PolygonalNumberType_None;
    }
    // Set the starting polygonal number (in the set of six cyclic polygona/
    // numbers to be the current starting polygonal number.
    cyclicPolygonalNumbers[0] = polygonalNumbers[i];
    
    // Set the type used of the starting polygonal number.
    typesUsed[0] = polygonalNumbers[i].type;
    
    // Reset the index of the polygonal numbers currently set to 0.
    index = 0;
    
    // For all the polygonal numbers in the set of six cyclic polygonal numbers,
    for(int j = 0; j < polygonalNumberIndex; j++){
      // Reset that the current type is a new type in the set of six cyclic
      // polygonal numbers.
      isNewType = YES;
      
      // For all of the cyclic polygonal numbers,
      for(int n = 0; n < 6; n++){
        // If the current type is equal to a previously used type,
        if(typesUsed[n] == polygonalNumbers[j].type){
          // Mark that this polygonal numbers type is NOT unused.
          isNewType = NO;
          
          // Break out of the loop.
          break;
        }
      }
      // If the current polygonal numbers type IS unused in the set of six
      // cyclic polygonal numbers,
      if(isNewType){
        // If the last two digits of the cyclic polygonal number we are looking
        // at are equal to the first two digits of the current polygonal number
        // we are looking at,
        if([self lastTwoDigitsOfNumber:cyclicPolygonalNumbers[index].number isEqualToFirstTwoDigitsOfNumber:polygonalNumbers[j].number]){
          // Store the starting index of the current polygonal number, as we
          // may have to come back to it if it does not produce a chain of six
          // cyclic polygonal numbers.
          startIndex[index] = j;
          
          // Increment the number of cyclic polygonal numbers in the chain by 1.
          index++;
          
          // Store the current polygonal number in the set of six cyclic
          // polygonal numbers,
          cyclicPolygonalNumbers[index] = polygonalNumbers[j];
          
          // Store the type of the current polygonal number in the types used
          // array.
          typesUsed[index] = polygonalNumbers[j].type;
          
          // Reset the index of the polygonal numbers we are looking through to
          // 0, so that we don't miss any!
          j = 0;
          
          // If the number of cyclic numbers found is six,
          if(index == 5){
            // If the last two digits of the last number in the set of six
            // cyclic polygonal numbers are equal to the first two digits of the
            // first polygonal number (hence, completing our cycle),
            if([self lastTwoDigitsOfNumber:cyclicPolygonalNumbers[5].number isEqualToFirstTwoDigitsOfNumber:cyclicPolygonalNumbers[0].number]){
              // Mark that we have found the 6 cyclic polygonal numbers.
              isFound = YES;
              
              // Break out of the loop.
              break;
            }
            // If the last two digits of the last number in the set of six
            // cyclic polygonal numbers are NOT equal to the first two digits of
            // the first polygonal number,
            else{
              // Remove the current polygonal numbers type from the types used
              // array.
              typesUsed[index] = PolygonalNumberType_None;
              
              // Decrement the index by 1.
              index--;
              
              // Reset the index of polygonal numbers we are looking at in order
              // to start where we left off.
              j = startIndex[index];
            }
          }
        }
      }
      // If we have gotten to the last polygonal number, and the number of
      // polygonal numbers in our set of six cyclic polygonal numbers is NOT 1,
      if((j == (polygonalNumberIndex - 1)) && (index > 0)){
        // Remove the current polygonal numbers type from the types used
        // array.
        typesUsed[index] = PolygonalNumberType_None;
        
        // Decrement the index by 1.
        index--;
        
        // Reset the index of polygonal numbers we are looking at in order
        // to start where we left off.
        j = startIndex[index];
      }
    }
    // If we have found the 6 cyclic polygonal numbers,
    if(isFound){
      // Break out of the loop.
      break;
    }
  }
  // For all the cyclic polygonal numbers,
  for(int i = 0; i < 6; i++){
    // Add the cyclic polygonal number to the sum of the polygonal numbers.
    sumOfCyclicPolygonalNumbers += cyclicPolygonalNumbers[i].number;
  }
  // Set the answer string to the sum of the cyclic polygonal numbers.
  self.answer = [NSString stringWithFormat:@"%d", sumOfCyclicPolygonalNumbers];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

- (void)computeAnswerByBruteForce; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we simply compute all of the polygonal numbers using Macros, and
  // store them all in an array. We then loop through all of the polygonal
  // numbers, and using a helper method, we check if the last two digits of the
  // first polygonal number are equal to the first two digits of the second
  // polygonal number.
  //
  // Then, we store the index of the second polygonal number in order to come
  // back to it if it does NOT yield a set of six cyclic polygonal numbers.
  //
  // We then repeat the process, adding polygonal numbers into the set of six
  // cyclic polygonal numbers, and storing the indices, and if we find that the
  // current set does NOT yield a set of six cyclic polygonal numbers, we remove
  // the last one, reset the index to the one we stored, and repeat.
  //
  // Once we have found six polygonal numbers that are cyclic, we check that the
  // last and first polygonal numbers also share the digits property. If they
  // do, we mark that we have found the set of six cyclic polygonal numbers, and
  // break out of the loop. We then sum them up, and set them to the answer!
  
  // Variable to mark if we have found the six cyclic polygonal numbers.
  BOOL isFound = NO;
  
  // Variable to hold if the current type of polygonal number we are looking at
  // in the array is NOT the same as a previous type.
  BOOL isNewType = NO;
  
  // Variable to hold the index of the current cyclic polygonal number we are
  // looking at.
  uint index = 0;
  
  // Variable to hold the maximum polygonal number to look at.
  uint maxSize = 200;
  
  // Variable to hold the current polygonal number.
  uint polygonalNumber = 0;
  
  // Variable to hold the current polygonal numbers index.
  uint polygonalNumberIndex = 0;
  
  // Variable to hold the sum of the cyclic polygonal numbers.
  uint sumOfCyclicPolygonalNumbers = 0;
  
  // Variable array to hold the start indices to return to if the current
  // polygonal number does NOT belong in the required 6 cyclic polygonal number.
  uint startIndex[6] = {0};
  
  // Variable array to hold all the polygonal numbers (regardless of type).
  PolygonalNumber polygonalNumbers[400];
  
  // Variable array to hold the six cyclic polygonal numbers. Also used when
  // testing the polygonal numbers to see if they are indeed cyclic.
  PolygonalNumber cyclicPolygonalNumbers[6];
  
  // Variable array to hold the types of the current polygonal numbers.
  PolygonalNumberType typesUsed[6] = {PolygonalNumberType_None};
  
  // For all of the different types of polygonal numbers,
  for(PolygonalNumberType type = PolygonalNumberType_Triangle; type <= PolygonalNumberType_Octagonal; type++){
    // For all the polygonal numbers up to the maximum size,
    for(int n = 1; n < maxSize; n++){
      // Based on the type of the polygonal number,
      switch(type){
          // If the type of polygonal number is Triangle,
        case PolygonalNumberType_Triangle:
          // Compute the Triangle number using a Macro.
          polygonalNumber = TriangleNumber(n);
          break;
          // If the type of polygonal number is Square,
        case PolygonalNumberType_Square:
          // Compute the Square number using a Macro.
          polygonalNumber = SquareNumber(n);
          break;
          // If the type of polygonal number is Pentagonal,
        case PolygonalNumberType_Pentagonal:
          // Compute the Pentagonal number using a Macro.
          polygonalNumber = PentagonalNumber(n);
          break;
          // If the type of polygonal number is Hexagonal,
        case PolygonalNumberType_Hexagonal:
          // Compute the Hexagonal number using a Macro.
          polygonalNumber = HexagonalNumber(n);
          break;
          // If the type of polygonal number is Heptagonal,
        case PolygonalNumberType_Heptagonal:
          // Compute the Heptagonal number using a Macro.
          polygonalNumber = HeptagonalNumber(n);
          break;
          // If the type of polygonal number is Octagonal,
        case PolygonalNumberType_Octagonal:
          // Compute the Octagonal number using a Macro.
          polygonalNumber = OctagonalNumber(n);
          break;
        default:
          break;
      }
      // If the polygonal number has more than 5 digits,
      if(polygonalNumber >= 10000){
        // Break out of the loop.
        break;
      }
      // If the polygonal number has exactly 4 digits,
      else if(polygonalNumber >= 1000){
        // Add the polygonal number to the array of polygonal numbers.
        polygonalNumbers[polygonalNumberIndex] = PolygonalNumberMake(polygonalNumber, type);
        
        // Increment the number of polygonal numbers by 1.
        polygonalNumberIndex++;
      }
    }
  }
  // For all of the cyclic polygonal numbers,
  for(int i = 0; i < 6; i++){
    // Set them to 0 by default.
    cyclicPolygonalNumbers[i] = PolygonalNumberZero;
  }
  // For all the starting polygonal numbers in the set of six cyclic polygonal
  // numbers,
  for(int i = 0; i < polygonalNumberIndex; i++){
    // For all of the cyclic polygonal numbers,
    for(int n = 0; n < 6; n++){
      // Reset the types used to None.
      typesUsed[n] = PolygonalNumberType_None;
    }
    // Set the starting polygonal number (in the set of six cyclic polygona/
    // numbers to be the current starting polygonal number.
    cyclicPolygonalNumbers[0] = polygonalNumbers[i];
    
    // Set the type used of the starting polygonal number.
    typesUsed[0] = polygonalNumbers[i].type;
    
    // Reset the index of the polygonal numbers currently set to 0.
    index = 0;
    
    // For all the polygonal numbers in the set of six cyclic polygonal numbers,
    for(int j = 0; j < polygonalNumberIndex; j++){
      // Reset that the current type is a new type in the set of six cyclic
      // polygonal numbers.
      isNewType = YES;
      
      // For all of the cyclic polygonal numbers,
      for(int n = 0; n < 6; n++){
        // If the current type is equal to a previously used type,
        if(typesUsed[n] == polygonalNumbers[j].type){
          // Mark that this polygonal numbers type is NOT unused.
          isNewType = NO;
          
          // Break out of the loop.
          break;
        }
      }
      // If the current polygonal numbers type IS unused in the set of six
      // cyclic polygonal numbers,
      if(isNewType){
        // If the last two digits of the cyclic polygonal number we are looking
        // at are equal to the first two digits of the current polygonal number
        // we are looking at,
        if([self lastTwoDigitsOfNumber:cyclicPolygonalNumbers[index].number isEqualToFirstTwoDigitsOfNumber:polygonalNumbers[j].number]){
          // Store the starting index of the current polygonal number, as we
          // may have to come back to it if it does not produce a chain of six
          // cyclic polygonal numbers.
          startIndex[index] = j;
          
          // Increment the number of cyclic polygonal numbers in the chain by 1.
          index++;
          
          // Store the current polygonal number in the set of six cyclic
          // polygonal numbers,
          cyclicPolygonalNumbers[index] = polygonalNumbers[j];
          
          // Store the type of the current polygonal number in the types used
          // array.
          typesUsed[index] = polygonalNumbers[j].type;
          
          // Reset the index of the polygonal numbers we are looking through to
          // 0, so that we don't miss any!
          j = 0;
          
          // If the number of cyclic numbers found is six,
          if(index == 5){
            // If the last two digits of the last number in the set of six
            // cyclic polygonal numbers are equal to the first two digits of the
            // first polygonal number (hence, completing our cycle),
            if([self lastTwoDigitsOfNumber:cyclicPolygonalNumbers[5].number isEqualToFirstTwoDigitsOfNumber:cyclicPolygonalNumbers[0].number]){
              // Mark that we have found the 6 cyclic polygonal numbers.
              isFound = YES;
              
              // Break out of the loop.
              break;
            }
            // If the last two digits of the last number in the set of six
            // cyclic polygonal numbers are NOT equal to the first two digits of
            // the first polygonal number,
            else{
              // Remove the current polygonal numbers type from the types used
              // array.
              typesUsed[index] = PolygonalNumberType_None;
              
              // Decrement the index by 1.
              index--;
              
              // Reset the index of polygonal numbers we are looking at in order
              // to start where we left off.
              j = startIndex[index];
            }
          }
        }
      }
      // If we have gotten to the last polygonal number, and the number of
      // polygonal numbers in our set of six cyclic polygonal numbers is NOT 1,
      if((j == (polygonalNumberIndex - 1)) && (index > 0)){
        // Remove the current polygonal numbers type from the types used
        // array.
        typesUsed[index] = PolygonalNumberType_None;
        
        // Decrement the index by 1.
        index--;
        
        // Reset the index of polygonal numbers we are looking at in order
        // to start where we left off.
        j = startIndex[index];
      }
    }
    // If we have found the 6 cyclic polygonal numbers,
    if(isFound){
      // Break out of the loop.
      break;
    }
  }
  // For all the cyclic polygonal numbers,
  for(int i = 0; i < 6; i++){
    // Add the cyclic polygonal number to the sum of the polygonal numbers.
    sumOfCyclicPolygonalNumbers += cyclicPolygonalNumbers[i].number;
  }
  // Set the answer string to the sum of the cyclic polygonal numbers.
  self.answer = [NSString stringWithFormat:@"%d", sumOfCyclicPolygonalNumbers];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question61 (Private)

- (BOOL)lastTwoDigitsOfNumber:(uint)aFirstNumber isEqualToFirstTwoDigitsOfNumber:(uint)aSecondNumber; {
  // If the second number is 0,
  if(aSecondNumber == 0){
    // Return that the last two digits are NOT equal to the first two digits.
    return NO;
  }
  // Variable to hold the number of digits there are for the second number.
  int numberOfDigits = ((int)(log10(aSecondNumber))) + 1;
  
  // If the number of digits of the second number is less than 2,
  if(numberOfDigits < 2){
    // Return that the last two digits are NOT equal to the first two digits.
    return NO;
  }
  // Subtract 2 off the number of digits.
  numberOfDigits -= 2;
  
  // Grab the last two digits of the first number.
  uint lastTwoDigits = aFirstNumber % 100;
  
  // Grab the first two digits of the second number.
  uint firstTwoDigits = aSecondNumber / (((uint)pow(10.0, ((double)numberOfDigits))));
  
  // Return if the last two digits of the first number is equal to the second
  // two digits of the second number.
  return lastTwoDigits == firstTwoDigits;
}

@end