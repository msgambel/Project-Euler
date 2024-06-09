//  Question46.m

#import "Question46.h"

@implementation Question46

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"20 June 2003";
  self.hint = @"Check if (n - p) / 2 is a square for all primes p < n.";
  self.link = @"https://en.wikipedia.org/wiki/Goldbach%27s_conjecture";
  self.text = @"It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.\n\n9 = 7 + 2x1²\n15 = 7 + 2x2²\n21 = 3 + 2x3²\n25 = 7 + 2x3²\n27 = 19 + 2x2²\n33 = 31 + 2x1²\n\nIt turns out that the conjecture was false.\n\nWhat is the smallest odd composite that cannot be written as the sum of a prime and twice a square?";
  self.isFun = YES;
  self.title = @"Goldbach's other conjecture";
  self.answer = @"5777";
  self.number = @"46";
  self.rating = @"5";
  self.category = @"Primes";
  self.isUseful = YES;
  self.keywords = @"christian,goldbach's,other,conjecture,prime,square,sum,twice,odd,composite,number,false,smallest";
  self.loadsFile = NO;
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"32";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.isContestMath = YES;
  self.startedOnDate = @"15/02/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"15/02/13";
  self.solutionLineCount = @"71";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = YES;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.27e-02";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.27e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply get an array of prime numbers up to a max size, and store
  // which values are prime in a Hash Table. Then, we iterate through all the
  // odd numbers, first checking if the number is prime or not. If it is
  // composite, we compute:
  //
  //                   n - p
  // potentialSquare = -----
  //                     2
  //
  // for all primes p < n. Then using a helper method, we check if the potential
  // square is a perfect square or not. If it is, we break out of the loop, and
  // check the next odd composite. If we loop through all the primes p < n, and
  // none of the potential squares are perfect squares, we have found the
  // smallest odd composite that cannot be written as the sum of a prime and
  // twice a square.
  
  // Variable to hld if the potential square is a perfect square or not.
  BOOL isASquare = NO;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 10000;
  
  // Variable to hold the potential square.
  uint potentialSquare = 0;
  
  // Variable to hold the current prime number.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the smallest odd composite that cannot be written as the
  // sum of a prime and twice a square.
  uint smallestOddComposite = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the odd numbers,
  for(int number = 3; number < maxSize; number += 2){
    // If the number is NOT prime (using the Hash Table), and is therefore
    // composite,
    if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", number]] boolValue] == NO){
      // Mark that this number will NOT generate a perfect square.
      isASquare = NO;
      
      // For all the prime numbers found,
      for(NSNumber * primeNumber in primeNumbersArray){
        // Grab the current prime number.
        currentPrimeNumber = [primeNumber intValue];
        
        // If the current prime number is greater than the current composite
        // number,
        if(currentPrimeNumber > number){
          // Break out of the loop.
          break;
        }
        // If the current prime number is less than the current composite
        // number,
        else{
          // Compute the potential square.
          potentialSquare = ((number - currentPrimeNumber) / 2);
          
          // If the potential square is a perfect square,
          if([self isNumberAPerfectSquare:potentialSquare]){
            // This number can be written as the sum of a prime and twice a
            // square, so mark it as such.
            isASquare = YES;
            
            // Break out of the loop.
            break;
          }
        }
      }
      // If the number cannot be written as the sum of a prime and twice a
      // square,
      if(isASquare == NO){
        // Store the current number.
        smallestOddComposite = number;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the smallest odd composite that cannot be written
  // as the sum of a prime and twice a square.
  self.answer = [NSString stringWithFormat:@"%d", smallestOddComposite];
  
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
  
  // Here, we simply get an array of prime numbers up to a max size, and store
  // which values are prime in a Hash Table. Then, we iterate through all the
  // odd numbers, first checking if the number is prime or not. If it is
  // composite, we compute:
  //
  //                   n - p
  // potentialSquare = -----
  //                     2
  //
  // for all primes p < n. Then using a helper method, we check if the potential
  // square is a perfect square or not. If it is, we break out of the loop, and
  // check the next odd composite. If we loop through all the primes p < n, and
  // none of the potential squares are perfect squares, we have found the
  // smallest odd composite that cannot be written as the sum of a prime and
  // twice a square.
  
  // Variable to hld if the potential square is a perfect square or not.
  BOOL isASquare = NO;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 10000;
  
  // Variable to hold the potential square.
  uint potentialSquare = 0;
  
  // Variable to hold the current prime number.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the smallest odd composite that cannot be written as the
  // sum of a prime and twice a square.
  uint smallestOddComposite = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the odd numbers,
  for(int number = 3; number < maxSize; number += 2){
    // If the number is NOT prime (using the Hash Table), and is therefore
    // composite,
    if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", number]] boolValue] == NO){
      // Mark that this number will NOT generate a perfect square.
      isASquare = NO;
      
      // For all the prime numbers found,
      for(NSNumber * primeNumber in primeNumbersArray){
        // Grab the current prime number.
        currentPrimeNumber = [primeNumber intValue];
        
        // If the current prime number is greater than the current composite
        // number,
        if(currentPrimeNumber > number){
          // Break out of the loop.
          break;
        }
        // If the current prime number is less than the current composite
        // number,
        else{
          // Compute the potential square.
          potentialSquare = ((number - currentPrimeNumber) / 2);
          
          // If the potential square is a perfect square,
          if([self isNumberAPerfectSquare:potentialSquare]){
            // This number can be written as the sum of a prime and twice a
            // square, so mark it as such.
            isASquare = YES;
            
            // Break out of the loop.
            break;
          }
        }
      }
      // If the number cannot be written as the sum of a prime and twice a
      // square,
      if(isASquare == NO){
        // Store the current number.
        smallestOddComposite = number;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the smallest odd composite that cannot be written
  // as the sum of a prime and twice a square.
  self.answer = [NSString stringWithFormat:@"%d", smallestOddComposite];
  
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