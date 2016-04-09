//  Question187.m

#import "Question187.h"

@implementation Question187

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"22 March 2008";
  self.hint = @"Get a list of primes to create the required semiprimes!";
  self.text = @"A composite is a number containing at least two prime factors. For example, 15 = 3 * 5; 9 = 3 * 3; 12 = 2 * 2 * 3.\n\nThere are ten composites below thirty containing precisely two, not necessarily distinct, prime factors: 4, 6, 9, 10, 14, 15, 21, 22, 25, 26.\nHow many composite integers, n < 10^8, have precisely two, not necessarily distinct, prime factors?";
  self.isFun = YES;
  self.title = @"Semiprimes";
  self.answer = @"17427258";
  self.number = @"187";
  self.rating = @"4";
  self.keywords = @"semiprimes,two,2,prime,factors,composites,distinct";
  self.solveTime = @"30";
  self.difficulty = @"Easy";
  self.solutionLineCount = @"65";
  self.estimatedComputationTime = @"91.5";
  self.estimatedBruteForceComputationTime = @"91.5";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply grab all the prime number up to half the maximum size, and
  // then multiply them in pairs until the semi-prime is larger than the maximum
  // size. It's slow, but it works!
  
  // Variable to hold the maximum size.
  uint maximumSize = 100000000;
  
  // Variable to hold the first prime factor of the current semi-prime.
  uint primeNumber1 = 0;
  
  // Variable to hold the second prime factor of the current semi-prime.
  uint primeNumber2 = 0;
  
  // Variable to hold the total number of semi-primes less than the maximum size.
  uint totalSemiPrimes = 0;
  
  // Variable to hold the current semi-prime.
  uint currentSemiPrime = 0;
  
  // Array to hold all the prime numbers found.
  NSArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:(maximumSize / 2)];
  
  // For all the prime numbers in the prime numbers array,
  for(uint primeNumberIndex1 = 0; primeNumberIndex1 < [primeNumbersArray count]; primeNumberIndex1++){
    // Grab the first prime factor of the current semi-prime.
    primeNumber1 = [[primeNumbersArray objectAtIndex:primeNumberIndex1] intValue];
    
    // Compute the current semi-prime.
    currentSemiPrime = primeNumber1 * primeNumber1;
    
    // If the current semi-prime is greater than the maximum size,
    if(currentSemiPrime > maximumSize){
      // Break out of the loop.
      break;
    }
    // If the current semi-prime is less than or equal to the maximum size,
    else{
      // Increment the total number of semi-primes by 1.
      totalSemiPrimes++;
    }
    // For all the prime numbers in the prime numbers array, starting from the
    // prime immediately after the first prime factor of the semi-prime,
    for(uint primeNumberIndex2 = (primeNumberIndex1 + 1); primeNumberIndex2 < [primeNumbersArray count]; primeNumberIndex2++){
      // Grab the second prime factor of the current semi-prime.
      primeNumber2 = [[primeNumbersArray objectAtIndex:primeNumberIndex2] intValue];
      
      // Compute the current semi-prime.
      currentSemiPrime = primeNumber1 * primeNumber2;
      
      // If the current semi-prime is greater than the maximum size,
      if(currentSemiPrime > maximumSize){
        // Break out of the loop.
        break;
      }
      // If the current semi-prime is less than or equal to the maximum size,
      else{
        // Increment the total number of semi-primes by 1.
        totalSemiPrimes++;
      }
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
    // Set the answer string to the total number of semi-primes less than the
    // maximum size.
    self.answer = [NSString stringWithFormat:@"%d", totalSemiPrimes];
    
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
  
  // Here, we simply grab all the prime number up to half the maximum size, and
  // then multiply them in pairs until the semi-prime is larger than the maximum
  // size. It's slow, but it works!
  
  // Variable to hold the maximum size.
  uint maximumSize = 100000000;
  
  // Variable to hold the first prime factor of the current semi-prime.
  uint primeNumber1 = 0;
  
  // Variable to hold the second prime factor of the current semi-prime.
  uint primeNumber2 = 0;
  
  // Variable to hold the total number of semi-primes less than the maximum size.
  uint totalSemiPrimes = 0;
  
  // Variable to hold the current semi-prime.
  uint currentSemiPrime = 0;
  
  // Array to hold all the prime numbers found.
  NSArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:(maximumSize / 2)];
  
  // For all the prime numbers in the prime numbers array,
  for(uint primeNumberIndex1 = 0; primeNumberIndex1 < [primeNumbersArray count]; primeNumberIndex1++){
    // Grab the first prime factor of the current semi-prime.
    primeNumber1 = [[primeNumbersArray objectAtIndex:primeNumberIndex1] intValue];
    
    // Compute the current semi-prime.
    currentSemiPrime = primeNumber1 * primeNumber1;
    
    // If the current semi-prime is greater than the maximum size,
    if(currentSemiPrime > maximumSize){
      // Break out of the loop.
      break;
    }
    // If the current semi-prime is less than or equal to the maximum size,
    else{
      // Increment the total number of semi-primes by 1.
      totalSemiPrimes++;
    }
    // For all the prime numbers in the prime numbers array, starting from the
    // prime immediately after the first prime factor of the semi-prime,
    for(uint primeNumberIndex2 = (primeNumberIndex1 + 1); primeNumberIndex2 < [primeNumbersArray count]; primeNumberIndex2++){
      // Grab the second prime factor of the current semi-prime.
      primeNumber2 = [[primeNumbersArray objectAtIndex:primeNumberIndex2] intValue];
      
      // Compute the current semi-prime.
      currentSemiPrime = primeNumber1 * primeNumber2;
      
      // If the current semi-prime is greater than the maximum size,
      if(currentSemiPrime > maximumSize){
        // Break out of the loop.
        break;
      }
      // If the current semi-prime is less than or equal to the maximum size,
      else{
        // Increment the total number of semi-primes by 1.
        totalSemiPrimes++;
      }
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
    // Set the answer string to the total number of semi-primes less than the
    // maximum size.
    self.answer = [NSString stringWithFormat:@"%d", totalSemiPrimes];
    
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