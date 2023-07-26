//  Question63.m

#import "Question63.h"

@implementation Question63

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"13 February 2004";
  self.hint = @"The log function is your friend!";
  self.link = @"https://en.wikipedia.org/wiki/Logarithm";
  self.text = @"The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.\n\nHow many n-digit positive integers exist which are also an nth power?";
  self.isFun = NO;
  self.title = @"Powerful digit counts";
  self.answer = @"49";
  self.number = @"63";
  self.rating = @"4";
  self.category = @"Counting";
  self.isUseful = NO;
  self.keywords = @"powers,digits,count,fifth,nine,9,exist,positive,integers,number,nth,bases,exponents";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.commentCount = @"23";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"04/03/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"04/03/13";
  self.solutionLineCount = @"17";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.8e-05";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.8e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute the base^power, take the log of the number, and
  // check to see if the values are equal. If they are, increment the number of
  // nth power numbers by 1.
  //
  // We note that the possible bases these number can have are 1 to 9, as:
  //
  // log(10^n) = n+1 != n.
  //
  // Also, if we take out the 1 power (as log(x^1) = 1 if 1 <= x <= 9), we can
  // start the sum at 9.
  //
  // Once a base^power has less digits than the power, no higher powers will,
  // as all of the bases are less than 10.
  //
  // Finally, if the number of digits of the number gets too large, we remove
  // the units digit (by dividing by 10) and keep track of the number of times
  // we have removed the units digit to make sure we get the same power.
  
  // Variable to hold the removed power if the number of digits gets too large.
  uint removedDigits = 0;
  
  // Variable to hold the number of nth powers numbers.
  uint numberOfNthPowersNumbers = 9;
  
  // Variable to hold the current result of the current base to the current power.
  long long int result = 0;
  
  // For all the possible bases 2 to 9,
  for(long long int base = 2; base <= 9; base++){
    // Set the result to the base^1.
    result = base;
    
    // Reset the number of removed digits to 0.
    removedDigits = 0;
    
    // For all the number of digits that could lead to nth power numbers,
    for(int numOfDigits = 1; numOfDigits < 25; numOfDigits++){
      // Multiply the result by the current base.
      result *= base;
      
      // If the number of digits is greater than 17 (the result is a long long int),
      if(numOfDigits > 17){
        // Remove the units digit of the result.
        result /= 10;
        
        // Increment the number of digits removed by 1.
        removedDigits++;
      }
      // If the number of digits is equal to the power,
      if([self flooredLog:((double)result) withBase:10] == (numOfDigits - removedDigits)){
        // Increment the number of nth power numbers by 1.
        numberOfNthPowersNumbers++;
      }
      // If the number of digits is NOT equal to the power,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the number of nth powers numbers.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNthPowersNumbers];
  
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
  
  // Here, we simply compute the base^power, take the log of the number, and
  // check to see if the values are equal. If they are, increment the number of
  // nth power numbers by 1.
  //
  // We note that the possible bases these number can have are 1 to 9, as:
  //
  // log(10^n) = n+1 != n.
  //
  // Also, if we take out the 1 power (as log(x^1) = 1 if 1 <= x <= 9), we can
  // start the sum at 9.
  //
  // Once a base^power has less digits than the power, no higher powers will,
  // as all of the bases are less than 10.
  //
  // Finally, if the number of digits of the number gets too large, we remove
  // the units digit (by dividing by 10) and keep track of the number of times
  // we have removed the units digit to make sure we get the same power.
  
  // Variable to hold the removed power if the number of digits gets too large.
  uint removedDigits = 0;
  
  // Variable to hold the number of nth powers numbers.
  uint numberOfNthPowersNumbers = 9;
  
  // Variable to hold the current result of the current base to the current power.
  long long int result = 0;
  
  // For all the possible bases 2 to 9,
  for(long long int base = 2; base <= 9; base++){
    // Set the result to the base^1.
    result = base;
    
    // Reset the number of removed digits to 0.
    removedDigits = 0;
    
    // For all the number of digits that could lead to nth power numbers,
    for(int numOfDigits = 1; numOfDigits < 25; numOfDigits++){
      // Multiply the result by the current base.
      result *= base;
      
      // If the number of digits is greater than 17 (the result is a long long int),
      if(numOfDigits > 17){
        // Remove the units digit of the result.
        result /= 10;
        
        // Increment the number of digits removed by 1.
        removedDigits++;
      }
      // If the number of digits is equal to the power,
      if([self flooredLog:((double)result) withBase:10] == (numOfDigits - removedDigits)){
        // Increment the number of nth power numbers by 1.
        numberOfNthPowersNumbers++;
      }
      // If the number of digits is NOT equal to the power,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the number of nth powers numbers.
  self.answer = [NSString stringWithFormat:@"%d", numberOfNthPowersNumbers];
  
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