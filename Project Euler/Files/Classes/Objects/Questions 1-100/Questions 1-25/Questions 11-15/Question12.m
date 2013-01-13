//  Question12.m

#import "Question12.h"

@implementation Question12

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"08 March 2002";
  self.text = @"The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:\n\n1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...\n\nLet us list the factors of the first seven triangle numbers:\n\n1: 1\n3: 1,3\n6: 1,2,3,6\n10: 1,2,5,10\n15: 1,3,5,15\n21: 1,3,7,21\n28: 1,2,4,7,14,28\n\nWe can see that 28 is the first triangle number to have over five divisors.\n\nWhat is the value of the first triangle number to have over five hundred divisors?";
  self.title = @"Highly divisible triangular number";
  self.answer = @"76576500";
  self.number = @"Problem 12";
  self.estimatedComputationTime = @"1.09e-02";
  self.estimatedBruteForceComputationTime = @"565";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we will note a few properties of the factors of triangle numbers. Let
  // T_n be the nth triangle number. Then,
  //
  // 1) T_n = \sum_{i = 1}^{n} i = ((n * (n + 1)) / 2)
  //
  // 2) gcd(n, (n+1)) = 1 for all n in N.
  //
  // 3) Let F(x) be the number of factors of a number x. Then we have:
  //
  //    F(x) = F(\prod_{i=1}^{m}p_{i}^{\alpha_{i}})
  //
  //         = \prod_{i=1}^{m}(\alpha_{i} + 1)
  //
  //    where p_{i} are the unique prime factors of x, \alpha_{i} > 1.
  //
  // This means that we need only compute the prime factorization of n and
  // (n+1) (divide the even number by 2 so that their product is equal to the
  // nth triangle number T_n).
  //
  // The algorithm works as follows. Find the prime numbers upto a specific
  // point (Note: we chose 13,000 as previously running this algorithm with a
  // higher number). Then, we compute the prime factorization of n, multiply it
  // with the previous factorization of (n-1), and then compute the number of
  // factors of T_n, their product.
  //
  // The answer ends up being:
  //
  // 76576500 = 2^2 * 3^2 * 5^3 * 7 * 11 * 13 * 17 = 12375 * 12376 / 2
  //
  // 12375 = 3^2 * 5^3 * 11
  // 12376 = 2^3 * 7 * 13 * 17
  
  // Variable to hold the desired minimum number of factors.
  uint desiredNumberOfFactors = 500;
  
  // Variable to hold the upper limit of the triangle numbers to test.
  uint triangleNumberLimit = 13000;
  
  // Variable to hold the square root of the current triangle number used for
  // the prime factorization later. Currently, it is used to set the upper limit
  // of the prime numbers required for the prime factorization.
  uint sqrtOfTriangleNumber = (uint)sqrt((double)triangleNumberLimit);
  
  // Array to hold all the prime numbers found.
  NSArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:sqrtOfTriangleNumber];
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the current triangle number for prime factorization.
  uint lastTriangleNumberIndex = 1;
  
  // Variable to hold the number of factors in the current number n, used when
  // computing the prime factorization.
  uint currentNumberOfPrimeFactors = 1;
  
  // Variable to hold the number of factors in the current number (n-1).
  uint currentNumberOfFactorsNMinus1 = 1;
  
  // Variable to hold the number of factors in the current number (n).
  uint currentNumberOfFactorsN = 2;
  
  // Variable to hold the triangle number which has the desired number of factors.
  uint triangleNumberWithLargeFactors = 1;
  
  // For all the triangle numbers up to the limit (we start at 12 as 11 is prime,
  // and we know that the numbers less than 12 definitely are not what we are
  // looking for),
  for(int triangleNumberIndex = 12; triangleNumberIndex < triangleNumberLimit; triangleNumberIndex++){
    // Set the number of factors of (n-1) to be the previously computed number
    // of factors of n.
    currentNumberOfFactorsNMinus1 = currentNumberOfFactorsN;
    
    // Reset the current number of factors of n to 1.
    currentNumberOfFactorsN = 1;
    
    // Set the current triangle number index for prime factorization.
    lastTriangleNumberIndex = triangleNumberIndex;
    
    // Compute the square root of the current number.
    sqrtOfTriangleNumber = (uint)sqrt((double)triangleNumberIndex);
    
    // Loop through all the prime numbers already found.
    for(NSNumber * number in primeNumbersArray){
      // Grab the current prime number.
      currentPrimeNumber = [number intValue];
      
      // If the current prime number is less than the square root of the current number,
      if(currentPrimeNumber <= sqrtOfTriangleNumber){
        // If the current prime number divides our current number,
        if((lastTriangleNumberIndex % currentPrimeNumber) == 0){
          currentNumberOfPrimeFactors = 1;
          
          // Loop by continually dividing out by the current prime number. This
          // removes any powers of the current prime factor.
          while((lastTriangleNumberIndex % currentPrimeNumber) == 0){
            currentNumberOfPrimeFactors++;
            
            // Divide the number to factor by the current prime number.
            lastTriangleNumberIndex /= currentPrimeNumber;
          }
          // If the current prime number is 2,
          if(currentPrimeNumber == 2){
            // The triangle index number is even, so we factor out the extra
            // factor of 2 as per equation 1).
            currentNumberOfPrimeFactors--;
          }
          // Multiply the current number of factors of n as per equation 3).
          currentNumberOfFactorsN *= currentNumberOfPrimeFactors;
        }
      }
      // If the current prime number is greater than the square root of the number,
      else{
        // If the last triangle number index n is not 1,
        if(lastTriangleNumberIndex != 1){
          // It must be a prime number, and there must only be a single factor
          // of the prime number as we would have removed any higher powers
          // above, so multiply the number of factors by (1+1) = 2.
          currentNumberOfFactorsN *= 2;
        }
        // Since the number is bigger than the square root of the current number,
        // exit the loop.
        break;
      }
    }
    // If the current number of factors of the triangle number T_n (equation 1))
    // is higher than the desired number of factors,
    if((currentNumberOfFactorsNMinus1 * currentNumberOfFactorsN) > desiredNumberOfFactors){
      // Set the larger triangle number to be the current one as per equation 1).
      triangleNumberWithLargeFactors = triangleNumberIndex * (triangleNumberIndex - 1) / 2;
      
      // Break out of the loop, as we found what we were looking for.
      break;
    }
  }
  // Set the answer string to the value of the triangle number with the desired number of factors.
  self.answer = [NSString stringWithFormat:@"%d", triangleNumberWithLargeFactors];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
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
  
  // We simply compute the nth triangle number, then loop through all the numbers
  // less than half of the triangle number to see if it is a factor or not.
  
  // Variable to hold the desired minimum number of factors.
  uint desiredNumberOfFactors = 500;
  
  // Variable to hold the index of the current triangle number.
  uint currentIndex = 1;
  
  // Variable to hold the current triangle number.
  uint currentTriangleNumber = 1;
  
  // Variable to hold the number of factors in the current triangle number.
  uint currentNumberOfFactors = 1;
  
  // Variable to hold the limit of numbers to check up to.
  uint currentHalfOfTriangleNumber = 1;
  
  // Variable to hold the triangle number which has the desired number of factors.
  uint triangleNumberWithLargeFactors = 1;
  
  // Keep looping until we have found the triangle number with the desired number
  // of factors.
  while(YES){
    // Increment the index of the current triangle number.
    currentIndex++;
    
    // Add the index to the current triangle number.
    currentTriangleNumber += currentIndex;
    
    // Reset the number of factors of the current triangle number. 1 is always a
    // factor of every number, as it is a unit.
    currentNumberOfFactors = 2;
    
    // Compute the half way point of the current triangle number. We know that
    // all the factors (except for the number itself) is less than this number,
    // as if the number is even, the n/2 is the second largest factor, and if it
    // is odd, the n/m < n/2, (where m is the smallest odd factor).
    
    // If the current triangle number is even,
    if((currentTriangleNumber % 2) == 0){
      // Set the half way point to be half the triangle number plus 1.
      currentHalfOfTriangleNumber = ((uint)(currentTriangleNumber / 2)) + 1;
    }
    // If the current triangle number is odd,
    else{
      // Set the half way point to be a thurd the triangle number plus 1.
      currentHalfOfTriangleNumber = ((uint)(currentTriangleNumber / 3)) + 1;
    }
    // For all the positive natural numbers greater than 1,
    for(int number = 2; number < currentHalfOfTriangleNumber; number++){
      // If the number divides the current triangle number,
      if((currentTriangleNumber % number) == 0){
        // Increment the number of factors of the current triangle number by 1.
        currentNumberOfFactors++;
      }
    }
    // If the number of factors of the current triangle number is at least as many
    // as the desired number of factors,
    if(currentNumberOfFactors >= desiredNumberOfFactors){
      // Set the number with the largest number of factors to the current triangle
      // number. This is not needed, as we could just use the current triangle number
      // when setting the answer, but I do it for ease of reading.
      triangleNumberWithLargeFactors = currentTriangleNumber;
      
      // We found the desired triangle number, so exit the loop.
      break;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  if(_isComputing){
    // Set the answer string to the value of the triangle number with the desired number of factors.
    self.answer = [NSString stringWithFormat:@"%d", triangleNumberWithLargeFactors];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end