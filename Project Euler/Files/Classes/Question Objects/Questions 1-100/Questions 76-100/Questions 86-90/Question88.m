//  Question88.m

#import "Question88.h"

@implementation Question88

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 February 2005";
  self.hint = @"Prime factorization will do wonders!";
  self.link = @"https://en.wikipedia.org/wiki/Product_(mathematics)";
  self.text = @"A natural number, N, that can be written as the sum and product of a given set of at least two natural numbers, {a1, a2, ... , ak} is called a product-sum number: N = a1 + a2 + ... + ak = a1  a2  ...  ak.\n\nFor example, 6 = 1 + 2 + 3 = 1 x 2 x 3.\n\nFor a given set of size, k, we shall call the smallest N with this property a minimal product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6 are as follows.\n\nk=2: 4 = 2 x 2 = 2 + 2\nk=3: 6 = 1 x 2 x 3 = 1 + 2 + 3\nk=4: 8 = 1 x 1 x 2 x 4 = 1 + 1 + 2 + 4\nk=5: 8 = 1 x 1 x 2 x 2  2 = 1 + 1 + 2 + 2 + 2\nk=6: 12 = 1 x 1 x 1 x 1 x 2 x 6 = 1 + 1 + 1 + 1 + 2 + 6\n\nHence for 2 <= k <= 6, the sum of all the minimal product-sum numbers is 4+6+8+12 = 30; note that 8 is only counted once in the sum.\n\nIn fact, as the complete set of minimal product-sum numbers for 2 <= k <= 12 is {4, 6, 8, 12, 15, 16}, the sum is 61.\n\nWhat is the sum of all the minimal product-sum numbers for 2 <= k <= 12000?";
  self.isFun = NO;
  self.title = @"Product-sum numbers";
  self.answer = @"7587457";
  self.number = @"88";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"minimal,product,sum,recursive,product,k,complete,set,product-sum";
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.isChallenging = YES;
  self.completedOnDate = @"29/03/13";
  self.solutionLineCount = @"73";
  self.estimatedComputationTime = @"0.881";
  self.estimatedBruteForceComputationTime = @"0.881";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply
  
  // Variable to mark the maximum size of the minimal product-sum numbers to
  // examine.
  const uint maxSize = 12000;
  
  // Variable to mark if we should add the number to the total of the minimum
  // product sums or NOT.
  BOOL shouldAddNumber = NO;
  
  // Variable to hold the minimal product-sum number, as defined in the question.
  uint k = 0;
  
  // Variable to hold the sum of the factors of the current product-sum number.
  uint sumOfFactors = 0;
  
  // Variable to hold the current number we are looking at.
  uint currentNumber = 0;
  
  // Variable to hold the square root of the current number we are looking at.
  uint currentSquareRoot = 0;
  
  // Variable to hold the total sum of the minimal product-sum numbers up to
  // the maximum size. We start at 4, as the minimal product-sum for 2 is 4.
  uint totalMinimalProductSum = 4;
  
  // Variable to hold the minimal product sums for all the numbers up to the
  // maximum size.
  uint minimalProductSums[(maxSize + 1)] = {0};
  
  // Variable array to hold the minimal product-sums for each of the factors
  // of the current number.
  NSMutableArray * sumOfFactorsArray = [[NSMutableArray alloc] initWithCapacity:maxSize];
  
  // Variable array to hold the factors of the current number.
  NSMutableArray * factorsForNumber = nil;
  
  // Variable to hold the 
  NSMutableArray * currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
  
  // Set the minimal product-sum for 2 as 4.
  minimalProductSums[2] = 4;
  
  // Add the array with 0 to the sum of factors array, as 0 minimal product-sum
  // is 0.
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  // For all the numbers from 0 to 2 (which represent the numbers 1-3,
  for(int n = 0; n < 3; n++){
    // Create an array with the current number.
    currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:n], nil];
    
    // Add the array with the current number to the sum of factors array.
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Create an array with the numbers 2 and 3 in it.
  currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
  
  // Add the with the numbers 2 and 3 to the sum of factors array.
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  // For all the numbers from 5 up to 10% larger than the maximum size,
  for(int n = 5; n <= (1.1 * maxSize); n++){
    // If the number is prime,
    if([self isPrime:n]){
      // Create an array with the prime number minus 1 in it.
      currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(n-1)], nil];
    }
    // If the number is NOT a prime,
    else{
      // Mark that we should NOT add a number by default.
      shouldAddNumber = NO;
      
      // Set the current number we are looking at.
      currentNumber = n;
      
      // Compute the floored square root of the current number.
      currentSquareRoot = ((uint)sqrt((double)n));
      
      // Initialize a new array to store all the possible factors for the current
      // numbers.
      currentFactorsForNumber = [[NSMutableArray alloc] init];
      
      // For all the factors that the current number could possible have,
      for(int factor = 2; factor <= currentSquareRoot; factor++){
        // If the current factor is actually a factor of the current number,
        if((n % factor) == 0){
          // Set the current number to be the current number divided by the
          // current factor.
          currentNumber = n / factor;
          
          // Grab the other sums of factors for the other factor of the current
          // number.
          factorsForNumber = [sumOfFactorsArray objectAtIndex:currentNumber];
          
          // For all the sums of factors in the factors array,
          for(NSNumber * number in factorsForNumber){
            // Compute the sum of the factors for the current number.
            sumOfFactors = [number intValue] + (factor - 1);
            
            // If the sum of the factors is less than the current number,
            if(n > sumOfFactors){
              // Compute k, the minimal product-sum.
              k = n - sumOfFactors;
              
              // If k is less than the maximum size we are examining,
              if(k <= maxSize){
                // If we have not already added a minimal product-sum for this
                // value of k,
                if(minimalProductSums[k] == 0){
                  // Set the current number to be the minimal product-sum for
                  // this value of k.
                  minimalProductSums[k] = n;
                  
                  // Mark that we should add the minimal product-sum to the total
                  // minimal product-sums.
                  shouldAddNumber = YES;
                }
              }
              // For the current number, add the sum of the factors to the array
              // of possible factorizations.
              [currentFactorsForNumber addObject:[NSNumber numberWithInt:sumOfFactors]];
            }
          }
        }
      }
      // If we should add the minimal product-sum to the total minimal product-sums,
      if(shouldAddNumber){
        // Add the current number to the total minimal product-sums.
        totalMinimalProductSum += n;
      }
      // Add the current number minus one to the sums of the factors array, as
      // 1 * n = (n-1) + 1.
      [currentFactorsForNumber addObject:[NSNumber numberWithInt:(n-1)]];
    }
    // Add all the possible combinations of factors for the current number to
    // the array of all the posible combinations of factors for every number.
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Set the answer string to the total sum of the minimal product-sums.
  self.answer = [NSString stringWithFormat:@"%d", totalMinimalProductSum];
  
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
  
  // Here, we simply
  
  // Variable to mark the maximum size of the minimal product-sum numbers to
  // examine.
  const uint maxSize = 12000;
  
  // Variable to mark if we should add the number to the total of the minimum
  // product sums or NOT.
  BOOL shouldAddNumber = NO;
  
  // Variable to hold the minimal product-sum number, as defined in the question.
  uint k = 0;
  
  // Variable to hold the sum of the factors of the current product-sum number.
  uint sumOfFactors = 0;
  
  // Variable to hold the current number we are looking at.
  uint currentNumber = 0;
  
  // Variable to hold the square root of the current number we are looking at.
  uint currentSquareRoot = 0;
  
  // Variable to hold the total sum of the minimal product-sum numbers up to
  // the maximum size. We start at 4, as the minimal product-sum for 2 is 4.
  uint totalMinimalProductSum = 4;
  
  // Variable to hold the minimal product sums for all the numbers up to the
  // maximum size.
  uint minimalProductSums[(maxSize + 1)] = {0};
  
  // Variable array to hold the minimal product-sums for each of the factors
  // of the current number.
  NSMutableArray * sumOfFactorsArray = [[NSMutableArray alloc] initWithCapacity:maxSize];
  
  // Variable array to hold the factors of the current number.
  NSMutableArray * factorsForNumber = nil;
  
  // Variable to hold the
  NSMutableArray * currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
  
  // Set the minimal product-sum for 2 as 4.
  minimalProductSums[2] = 4;
  
  // Add the array with 0 to the sum of factors array, as 0 minimal product-sum
  // is 0.
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  // For all the numbers from 0 to 2 (which represent the numbers 1-3,
  for(int n = 0; n < 3; n++){
    // Create an array with the current number.
    currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:n], nil];
    
    // Add the array with the current number to the sum of factors array.
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Create an array with the numbers 2 and 3 in it.
  currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
  
  // Add the with the numbers 2 and 3 to the sum of factors array.
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  // For all the numbers from 5 up to 10% larger than the maximum size,
  for(int n = 5; n <= (1.1 * maxSize); n++){
    // If the number is prime,
    if([self isPrime:n]){
      // Create an array with the prime number minus 1 in it.
      currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(n-1)], nil];
    }
    // If the number is NOT a prime,
    else{
      // Mark that we should NOT add a number by default.
      shouldAddNumber = NO;
      
      // Set the current number we are looking at.
      currentNumber = n;
      
      // Compute the floored square root of the current number.
      currentSquareRoot = ((uint)sqrt((double)n));
      
      // Initialize a new array to store all the possible factors for the current
      // numbers.
      currentFactorsForNumber = [[NSMutableArray alloc] init];
      
      // For all the factors that the current number could possible have,
      for(int factor = 2; factor <= currentSquareRoot; factor++){
        // If the current factor is actually a factor of the current number,
        if((n % factor) == 0){
          // Set the current number to be the current number divided by the
          // current factor.
          currentNumber = n / factor;
          
          // Grab the other sums of factors for the other factor of the current
          // number.
          factorsForNumber = [sumOfFactorsArray objectAtIndex:currentNumber];
          
          // For all the sums of factors in the factors array,
          for(NSNumber * number in factorsForNumber){
            // Compute the sum of the factors for the current number.
            sumOfFactors = [number intValue] + (factor - 1);
            
            // If the sum of the factors is less than the current number,
            if(n > sumOfFactors){
              // Compute k, the minimal product-sum.
              k = n - sumOfFactors;
              
              // If k is less than the maximum size we are examining,
              if(k <= maxSize){
                // If we have not already added a minimal product-sum for this
                // value of k,
                if(minimalProductSums[k] == 0){
                  // Set the current number to be the minimal product-sum for
                  // this value of k.
                  minimalProductSums[k] = n;
                  
                  // Mark that we should add the minimal product-sum to the total
                  // minimal product-sums.
                  shouldAddNumber = YES;
                }
              }
              // For the current number, add the sum of the factors to the array
              // of possible factorizations.
              [currentFactorsForNumber addObject:[NSNumber numberWithInt:sumOfFactors]];
            }
          }
        }
      }
      // If we should add the minimal product-sum to the total minimal product-sums,
      if(shouldAddNumber){
        // Add the current number to the total minimal product-sums.
        totalMinimalProductSum += n;
      }
      // Add the current number minus one to the sums of the factors array, as
      // 1 * n = (n-1) + 1.
      [currentFactorsForNumber addObject:[NSNumber numberWithInt:(n-1)]];
    }
    // Add all the possible combinations of factors for the current number to
    // the array of all the posible combinations of factors for every number.
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Set the answer string to the total sum of the minimal product-sums.
  self.answer = [NSString stringWithFormat:@"%d", totalMinimalProductSum];
  
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