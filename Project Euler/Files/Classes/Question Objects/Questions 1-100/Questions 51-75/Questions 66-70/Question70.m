//  Question70.m

#import "Question70.h"
#import "Global.h"

@implementation Question70

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"21 May 2004";
  self.hint = @"A prime number can never be a permutation of it's Totient Function.";
  self.text = @"Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.\n\nThe number 1 is considered to be relatively prime to every positive number, so φ(1)=1.\n\nInterestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.\n\nFind the value of n, 1 <= n <= 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.";
  self.title = @"Totient permutation";
  self.answer = @"8319823";
  self.number = @"70";
  self.keywords = @"totient,function,maximum,phi,euler's,eulers,product,permutation,relatively,prime,positive,numbers,ratio,produces,minimum";
  self.estimatedComputationTime = @"1.83e-02";
  self.estimatedBruteForceComputationTime = @"50.3";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note simply look at the numbers between 1,000,000 and 10,000,000
  // with only two larger prime factors. We know that a prime number and it's
  // Totient Function cannot be permutations of each other, as the digit sums
  // will never be equal. Therefore, checking numbers with two large prime
  // factors is our most likely next option. Once we compute the number, we
  // compute the Euler Totient Function. Then, we simply compute if the number
  // and φ(n) are permutations of each other, and if they are, compute the ratio
  // and store the minimum value. For more information about the Euler Totient
  // Function, visit:
  //
  //http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula
  
  // Set the max size for the prime numbers.
  uint maxSize = 5000;
  
  // Set the max size for the prime numbers.
  uint minSize = 2000;
  
  // Set the max size for the numbers.
  uint maxNumber = 10000000;
  
  // Variable to hold the current number.
  uint currentNumber = 0;
  
  // Variable to hold the numerator of the totient function of the current number.
  uint totientNumerator = 0;
  
  // Variable to hold the number with the smallest totient ratio.
  uint minimumRatioNumber = 0;
  
  // Variable to hold the ratio of the current number.
  double currentRatio = 1.0;
  
  // Variable to hold the smallest ratio found.
  double minimumRatio = 10.0;
  
  // Variable to hold the current prime number we are looking at.
  NSNumber * primeNumber = nil;
  
  // Variable to hold the current larger prime number we are looking at.
  NSNumber * largerPrimeNumber = nil;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Array that holds the primes numbers inbetween the maximum and minimum sizes.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // For all the prime numbers less than the maximum size,
  for(int primeIndex = 0; primeIndex < [primeNumbersArray count]; primeIndex++){
    // Grab the current prime number.
    primeNumber = [primeNumbersArray objectAtIndex:primeIndex];
    
    // If the prime number is greater than the minimum size,
    if([primeNumber intValue] > minSize){
      // Add the prime number to the updated prime numbers array.
      [updatedPrimeNumbersArray addObject:primeNumber];
    }
  }
  // For all the prime numbers between the minimum and maximum sizes,
  for(int primeIndex = 0; primeIndex < [updatedPrimeNumbersArray count]; primeIndex++){
    // Grab the current prime number.
    primeNumber = [updatedPrimeNumbersArray objectAtIndex:primeIndex];
    
    // For all the prime numbers larger than the current prime number,
    for(int largerPrimeIndex = (primeIndex + 1); largerPrimeIndex < [updatedPrimeNumbersArray count]; largerPrimeIndex++){
      // Grab the current larger prime number.
      largerPrimeNumber = [updatedPrimeNumbersArray objectAtIndex:largerPrimeIndex];
      
      // Compute the current number.
      currentNumber = [primeNumber intValue] * [largerPrimeNumber intValue];
      
      // If the current number is less than the maximum number to check,
      if(currentNumber < maxNumber){
        // Compute the numerator of φ(n).
        totientNumerator = ([primeNumber intValue] - 1) * ([largerPrimeNumber intValue] - 1);
        
        // If the number is a permutation of it's totient function,
        if([self anInt:currentNumber isAPermutationOfInt:totientNumerator]){
          
          // Compute the ratio of the current number and it's totient function,
          currentRatio = ((double)currentNumber) / ((double)totientNumerator);
          
          // If the current ratio is less than the minimum ratio already found,
          if(currentRatio < minimumRatio){
            // Set the minimum ratio to be the current ratio.
            minimumRatio = currentRatio;
            
            // Set the number with the minimum ratio to the current number.
            minimumRatioNumber = currentNumber;
          }
        }
      }
    }
  }
  // Set the answer string to the number with the minimum ratio.
  self.answer = [NSString stringWithFormat:@"%d", minimumRatioNumber];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm only checks numbers with 2 prime factors.
  
  // Here, we note simply compute all the prime factors of each number, and then
  // compute the Euler Totient Function. Then, we simply compute if the number
  // and φ(n) are permutations of each other, and if they are, compute the ratio
  // and store the minimum value. For more information about the Euler Totient
  // Function, visit:
  //
  // http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula
  
  // Set the max size for the numbers.
  uint maxSize = 10000000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the numerator of the totient function of the current number.
  uint totientNumerator = 0;
  
  // Variable to hold the number with the smallest totient ratio.
  uint minimumRatioNumber = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable to hold the ratio of the current number.
  double currentRatio = 1.0;
  
  // Variable to hold the smallest ratio found.
  double minimumRatio = 10.0;
  
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
  // For all the odd numbers from 33 to the max size,
  for(int number = 33; number < maxSize; number += 2){
    // If the number is NOT a prime number,
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
      // Reset the current totient's numerator to 1.
      totientNumerator = 1;
      
      // For all the prime factors of this number,
      for(int i = 0; i < primePowerIndex; i++){
        // Compute the numerator of φ(n).
        totientNumerator *= (currentPrimePowers[i].primeNumber - 1);
      }
      // If the number is a permutation of it's totient function,
      if([self anInt:number isAPermutationOfInt:totientNumerator]){
        // Compute the ratio of the current number and it's totient function,
        currentRatio = ((double)number) / ((double)totientNumerator);
        
        // If the current ratio is less than the minimum ratio already found,
        if(currentRatio < minimumRatio){
          // Set the minimum ratio to be the current ratio.
          minimumRatio = currentRatio;
          
          // Set the number with the minimum ratio to the current number.
          minimumRatioNumber = number;
        }
      }
    }
  }
  // Set the answer string to the number with the minimum ratio.
  self.answer = [NSString stringWithFormat:@"%d", minimumRatioNumber];
  
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