//  Question123.m

#import "Question123.h"

@implementation Question123

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"16 June 2006";
  self.hint = @"Just use modular arithmetic!";
  self.link = @"https://en.wikipedia.org/wiki/Modular_arithmetic";
  self.text = @"Let p_n be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when (p_n-1)^n + (p_n+1)^n is divided by p_n².\n\nFor example, when n = 3, p_3 = 5, and 4^3 + 6^3 = 280 = 5 mod 25.\n\nThe least value of n for which the remainder first exceeds 10^9 is 7037.\n\nFind the least value of n for which the remainder first exceeds 10^10.";
  self.isFun = YES;
  self.title = @"Prime square remainders";
  self.answer = @"21035";
  self.number = @"123";
  self.rating = @"5";
  self.summary = @"Find the first n such that (p_n-1)^n + (p_n+1)^n mod p_n² > 10^10.";
  self.category = @"Primes";
  self.isUseful = YES;
  self.keywords = @"prime,square,remainders,modulo,polynomial,expansion,least";
  self.loadsFile = NO;
  self.memorable = NO;
  self.solveTime = @"90";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"18";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"13/04/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"13/04/13";
  self.solutionLineCount = @"45";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"1.59e-02";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.59e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply note the following:
  //
  // 1) (p_n+1)^n = np_n + 1 mod p_n².
  //
  // 2) (p_n-1)^n = np_n - 1 mod p_n² if n is odd.
  //
  // 3) (p_n-1)^n = 1 - np_n mod p_n² if n is even.
  //
  // Therefore, using 1) and 2), and 1) and 3), the sums are:
  //
  // 4) (p_n+1)^n + (p_n-1)^n = np_n + 1 + np_n - 1 mod p_n² = 2np_n mod p_n² if n is odd.
  //
  // 5) (p_n+1)^n + (p_n-1)^n = np_n + 1 + 1 - np_n mod p_n² = 2 mod p_n² if n is even.
  //
  // Therefore, r will only occur if n is odd. Finally, using 4), we have:
  //
  // 6) 4) => (p_n+1)^n + (p_n-1)^n = 2n mod p_n if n is odd.
  //
  // Therefore,
  //
  // 7) r = 2 * n * p_n.
  //
  // So all we need to do is find a list of primes, and then find when r is less
  // then the minimum remainder!
  
  // Variable to hold the minimum remainder.
  long long int minRemainder = 10000000000;
  
  // Variable to hold the last prime index of the primes array. It must be odd,
  // as the even powers will not generate a large enough remainder. This number
  // was chosen as it is sufficient, but would need to be larger if a larger
  // remainder was required.
  long long int lastPrimeIndex = 21501;
  
  // Variable to hold the current remainder for a given prime and index. We set
  // it to the minimum remainder in order to make sure the while loop starts!
  long long int currentRemainder = minRemainder;
  
  // Array to hold the list of primes up to the last primes index.
  NSArray * primes = [self arrayOfPrimeNumbersOfSize:(uint)lastPrimeIndex];
  
  // Variable to hold the prime at the current index.
  NSNumber * currentPrime = nil;
  
  // Decrement the last prime index by 1, as the primes array is 0 indexed, but
  // we are assuming that the primes are 1 indexed array in the question text.
  lastPrimeIndex--;
  
  // While the current remainder is greater than or equal to the minimum
  // remainder,
  while(currentRemainder >= minRemainder){
    // Decrement the last primes index by 2, as we are only interested in odd
    // indices.
    lastPrimeIndex -= 2;
    
    // Grab the prime at the current index.
    currentPrime = [primes objectAtIndex:lastPrimeIndex];
    
    // Compute the current remainder. Again, we add 1 to the last primes index
    // as we are using a 1 indexed array in the question text.
    currentRemainder = 2 * [currentPrime longLongValue] * (lastPrimeIndex + 1);
  }
  // Set the answer string to the last primes index. We add 2 to the index as it
  // would have been subtracted off in the while loop (we are interested in the
  // first prime greater than the minimum remainder, not the largest prime with
  // a smaller remainder!), and we also add 1 to the index, as we again want to
  // move from a 0 indexed array to a 1 indexed array.
  self.answer = [NSString stringWithFormat:@"%llu", (lastPrimeIndex + 3)];
  
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
  
  // Here, we simply note the following:
  //
  // 1) (p_n+1)^n = np_n + 1 mod p_n².
  //
  // 2) (p_n-1)^n = np_n - 1 mod p_n² if n is odd.
  //
  // 3) (p_n-1)^n = 1 - np_n mod p_n² if n is even.
  //
  // Therefore, using 1) and 2), and 1) and 3), the sums are:
  //
  // 4) (p_n+1)^n + (p_n-1)^n = np_n + 1 + np_n - 1 mod p_n² = 2np_n mod p_n² if n is odd.
  //
  // 5) (p_n+1)^n + (p_n-1)^n = np_n + 1 + 1 - np_n mod p_n² = 2 mod p_n² if n is even.
  //
  // Therefore, r will only occur if n is odd. Finally, using 4), we have:
  //
  // 6) 4) => (p_n+1)^n + (p_n-1)^n = 2n mod p_n if n is odd.
  //
  // Therefore,
  //
  // 7) r = 2 * n * p_n.
  //
  // So all we need to do is find a list of primes, and then find when r is less
  // then the minimum remainder!
  
  // Variable to hold the minimum remainder.
  long long int minRemainder = 10000000000;
  
  // Variable to hold the last prime index of the primes array. It must be odd,
  // as the even powers will not generate a large enough remainder. This number
  // was chosen as it is sufficient, but would need to be larger if a larger
  // remainder was required.
  long long int lastPrimeIndex = 21501;
  
  // Variable to hold the current remainder for a given prime and index. We set
  // it to the minimum remainder in order to make sure the while loop starts!
  long long int currentRemainder = minRemainder;
  
  // Array to hold the list of primes up to the last primes index.
  NSArray * primes = [self arrayOfPrimeNumbersOfSize:(uint)lastPrimeIndex];
  
  // Variable to hold the prime at the current index.
  NSNumber * currentPrime = nil;
  
  // Decrement the last prime index by 1, as the primes array is 0 indexed, but
  // we are assuming that the primes are 1 indexed array in the question text.
  lastPrimeIndex--;
  
  // While the current remainder is greater than or equal to the minimum
  // remainder,
  while(currentRemainder >= minRemainder){
    // Decrement the last primes index by 2, as we are only interested in odd
    // indices.
    lastPrimeIndex -= 2;
    
    // Grab the prime at the current index.
    currentPrime = [primes objectAtIndex:lastPrimeIndex];
    
    // Compute the current remainder. Again, we add 1 to the last primes index
    // as we are using a 1 indexed array in the question text.
    currentRemainder = 2 * [currentPrime longLongValue] * (lastPrimeIndex + 1);
  }
  // Set the answer string to the last primes index. We add 2 to the index as it
  // would have been subtracted off in the while loop (we are interested in the
  // first prime greater than the minimum remainder, not the largest prime with
  // a smaller remainder!), and we also add 1 to the index, as we again want to
  // move from a 0 indexed array to a 1 indexed array.
  self.answer = [NSString stringWithFormat:@"%llu", (lastPrimeIndex + 3)];
  
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