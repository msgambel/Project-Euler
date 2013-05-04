//  Question52.m

#import "Question52.h"

@implementation Question52

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"12 September 2003";
  self.text = @"It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.\n\nFind the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.";
  self.title = @"Permuted multiples";
  self.answer = @"142857";
  self.number = @"52";
  self.keywords = @"multiples,permutation,digits";
  self.estimatedComputationTime = @"3.11e-02";
  self.estimatedBruteForceComputationTime = @"5.63e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply iterate through the numbers to see if the multiples all use
  // the same digits as the original number. We only iterate from:
  //
  // 10^n to 10^(n+1) / maxMultiple,
  //
  // as any number larger would not be valid for the larger multples.
  
  // Variable to hold the maximum multiple that needs to be a permutation.
  uint maxMultiple = 6;
  
  // Variable to hold the current multiple we are iterating over.
  uint currentMultiple = 2;
  
  // Variable to hold the current power of 10 we are starting with.
  uint currentPowerOf10 = 10;
  
  // Variable to hold the smallest possible integer with the desired property.
  uint smallestPossibleInteger = 0;
  
  // While we haven't yet found the smallest possible integer with the desired
  // property,
  while(smallestPossibleInteger == 0){
    // For all the number from 10^n to 10^(n+1) / 6,
    for(int number = currentPowerOf10; number < ((currentPowerOf10 * 10) / maxMultiple); number++){
      // Reset the current multiple to 2.
      currentMultiple = 2;
      
      // While the current multiple is less than or equal to the maximum multiple,
      while(currentMultiple <= maxMultiple){
        // If the number is a permutation of the current multiple,
        if([self number:number isAPermutationOfNumber:(currentMultiple * number)]){
          // Increment the current multiple by 1.
          currentMultiple++;
        }
        // If the number is NOT a permutation of the current multiple,
        else{
          // Break out of the loop.
          break;
        }
      }
      // If the current multiple is greater than the maximum multiple,
      if(currentMultiple > maxMultiple){
        // Set the smallest possible integer with the desired property to be the
        // current number.
        smallestPossibleInteger = number;
        
        // Break out of the loop.
        break;
      }
    }
    // Compute the next power of 10.
    currentPowerOf10 *= 10;
  }
  // Set the answer string to the smallest possible integer with the desired
  // property.
  self.answer = [NSString stringWithFormat:@"%d", smallestPossibleInteger];
  
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
  
  // Here, we simply iterate through the numbers to see if the multiples all use
  // the same digits as the original number.
  
  // Variable to hold the maximum number to check.
  uint maxSize = 1000000;
  
  // Variable to hold the maximum multiple that needs to be a permutation.
  uint maxMultiple = 6;
  
  // Variable to hold the current multiple we are iterating over.
  uint currentMultiple = 2;
  
  // Variable to hold the smallest possible integer with the desired property.
  uint smallestPossibleInteger = 0;
  
  // While we haven't yet found the smallest possible integer with the desired
  // property,
  while(smallestPossibleInteger == 0){
    // For all the number from 1 to the maximum size,
    for(int number = 1; number < maxSize; number++){
      // Reset the current multiple to 2.
      currentMultiple = 2;
      
      // While the current multiple is less than or equal to the maximum multiple,
      while(currentMultiple <= maxMultiple){
        // If the number is a permutation of the current multiple,
        if([self number:number isAPermutationOfNumber:(currentMultiple * number)]){
          // Increment the current multiple by 1.
          currentMultiple++;
        }
        // If the number is NOT a permutation of the current multiple,
        else{
          // Break out of the loop.
          break;
        }
      }
      // If the current multiple is greater than the maximum multiple,
      if(currentMultiple > maxMultiple){
        // Set the smallest possible integer with the desired property to be the
        // current number.
        smallestPossibleInteger = number;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the smallest possible integer with the desired
  // property.
  self.answer = [NSString stringWithFormat:@"%d", smallestPossibleInteger];
  
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