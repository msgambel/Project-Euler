//  Question34.m

#import "Question34.h"

@interface Question34 (Private)

- (BOOL)isNumberEqualToItsDigitFactorials:(uint)aNumber;

@end

@implementation Question34

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"03 January 2003";
  self.text = @"145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.\n\nFind the sum of all numbers which are equal to the sum of the factorial of their digits.\n\nNote: as 1! = 1 and 2! = 2 are not sums they are not included.";
  self.title = @"Digit factorials";
  self.answer = @"40730";
  self.number = @"Problem 34";
  self.estimatedComputationTime = @"7.71e-03";
  self.estimatedBruteForceComputationTime = @"7.71e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we use a helper method to determine if the number is equal to its
  // digit factorials or not. If it is, we add it to the sum!
  //
  // The only numbers we have to check are the numbers starting from 10, up to
  // about 50,000. The reason is that even 8! is equal 40,320, so having 5 8's
  // in the number would only yield 201,600, and would give a very narrow margin
  // of other digits in the number. This is confirmed by making the numbers to
  // check up to 10,000,000, which is indeed an upper limit, as:
  //
  // 9! * 7 = 2,540,160 < 9,999,999.
  //
  // It turns out that there are only 2 numbers that have this property:
  //
  // 1: 145   2: 40,585
  
  // Variable to hold the sum of all the numbers equal to their digit factorials.
  uint sum = 0;
  
  // For all the numbers that can possibly be equal to their digit factorials,
  for(int number = 11; number < 50000; number++){
    // If the number is equal to its digit factorials,
    if([self isNumberEqualToItsDigitFactorials:number]){
      // Add the number to the sum of all the numbers equal to their digit factorials.
      sum += number;
    }
  }
  // Set the answer string to the sum of all the numbers equal to their digit factorials.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
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
  
  // Here, we use a helper method to determine if the number is equal to its
  // digit factorials or not. If it is, we add it to the sum!
  //
  // The only numbers we have to check are the numbers starting from 10, up to
  // about 50,000. The reason is that even 8! is equal 40,320, so having 5 8's
  // in the number would only yield 201,600, and would give a very narrow margin
  // of other digits in the number. This is confirmed by making the numbers to
  // check up to 10,000,000, which is indeed an upper limit, as:
  //
  // 9! * 7 = 2,540,160 < 9,999,999.
  //
  // It turns out that there are only 2 numbers that have this property:
  //
  // 1: 145   2: 40,585
  
  // Variable to hold the sum of all the numbers equal to their digit factorials.
  uint sum = 0;
  
  // For all the numbers that can possibly be equal to their digit factorials,
  for(int number = 10; number < 50000; number++){
    // If the number is equal to its digit factorials,
    if([self isNumberEqualToItsDigitFactorials:number]){
      // Add the number to the sum of all the numbers equal to their digit factorials.
      sum += number;
    }
  }
  // Set the answer string to the sum of all the numbers equal to their digit factorials.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question34 (Private)

- (BOOL)isNumberEqualToItsDigitFactorials:(uint)aNumber; {
  // Constant array to hold the value of the factorials from 0 to 9.
  const uint factorialValues[10] = {1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880};
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable to hold the sum of the factorials of the digits.
  uint digitFactorialSum = 0;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // Add the factorial of the current digit to the sum.
    digitFactorialSum += factorialValues[digit];
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is equal to its digit factorial sum of not.
  return (aNumber == digitFactorialSum);
}

@end