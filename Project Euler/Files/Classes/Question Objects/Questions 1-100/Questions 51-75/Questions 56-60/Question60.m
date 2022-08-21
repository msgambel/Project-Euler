//  Question60.m

#import "Question60.h"

@interface Question60 (Private)

- (BOOL)isPairPrime:(uint)aFirstPrime secondPrime:(uint)aSecondPrime; 
- (BOOL)concatenationsArePrimeOf:(uint *)aPrimeNumbers toIndex:(uint)aIndex;
- (long long int)concatenateLeftNumber:(long long int)aLeftNumber toRightNumber:(long long int)aRightNumber;
- (long long int)stringConcatenateLeftNumber:(long long int)aLeftNumber toRightNumber:(long long int)aRightNumber;

@end

@implementation Question60

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"02 January 2004";
  self.hint = @"All primes in a set must be unique.";
  self.link = @"https://en.wikipedia.org/wiki/Primality_test#Pseudocode";
  self.text = @"The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.\n\nFind the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.";
  self.isFun = YES;
  self.title = @"Prime pair sets";
  self.answer = @"26033";
  self.number = @"60";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"primes,concatenate,set,five,5,lowest,sum,produce,two,2,order,pairs,property,another,result";
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"48";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"01/03/13";
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"01/03/13";
  self.solutionLineCount = @"125";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"0.289";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.09";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to tell if the prime in a set of 5 form
  // a prime pair set. We then check every prime to see which set of 5 primes
  // will be valid. One thing to note is that a prime can only occur in the set
  // once, as any prime concatenated with itself would be divisible by itself,
  // and hence, would not be prime. This allows us to look at the next index
  // when we check for the next prime number to add.
  
  // Variable to mark if we found the prime pair set or not.
  BOOL isFound = NO;
  
  // Set the max size for the prime numbers.
  uint maxSize = 8500;
  
  // Variable to hold the sum of the prime numbers in the prime pair set.
  uint primeNumbersSum = 0;
  
  // Variablet array to hold the prime pair set.
  uint primeNumbers[5] = {0};
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Remove 2 from the primes array, as it can't be a concatenated prime.
  [primeNumbersArray removeObjectAtIndex:0];
  
  // Remove 5 from the primes array, as it can't be a concatenated prime.
  [primeNumbersArray removeObjectAtIndex:1];
  
  // For all the prime numbers in the prime numbers array,
  for(int primeIndex1 = 0; primeIndex1 < [primeNumbersArray count]; primeIndex1++){
    // Store the current prime number in the prime pair set array.
    primeNumbers[0] = [[primeNumbersArray objectAtIndex:primeIndex1] intValue];
    
    // For all the prime numbers in the prime numbers array, starting after the
    // previous prime number,
    for(int primeIndex2 = primeIndex1 + 1; primeIndex2 < [primeNumbersArray count]; primeIndex2++){
      // Store the current prime number in the prime pair set array.
      primeNumbers[1] = [[primeNumbersArray objectAtIndex:primeIndex2] intValue];
      
      // Grab if the prime pair sets up to the second prime generate
      // concatenated primes.
      isFound = [self isPairPrime:primeNumbers[0] secondPrime:primeNumbers[1]];
      
      // If the prime pairs all generate concatenated primes,
      if(isFound){
        // For all the prime numbers in the prime numbers array, starting after the
        // previous prime number,
        for(int primeIndex3 = primeIndex2 + 1; primeIndex3 < [primeNumbersArray count]; primeIndex3++){
          // Store the current prime number in the prime pair set array.
          primeNumbers[2] = [[primeNumbersArray objectAtIndex:primeIndex3] intValue];
          
          // Grab if the prime pair sets up to the third prime generate
          // concatenated primes.
          isFound = ([self isPairPrime:primeNumbers[0] secondPrime:primeNumbers[2]] &&
                     [self isPairPrime:primeNumbers[1] secondPrime:primeNumbers[2]]);
          
          // If the prime pairs all generate concatenated primes,
          if(isFound){
            // For all the prime numbers in the prime numbers array, starting after the
            // previous prime number,
            for(int primeIndex4 = primeIndex3 + 1; primeIndex4 < [primeNumbersArray count]; primeIndex4++){
              // Store the current prime number in the prime pair set array.
              primeNumbers[3] = [[primeNumbersArray objectAtIndex:primeIndex4] intValue];
              
              // Grab if the prime pair sets up to the fourth prime generate
              // concatenated primes.
              isFound = ([self isPairPrime:primeNumbers[0] secondPrime:primeNumbers[3]] &&
                         [self isPairPrime:primeNumbers[1] secondPrime:primeNumbers[3]] &&
                         [self isPairPrime:primeNumbers[2] secondPrime:primeNumbers[3]]);
              
              // If the prime pairs all generate concatenated primes,
              if(isFound){
                // For all the prime numbers in the prime numbers array, starting after the
                // previous prime number,
                for(int primeIndex5 = primeIndex4 + 1; primeIndex5 < [primeNumbersArray count]; primeIndex5++){
                  // Store the current prime number in the prime pair set array.
                  primeNumbers[4] = [[primeNumbersArray objectAtIndex:primeIndex5] intValue];
                  
                  // Grab if the prime pair sets up to the fifth prime generate
                  // concatenated primes.
                  isFound = ([self isPairPrime:primeNumbers[0] secondPrime:primeNumbers[4]] &&
                             [self isPairPrime:primeNumbers[1] secondPrime:primeNumbers[4]] &&
                             [self isPairPrime:primeNumbers[2] secondPrime:primeNumbers[4]] &&
                             [self isPairPrime:primeNumbers[3] secondPrime:primeNumbers[4]]);
                  
                  // If the prime pairs all generate concatenated primes,
                  if(isFound){
                    // We have found the 5 prime pair set, so break out of the loop.
                    break;
                  }
                }
              }
              // If we found the 5th and final prime,
              if(isFound){
                // Break out of the loop.
                break;
              }
            }
            // If we found the 5th and final prime,
            if(isFound){
              // Break out of the loop.
              break;
            }
          }
          // If we found the 5th and final prime,
          if(isFound){
            // Break out of the loop.
            break;
          }
        }
        // If we found the 5th and final prime,
        if(isFound){
          // Break out of the loop.
          break;
        }
      }
      // If we found the 5th and final prime,
      if(isFound){
        // Break out of the loop.
        break;
      }
    }
    // If we found the 5th and final prime,
    if(isFound){
      // Break out of the loop.
      break;
    }
  }
  // For all the prime numbers in the prime pair set,
  for(int i = 0; i < 5; i++){
    // Add the prime number to the sum.
    primeNumbersSum += primeNumbers[i];
  }
  // Set the answer string to the sum of the prime numbers.
  self.answer = [NSString stringWithFormat:@"%d", primeNumbersSum];
  
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
  //       algorithm just doesn't do extra checks when looking for prime pairs.
  
  // Here, we simply use a helper method to tell if the prime in a set of 5 form
  // a prime pair set. We then check every prime to see which set of 5 primes
  // will be valid. One thing to note is that a prime can only occur in the set
  // once, as any prime concatenated with itself would be divisible by itself,
  // and hence, would not be prime. This allows us to look at the next index
  // when we check for the next prime number to add.
  
  // Variable to mark if we found the prime pair set or not.
  BOOL isFound = NO;
  
  // Set the max size for the prime numbers.
  uint maxSize = 8500;
  
  // Variable to hold the sum of the prime numbers in the prime pair set.
  uint primeNumbersSum = 0;
  
  // Variablet array to hold the prime pair set.
  uint primeNumbers[5] = {0};
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Remove 2 from the primes array, as it can't be a concatenated prime.
  [primeNumbersArray removeObjectAtIndex:0];
  
  // Remove 5 from the primes array, as it can't be a concatenated prime.
  [primeNumbersArray removeObjectAtIndex:1];
  
  // For all the prime numbers in the prime numbers array,
  for(int primeIndex1 = 0; primeIndex1 < [primeNumbersArray count]; primeIndex1++){
    // Store the current prime number in the prime pair set array.
    primeNumbers[0] = [[primeNumbersArray objectAtIndex:primeIndex1] intValue];
    
    // For all the prime numbers in the prime numbers array, starting after the
    // previous prime number,
    for(int primeIndex2 = primeIndex1 + 1; primeIndex2 < [primeNumbersArray count]; primeIndex2++){
      // Store the current prime number in the prime pair set array.
      primeNumbers[1] = [[primeNumbersArray objectAtIndex:primeIndex2] intValue];
      
      // Grab if the prime pair sets up to the second prime generate
      // concatenated primes.
      isFound = [self concatenationsArePrimeOf:primeNumbers toIndex:2];
      
      // If the prime pairs all generate concatenated primes,
      if(isFound){
        // For all the prime numbers in the prime numbers array, starting after the
        // previous prime number,
        for(int primeIndex3 = primeIndex2 + 1; primeIndex3 < [primeNumbersArray count]; primeIndex3++){
          // Store the current prime number in the prime pair set array.
          primeNumbers[2] = [[primeNumbersArray objectAtIndex:primeIndex3] intValue];
          
          // Grab if the prime pair sets up to the third prime generate
          // concatenated primes.
          isFound = [self concatenationsArePrimeOf:primeNumbers toIndex:3];
          
          // If the prime pairs all generate concatenated primes,
          if(isFound){
            // For all the prime numbers in the prime numbers array, starting after the
            // previous prime number,
            for(int primeIndex4 = primeIndex3 + 1; primeIndex4 < [primeNumbersArray count]; primeIndex4++){
              // Store the current prime number in the prime pair set array.
              primeNumbers[3] = [[primeNumbersArray objectAtIndex:primeIndex4] intValue];
              
              // Grab if the prime pair sets up to the fourth prime generate
              // concatenated primes.
              isFound = [self concatenationsArePrimeOf:primeNumbers toIndex:4];
              
              // If the prime pairs all generate concatenated primes,
              if(isFound){
                // For all the prime numbers in the prime numbers array, starting after the
                // previous prime number,
                for(int primeIndex5 = primeIndex4 + 1; primeIndex5 < [primeNumbersArray count]; primeIndex5++){
                  // Store the current prime number in the prime pair set array.
                  primeNumbers[4] = [[primeNumbersArray objectAtIndex:primeIndex5] intValue];
                  
                  // Grab if the prime pair sets up to the fifth prime generate
                  // concatenated primes.
                  isFound = [self concatenationsArePrimeOf:primeNumbers toIndex:5];
                  
                  // If the prime pairs all generate concatenated primes,
                  if(isFound){
                    // We have found the 5 prime pair set, so break out of the loop.
                    break;
                  }
                }
              }
              // If we found the 5th and final prime,
              if(isFound){
                // Break out of the loop.
                break;
              }
            }
            // If we found the 5th and final prime,
            if(isFound){
              // Break out of the loop.
              break;
            }
          }
          // If we found the 5th and final prime,
          if(isFound){
            // Break out of the loop.
            break;
          }
        }
        // If we found the 5th and final prime,
        if(isFound){
          // Break out of the loop.
          break;
        }
      }
      // If we found the 5th and final prime,
      if(isFound){
        // Break out of the loop.
        break;
      }
    }
    // If we found the 5th and final prime,
    if(isFound){
      // Break out of the loop.
      break;
    }
  }
  // For all the prime numbers in the prime pair set,
  for(int i = 0; i < 5; i++){
    // Add the prime number to the sum.
    primeNumbersSum += primeNumbers[i];
  }
  // Set the answer string to the sum of the prime numbers.
  self.answer = [NSString stringWithFormat:@"%d", primeNumbersSum];
  
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

@implementation Question60 (Private)

- (BOOL)isPairPrime:(uint)aFirstPrime secondPrime:(uint)aSecondPrime; {
  // Grab the first concatenated number number.
  uint concatenatedNumber = (uint)[self concatenateLeftNumber:aFirstPrime toRightNumber:aSecondPrime];
  
  // If it is NOT prime,
  if(![self isPrime:concatenatedNumber]){
    // Return that the prime pair is NOT a prime pair set.
    return NO;
  }
  // Grab the second concatenated number number.
  concatenatedNumber = (uint)[self concatenateLeftNumber:aSecondPrime toRightNumber:aFirstPrime];
  
  // If it is NOT prime,
  if(![self isPrime:concatenatedNumber]){
    // Return that the prime pair is NOT a prime pair set.
    return NO;
  }
  // Return that the prime pair is a prime pair set.
  return YES;
}

- (BOOL)concatenationsArePrimeOf:(uint *)aPrimeNumbers toIndex:(uint)aIndex; {
  // Variable to mark if the inputted prime pair set array holds a prime pair
  // set up to a given index.
  BOOL isFound = YES;
  
  // For all the primes up to the inputted index,
  for(int firstPrimeIndex = 0; firstPrimeIndex < aIndex; firstPrimeIndex++){
    // For all the primes from the next largest prime up to the inputted index,
    for(int secondPrimeIndex = firstPrimeIndex + 1; secondPrimeIndex < aIndex; secondPrimeIndex++){
      // If the two current primes do NOT form a prime pair set,
      if(![self isPairPrime:aPrimeNumbers[firstPrimeIndex] secondPrime:aPrimeNumbers[secondPrimeIndex]]){
        // Mark that the whole set of primes is NOT a prime pair set.
        isFound = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the inputted prime numbers do NOT form a prime pair set,
    if(!isFound){
      // Break out of the loop.
      break;
    }
  }
  // Return if the inputted prime numbers form a prime pair set or NOT.
  return isFound;
}

- (long long int)concatenateLeftNumber:(long long int)aLeftNumber toRightNumber:(long long int)aRightNumber; {
  // Variable to hold the number of digits there are for the right number.
  int numberOfDigits = ((int)(log10(aRightNumber))) + 1;
  
  // Return the sum of the left number (shifted to the left by the number of
  // digits of the right number) and the right number.
  return (aLeftNumber * ((long long int)pow(10.0, ((double)numberOfDigits))) + aRightNumber);
}

- (long long int)stringConcatenateLeftNumber:(long long int)aLeftNumber toRightNumber:(long long int)aRightNumber; {
  // Return the long long int value of the concatenated string of the left and
  // right numbers.
  return [[NSString stringWithFormat:@"%llu%llu", aLeftNumber, aRightNumber] longLongValue];
}

@end