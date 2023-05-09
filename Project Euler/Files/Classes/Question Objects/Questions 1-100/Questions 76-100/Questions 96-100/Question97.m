//  Question97.m

#import "Question97.h"
#import "BigInt.h"

@implementation Question97

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"10 June 2005";
  self.hint = @"BigInt classes are your friend!";
  self.link = @"https://docs.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql";
  self.text = @"The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form 2^6972593-1; it contains exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form 2^p-1, have been found which contain more digits.\n\nHowever, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 28433x2^7830457+1.\n\nFind the last ten digits of this prime number.";
  self.isFun = YES;
  self.title = @"Large non-Mersenne prime";
  self.answer = @"8739992577";
  self.number = @"97";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"large,prime,non,mersenne,last,digits,big,int,one,million,1000000,ten,10,mod,radix";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = YES;
  self.commentCount = @"19";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"07/04/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"07/04/13";
  self.solutionLineCount = @"11";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"1.45e-03";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.45e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use our BigInt class to compute the last 10 digits.
  
  // Variable to hold the modulo for the last ten digits of the prime number.
  BigInt * mod = [BigInt createFromString:@"10000000000" andRadix:10];
  
  // Variable to hold the base for the computation of the prime number.
  BigInt * base = [BigInt createFromInt:2];
  
  // Temporary variable for the computations of the prime number.
  BigInt * temp = nil;
  
  // Variable to hold the power for the computation of the prime number.
  BigInt * power = [BigInt createFromInt:7830457];
  
  // Variable to hold the addition for the computation of the prime number.
  BigInt * addition = [BigInt createFromInt:1];
  
  // Variable to hold the multiple for the computation of the prime number.
  BigInt * multiple = [BigInt createFromInt:28433];
  
  // Variable to hold the last ten digits of the prime number.
  BigInt * lastDigits = nil;
  
  // Compute 2^7830457.
  temp = [base modPow:power withMod:mod];
  
  // Multiply 28433x2^7830457
  lastDigits = [temp multiply:multiple];
  
  // Add 28433x2^7830457+1
  temp = [lastDigits add:addition];
  
  // Get the last ten digits of the number.
  lastDigits = [temp mod:mod];
  
  // Set the answer string to the last ten digits of the prime number.
  self.answer = [lastDigits toStringWithRadix:10];
  
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
  
  // Here, we simply use our BigInt class to compute the last 10 digits.
  
  // Variable to hold the modulo for the last ten digits of the prime number.
  BigInt * mod = [BigInt createFromString:@"10000000000" andRadix:10];
  
  // Variable to hold the base for the computation of the prime number.
  BigInt * base = [BigInt createFromInt:2];
  
  // Temporary variable for the computations of the prime number.
  BigInt * temp = nil;
  
  // Variable to hold the power for the computation of the prime number.
  BigInt * power = [BigInt createFromInt:7830457];
  
  // Variable to hold the addition for the computation of the prime number.
  BigInt * addition = [BigInt createFromInt:1];
  
  // Variable to hold the multiple for the computation of the prime number.
  BigInt * multiple = [BigInt createFromInt:28433];
  
  // Variable to hold the last ten digits of the prime number.
  BigInt * lastDigits = nil;
  
  // Compute 2^7830457.
  temp = [base modPow:power withMod:mod];
  
  // Multiply 28433x2^7830457
  lastDigits = [temp multiply:multiple];
  
  // Add 28433x2^7830457+1
  temp = [lastDigits add:addition];
  
  // Get the last ten digits of the number.
  lastDigits = [temp mod:mod];
  
  // Set the answer string to the last ten digits of the prime number.
  self.answer = [lastDigits toStringWithRadix:10];
  
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