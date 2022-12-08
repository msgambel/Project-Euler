//  Question57.m

#import "Question57.h"
#import "BigInt.h"

@implementation Question57

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"21 November 2003";
  self.hint = @"Expand d_{i+1} and n_{i+1} in terms of d_i and n_i.";
  self.link = @"http://mathworld.wolfram.com/RecursiveSequence.html";
  self.text = @"It is possible to show that the square root of two can be expressed as an infinite continued fraction.\n\n2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...\n\nBy expanding this for the first four iterations, we get:\n\n1 + 1/2 = 3/2 = 1.5\n1 + 1/(2 + 1/2) = 7/5 = 1.4\n1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...\n1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...\n\nThe next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.\n\nIn the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?";
  self.isFun = YES;
  self.title = @"Square root convergents";
  self.answer = @"153";
  self.number = @"57";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"square,root,continued,fractions,infinite,expansions,numerator,denominator,one,thousand,1000,more,digits,how,many";
  self.solveTime = @"60";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.commentCount = @"24";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.isContestMath = YES;
  self.startedOnDate = @"26/02/13";
  self.trickRequired = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"26/02/13";
  self.solutionLineCount = @"17";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = YES;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"3.14e-04";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"4.97";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note the relationship:
  //
  // n_{i+1}           1                1         d_i + n_i        d_i        2 * d_i + n_i
  // ------- = 1 + --------- = 1 + ----------- = ----------- + ----------- = ---------------
  // d_{i+1}            n_i         d_i + n_i     d_i + n_i     d_i + n_i       d_i + n_i
  //                1 + ---         ---------
  //                    d_i            d_i
  //
  // Therefore,
  //
  // d_{i+1} = d_i + n_i
  //
  // n_{i+1} = 2 * d_i + n_i = d_i + d_{i+1}
  //
  // With this identity, we can easily compute the numerators and denominators
  // in order to figure out which numerators have more digits than the denominators.
  //
  // When the numerator and denominator have too many digits, we remove the
  // units digit. This loses a bit of accuracy, but will still be accurate
  // enough to arrive at the required result.
  
  // Variable to hold how many iterations we need.
  uint numberOfIterations = 1000;
  
  // Variable to hold the number of numerators with more digits than the denominators.
  uint numberOfNumeratorsWithMoreDigitsThanDenominator = 0;
  
  // Variable to hold the current numerator while iterating.
  long long int numerator = 3;
  
  // Variable to hold the current denominator while iterating.
  long long int denominator = 2;
  
  // Variable to hold the temporary numerator when computing the numerator while
  // iterating.
  long long int temporaryNumerator = 0;
  
  // Variable to hold the temporary denominator when computing the denominator
  // while iterating.
  long long int temporaryDenominator = 0;
  
  // For all the iterations required (start at 1, as we already did the first by
  // default),
  for(int index = 1; index < numberOfIterations; index++){
    // Compute the current denominator.
    temporaryDenominator = denominator + numerator;
    
    // Compute the current numerator.
    temporaryNumerator = denominator + temporaryDenominator;
    
    // Set the current numerator.
    numerator = temporaryNumerator;
    
    // Set the current denominator.
    denominator = temporaryDenominator;
    
    // If the numerators length as a string is longer than the denominators,
    if([self flooredLog:((double)numerator) withBase:10.0] > [self flooredLog:((double)denominator) withBase:10.0]){
      // Increment the number of numerators with more digits than the denominators
      // by 1.
      numberOfNumeratorsWithMoreDigitsThanDenominator++;
    }
    // If the number of digits in the numerator is greater than 15,
    if([self flooredLog:((double)numerator) withBase:10.0] > 15){
      // Remove the units digit from the numerator.
      numerator /= 10;
      
      // Remove the units digit from the denominator.
      denominator /= 10;
    }
  }
  // Set the answer string to the sum of all the numbers equal to their digit factorials.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNumeratorsWithMoreDigitsThanDenominator];
  
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
  
  // Note: This is the basically the same algorithm as the optimal one. The only
  //       difference is that we store the value of the numerator and denominator
  //       in a BigInt object, instead of removing the extra digits.
  
  // Here, we note the relationship:
  //
  // n_{i+1}           1                1         d_i + n_i        d_i        2 * d_i + n_i
  // ------- = 1 + --------- = 1 + ----------- = ----------- + ----------- = ---------------
  // d_{i+1}            n_i         d_i + n_i     d_i + n_i     d_i + n_i       d_i + n_i
  //                1 + ---         ---------
  //                    d_i            d_i
  //
  // Therefore,
  //
  // d_{i+1} = d_i + n_i
  //
  // n_{i+1} = 2 * d_i + n_i = d_i + d_{i+1}
  //
  // With this identity, we can easily compute the numerators and denominators
  // in order to figure out which numerators have more digits than the denominators.
  
  // Variable to hold how many iterations we need.
  uint numberOfIterations = 1000;
  
  // Variable to hold the number of numerators with more digits than the denominators.
  uint numberOfNumeratorsWithMoreDigitsThanDenominator = 0;
  
  // Variable to hold the current numerator while iterating.
  BigInt * numerator = [BigInt createFromInt:3];
  
  // Variable to hold the current denominator while iterating.
  BigInt * denominator = [BigInt createFromInt:2];
  
  // Variable to hold the temporary numerator when computing the numerator while
  // iterating.
  BigInt * temporaryNumerator = nil;
  
  // Variable to hold the temporary denominator when computing the denominator
  // while iterating.
  BigInt * temporaryDenominator = nil;
  
  // For all the iterations required (start at 1, as we already did the first by
  // default),
  for(int index = 1; index < numberOfIterations; index++){
    // Compute the current denominator.
    temporaryDenominator = [denominator add:numerator];
    
    // Compute the current numerator.
    temporaryNumerator = [denominator add:temporaryDenominator];
    
    // Set the current numerator.
    numerator = temporaryNumerator;
    
    // Set the current denominator.
    denominator = temporaryDenominator;
    
    // If the numerators length as a string is longer than the denominators,
    if([numerator toStringWithRadix:10].length > [denominator toStringWithRadix:10].length){
      // Increment the number of numerators with more digits than the denominators
      // by 1.
      numberOfNumeratorsWithMoreDigitsThanDenominator++;
    }
  }
  // Set the answer string to the sum of all the numbers equal to their digit factorials.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNumeratorsWithMoreDigitsThanDenominator];
  
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