//  Question47.m

#import "Question47.h"

@implementation Question47

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 July 2003";
  self.hint = @"Choose 150,000 as your maximum size, and the factor the numbers downwards.";
  self.link = @"https://en.wikipedia.org/wiki/Prime_factor";
  self.text = @"The first two consecutive numbers to have two distinct prime factors are:\n\n14 = 2 x 7\n15 = 3 x 5\n\nThe first three consecutive numbers to have three distinct prime factors are:\n\n644 = 2² x 7 x 23\n645 = 3 x 5 x 43\n646 = 2 x 17 x 19.\n\nFind the first four consecutive integers to have four distinct primes factors. What is the first of these numbers?";
  self.isFun = YES;
  self.title = @"Distinct primes factors";
  self.answer = @"134043";
  self.number = @"47";
  self.rating = @"4";
  self.category = @"Primes";
  self.keywords = @"consecutive,four,4,distinct,prime,factors,numbers,first,integers,maximum,size";
  self.solveTime = @"120";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"40";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"16/02/13";
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"16/02/13";
  self.solutionLineCount = @"65";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.133";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.133";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply iterate all the numbers to a maximum size, and compute its
  // prime factorization. If we find a number that has 4 unique prime factors,
  // we start a count to see if the next 3 successive number also have 4 unique
  // prime factors, resetting the count to 0 until the next number with 4 unique
  // prime factors is found.
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 150000;
  
  // Variable to hold the current number we are factoring.
  uint currentNumber = 0;
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the square root of the current number.
  uint sqrtOfCurrentNumber = 0;
  
  // Variable to hold the first number with four unique prime factors.
  uint firstNumberWithFourUniquePrimeFactors = 1;
  
  // Variable to hold the number of unique factors of the current numbe.
  uint currentNumberOfUniqueFactors = 0;
  
  // Variable to hold the number of consecutive numbers with four unique prime
  // factors.
  uint numberOfConsecutiveNumbersWithFourUniqueFactors = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the numbers up to the maximum size, starting with the first number
  // to have 4 unique prime factors,
  for(int number = (2 * 3 * 5 * 7); number < maxSize; number++){
    // Grab the current number.
    currentNumber = number;
    
    // Compute the square root of the current number.
    sqrtOfCurrentNumber = (uint)sqrt((double)currentNumber);
    
    // Reset the current number of unique factors for this number to 0.
    currentNumberOfUniqueFactors = 0;
    
    // Loop through all the prime numbers already found.
    for(NSNumber * primeNumber in primeNumbersArray){
      // Grab the current prime number.
      currentPrimeNumber = [primeNumber intValue];
      
      // If the current prime number is less than the square root of the current number,
      if(currentPrimeNumber <= sqrtOfCurrentNumber){
        // If the current prime number divides our current number,
        if((currentNumber % currentPrimeNumber) == 0){
          // Loop by continually dividing out by the current prime number. This
          // removes any powers of the current prime factor.
          while((currentNumber % currentPrimeNumber) == 0){
            // Divide the number to factor by the current prime number.
            currentNumber /= currentPrimeNumber;
          }
          // Increment the number of unique prime factors by 1.
          currentNumberOfUniqueFactors++;
          
          // Compute the square root of the current number.
          sqrtOfCurrentNumber = (uint)sqrt((double)currentNumber);
        }
      }
      // If the current prime number is greater than the square root of the number,
      else{
        // If the remaining number is NOT 1,
        if(currentNumber != 1){
          // It must be a prime number, and there must only be a single factor
          // of the prime number as we would have removed any higher powers
          // above, so increment the number of unique prime factors by 1.
          currentNumberOfUniqueFactors++;
        }
        // Since the number is bigger than the square root of the current number,
        // exit the loop.
        break;
      }
    }
    // If the current number has 4 unique prime factors,
    if(currentNumberOfUniqueFactors == 4){
      // If this is the first number to have 4 unique prime factors,
      if(numberOfConsecutiveNumbersWithFourUniqueFactors == 0){
        // Set the first number with 4 unique prime factors to the current number.
        firstNumberWithFourUniquePrimeFactors = number;
      }
      // Increment the number of consecutive numbers with 4 prime factors to by 1.
      numberOfConsecutiveNumbersWithFourUniqueFactors++;
      
      // If there are 4 consecutive numbers with 4 unique prime factors,
      if(numberOfConsecutiveNumbersWithFourUniqueFactors == 4){
        // Break out of the loop, as we found what we were looking for.
        break;
      }
    }
    // If the current number does NOT have 4 unique prime factors,
    else{
      // Reset the number of consecutive numbers with 4 unique prime factors to 0.
      numberOfConsecutiveNumbersWithFourUniqueFactors = 0;
    }
  }
  // Set the answer string to the first number with four unique prime factors.
  self.answer = [NSString stringWithFormat:@"%d", firstNumberWithFourUniquePrimeFactors];
  
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
  
  // Here, we simply iterate all the numbers to a maximum size, and compute its
  // prime factorization. If we find a number that has 4 unique prime factors,
  // we start a count to see if the next 3 successive number also have 4 unique
  // prime factors, resetting the count to 0 until the next number with 4 unique
  // prime factors is found.
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 150000;
  
  // Variable to hold the current number we are factoring.
  uint currentNumber = 0;
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the square root of the current number.
  uint sqrtOfCurrentNumber = 0;
  
  // Variable to hold the first number with four unique prime factors.
  uint firstNumberWithFourUniquePrimeFactors = 1;
  
  // Variable to hold the number of unique factors of the current numbe.
  uint currentNumberOfUniqueFactors = 0;
  
  // Variable to hold the number of consecutive numbers with four unique prime
  // factors.
  uint numberOfConsecutiveNumbersWithFourUniqueFactors = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the numbers up to the maximum size, starting with the first number
  // to have 4 unique prime factors,
  for(int number = (2 * 3 * 5 * 7); number < maxSize; number++){
    // Grab the current number.
    currentNumber = number;
    
    // Compute the square root of the current number.
    sqrtOfCurrentNumber = (uint)sqrt((double)currentNumber);
    
    // Reset the current number of unique factors for this number to 0.
    currentNumberOfUniqueFactors = 0;
    
    // Loop through all the prime numbers already found.
    for(NSNumber * primeNumber in primeNumbersArray){
      // Grab the current prime number.
      currentPrimeNumber = [primeNumber intValue];
      
      // If the current prime number is less than the square root of the current number,
      if(currentPrimeNumber <= sqrtOfCurrentNumber){
        // If the current prime number divides our current number,
        if((currentNumber % currentPrimeNumber) == 0){
          // Loop by continually dividing out by the current prime number. This
          // removes any powers of the current prime factor.
          while((currentNumber % currentPrimeNumber) == 0){
            // Divide the number to factor by the current prime number.
            currentNumber /= currentPrimeNumber;
          }
          // Increment the number of unique prime factors by 1.
          currentNumberOfUniqueFactors++;
          
          // Compute the square root of the current number.
          sqrtOfCurrentNumber = (uint)sqrt((double)currentNumber);
        }
      }
      // If the current prime number is greater than the square root of the number,
      else{
        // If the remaining number is NOT 1,
        if(currentNumber != 1){
          // It must be a prime number, and there must only be a single factor
          // of the prime number as we would have removed any higher powers
          // above, so increment the number of unique prime factors by 1.
          currentNumberOfUniqueFactors++;
        }
        // Since the number is bigger than the square root of the current number,
        // exit the loop.
        break;
      }
    }
    // If the current number has 4 unique prime factors,
    if(currentNumberOfUniqueFactors == 4){
      // If this is the first number to have 4 unique prime factors,
      if(numberOfConsecutiveNumbersWithFourUniqueFactors == 0){
        // Set the first number with 4 unique prime factors to the current number.
        firstNumberWithFourUniquePrimeFactors = number;
      }
      // Increment the number of consecutive numbers with 4 prime factors to by 1.
      numberOfConsecutiveNumbersWithFourUniqueFactors++;
      
      // If there are 4 consecutive numbers with 4 unique prime factors,
      if(numberOfConsecutiveNumbersWithFourUniqueFactors == 4){
        // Break out of the loop, as we found what we were looking for.
        break;
      }
    }
    // If the current number does NOT have 4 unique prime factors,
    else{
      // Reset the number of consecutive numbers with 4 unique prime factors to 0.
      numberOfConsecutiveNumbersWithFourUniqueFactors = 0;
    }
  }
  // Set the answer string to the first number with four unique prime factors.
  self.answer = [NSString stringWithFormat:@"%d", firstNumberWithFourUniquePrimeFactors];
  
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