//  Question88.m

#import "Question88.h"
#import "Global.h"

@implementation Question88

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 February 2005";
  self.text = @"A natural number, N, that can be written as the sum and product of a given set of at least two natural numbers, {a1, a2, ... , ak} is called a product-sum number: N = a1 + a2 + ... + ak = a1  a2  ...  ak.\n\nFor example, 6 = 1 + 2 + 3 = 1 x 2 x 3.\n\nFor a given set of size, k, we shall call the smallest N with this property a minimal product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6 are as follows.\n\nk=2: 4 = 2 x 2 = 2 + 2\nk=3: 6 = 1 x 2 x 3 = 1 + 2 + 3\nk=4: 8 = 1 x 1 x 2 x 4 = 1 + 1 + 2 + 4\nk=5: 8 = 1 x 1 x 2 x 2  2 = 1 + 1 + 2 + 2 + 2\nk=6: 12 = 1 x 1 x 1 x 1 x 2 x 6 = 1 + 1 + 1 + 1 + 2 + 6\n\nHence for 2 <= k <= 6, the sum of all the minimal product-sum numbers is 4+6+8+12 = 30; note that 8 is only counted once in the sum.\n\nIn fact, as the complete set of minimal product-sum numbers for 2 <= k <= 12 is {4, 6, 8, 12, 15, 16}, the sum is 61.\n\nWhat is the sum of all the minimal product-sum numbers for 2 <= k <= 12000?";
  self.title = @"Product-sum numbers";
  self.answer = @"";
  self.number = @"Problem 88";
  self.estimatedComputationTime = @"";
  self.estimatedBruteForceComputationTime = @"";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 24000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable to hold the sum of the divisors for every number up to the max size.
  uint sumOfDivisors = 0;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable array to hold the abundent numbers up to the max size.
  uint minimalProductSumNumbers[maxSize];
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:sqrtOfCurrentNumber];
  
  // For all the prime numbers in the prime numbers array,
  for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
    // Grab the current prime number from the prime numbers array.
    primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
    
    // Multiply the current max size by the current prime number.
    currentMaxSize *= primeNumber;
    
    // Increment the maximum number of prime factors by 1.
    maxNumberOfPrimeFactors++;
    
    // If the current max size is greater than the max size,
    if(currentMaxSize > maxSize){
      // Break out of the loop.
      break;
    }
  }
  // Variable to hold the current prime power struct when factoring the current
  // number.
  PrimePower currentPrimePower = PrimePowerZero;
  
  // Variable to hold the current prime power structs when factoring the current
  // number.
  PrimePower currentPrimePowers[maxNumberOfPrimeFactors];
  
  // For all the prime factors up to the maximum number of prime factors,
  for(int i = 0; i < maxNumberOfPrimeFactors; i++){
    // Set the current prime factors to zero by default.
    currentPrimePowers[i] = PrimePowerZero;
  }
  // For all the numbers from 4 to the max size,
  for(int number = 4; number < maxSize; number++){
    if([self isPrime:number] == NO){
      // Grab the current number for use in factoring.
      currentNumber = number;
      
      // Recompute the square root of the current minimum number, in order to
      // speed up the computation.
      sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
      
      // Reset the prime power index to 0, as we haven't found any prime factors
      // yet!
      primePowerIndex = 0;
      
      // For all the prime numbers in the prime numbers array,
      for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
        // Grab the current prime number from the prime numbers array.
        primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
        
        // If the current prime number is less than or equal to the square root of
        // the current number,
        if(primeNumber <= sqrtOfCurrentNumber){
          // If the current prime number divides the current number,
          if((currentNumber % primeNumber) == 0){
            // Set the current prime power to be the prime number.
            currentPrimePower = PrimePowerMake(primeNumber, 0);
            
            // While the current prime number divides the current number,
            while((currentNumber % primeNumber) == 0){
              // Divide out the prime number from the number.
              currentNumber /= primeNumber;
              
              // Increment the current prime powers power by 1.
              currentPrimePower.power++;
            }
            // Recompute the square root of the current number, in order to speed
            // up the computation.
            sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
            
            // Set the current prime power to the current prime powers index.
            currentPrimePowers[primePowerIndex] = currentPrimePower;
            
            // Increment the current prime power index by 1.
            primePowerIndex++;
          }
        }
        // If the current prime number is greater than or equal to the square root
        // of the current prime number,
        else{
          // Break out of the loop.
          break;
        }
      }
      // If the current minimum number is NOT equal to 1 after the above factoring,
      // it must be a prime number itself,
      if(currentNumber > 1){
        // Set the current prime number (which is the current number) to the current
        // prime power. Since this number is prime, there is no need to loop to
        // find the power, as it must be 1.
        currentPrimePower = PrimePowerMake(currentNumber, 1);
        
        // Set the current prime power to be the prime number.
        currentPrimePowers[primePowerIndex] = currentPrimePower;
        
        // Increment the current prime power index by 1.
        primePowerIndex++;
      }
      // Set the sum of the divisors for this number to 1.
      sumOfDivisors = 1;
      
      // TODO: Figure all combinations of factors, and add (n - k) ones onto the
      //       k factors to arrive at n. If p_1 * ... * p_k = n, then n is the
      //       minimal product sum for (p_1 + ... + p_k) + (p_1 * ... * p_k),
      //       where (p_1 + ... + p_k) = 1 + ... + 1.
      
      // TODO: Store all the combinations of factors for each number in an array
      //       and use those combinations when factoring larger numbers to get
      //       the total sums. Potentially use an NSMutableArray?
    }
  }
  
//  // Set the answer string to the.
//  self.answer = [NSString stringWithFormat:@"%d", ];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm just uses better tricks for avoiding computation.
  
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