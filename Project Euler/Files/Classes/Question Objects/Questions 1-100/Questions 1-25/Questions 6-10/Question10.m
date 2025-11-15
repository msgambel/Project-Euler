//  Question10.m

#import "Question10.h"

@implementation Question10

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"08 February 2002";
  self.hint = @"Sieve of \"insert name here\". (long long int)'s should suffice for the sum.";
  self.link = @"https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes";
  self.text = @"The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.\n\nFind the sum of all the primes below two million.";
  self.isFun = YES;
  self.title = @"Summation of primes";
  self.answer = @"142913828922";
  self.number = @"10";
  self.rating = @"3";
  self.summary = @"Find the primes up to 2,000,000, and sum them.";
  self.category = @"Primes";
  self.isUseful = YES;
  self.keywords = @"primes,summation,below,less,than,two,million,2000000,find,of,array,long,int";
  self.loadsFile = NO;
  self.memorable = YES;
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.isIntuitive = YES;
  self.recommended = YES;
  self.commentCount = @"14";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"10/01/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"10/01/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"31";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.solutionWorksInGeneral = YES;
  self.estimatedComputationTime = @"1.4";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.4";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to grab the array of prime numbers less
  // than 2,000,000, and sum them!
  
  // Set the sum to 0 before we start iterating over all the prime numbers.
  long long int sum = 0;
  
  // Set the max size for the prime numbers.
  uint maxSize = 2000000;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the prime numbers up to the max size,
    for(NSNumber * number in primeNumbersArray){
      // Add the prime number to the sum. Note: The maximum size that this sum
      // can be is bounded above by
      //
      // (2,000,000)*(2,000,001) / 2 = 2,000,001,000,000
      //
      // which is within the size limits of long long int.
      sum += [number intValue];
    }
    // Set the answer string to the sum.
    self.answer = [NSString stringWithFormat:@"%llu", sum];
    
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
  
  // This algorithm is the same as the above! First quesiton this has happened!
  
  // Here, we simply use a helper method to grab the array of prime numbers less
  // than 2,000,000, and sum them!
  
  // Set the sum to 0 before we start iterating over all the prime numbers.
  long long int sum = 0;
  
  // Set the max size for the prime numbers.
  uint maxSize = 2000000;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the prime numbers up to the max size,
    for(NSNumber * number in primeNumbersArray){
      // Add the prime number to the sum. Note: The maximum size that this sum
      // can be is bounded above by
      //
      // (2,000,000)*(2,000,001) / 2 = 2,000,001,000,000
      //
      // which is within the size limits of long long int.
      sum += [number intValue];
    }
    // Set the answer string to the sum.
    self.answer = [NSString stringWithFormat:@"%llu", sum];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated brute force computation time to the calculated value. We
    // use scientific notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end