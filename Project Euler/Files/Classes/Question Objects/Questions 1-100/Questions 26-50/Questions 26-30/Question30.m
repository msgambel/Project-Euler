//  Question30.m

#import "Question30.h"

@interface Question30 (Private)

- (uint)sumOfFifthPowerOfDigitsOfNumber:(uint)aNumber;

@end

@implementation Question30

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"08 November 2002";
  self.hint = @"Only look up to 200,000, as 8^5 * 6 = 196608 != 888,888.";
  self.link = @"https://en.wikipedia.org/wiki/Digit_sum";
  self.text = @"Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:\n\n1634 = 1^4 + 6^4 + 3^4 + 4^4\n8208 = 8^4 + 2^4 + 0^4 + 8^4\n9474 = 9^4 + 4^4 + 7^4 + 4^4\n\nAs 1 = 1^4 is not a sum it is not included.\n\nThe sum of these numbers is 1634 + 8208 + 9474 = 19316.\n\nFind the sum of all the numbers that can be written as the sum of fifth powers of their digits.";
  self.isFun = YES;
  self.title = @"Digit fifth powers";
  self.answer = @"443839";
  self.number = @"30";
  self.rating = @"3";
  self.category = @"Sums";
  self.isUseful = NO;
  self.keywords = @"sum,powers,digits,fourth,fifth,written,total,200000,two,hundred,thousand,5,five";
  self.loadsFile = NO;
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = NO;
  self.commentCount = @"12";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"30/01/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"30/01/13";
  self.solutionLineCount = @"13";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"5.17e-02";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"5.17e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply loop through all of the number up to 200,000, and use a
  // helper method to see if the number is equal to the sum of the fifth power
  // of its digits. We only have to look up to 200,000, as:
  //
  // 9^5 * 6 = 354,294 != 999,999, and 8^5 * 6 = 196608 != 888,888.
  //
  // And 9^5 is the largest you can add to the sum. It is also confirmed by
  // replacing the 200,000 with 500,000.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // For all the numbers less than 200,000,
  for(int number = 10; number < 200000; number++){
    // If the number is equal to the sum of the fifth powers of the digits,
    if(number == [self sumOfFifthPowerOfDigitsOfNumber:number]){
      // Add the number to the sum.
      sum += number;
    }
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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
  
  // Here, we simply loop through all of the number up to 200,000, and use a
  // helper method to see if the number is equal to the sum of the fifth power
  // of its digits. We only have to look up to 200,000, as:
  //
  // 9^5 * 6 = 354,294 != 999,999, and 8^5 * 6 = 196608 != 888,888.
  //
  // And 9^5 is the largest you can add to the sum. It is also confirmed by
  // replacing the 200,000 with 500,000.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // For all the numbers less than 200,000,
  for(int number = 10; number < 200000; number++){
    // If the number is equal to the sum of the fifth powers of the digits,
    if(number == [self sumOfFifthPowerOfDigitsOfNumber:number]){
      // Add the number to the sum.
      sum += number;
    }
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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

#pragma mark - Private Methods

@implementation Question30 (Private)

- (uint)sumOfFifthPowerOfDigitsOfNumber:(uint)aNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((uint)(aNumber / powerOf10)) % 10);
    
    // Add the fifth power of the digit to the sum.
    sum += ((uint)pow(digit, 5));
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return the sum.
  return sum;
}

@end