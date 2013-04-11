//  Question243.m

#import "Question243.h"

@implementation Question243

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"02 May 2009";
  self.text = @"A positive fraction whose numerator is less than its denominator is called a proper fraction.\n\nFor any denominator, d, there will be d1 proper fractions; for example, with d = 12:\n\n1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12.\n\nWe shall call a fraction that cannot be cancelled down a resilient fraction.\n\nFurthermore we shall define the resilience of a denominator, R(d), to be the ratio of its proper fractions that are resilient; for example, R(12) = 4/11.\n\nIn fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10.\n\nFind the smallest denominator d, having a resilience R(d) < 15499/94744.";
  self.title = @"Resilience";
  self.answer = @"892371480";
  self.number = @"243";
  self.estimatedComputationTime = @"4.5e-05";
  self.estimatedBruteForceComputationTime = @">1000";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply notice that when computing the totient function of a number,
  // the only thing that matters is the unique prime factors. Therefore, extra
  // copies of a prime number do NOT increase the total fraction of reduced
  // proper fractions of a number. The onyl exception to this is 2. Since the
  // number of fractions for a number n is (n-1) and not n, adding an extra
  // factor of 2 on a number can decrease the number of reduced proper fractions
  // more than multiplying by another unique prime factor. Here, we use this
  // fact to precompute the start of the target number. This needs to be done
  // manually if the target ratio changes.
  
  // Variable to hold the maximum size for the prime numbers.
  uint maxSize = 50;
  
  // Variable to hold the numerator of φ(n) for the target number. We start with
  // 2 extra factors of 2.
  uint numerator = 4;
  
  // Variable to hold the denominator of φ(n) for the target number. We start
  // with 2 extra factors of 2.
  uint denominator = 8;
  
  // Variable to hold the target numerator.
  uint targetNumerator = 15499;
  
  // Variable to hold the target denominator.
  uint targetDenominator = 94744;
  
  // Variable to hold the target fraction.
  double targetFraction = (((double)targetNumerator) / ((double)targetDenominator));
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the prime numbers from 3 to the last prime number,
  for(int primeNumberIndex = 1; primeNumberIndex < [primeNumbersArray count]; primeNumberIndex++){
    // Compute the numerator of φ(n).
    numerator *= ([[primeNumbersArray objectAtIndex:primeNumberIndex] intValue] - 1);
    
    // Compute the denominator of φ(n).
    denominator *= [[primeNumbersArray objectAtIndex:primeNumberIndex] intValue];
    
    // If the current number has the target number of reduced proper fractions,
    if((((double)numerator) / ((double)(denominator - 1))) < targetFraction){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the smallest denominator with the target number of
  // reduced proper fractions.
  self.answer = [NSString stringWithFormat:@"%d", denominator];
  
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
  
  // Here, we note simply compute all the prime factors of each number, and then
  // compute the Euler Totient Function. This in turn will give us the number of
  // numbers that are relatively prime to the current number. Since each one of
  // the numbers are relatively prime to the current number, they must generate
  // a proper fraction! Then, if the ratio of reduced proper fractions is less
  // than the target fraction, we break out of the loop, as we have found the
  // required number. For more information about the Euler Totient Function,
  // visit:
  //
  // http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula
  
  // Variable to hold the maximum size for the numbers.
  uint maxSize = 900000000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable to hold the target numerator.
  uint targetNumerator = 15499;
  
  // Variable to hold the numerator of the totient function of the current number.
  uint totientNumerator = 0;
  
  // Variable to hold the target denominator.
  uint targetDenominator = 94744;
  
  // Variable to hold the denominator of the totient function of the current number.
  uint totientDenominator = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the total number of reduced proper fractions.
  uint totalReducedProperFractions = 0;
  
  // Variable to hold the target fraction.
  double targetFraction = (((double)targetNumerator) / ((double)targetDenominator));
  
  // Variable to hold the smallest denominator with the target number of reduced
  // proper fractions.
  uint smallestDenominator = 0;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:sqrtOfCurrentNumber];
  
  // For all the numbers from 12 to the max size, incrementing by 12,
  for(int number = 12; number <= maxSize; number += 12){
    // If the number is NOT a prime number,
    if([self isPrime:number] == NO){
      // Grab the current number for use in factoring.
      currentNumber = number;
      
      // Recompute the square root of the current minimum number, in order to
      // speed up the computation.
      sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
      
      // Reset the current totient's numerator to 1.
      totientNumerator = 1;
      
      // Reset the current totient's denominator to 1.
      totientDenominator = 1;
      
      // For all the prime numbers in the prime numbers array,
      for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
        // Grab the current prime number from the prime numbers array.
        primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
        
        // If the current prime number is less than or equal to the square root of
        // the current number,
        if(primeNumber <= sqrtOfCurrentNumber){
          // If the current prime number divides the current number,
          if((currentNumber % primeNumber) == 0){
            // While the current prime number divides the current number,
            while((currentNumber % primeNumber) == 0){
              // Divide out the prime number from the number.
              currentNumber /= primeNumber;
            }
            // Compute the numerator of φ(n).
            totientNumerator *= (primeNumber - 1);
            
            // Compute the denominator of φ(n).
            totientDenominator *= primeNumber;
            
            // Recompute the square root of the current number, in order to speed
            // up the computation.
            sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
          }
        }
        // If the current prime number is greater than or equal to the square root
        // of the current prime number,
        else{
          // Break out of the loop.
          break;
        }
      }
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
      // If the current minimum number is NOT equal to 1 after the above factoring,
      // it must be a prime number itself,
      if(currentNumber > 1){
        // Compute the numerator of φ(n).
        totientNumerator *= (currentNumber - 1);
        
        // Compute the denominator of φ(n).
        totientDenominator *= currentNumber;
      }
      // Compute φ(n),the number of reduced proper fractions.
      totalReducedProperFractions = ((uint)((number / totientDenominator) * totientNumerator));
      
      if((((double)totalReducedProperFractions) / ((double)(number - 1))) < targetFraction){
        // Set the current number as the smallest denominator with the target
        // number of reduced proper fractions.
        smallestDenominator = number;
        
        // Break out of the loop.
        break;
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the smallest denominator with the target number of
    // reduced proper fractions.
    self.answer = [NSString stringWithFormat:@"%d", smallestDenominator];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end