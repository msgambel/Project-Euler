//  Question87.m

#import "Question87.h"

@implementation Question87

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"21 January 2005";
  self.hint = @"Compute all the sums, and remove the copies!";
  self.text = @"The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28. In fact, there are exactly four numbers below fifty that can be expressed in such a way:\n\n28 = 2² + 2³ + 2⁴\n33 = 3² + 2³ + 2⁴\n49 = 5² + 2³ + 2⁴\n47 = 2² + 3³ + 2⁴\n\nHow many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?";
  self.isFun = YES;
  self.title = @"Prime power triples";
  self.answer = @"1097343";
  self.number = @"87";
  self.rating = @"4";
  self.keywords = @"prime,square,cube,fourth,power,sum,count,triples,count,50000000,fifty,million,below,expressed,numbers";
  self.solveTime = @"300";
  self.difficulty = @"Medium";
  self.solutionLineCount = @"67";
  self.estimatedComputationTime = @"1.49";
  self.estimatedBruteForceComputationTime = @"1.49";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute the sum of all the prime squares, cubes, and fourth
  // powers up to the maximum size, and store them in an array. We then remove
  // all the copies, and store the count. Simple as that!
  
  // Variable to hold the maximum number the sum can achieve.
  uint maxNumber = 50000000;
  
  // Variable to hold the third power of the current prime.
  uint currentThirdPower = 0;
  
  // Variable to hold the fourth power of the current prime.
  uint currentFourthPower = 0;
  
  // Variable to hold the sum of the square, third, and fourth power of the
  // current primes.
  uint currentSumOfPrimePowers = 0;
  
  // Variable to hold the number of numbers that can be expressed as the sum of
  // a square, third, and fourth power of primes.
  uint numberExpressedAsSumOfPowers = 0;
  
  // Variable array to hold all of the numbers that can be expressed as the sum
  // of a square, third, and fourth power of primes.
  NSMutableArray * sumOfPrimePowersNumbers = [[NSMutableArray alloc] init];
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:((uint)sqrt((double)maxNumber))];
  
  // For all the prime numbers in the prime numbers array,
  for(uint primeIndexSquared = 0; primeIndexSquared < [primeNumbersArray count]; primeIndexSquared++){
    // Compute the square of the first prime number, and set it as the start of
    // the sum.
    currentSumOfPrimePowers = [[primeNumbersArray objectAtIndex:primeIndexSquared] intValue] * [[primeNumbersArray objectAtIndex:primeIndexSquared] intValue];
    
    // For all the prime numbers in the prime numbers array,
    for(uint primeIndexCubed = 0; primeIndexCubed < [primeNumbersArray count]; primeIndexCubed++){
      // Compute the cube of the second prime number.
      currentThirdPower = ([[primeNumbersArray objectAtIndex:primeIndexCubed] intValue] * [[primeNumbersArray objectAtIndex:primeIndexCubed] intValue] * [[primeNumbersArray objectAtIndex:primeIndexCubed] intValue]);
      
      // Add the cubed prime number to the sum.
      currentSumOfPrimePowers += currentThirdPower;
      
      // If the current sum of prime numbers is greater than the maximum number
      // the sum can be,
      if(currentSumOfPrimePowers > maxNumber){
        // Break out of the loop.
        break;
      }
      // For all the prime numbers in the prime numbers array,
      for(uint primeIndexFourth = 0; primeIndexFourth < [primeNumbersArray count]; primeIndexFourth++){
        // Compute the fourth power of the third prime number.
        currentFourthPower = ([[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue]);
        
        // Add the fourth power of the prime number to the sum.
        currentSumOfPrimePowers += currentFourthPower;
        
        // If the current sum of prime numbers is greater than the maximum number
        // the sum can be,
        if(currentSumOfPrimePowers > maxNumber){
          // Subtract of the current prime to the fourth power so we can add the
          // next fourth power prime later.
          currentSumOfPrimePowers -= currentFourthPower;
          
          // Break out of the loop.
          break;
        }
        // Add the sum of the square, third, and fourth power of the current
        // prime numbers to the array.
        [sumOfPrimePowersNumbers addObject:[NSNumber numberWithInt:currentSumOfPrimePowers]];
        
        // Subtract of the current prime to the fourth power so we can add the
        // next fourth power prime later.
        currentSumOfPrimePowers -= currentFourthPower;
        
        // If we are no longer computing,
        if(!_isComputing){
          // Break out of the loop.
          break;
        }
      }
      // Subtract of the current prime to the third power so we can add the
      // next third power prime later.
      currentSumOfPrimePowers -= currentThirdPower;
      
      // If we are no longer computing,
      if(!_isComputing){
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
    // Create an NSSet to get rid of all the copies in the array, and store the
    // count of the resulting NSSet.
    numberExpressedAsSumOfPowers = (uint)[[NSSet setWithArray:sumOfPrimePowersNumbers] count];
    
    // Set the answer string to the maximum pandigital number.
    self.answer = [NSString stringWithFormat:@"%d", numberExpressedAsSumOfPowers];
    
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
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we simply compute the sum of all the prime squares, cubes, and fourth
  // powers up to the maximum size, and store them in an array. We then remove
  // all the copies, and store the count. Simple as that!
  
  // Variable to hold the maximum number the sum can achieve.
  uint maxNumber = 50000000;
  
  // Variable to hold the third power of the current prime.
  uint currentThirdPower = 0;
  
  // Variable to hold the fourth power of the current prime.
  uint currentFourthPower = 0;
  
  // Variable to hold the sum of the square, third, and fourth power of the
  // current primes.
  uint currentSumOfPrimePowers = 0;
  
  // Variable to hold the number of numbers that can be expressed as the sum of
  // a square, third, and fourth power of primes.
  uint numberExpressedAsSumOfPowers = 0;
  
  // Variable array to hold all of the numbers that can be expressed as the sum
  // of a square, third, and fourth power of primes.
  NSMutableArray * sumOfPrimePowersNumbers = [[NSMutableArray alloc] init];
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:((uint)sqrt((double)maxNumber))];
  
  // For all the prime numbers in the prime numbers array,
  for(uint primeIndexSquared = 0; primeIndexSquared < [primeNumbersArray count]; primeIndexSquared++){
    // Compute the square of the first prime number, and set it as the start of
    // the sum.
    currentSumOfPrimePowers = [[primeNumbersArray objectAtIndex:primeIndexSquared] intValue] * [[primeNumbersArray objectAtIndex:primeIndexSquared] intValue];
    
    // For all the prime numbers in the prime numbers array,
    for(uint primeIndexCubed = 0; primeIndexCubed < [primeNumbersArray count]; primeIndexCubed++){
      // Compute the cube of the second prime number.
      currentThirdPower = ([[primeNumbersArray objectAtIndex:primeIndexCubed] intValue] * [[primeNumbersArray objectAtIndex:primeIndexCubed] intValue] * [[primeNumbersArray objectAtIndex:primeIndexCubed] intValue]);
      
      // Add the cubed prime number to the sum.
      currentSumOfPrimePowers += currentThirdPower;
      
      // If the current sum of prime numbers is greater than the maximum number
      // the sum can be,
      if(currentSumOfPrimePowers > maxNumber){
        // Break out of the loop.
        break;
      }
      // For all the prime numbers in the prime numbers array,
      for(uint primeIndexFourth = 0; primeIndexFourth < [primeNumbersArray count]; primeIndexFourth++){
        // Compute the fourth power of the third prime number.
        currentFourthPower = ([[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue] * [[primeNumbersArray objectAtIndex:primeIndexFourth] intValue]);
        
        // Add the fourth power of the prime number to the sum.
        currentSumOfPrimePowers += currentFourthPower;
        
        // If the current sum of prime numbers is greater than the maximum number
        // the sum can be,
        if(currentSumOfPrimePowers > maxNumber){
          // Subtract of the current prime to the fourth power so we can add the
          // next fourth power prime later.
          currentSumOfPrimePowers -= currentFourthPower;
          
          // Break out of the loop.
          break;
        }
        // Add the sum of the square, third, and fourth power of the current
        // prime numbers to the array.
        [sumOfPrimePowersNumbers addObject:[NSNumber numberWithInt:currentSumOfPrimePowers]];
        
        // Subtract of the current prime to the fourth power so we can add the
        // next fourth power prime later.
        currentSumOfPrimePowers -= currentFourthPower;
        
        // If we are no longer computing,
        if(!_isComputing){
          // Break out of the loop.
          break;
        }
      }
      // Subtract of the current prime to the third power so we can add the
      // next third power prime later.
      currentSumOfPrimePowers -= currentThirdPower;
      
      // If we are no longer computing,
      if(!_isComputing){
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
    // Create an NSSet to get rid of all the copies in the array, and store the
    // count of the resulting NSSet.
    numberExpressedAsSumOfPowers = (uint)[[NSSet setWithArray:sumOfPrimePowersNumbers] count];
    
    // Set the answer string to the maximum pandigital number.
    self.answer = [NSString stringWithFormat:@"%d", numberExpressedAsSumOfPowers];
    
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