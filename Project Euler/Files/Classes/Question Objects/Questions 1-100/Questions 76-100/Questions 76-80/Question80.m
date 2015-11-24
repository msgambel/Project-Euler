//  Question80.m

#import "Question80.h"
#import "BigInt.h"

@implementation Question80

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"08 October 2004";
  self.hint = @"Use a BigInt class, and note that sqrt(200) = 10 * sqrt(2).";
  self.text = @"It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.\n\nThe square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.\n\nFor the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.";
  self.isFun = YES;
  self.title = @"Square root digital expansion";
  self.answer = @"40886";
  self.number = @"80";
  self.rating = @"4";
  self.keywords = @"irrational,square,root,digital,expansion,sums,natural,number,infinite,total,digits";
  self.difficulty = @"Easy";
  self.solutionLineCount = @"15";
  self.estimatedComputationTime = @"0.5";
  self.estimatedBruteForceComputationTime = @"0.5";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use our BigInt class to perform the square root of all the
  // non-perfect square numbers from 1 to 100. Since the BigInt class is integer
  // values only, we use a simple trick. Notice that:
  //
  // sqrt(200) = sqrt(2) * 10
  //
  // Therefore, if we multiply the numbers by 100^100, when we take the square
  // root of the result, we will arrive at the first 100 decimal digits of the
  // number!
  
  // Variable to hold the total digit sum of all the non-perfect squares first
  // 100 digits.
  uint totalDigitSum = 0;
  
  // Variable to hold the required number of decimal digits for each non-perfect
  // sqaure number.
  uint requiredNumberOfDigits = 100;
  
  // Variable to hold the required number of numbers we need to sum their
  // decimal digits.
  uint requiredNumberOfNumbers = 100;
  
  // Variable to hold the square root of the current non-perfect square number.
  BigInt * squareRoot = nil;
  
  // Variable to thold the power of 10 we need to generate the number of decimal
  // digits required for each non-perfect sqaure number.
  BigInt * powerOf10 = [BigInt createFromInt:1];
  
  // For all the numbers from 1 to the required number of digits for each
  // non-perfect square number.
  for(int i = 1; i < requiredNumberOfDigits; i++){
    // Multiply the power of 10 by 100. Recall that when we take the square root
    // of the current non-perfect square number, the 100 -> 10, which represents
    // 1 digit.
    powerOf10 = [powerOf10 multiply:[BigInt createFromInt:100]];
  }
  // For all the numbers from 1 to the required number of numbers,
  for(int number = 1; number <= requiredNumberOfNumbers; number++){
    // If the number is NOT a perfect square,
    if([self isNumberAPerfectSquare:number] == NO){
      // Compute the square root of the current number times 100^100.
      squareRoot = [[[BigInt createFromInt:number] multiply:powerOf10] sqrt];
      
      // Use the helper method to compute the digit sum of the sqaure root.
      totalDigitSum += [self digitSumOfNumber:[squareRoot toStringWithRadix:10]];
    }
  }
  // Set the answer string to the total digit sum of all the non-perfect sqaures
  // first 100 digits.
  self.answer = [NSString stringWithFormat:@"%d", totalDigitSum];
  
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
  
  // Here, we simply use our BigInt class to perform the square root of all the
  // non-perfect square numbers from 1 to 100. Since the BigInt class is integer
  // values only, we use a simple trick. Notice that:
  //
  // sqrt(200) = sqrt(2) * 10
  //
  // Therefore, if we multiply the numbers by 100^100, when we take the square
  // root of the result, we will arrive at the first 100 decimal digits of the
  // number!
  
  // Variable to hold the total digit sum of all the non-perfect squares first
  // 100 digits.
  uint totalDigitSum = 0;
  
  // Variable to hold the required number of decimal digits for each non-perfect
  // sqaure number.
  uint requiredNumberOfDigits = 100;
  
  // Variable to hold the required number of numbers we need to sum their
  // decimal digits.
  uint requiredNumberOfNumbers = 100;
  
  // Variable to hold the square root of the current non-perfect square number.
  BigInt * squareRoot = nil;
  
  // Variable to thold the power of 10 we need to generate the number of decimal
  // digits required for each non-perfect sqaure number.
  BigInt * powerOf10 = [BigInt createFromInt:1];
  
  // For all the numbers from 1 to the required number of digits for each
  // non-perfect square number.
  for(int i = 1; i < requiredNumberOfDigits; i++){
    // Multiply the power of 10 by 100. Recall that when we take the square root
    // of the current non-perfect square number, the 100 -> 10, which represents
    // 1 digit.
    powerOf10 = [powerOf10 multiply:[BigInt createFromInt:100]];
  }
  // For all the numbers from 1 to the required number of numbers,
  for(int number = 1; number <= requiredNumberOfNumbers; number++){
    // If the number is NOT a perfect square,
    if([self isNumberAPerfectSquare:number] == NO){
      // Compute the square root of the current number times 100^100.
      squareRoot = [[[BigInt createFromInt:number] multiply:powerOf10] sqrt];
      
      // Use the helper method to compute the digit sum of the sqaure root.
      totalDigitSum += [self digitSumOfNumber:[squareRoot toStringWithRadix:10]];
    }
  }
  // Set the answer string to the total digit sum of all the non-perfect sqaures
  // first 100 digits.
  self.answer = [NSString stringWithFormat:@"%d", totalDigitSum];
  
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