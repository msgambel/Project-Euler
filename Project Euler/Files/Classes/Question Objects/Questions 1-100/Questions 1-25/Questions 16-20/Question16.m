//  Question16.m

#import "Question16.h"
#import "BigInt.h"

@implementation Question16

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"03 May 2002";
  self.hint = @"Implement a BitInt class to hold the multiplication, then sum the digits.";
  self.link = @"https://docs.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql";
  self.text = @"2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.\n\nWhat is the sum of the digits of the number 2^1000?";
  self.isFun = YES;
  self.title = @"Power digit sum";
  self.answer = @"1366";
  self.number = @"16";
  self.rating = @"3";
  self.category = @"Sums";
  self.keywords = @"sum,power,digits,big,int,2,two,1000,one,thousand,to,the,of,multiplication,string,helper,method";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.commentCount = @"15";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"16/01/13";
  self.completedOnDate = @"16/01/13";
  self.solutionLineCount = @"7";
  self.usesCustomObjects = YES;
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"3.05e-03";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"3.05e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just use a BigInt data model to handle the multiplication. Then we
  // return the result as a string, and use a helper method to add up the digits.
  
  // Variable to hold the value we will continually multiply with. We start at
  // 1024 = 2^10 to reduce the number of multiplications.
  BigInt * baseNumber = [BigInt createFromInt:1024];
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // Since we want to compute 2^1000, we simply multiply 2^10 100 times as:
  //
  // (2^10)^100 = 2^1000
  
  // While looping 100 time,
  for(int i = 0; i < 100; i++){
    // Store the multiplication of the base number 2^10 and the result number in
    // a temporary variable.
    temporaryNumber = [baseNumber multiply:resultNumber];
    
    // Set the result number to be the result of the above multiplication.
    resultNumber = temporaryNumber;
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
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
  
  // Here, we just use a BigInt data model to handle the multiplication. Then we
  // return the result as a string, and use a helper method to add up the digits.
  
  // Variable to hold the value we will continually multiply with. We start at
  // 1024 = 2^10 to reduce the number of multiplications.
  BigInt * baseNumber = [BigInt createFromInt:1024];
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // Since we want to compute 2^1000, we simply multiply 2^10 100 times as:
  //
  // (2^10)^100 = 2^1000
  
  // While looping 100 times,
  for(int i = 0; i < 100; i++){
    // Store the multiplication of the base number 2^10 and the result number in
    // a temporary variable.
    temporaryNumber = [baseNumber multiply:resultNumber];
    
    // Set the result number to be the result of the above computation.
    resultNumber = temporaryNumber;
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
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