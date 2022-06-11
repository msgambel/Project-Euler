//  Question112.m

#import "Question112.h"

@interface Question112 (Private)

- (BOOL)isBouncy:(uint)aNumber;
- (BOOL)isDecreasing:(uint)aNumber;
- (BOOL)isIncreasing:(uint)aNumber;

@end

@implementation Question112

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"30 December 2005";
  self.hint = @"Iterate through each digit to see if the number is bouncy or not!";
  self.link = @"https://en.wikipedia.org/wiki/For_loop";
  self.text = @"Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.\n\nSimilarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.\n\nWe shall call a positive integer that is neither increasing nor decreasing a \"bouncy\" number; for example, 155349.\n\nClearly there cannot be any bouncy numbers below one-hundred, but just over half of the numbers below one-thousand (525) are bouncy. In fact, the least number for which the proportion of bouncy numbers first reaches 50% is 538.\n\nSurprisingly, bouncy numbers become more and more common and by the time we reach 21780 the proportion of bouncy numbers is equal to 90%.\n\nFind the least number for which the proportion of bouncy numbers is exactly 99%.";
  self.isFun = YES;
  self.title = @"Bouncy numbers";
  self.answer = @"1587000";
  self.number = @"112";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"bouncy,numbers,digits,increasing,decreasing,99,ninety,nine,percent";
  self.solveTime = @"600";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.commentCount = @"15";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"11/04/13";
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"11/04/13";
  self.solutionLineCount = @"37";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.289";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.289";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to tell if a number is Bouncy or NOT.
  // Then, we iterate in a while loop until we get the desired ratio. Very easy!
  
  // Veriable to hold the number of numbers checked. The first 100 numbers are
  // NOT Bouncy, given to us in the question text.
  uint numberOfNumbers = 100;
  
  // Variable to hold the numerator of the required percentage.
  uint requiredPercentage = 99;
  
  // Variable to hold the number of bouncy numbers found.
  uint numberOfBouncyNumbers = 0;
  
  // While the number of Bouncy numbers isn't at the required ratio,
  while((numberOfBouncyNumbers * 100) != (numberOfNumbers * requiredPercentage)){
    // Increment the number of numbers checked by 1.
    numberOfNumbers++;
    
    // If the number is Bouncy,
    if([self isBouncy:numberOfNumbers]){
      // Increment the number of bouncy numbers by 1.
      numberOfBouncyNumbers++;
    }
  }
  // Set the answer string to the smallest number with the required proportion
  // of bouncy numbers.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNumbers];
  
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
  
  // Here, we simply use a helper method to tell if a number is Bouncy or NOT.
  // Then, we iterate in a while loop until we get the desired ratio. Very easy!
  
  // Veriable to hold the number of numbers checked. The first 100 numbers are
  // NOT Bouncy, given to us in the question text.
  uint numberOfNumbers = 100;
  
  // Variable to hold the numerator of the required percentage.
  uint requiredPercentage = 99;
  
  // Variable to hold the number of bouncy numbers found.
  uint numberOfBouncyNumbers = 0;
  
  // While the number of Bouncy numbers isn't at the required ratio,
  while((numberOfBouncyNumbers * 100) != (numberOfNumbers * requiredPercentage)){
    // Increment the number of numbers checked by 1.
    numberOfNumbers++;
    
    // If the number is Bouncy,
    if([self isBouncy:numberOfNumbers]){
      // Increment the number of bouncy numbers by 1.
      numberOfBouncyNumbers++;
    }
  }
  // Set the answer string to the smallest number with the required proportion
  // of bouncy numbers.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNumbers];
  
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

#pragma mark - Private Methods

@implementation Question112 (Private)

- (BOOL)isBouncy:(uint)aNumber; {
  // Return if the number is NOT increasing or decreasing.
  return (![self isDecreasing:aNumber] && ![self isIncreasing:aNumber]);
}

- (BOOL)isDecreasing:(uint)aNumber; {
  // Variable to hold if the number is decreasing or not.
  BOOL numberIsDecreasing = YES;
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable to hold the digit to the left of the one we are looking at.
  uint digitToTheLeft = 0;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // If the digit is NOT greater than or equal to the digit to it's left,
    if(digit < digitToTheLeft){
      // Set that the number is NOT decreasing.
      numberIsDecreasing = NO;
      
      // Break out of the loop.
      break;
    }
    // Set the next digit to the left as the current digit.
    digitToTheLeft = digit;
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is decreasing or not.
  return numberIsDecreasing;
}

- (BOOL)isIncreasing:(uint)aNumber; {
  // Variable to hold if the number is increasing or not.
  BOOL numberIsIncreasing = YES;
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable to hold the digit to the left of the one we are looking at.
  uint digitToTheLeft = 9;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // If the digit is NOT less than or equal to the digit to it's left,
    if(digit > digitToTheLeft){
      // Set that the number is NOT increasing.
      numberIsIncreasing = NO;
      
      // Break out of the loop.
      break;
    }
    // Set the next digit to the left as the current digit.
    digitToTheLeft = digit;
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is increasing or not.
  return numberIsIncreasing;
}

@end