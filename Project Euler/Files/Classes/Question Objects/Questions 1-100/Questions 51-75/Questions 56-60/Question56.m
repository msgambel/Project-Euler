//  Question56.m

#import "Question56.h"
#import "BigInt.h"

@implementation Question56

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"07 November 2003";
  self.hint = @"Ignore powers of 10, and b <= 90.";
  self.text = @"A googol (10^100) is a massive number: one followed by one-hundred zeros; 100^100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.\n\nConsidering natural numbers of the form, a^b, where a, b <= 100, what is the maximum digital sum?";
  self.isFun = YES;
  self.title = @"Powerful digit sum";
  self.answer = @"972";
  self.number = @"56";
  self.rating = @"3";
  self.category = @"Combinations";
  self.keywords = @"powers,powerful,digital,sum,maximum,massive,natural,numbers,googol,considering,form";
  self.solveTime = @"30";
  self.difficulty = @"Easy";
  self.isChallenging = NO;
  self.completedOnDate = @"25/02/13";
  self.solutionLineCount = @"17";
  self.estimatedComputationTime = @"0.858";
  self.estimatedBruteForceComputationTime = @"9.41";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a BigInt data model to handle the multiplication. Then
  // we return the result as a string, and use a helper method to add up the
  // digits.
  //
  // We ignore checking the digit sum unless the power is above 90, as anything
  // lower would most likely not have as high of a digit sum.
  //
  // We also ignore multiples of 10, as they will not produce a high enough
  // digit sum.
  
  // Variable to hold the current digit sum.
  uint currentDigitSum = 0;
  
  // Variable to hold the maximum digit sum.
  uint maximumDigitSum = 0;
  
  // Variable to hold the current base.
  BigInt * base = nil;
  
  // Variable to hold the result number of the multiplication.
  BigInt * resultNumber = nil;
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // For all the bases from 2 to 100,
  for(int a = 2; a <= 100; a++){
    // If a is not a multiple of 10,
    if((a % 10) != 0){
      // Grab the current base.
      base = [BigInt createFromInt:a];
      
      // Reset the result of the base to the power to 1.
      resultNumber = [BigInt createFromInt:1];
      
      // For all the powers from 2 to 100,
      for(int b = 2; b <= 100; b++){
        // Multiple the current base^power by the base again to get the current
        // base^power.
        temporaryNumber = [resultNumber multiply:base];
        
        // Set the result number to be the result of the above computation.
        resultNumber = temporaryNumber;
        
        // If the power is greater than 90,
        if(b > 95){
          // Compute the digit sum of the current base^power.
          currentDigitSum = [self digitSumOfNumber:[resultNumber toStringWithRadix:10]];
          
          // If the current digit sum is greater than the maximum found digit sum,
          if(currentDigitSum > maximumDigitSum){
            // Set the maximum digit sum to the current digit sum.
            maximumDigitSum = currentDigitSum;
          }
        }
      }
    }
  }
  // Set the answer string to the maximum digit sum.
  self.answer = [NSString stringWithFormat:@"%d", maximumDigitSum];
  
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
  //       difference is amount of numbers we check.
  
  // Here, we simply use a BigInt data model to handle the multiplication. Then
  // we return the result as a string, and use a helper method to add up the
  // digits.
  
  // Variable to hold the current digit sum.
  uint currentDigitSum = 0;
  
  // Variable to hold the maximum digit sum.
  uint maximumDigitSum = 0;
  
  // Variable to hold the current base.
  BigInt * base = nil;
  
  // Variable to hold the result number of the multiplication.
  BigInt * resultNumber = nil;
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // For all the bases from 2 to 100,
  for(int a = 2; a <= 100; a++){
    // Grab the current base.
    base = [BigInt createFromInt:a];
    
    // Reset the result of the base to the power to 1.
    resultNumber = [BigInt createFromInt:1];
    
    // For all the powers from 2 to 100,
    for(int b = 2; b <= 100; b++){
      // Multiple the current base^power by the base again to get the current
      // base^power.
      temporaryNumber = [resultNumber multiply:base];
      
      // Set the result number to be the result of the above computation.
      resultNumber = temporaryNumber;
      
      // Compute the digit sum of the current base^power.
      currentDigitSum = [self digitSumOfNumber:[resultNumber toStringWithRadix:10]];
      
      // If the current digit sum is greater than the maximum found digit sum,
      if(currentDigitSum > maximumDigitSum){
        // Set the maximum digit sum to the current digit sum.
        maximumDigitSum = currentDigitSum;
      }
    }
  }
  // Set the answer string to the maximum digit sum.
  self.answer = [NSString stringWithFormat:@"%d", maximumDigitSum];
  
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