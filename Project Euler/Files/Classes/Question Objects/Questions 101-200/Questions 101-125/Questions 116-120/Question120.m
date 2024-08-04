//  Question120.m

#import "Question120.h"

@implementation Question120

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"21 April 2006";
  self.hint = @"Just use modular arithmetic to compute rmax.";
  self.link = @"https://en.wikipedia.org/wiki/Modular_arithmetic";
  self.text = @"Let r be the remainder when (a-1)^n + (a+1)^n is divided by a^2.\n\nFor example, if a = 7 and n = 3, then r = 42: 63 + 83 = 728 = 42 mod 49. And as n varies, so too will r, but for a = 7 it turns out that rmax = 42.\n\nFor 3 <= a <= 1000, find sum(rmax).";
  self.isFun = YES;
  self.title = @"Square remainders";
  self.answer = @"333082500";
  self.number = @"120";
  self.rating = @"5";
  self.category = @"Sums";
  self.isUseful = YES;
  self.keywords = @"square,remainders,modulo,polynomial,expansion,rmax,sum";
  self.loadsFile = NO;
  self.solveTime = @"60";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"16";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"12/04/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"12/04/13";
  self.solutionLineCount = @"9";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.9e-05";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.9e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply note the following:
  //
  // 1) (a+1)^n = na + 1 mod a².
  //
  // 2) (a-1)^n = na - 1 mod a² if n is odd.
  //
  // 3) (a-1)^n = 1 - na mod a² if n is even.
  //
  // Therefore, using 1) and 2), and 1) and 3), the sums are:
  //
  // 4) (a+1)^n + (a-1)^n = na + 1 + na - 1 mod a² = 2na mod a² if n is odd.
  //
  // 5) (a+1)^n + (a-1)^n = na + 1 + 1 - na mod a² = 2 mod a² if n is even.
  //
  // Therefore, rmax will only occur if n is odd. Finally, using 4), we have:
  //
  // 6) 4) => (a+1)^n + (a-1)^n = 2n mod a if n is odd.
  //
  // Therefore, if we write a as a = 2m + 1 (a odd), or a = 2(m+1) (a even), we
  // have:
  //
  // 7) rmax = 2 * m * a.
  //
  // So all we need to do is sum all the rmax for the given numbers.
  
  // Variable to hold the maximum number we need to check.
  uint maxSize = 1000;
  
  // Variable to hold the minimum number we need to check.
  uint minSize = 3;
  
  // Variable to hold the sum of the rmax's.
  uint sumRMax = 0;
  
  // For all the numbers from the minimum number to maximum number,
  for(int number = minSize; number <= maxSize; number++){
    // If the number is even,
    if((number % 2) == 0){
      // Add the rmax of the number to the sum.
      sumRMax += (2 * ((number / 2) - 1) * number);
    }
    // If the number is odd,
    else{
      // Add the rmax of the number to the sum.
      sumRMax += (2 * ((number - 1) / 2) * number);
    }
  }
  // Set the answer string to the sum of the rmax's.
  self.answer = [NSString stringWithFormat:@"%d", sumRMax];
  
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
  // 1) (a+1)^n = na + 1 mod a².
  //
  // 2) (a-1)^n = na - 1 mod a² if n is odd.
  //
  // 3) (a-1)^n = 1 - na mod a² if n is even.
  //
  // Therefore, using 1) and 2), and 1) and 3), the sums are:
  //
  // 4) (a+1)^n + (a-1)^n = na + 1 + na - 1 mod a² = 2na mod a² if n is odd.
  //
  // 5) (a+1)^n + (a-1)^n = na + 1 + 1 - na mod a² = 2 mod a² if n is even.
  //
  // Therefore, rmax will only occur if n is odd. Finally, using 4), we have:
  //
  // 6) 4) => (a+1)^n + (a-1)^n = 2n mod a if n is odd.
  //
  // Therefore, if we write a as a = 2m + 1 (a odd), or a = 2(m+1) (a even), we
  // have:
  //
  // 7) rmax = 2 * m * a.
  //
  // So all we need to do is sum all the rmax for the given numbers.
  
  // Variable to hold the maximum number we need to check.
  uint maxSize = 1000;
  
  // Variable to hold the minimum number we need to check.
  uint minSize = 3;
  
  // Variable to hold the sum of the rmax's.
  uint sumRMax = 0;
  
  // For all the numbers from the minimum number to maximum number,
  for(int number = minSize; number <= maxSize; number++){
    // If the number is even,
    if((number % 2) == 0){
      // Add the rmax of the number to the sum.
      sumRMax += (2 * ((number / 2) - 1) * number);
    }
    // If the number is odd,
    else{
      // Add the rmax of the number to the sum.
      sumRMax += (2 * ((number - 1) / 2) * number);
    }
  }
  // Set the answer string to the sum of the rmax's.
  self.answer = [NSString stringWithFormat:@"%d", sumRMax];
  
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