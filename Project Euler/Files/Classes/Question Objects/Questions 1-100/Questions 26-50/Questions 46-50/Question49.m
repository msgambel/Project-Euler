//  Question49.m

#import "Question49.h"

@implementation Question49

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"01 August 2003";
  self.hint = @"Split the prime numbers between 1,000 and 10,000 into 'small', 'medium', and 'large' numbers.";
  self.link = @"https://en.wikipedia.org/wiki/Arithmetic_progression";
  self.text = @"The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.\n\nThere are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.\n\nWhat 12-digit number do you form by concatenating the three terms in this sequence?";
  self.isFun = YES;
  self.title = @"Prime permutations";
  self.answer = @"296962999629";
  self.number = @"49";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"arithmetic,sequence,prime,permutations,increasing,four,4,twelve,12,digit,number,concatenating,form,unusual,10000";
  self.solveTime = @"120";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"38";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"18/02/13";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"18/02/13";
  self.solutionLineCount = @"87";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.127";
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.127";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply get all the prime numbers up to 10,000, and then remove the
  // prime numbers less than 1,000, to give us an array of all the 4-digit prime
  // numbers. Then, we iterated through the array twice, grabbing the minimum
  // and middle prime numbers. We use a helper method to check if the numbers
  // are permutations of each other, and then compute the difference between the
  // prime numbers if they are.
  //
  // We then compute the third number in the arithmetic sequence, and check if
  // it is prime using a precomputed hash table. If it is, we check if it is a
  // permutation of the minimum prime number. Lastly, we check to make sure it
  // isn't the example given in the question text.
  
  // Set the maxaimum size for the prime numbers.
  uint maxSize = 10000;
  
  // Set the minimum size for the prime numbers.
  uint minSize = 1000;
  
  // Variable to hold the current maximum prime number in the arithmetic sequence.
  uint currentMaxPrimeNumber = 0;
  
  // Variable to hold the current minimum prime number in the arithmetic sequence.
  uint currentMinPrimeNumber = 0;
  
  // Variable to hold the current middle prime number in the arithmetic sequence.
  uint currentMiddlePrimeNumber = 0;
  
  // Variable to hold the concatenated prime number for the result.
  NSString * concatenatedPrimeNumbers = nil;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Array to hold all the primes between the minimum and maximum sizes.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // If the prime number is greater than the minimum size,
    if([primeNumber intValue] > minSize){
      // Add it to the updated prime numbers array.
      [updatedPrimeNumbersArray addObject:primeNumber];
    }
  }
  // For all the prime numbers between the minimum and maximum sizes,
  for(NSNumber * primeNumber in updatedPrimeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the prime numbers from the minimum to the maximum,
  for(int minIndex = 0; minIndex < [updatedPrimeNumbersArray count]; minIndex++){
    // Grab the current minimum prime number in the potential arithmetic sequence.
    currentMinPrimeNumber = [[updatedPrimeNumbersArray objectAtIndex:minIndex] intValue];
    
    // For all the prime number greater than the minimum prime number,
    for(int middleIndex = (minIndex + 1); middleIndex < [updatedPrimeNumbersArray count]; middleIndex++){
      // Grab the current middle prime number in the potential arithmetic sequence.
      currentMiddlePrimeNumber = [[updatedPrimeNumbersArray objectAtIndex:middleIndex] intValue];
      
      // If the minimum and middle prime numbers are permutations of each other,
      if([self number:currentMinPrimeNumber isAPermutationOfNumber:currentMiddlePrimeNumber]){
        // Compute the arithmetic difference of the minimum and middle prime
        // numbers.
        currentMaxPrimeNumber = (currentMiddlePrimeNumber - currentMinPrimeNumber);
        
        // Add the arithmetic difference to the middle prime number.
        currentMaxPrimeNumber += currentMiddlePrimeNumber;
        
        // If the maximum (potential) prime number is greater than the maximum
        // size for a prime number,
        if(currentMaxPrimeNumber >= maxSize){
          // Break out of the loop.
          break;
        }
        // If the maximum prime number is indeed a prime number,
        if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", currentMaxPrimeNumber]] boolValue]){
          // If the minimum and maximum prime numbers are permutations of each other,
          if([self number:currentMinPrimeNumber isAPermutationOfNumber:currentMaxPrimeNumber]){
            // If the validated sequence is NOT the one described in the question
            // text,
            if((currentMinPrimeNumber != 1487) && (currentMiddlePrimeNumber != 4817) && (currentMaxPrimeNumber != 8147)){
              // Set the concatenated number to be the three prime numbers found,
              // in increasing order.
              concatenatedPrimeNumbers = [NSString stringWithFormat:@"%d%d%d", currentMinPrimeNumber, currentMiddlePrimeNumber, currentMaxPrimeNumber];
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
    }
    // If we have found the prime numbers,
    if(concatenatedPrimeNumbers != nil){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the concatenated prime numbers
  self.answer = concatenatedPrimeNumbers;
  
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
  
  // Here, we simply get all the prime numbers up to 10,000, and then remove the
  // prime numbers less than 1,000, to give us an array of all the 4-digit prime
  // numbers. Then, we iterated through the array twice, grabbing the minimum
  // and middle prime numbers. We use a helper method to check if the numbers
  // are permutations of each other, and then compute the difference between the
  // prime numbers if they are.
  //
  // We then compute the third number in the arithmetic sequence, and check if
  // it is prime using a precomputed hash table. If it is, we check if it is a
  // permutation of the minimum prime number. Lastly, we check to make sure it
  // isn't the example given in the question text.
  
  // Set the maxaimum size for the prime numbers.
  uint maxSize = 10000;
  
  // Set the minimum size for the prime numbers.
  uint minSize = 1000;
  
  // Variable to hold the current maximum prime number in the arithmetic sequence.
  uint currentMaxPrimeNumber = 0;
  
  // Variable to hold the current minimum prime number in the arithmetic sequence.
  uint currentMinPrimeNumber = 0;
  
  // Variable to hold the current middle prime number in the arithmetic sequence.
  uint currentMiddlePrimeNumber = 0;
  
  // Variable to hold the concatenated prime number for the result.
  NSString * concatenatedPrimeNumbers = nil;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Array to hold all the primes between the minimum and maximum sizes.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // If the prime number is greater than the minimum size,
    if([primeNumber intValue] > minSize){
      // Add it to the updated prime numbers array.
      [updatedPrimeNumbersArray addObject:primeNumber];
    }
  }
  // For all the prime numbers between the minimum and maximum sizes,
  for(NSNumber * primeNumber in updatedPrimeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the prime numbers from the minimum to the maximum,
  for(int minIndex = 0; minIndex < [updatedPrimeNumbersArray count]; minIndex++){
    // Grab the current minimum prime number in the potential arithmetic sequence.
    currentMinPrimeNumber = [[updatedPrimeNumbersArray objectAtIndex:minIndex] intValue];
    
    // For all the prime number greater than the minimum prime number,
    for(int middleIndex = (minIndex + 1); middleIndex < [updatedPrimeNumbersArray count]; middleIndex++){
      // Grab the current middle prime number in the potential arithmetic sequence.
      currentMiddlePrimeNumber = [[updatedPrimeNumbersArray objectAtIndex:middleIndex] intValue];
      
      // If the minimum and middle prime numbers are permutations of each other,
      if([self number:currentMinPrimeNumber isAPermutationOfNumber:currentMiddlePrimeNumber]){
        // Compute the arithmetic difference of the minimum and middle prime
        // numbers.
        currentMaxPrimeNumber = (currentMiddlePrimeNumber - currentMinPrimeNumber);
        
        // Add the arithmetic difference to the middle prime number.
        currentMaxPrimeNumber += currentMiddlePrimeNumber;
        
        // If the maximum (potential) prime number is greater than the maximum
        // size for a prime number,
        if(currentMaxPrimeNumber >= maxSize){
          // Break out of the loop.
          break;
        }
        // If the maximum prime number is indeed a prime number,
        if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", currentMaxPrimeNumber]] boolValue]){
          // If the minimum and maximum prime numbers are permutations of each other,
          if([self number:currentMinPrimeNumber isAPermutationOfNumber:currentMaxPrimeNumber]){
            // If the validated sequence is NOT the one described in the question
            // text,
            if((currentMinPrimeNumber != 1487) && (currentMiddlePrimeNumber != 4817) && (currentMaxPrimeNumber != 8147)){
              // Set the concatenated number to be the three prime numbers found,
              // in increasing order.
              concatenatedPrimeNumbers = [NSString stringWithFormat:@"%d%d%d", currentMinPrimeNumber, currentMiddlePrimeNumber, currentMaxPrimeNumber];
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
    }
    // If we have found the prime numbers,
    if(concatenatedPrimeNumbers != nil){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the concatenated prime numbers
  self.answer = concatenatedPrimeNumbers;
  
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