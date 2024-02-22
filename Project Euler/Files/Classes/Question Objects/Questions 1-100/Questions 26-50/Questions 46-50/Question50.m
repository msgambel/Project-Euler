//  Question50.m

#import "Question50.h"

@implementation Question50

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"15 August 2003";
  self.hint = @"Use a floating sum of consecutive primes (subtract the smallest, add the next largest).";
  self.link = @"https://en.wikipedia.org/wiki/Prime_number";
  self.text = @"The prime 41, can be written as the sum of six consecutive primes:\n\n41 = 2 + 3 + 5 + 7 + 11 + 13\n\nThis is the longest sum of consecutive primes that adds to a prime below one-hundred.\n\nThe longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.\n\nWhich prime, below one-million, can be written as the sum of the most consecutive primes?";
  self.isFun = YES;
  self.title = @"Consecutive prime sum";
  self.answer = @"997651";
  self.number = @"50";
  self.rating = @"5";
  self.category = @"Primes";
  self.isUseful = NO;
  self.keywords = @"sum,consecutive,primes,one,million,1000000,adds,terms,most,largest,written,below,floating";
  self.loadsFile = NO;
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"46";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.isContestMath = NO;
  self.startedOnDate = @"19/02/13";
  self.trickRequired = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"19/02/13";
  self.solutionLineCount = @"71";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"1.21";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"7.2";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a floating sum of consecutive prime numbers in order to
  // reduce computation. If we know the sum:
  //
  // s_{i,j} = \sum_{n = i}^{i+j} p_{n}
  //
  // Then,
  //
  // s_{i+1,j} = \sum_{n = (i+1)}^{i+1+j} p_{n}
  //           = p_{i+1+j} + \sum_{n = (i+1)}^{i+j} p_{n}
  //           = p_{i+1+j} + \sum_{n = i}^{i+j} p_{n} - p_{i}
  //           = p_{i+1+j} + s_{i,j} - p_{i}
  //
  // Therefore, if we add the next largest prime for our floating sum, and
  // subtract the minimum prime from the floating sum, we arrive at the answer!
  //
  // We then simply loop, incrementing the number of terms in our floating sum
  // by 1 until the number of terms is larger than the maximum size we are
  // looking for. We check if the sum is prime using a Hash Table, and if it is,
  // we store it in a variable.
  //
  // We also ignore the cases where the number of primes in the floating sum is
  // even (and does not start with 2), as the sum will be even, and therefore
  // NOT a prime.
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Variable to hold the floating sum of primes.
  uint floatingSum = 0;
  
  // Variable to hold the current minimum prime in the floating sum.
  uint minimumPrime = 0;
  
  // Variable to hold the sum of consecutive primes (starting at 2) for the
  // current number of consecutive primes.
  uint previousStartSum = 0;
  
  // Variable to hold current maximum prime index of the consecutive primes in
  // the primes array.
  uint maximumPrimeIndex = 0;
  
  // Variable to hold the index of the minimum prime number in the floating sum.
  uint minimumPrimeIndex = 0;
  
  // Variable to hold the number of consecutive primes.
  uint numOfConsecutivePrimes = 21;
  
  // Variable to hold the largest primes that can be written as the sum of the
  // most consecutive primes.
  uint largestConsecutivePrime = 953;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the prime numbers found,
    for(NSNumber * primeNumber in primeNumbersArray){
      // Add the prime number as a key to the Hash Table to easily look if the number
      // is prime or not.
      [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
    }
    // For all the primes starting at 2,
    for(int index = 0; index < numOfConsecutivePrimes; index++){
      // Add the current prime number to the previous start sum.
      previousStartSum += [[primeNumbersArray objectAtIndex:index] intValue];
    }
    // While the previous start sum is less than the maximum size,
    while(previousStartSum < maxSize){
      // Set the current floating sum to be the previous starting sum.
      floatingSum = previousStartSum;
      
      // Set the maximum prime index to be the number of consecutive primes.
      maximumPrimeIndex = numOfConsecutivePrimes;
      
      // Set the minimum index to be 0.
      minimumPrimeIndex = 0;
      
      // Grab the minimum prime based on the minimum prime index.
      minimumPrime = [[primeNumbersArray objectAtIndex:minimumPrimeIndex] intValue];
      
      // If the current floating sum is prime,
      if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", floatingSum]] boolValue]){
        // Store the current floating sum as the largest prime number that is
        // the sum of the most consecutive primes.
        largestConsecutivePrime = floatingSum;
      }
      // We only need to check the floating sum if the number of prime numbers is
      // odd, as is it is even, the sum will be even, and therefore NOT a prime.
      if((numOfConsecutivePrimes % 2) == 1){
        // While the floating sum is less than the maximum size,
        while(floatingSum < maxSize){
          // Add the current maximum prime number to the floating sum.
          floatingSum += [[primeNumbersArray objectAtIndex:maximumPrimeIndex] intValue];
          
          // Subtract off the minimum prime number from the floating sum.
          floatingSum -= minimumPrime;
          
          // If the floating sum is largest than the maximum size we are looking for,
          if(floatingSum > maxSize){
            // Break out of the loop.
            break;
          }
          // If the current floating sum is prime,
          if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", floatingSum]] boolValue]){
            // Store the current floating sum as the largest prime number that is
            // the sum of the most consecutive primes.
            largestConsecutivePrime = floatingSum;
          }
          // Increment the minimum prime number index by 1.
          minimumPrimeIndex++;
          
          // Grab the minimum prime based on the minimum prime index.
          minimumPrime = [[primeNumbersArray objectAtIndex:minimumPrimeIndex] intValue];
          
          // Increment the current maximum prime index of the floating sum by 1.
          maximumPrimeIndex++;
        }
      }
      // Add the current maximum prime number to the previous starting sum.
      previousStartSum += [[primeNumbersArray objectAtIndex:numOfConsecutivePrimes] intValue];
      
      // Increment the number consecutive primes by 1.
      numOfConsecutivePrimes++;
      
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the largest consecutive prime sum that is a prime
    // number.
    self.answer = [NSString stringWithFormat:@"%d", largestConsecutivePrime];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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
  
  // Here, we then simply loop, incrementing the number of terms in our sum by 1
  // until the number of terms is larger than the maximum size we are looking
  // for. We check if the sum is prime using a Hash Table, and if it is, we
  // store it in a variable.
  
  // Variable to hold the current consecutive sum.
  uint consecutiveSum = 0;
  
  // Variable to hold the number of consecutive primes.
  uint numOfConsecutivePrimes = 21;
  
  // Variable to hold current start index of the consecutive primes in the
  // primes array.
  uint currentStartIndex = 0;
  
  // Variable to hold the maximum number of consecutive primes.
  uint maxNumOfConsecutivePrimes = 0;
  
  // Variable to hold the largest primes that can be written as the sum of the
  // most consecutive primes.
  uint largestConsecutivePrime = 953;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Hash table to easily check if a number is prime of not.
    NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
    
    // For all the prime numbers found,
    for(NSNumber * primeNumber in primeNumbersArray){
      // Add the prime number as a key to the Hash Table to easily look if the number
      // is prime or not.
      [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
    }
    // While the consecutive sum of primes starting at 2 is less than the maximum
    // size,
    while(consecutiveSum < maxSize){
      // Increment the consecutive sum of primes starting at 2 by the current prime.
      consecutiveSum += [[primeNumbersArray objectAtIndex:maxNumOfConsecutivePrimes] intValue];
      
      // Increment the maximum number of consecutive primes by 1.
      maxNumOfConsecutivePrimes++;
    }
    // While the current number of consecutive primes is less than the maximum
    // number of consecutive primes,
    while(numOfConsecutivePrimes < maxNumOfConsecutivePrimes){
      // Reset the current consecutive sum to 0.
      consecutiveSum = 0;
      
      // Reset the current start index in the primes array to 0.
      currentStartIndex = 0;
      
      // While the current consecutive sum is less than the maximum size,
      while(consecutiveSum < maxSize){
        // Reset the current consecutive sum to 0.
        consecutiveSum = 0;
        
        // For all the prime numbers from the current start index to the current
        // end index of the primes array,
        for(int index = currentStartIndex; index < (currentStartIndex + numOfConsecutivePrimes); index++){
          // Add the current prime to the sum of consecutive primes.
          consecutiveSum += [[primeNumbersArray objectAtIndex:index] intValue];
        }
        // If the current sum is prime,
        if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", consecutiveSum]] boolValue]){
          // Store the current sum as the largest prime number that is the sum of
          // the most consecutive primes.
          largestConsecutivePrime = consecutiveSum;
        }
        // Increment the current start index by 1.
        currentStartIndex++;
      }
      // Increment the number consecutive primes by 1.
      numOfConsecutivePrimes++;
      
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the largest consecutive prime sum that is a prime
    // number.
    self.answer = [NSString stringWithFormat:@"%d", largestConsecutivePrime];
    
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