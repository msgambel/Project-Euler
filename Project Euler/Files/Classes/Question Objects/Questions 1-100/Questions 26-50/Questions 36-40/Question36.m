//  Question36.m

#import "Question36.h"

@interface Question36 (Private)

- (NSString *)base2StringOfNumber:(uint)aNumber;

@end

@implementation Question36

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"31 January 2003";
  self.text = @"The decimal number, 585 = 1001001001_{2} (binary), is palindromic in both bases.\n\nFind the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.\n\n(Please note that the palindromic number, in either base, may not include leading zeros.)";
  self.title = @"Double-base palindromes";
  self.answer = @"872187";
  self.number = @"Problem 36";
  self.estimatedComputationTime = @"7.61e-02";
  self.estimatedBruteForceComputationTime = @"6.11";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we construct all of the palindromes up to 1,000,000, and then check
  // if the base 2 form is also a palindrome. If it is, we add the number to the sum.
  
  // Variable to hold the sum of all the numbers equal to their digit factorials.
  uint sum = 0;
  
  // Variable to hold the current palindrome.
  uint currentNumber = 0;
  
  // Variable to hold the current number in base 2 as a string.
  NSString * currentBase2Number = nil;
  
  // For all the 1 digit and 2 digit palindromes,
  for(int i = 1; i < 10; i++){
    // Compute the current 1 digit palindrome.
    currentNumber = i;
    
    // Grab the number in base 2 as a string.
    currentBase2Number = [self base2StringOfNumber:currentNumber];
    
    // If the number in base 2 is a palindrome,
    if([self isStringAPalindrome:currentBase2Number]){
      // Add the palindrome in base 10 and base 2 to the sum.
      sum += currentNumber;
    }
    // Compute the current 2 digit palindrome.
    currentNumber = ((i * 10) + i);
    
    // Grab the number in base 2 as a string.
    currentBase2Number = [self base2StringOfNumber:currentNumber];
    
    // If the number in base 2 is a palindrome,
    if([self isStringAPalindrome:currentBase2Number]){
      // Add the palindrome in base 10 and base 2 to the sum.
      sum += currentNumber;
    }
  }
  // For all the 3 digit and 4 digit palindromes,
  for(int i = 1; i < 10; i++){
    for(int j = 0; j < 10; j++){
      // Compute the current 3 digit palindrome.
      currentNumber = ((i * 100) + (j * 10) + i);
      
      // Grab the number in base 2 as a string.
      currentBase2Number = [self base2StringOfNumber:currentNumber];
      
      // If the number in base 2 is a palindrome,
      if([self isStringAPalindrome:currentBase2Number]){
        // Add the palindrome in base 10 and base 2 to the sum.
        sum += currentNumber;
      }
      // Compute the current 4 digit palindrome.
      currentNumber = ((i * 1000) + (j * 100) + (j * 10) + i);
      
      // Grab the number in base 2 as a string.
      currentBase2Number = [self base2StringOfNumber:currentNumber];
      
      // If the number in base 2 is a palindrome,
      if([self isStringAPalindrome:currentBase2Number]){
        // Add the palindrome in base 10 and base 2 to the sum.
        sum += currentNumber;
      }
    }
  }
  // For all the 5 digit and 6 digit palindromes,
  for(int i = 1; i < 10; i++){
    for(int j = 0; j < 10; j++){
      for(int k = 0; k < 10; k++){
        // Compute the current 5 digit palindrome.
        currentNumber = ((i * 10000) + (j * 1000) + (k * 100) + (j * 10) + i);
        
        // Grab the number in base 2 as a string.
        currentBase2Number = [self base2StringOfNumber:currentNumber];
        
        // If the number in base 2 is a palindrome,
        if([self isStringAPalindrome:currentBase2Number]){
          // Add the palindrome in base 10 and base 2 to the sum.
          sum += currentNumber;
        }
        // Compute the current 6 digit palindrome.
        currentNumber = ((i * 100000) + (j * 10000) + (k * 1000) + (k * 100) + (j * 10) + i);
        
        // Grab the number in base 2 as a string.
        currentBase2Number = [self base2StringOfNumber:currentNumber];
        
        // If the number in base 2 is a palindrome,
        if([self isStringAPalindrome:currentBase2Number]){
          // Add the palindrome in base 10 and base 2 to the sum.
          sum += currentNumber;
        }
      }
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
  
  // Here, we check every number to see if it is a palindrome, and if it is,
  // convert it to base 2, and then check if the base 2 form is also a palindrome.
  // If it is, we add the number to the sum.
  
  // Variable to hold the sum of all the numbers equal to their digit factorials.
  uint sum = 0;
  
  // Set the max size for the palindromes.
  uint maxSize = 1000000;
  
  // Variable to hold the current number in base 2 as a string.
  NSString * currentBase2Number = nil;
  
  // For all the numbers that can possibly be equal to their digit factorials,
  for(int number = 1; number < maxSize; number++){
    // If the number is a palindrome,
    if([self isStringAPalindrome:[NSString stringWithFormat:@"%d", number]]){
      // Grab the number in base 2 as a string.
      currentBase2Number = [self base2StringOfNumber:number];
      
      // If the number in base 2 is a palindrome,
      if([self isStringAPalindrome:currentBase2Number]){
        // Add the palindrome in base 10 and base 2 to the sum.
        sum += number;
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the sum of all the numbers equal to their digit factorials.
    self.answer = [NSString stringWithFormat:@"%d", sum];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question36 (Private)

- (NSString *)base2StringOfNumber:(uint)aNumber; {
  // Variable to hold the digit we are looking at.
  uint currentNumber = aNumber;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf2 = ((uint)pow(2.0, ((uint)[self log:((double)aNumber) withBase:2.0])));
  
  // Variable to hold the number in base 2 as a string.
  NSString * numberInBase2 = @"";
  
  // While the number of digits is positive,
  while(powerOf2 >= 1){
    // If the current number greater than or equal to the current power of 2,
    if(currentNumber >= powerOf2){
      // Add a 1 to the number in base 2 string.
      numberInBase2 = [NSString stringWithFormat:@"%@1", numberInBase2];
      
      // Decrement the current number by the current power of 2.
      currentNumber -= powerOf2;
    }
    // If the current number less than the current power of 2,
    else{
      // Add a 0 to the number in base 2 string.
      numberInBase2 = [NSString stringWithFormat:@"%@0", numberInBase2];
    }
    // Divide the current power of 2 by 2 to move to the next smallest power of 2.
    powerOf2 /= 2;
  }
  // Return if the number is equal to its digit factorial sum of not.
  return numberInBase2;
}

@end