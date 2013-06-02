//  Question95.m

#import "Question95.h"
#import "Global.h"

@implementation Question95

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"13 May 2005";
  self.text = @"The proper divisors of a number are all the divisors excluding the number itself. For example, the proper divisors of 28 are 1, 2, 4, 7, and 14. As the sum of these divisors is equal to 28, we call it a perfect number.\n\nInterestingly the sum of the proper divisors of 220 is 284 and the sum of the proper divisors of 284 is 220, forming a chain of two numbers. For this reason, 220 and 284 are called an amicable pair.\n\nPerhaps less well known are longer chains. For example, starting with 12496, we form a chain of five numbers:\n\n12496 -> 14288 -> 15472 -> 14536 -> 14264 (-> 12496 -> ...)\n\nSince this chain returns to its starting point, it is called an amicable chain.\n\nFind the smallest member of the longest amicable chain with no element exceeding one million.";
  self.title = @"Amicable chains";
  self.answer = @"14316";
  self.number = @"95";
  self.keywords = @"amicable,chains,proper,divisors,sum,longest";
  self.estimatedComputationTime = @"10.1";
  self.estimatedBruteForceComputationTime = @"";
}

#pragma mark - Methods
// TODO: Clean-up.

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just find all the abundent numbers up to the max size, then add all
  // possible combinations together, and in a BOOL array, set index (the sum) to
  // be that the number IS the sum of two digit numbers.
  //
  // We use the prime factorization method (described in Question 21) to determine
  // if the number is abundent of not.
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 1000000;
  
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
  int * sumOfFactorsForNumbers = malloc((maxSize + 1) * sizeof(int));
  
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
  
  sumOfFactorsForNumbers[0] = -1;
  
  sumOfFactorsForNumbers[1] = -1;
  
  sumOfFactorsForNumbers[2] = -1;
  
  sumOfFactorsForNumbers[3] = -1;
  
  // For all the prime factors up to the maximum number of prime factors,
  for(int i = 0; i <= maxNumberOfPrimeFactors; i++){
    // Set the current prime factors to zero by default.
    currentPrimePowers[i] = PrimePowerZero;
  }
  // For all the numbers from 4 to the max size,
  for(int number = 4; number < maxSize; number++){
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
    
    // For all the prime factors of this number,
    for(int i = 0; i < primePowerIndex; i++){
      // If the current prime power is actually a factor,
      if(currentPrimePowers[i].primeNumber > 0){
        // Multiply the sum of the divisors by the sum of the powers for the
        // current prime power.
        sumOfDivisors *= [self sumOfPowersForPrimePower:currentPrimePowers[i]];
      }
      // Reset the current prime power to zero.
      currentPrimePowers[i] = PrimePowerZero;
    }
    sumOfFactorsForNumbers[number] = (int)(sumOfDivisors - number);
  }
  BOOL cycleFound = NO;
  
  int currentElementInChain = 0;
  
  uint currentChainLength = 0;
  
  uint smallestElementInLongestChain = 0;
  
  uint longestChainLength = 0;
  
  uint firstIndexOfChain = 0;
  
  // Variable array to hold all the numbers in the chain of amicable numbers.
  NSMutableArray * numbersInChain = nil;
  
  // Sort Descriptor to order the number in the chain of amicable numbers in
  // ascending order.
  NSSortDescriptor * lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
  
  // For all the numbers from 4 to the max size,
  for(int number = 4; number < maxSize; number++){
    // Grab the next element in the chain (the sum of the proper divisors of the
    // current number).
    currentElementInChain = sumOfFactorsForNumbers[number];
    
    // Reset the chain length to 0.
    currentChainLength = 0;
    
    // If the next element in the chain in positive,
    if(currentElementInChain > 0){
      // Mark that we have found a cycle.
      cycleFound = YES;
      
      // Create an array that will contain all of the numbers in the amicable chain.
      numbersInChain = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:number], nil];
      
      // While the chain does not contain a cycle,
      while([numbersInChain indexOfObject:[NSNumber numberWithInt:currentElementInChain]] == NSNotFound){
        // If the current element in the chain is negative, or outside of the
        // range of numbers we need to examine,
        if((currentElementInChain < 0) || (currentElementInChain > maxSize)){
          // Mark that a valid cycle was NOT found.
          cycleFound = NO;
          
          // Break out of the loop.
          break;
        }
        // Increment the current chain's length by 1.
        currentChainLength++;
        
        // Add the current number in the chain to the chain.
        [numbersInChain addObject:[NSNumber numberWithInt:currentElementInChain]];
        
        // Grab the next element in the chain.
        currentElementInChain = sumOfFactorsForNumbers[currentElementInChain];
      }
      // If we have found a cycle,
      if(cycleFound){
        // Grab the first index of the number that repeats in the chain, as it
        // may NOT be the first number in the array.
        firstIndexOfChain = [numbersInChain indexOfObject:[NSNumber numberWithInt:currentElementInChain]];
        
        // Decrease the current length of the chain by the index of the first
        // number that repeats in the chain.
        currentChainLength -= firstIndexOfChain;
        
        // If the current chain's length is greater than the longest chain length
        // previously found,
        if(currentChainLength > longestChainLength){
          // For all of the numbers in the chain until it repeats,
          for(int i = 0; i < firstIndexOfChain; i++){
            // Remove the first number leading up to the chain.
            [numbersInChain removeObjectAtIndex:0];
          }
          // For the remaining numbers in the chain, sort them from lowest to
          // highest.
          [numbersInChain sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
          
          // Set the current chain's length to be the longest chain's length.
          longestChainLength = currentChainLength;
          
          // Store the smallest element in the current (and longest) chain.
          smallestElementInLongestChain = [[numbersInChain objectAtIndex:0] intValue];
        }
      }
    }
    // For all the numbers in the current chain,
    for(int i = 0; i < currentChainLength; i++){
      // If the sum of the factors of the current number in the chain is positive,
      if(sumOfFactorsForNumbers[[[numbersInChain objectAtIndex:i] intValue]] > 0){
        // Make the sum of the factors for the current numberin the chain negative.
        sumOfFactorsForNumbers[[[numbersInChain objectAtIndex:i] intValue]] *= -1;
      }
    }
  }
  // Free the malloced data on the HEAP, as ARC will not do this for you.
  free(sumOfFactorsForNumbers);
  
  // Set the answer string to the smallest element in the longest chain.
  self.answer = [NSString stringWithFormat:@"%d", smallestElementInLongestChain];
  
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