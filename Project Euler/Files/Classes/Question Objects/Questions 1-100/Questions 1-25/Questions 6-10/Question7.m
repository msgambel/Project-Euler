//  Question7.m

#import "Question7.h"

@implementation Question7

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"28 December 2001";
  self.hint = @"Sieve of \"insert name here\".";
  self.link = @"https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes";
  self.text = @"By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.\n\nWhat is the 10 001st prime number?";
  self.isFun = YES;
  self.title = @"10001st prime";
  self.answer = @"104743";
  self.number = @"7";
  self.rating = @"5";
  self.category = @"Primes";
  self.isUseful = YES;
  self.keywords = @"prime,listing,10001st,one,thousand,and,find,number,first,helper,method";
  self.loadsFile = NO;
  self.solveTime = @"90";
  self.technique = @"Math";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.commentCount = @"10";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"07/01/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"07/01/13";
  self.solutionLineCount = @"41";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"7.35e-03";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"4.03e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to find the first 10,001 prime numbers,
  // and then grab the last value. Simple.
  
  // Variable to hold the desired count of the primes array.
  uint primesArrayCount = 10001;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersOfSize:primesArrayCount];
  
  // Set the answer string to the value of the last prime number in the array.
  self.answer = [NSString stringWithFormat:@"%d", [[primeNumbersArray lastObject] intValue]];
  
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
  
  // In the brute force computation, we simply use the sieve of Eratosthenes to
  // compute all the primes.
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [[NSMutableArray alloc] init];
  
  // Add in the first prime, 2, to the prime array.
  [primeNumbersArray addObject:[NSNumber numberWithInt:2]];
  
  // BOOL variable to mark if a current number is prime.
  BOOL isPrime = NO;
  
  // Variable to hold the current number of primes added. We already added in 2!
  uint currentCount = 1;
  
  // Variable to hold the desired count of the primes array.
  uint primesArrayCount = 10001;
  
  // By expanding out the Taylor Series of the result of the Prime Number Theorem,
  //
  // TT (n) ~ n / ln(n),
  //
  // We arrive at the fact that the nth prime is about size:
  //
  // n * ln(n) - n * ln(ln(n)) + O(n * ln(ln(ln(n))))
  //
  // Therefore, if we add a fairly large constant factor of 1.2 to the first term,
  // we should be able to get a fairly accurate upper limit of it's size.
  
  // Compute the limit based on the end size of the array (i.e.: The number of
  // primes in the array).
  uint maxNumber = (uint)(1.2 * primesArrayCount * log(primesArrayCount));
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the square root of the current number, used to minimize computations.
  uint sqrtOfCurrentNumber = 0;
  
  // Loop through all the prime numbers already found. No need to check the even
  // numbers, as they are always divisible by 2, and are therefore no prime. Since
  // we start at 3, incrementing by 2 will mean that currentNumber is always odd.
  for(int currentNumber = 3; currentNumber < maxNumber; currentNumber += 2){
    // Reset the marker to see if the current number is prime.
    isPrime = YES;
    
    // Compute the square root of the current number.
    sqrtOfCurrentNumber = (int)sqrtf(currentNumber);
    
    // Loop through all the prime numbers already found.
    for(NSNumber * number in primeNumbersArray){
      // Grab the current prime number.
      currentPrimeNumber = [number intValue];
      
      // If the current prime number is less than the square root of the current number,
      if(currentPrimeNumber <= sqrtOfCurrentNumber){
        // If the current prime number divides our current number,
        if((currentNumber % currentPrimeNumber) == 0){
          // The current number is not prime, so exit the loop.
          isPrime = NO;
          break;
        }
      }
      else{
        // Since the number is bigger than the square root of the current number,
        // exit the loop.
        break;
      }
    }
    // If the current number was marked as a prime number,
    if(isPrime){
      // Add the number to the array of prime numbers.
      [primeNumbersArray addObject:[NSNumber numberWithInt:currentNumber]];
      
      // Increase the current count of the primes by 1.
      currentCount++;
      
      // If the current count equals the requested number of primes,
      if(currentCount == primesArrayCount){
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the value of the last prime number in the array.
  self.answer = [NSString stringWithFormat:@"%d", [[primeNumbersArray lastObject] intValue]];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end