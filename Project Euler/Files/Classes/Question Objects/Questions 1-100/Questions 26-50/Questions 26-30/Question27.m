//  Question27.m

#import "Question27.h"

@interface Question27 (Private)

- (BOOL)isNumberPrime:(uint)aNumber primesArray:(NSMutableArray *)aPrimeNumbersArray;
- (uint)numberOfPrimesInConsecutiveOrderForA:(int)aA b:(int)aB primesArray:(NSMutableArray *)aPrimeNumbersArray;

@end

@implementation Question27

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"27 September 2002";
  self.hint = @"The coefficient a must be odd, and b must be a prime.";
  self.link = @"https://en.wikipedia.org/wiki/Formula_for_primes#Prime_formulas_and_polynomial_functions";
  self.text = @"Euler published the remarkable quadratic formula:\n\nn² + n + 41\n\nIt turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.\n\nUsing computers, the incredible formula  n²  79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, 79 and 1601, is 126479.\n\nConsidering quadratics of the form:\n\nn² + an + b, where |a| < 1000 and |b| < 1000\n\nwhere |n| is the modulus/absolute value of n\ne.g. |11| = 11 and |-4| = 4\n\nFind the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.";
  self.isFun = YES;
  self.title = @"Quadratic primes";
  self.answer = @"-59231";
  self.number = @"27";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"consecutive,odd,primes,formula,coefficients,quadratic,maximum,expression,production,absolute,value,produces,number,helper,methods";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"21";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"27/01/13";
  self.solvableByHand = NO;
  self.completedOnDate = @"27/01/13";
  self.solutionLineCount = @"39";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"0.23";
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.44";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply loop over all the valid a and b, and use our helper methods
  // to determine the number of consecutive primes generated by this a and b. We
  // Then save the largest one, and compute the product!
  //
  // We make a few optimizations:
  //
  // 1) b must be a prime number, as n = 0 is the first case.
  //
  // 2) a must be odd, as an even a would mean the n = 1 case generates an even
  //    number.
  //
  // With these things to note, the algorithm moves much quicker!
  
  // Note: The values generated by the algorithm are:
  //
  // a = -61, b = 971, consecutive number of primes: 71
  
  // Variable to hold the product of a and b.
  uint product = 1;
  
  // Set the max size for the prime numbers.
  uint maxSize = 10000;
  
  // Variable to hold the maximum number of consecutive primes found.
  uint maxNumberOfConsecutivePrimes = 0;
  
  // Variable to hold the current maximum number of consecutive primes found.
  uint currentNumberOfConsecutivePrimes = 0;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the ODD b such that 0 < b < 1000,
  for(int b = 1; b < 1000; b += 2){
    // If b is a prime number,
    if([self isNumberPrime:b primesArray:primeNumbersArray]){
      // For all the ODD a such that |a| < 1000,
      for(int a = -999; a < 1000; a += 2){
        // Grab the number of primes in consecutive order generated by this pair.
        currentNumberOfConsecutivePrimes = [self numberOfPrimesInConsecutiveOrderForA:a b:b primesArray:primeNumbersArray];
        
        // If the number of primes in consecutive order generated by this pair is
        // greater than the maximum number of primes in consecutive order,
        if(currentNumberOfConsecutivePrimes > maxNumberOfConsecutivePrimes){
          // Set the current number of primes in consecutive order generated by
          // this pair to be the maximum number of primes in consecutive order.
          maxNumberOfConsecutivePrimes = currentNumberOfConsecutivePrimes;
          
          // Compute the product of the pair.
          product = a * b;
        }
      }
    }
  }
  // Set the answer string to the product.
  self.answer = [NSString stringWithFormat:@"%d", product];
  
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
  
  // Here, we simply loop over all the valid a and b, and use our helper methods
  // to determine the number of consecutive primes generated by this a and b. We
  // Then save the largest one, and compute the product!
  
  // Note: The values generated by the algorithm are:
  //
  // a = -61, b = 971, consecutive number of primes: 71
  
  // Variable to hold the product of a and b.
  uint product = 1;
  
  // Set the max size for the prime numbers.
  uint maxSize = 10000;
  
  // Variable to hold the maximum number of consecutive primes found.
  uint maxNumberOfConsecutivePrimes = 0;
  
  // Variable to hold the current maximum number of consecutive primes found.
  uint currentNumberOfConsecutivePrimes = 0;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the a such that |a| < 1000,
  for(int a = -999; a < 1000; a++){
    // For all the b such that |b| < 1000,
    for(int b = -999; b < 1000; b++){
      // Grab the number of primes in consecutive order generated by this pair.
      currentNumberOfConsecutivePrimes = [self numberOfPrimesInConsecutiveOrderForA:a b:b primesArray:primeNumbersArray];
      
      // If the number of primes in consecutive order generated by this pair is
      // greater than the maximum number of primes in consecutive order,
      if(currentNumberOfConsecutivePrimes > maxNumberOfConsecutivePrimes){
        // Set the current number of primes in consecutive order generated by
        // this pair to be the maximum number of primes in consecutive order.
        maxNumberOfConsecutivePrimes = currentNumberOfConsecutivePrimes;
        
        // Compute the product of the pair.
        product = a * b;
      }
    }
  }
  // Set the answer string to the product.
  self.answer = [NSString stringWithFormat:@"%d", product];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question27 (Private)

- (BOOL)isNumberPrime:(uint)aNumber primesArray:(NSMutableArray *)aPrimeNumbersArray; {
  // BOOL variable to mark if a current number is prime.
  BOOL isPrime = YES;
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the square root of the number, used to minimize computations.
  uint sqrtOfCurrentNumber = (int)sqrtf(aNumber);;
  
  // Loop through all the prime numbers already found.
  for(NSNumber * number in aPrimeNumbersArray){
    // Grab the current prime number.
    currentPrimeNumber = [number intValue];
    
    // If the current prime number is less than the square root of the current number,
    if(currentPrimeNumber <= sqrtOfCurrentNumber){
      // If the current prime number divides our number,
      if((aNumber % currentPrimeNumber) == 0){
        // The number is not prime, so exit the loop.
        isPrime = NO;
        break;
      }
    }
    else{
      // Since the number is bigger than the square root of the current number,
      // exit the loop.
      break;
    }
  }
  // Return if it is a prime or not.
  return isPrime;
}


- (uint)numberOfPrimesInConsecutiveOrderForA:(int)aA b:(int)aB primesArray:(NSMutableArray *)aPrimeNumbersArray; {
  // Variable to hold the input for our result function. n \in {0,1,2,...}
  int n = 0;
  
  // Variable to hold the result of our equation: n² + aA * n + aB.
  int result = 0;
  
  // Variable to hold the number of primes in consecutive order.
  uint numberOfPrimesInConsecutiveOrder = 0;
  
  // Loop until we no longer generate a prime.
  while(YES){
    // Compute the result with the above equation.
    result = n * n + aA * n + aB;
    
    // If the result is a positive number,
    if(result > 0){
      // If the number is a prime,
      if([self isNumberPrime:result primesArray:aPrimeNumbersArray]){
        // Increment n by 1.
        n++;
        
        // Increment the number of primes in consecutive order by 1.
        numberOfPrimesInConsecutiveOrder++;
      }
      // If the number is NOT a prime,
      else{
        // Break out of the loop.
        break;
      }
    }
    // If the result is NOT a positive number,
    else{
      // Break out of the loop.
      break;
    }
  }
  // Return the number of primes in consecutive order.
  return numberOfPrimesInConsecutiveOrder;
}

@end