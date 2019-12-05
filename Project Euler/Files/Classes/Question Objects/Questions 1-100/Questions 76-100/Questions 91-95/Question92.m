//  Question92.m

#import "Question92.h"

@interface Question92 (Private)

- (uint)sumOfDigitsSquared:(uint)aNumber;

@end

@implementation Question92

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"01 April 2005";
  self.hint = @"The largest digit square sum is 567.";
  self.link = @"https://en.wikipedia.org/wiki/Iteration";
  self.text = @"A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.\n\nFor example,\n\n44 -> 32 -> 13 -> 10 -> 1 -> 1\n85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89\n\nTherefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.\n\nHow many starting numbers below ten million will arrive at 89?";
  self.isFun = YES;
  self.title = @"Square digit chains";
  self.answer = @"8581146";
  self.number = @"92";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"square,digit,chains,one,1,eighty,nine,89,count,starting,numbers,continuously,sequence";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"29";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"02/04/13";
  self.completedOnDate = @"02/04/13";
  self.solutionLineCount = @"21";
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.99";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"5.1";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to compute the digit square sum, and
  // continually loop until we hit 89 or 1. Every time we hit 89, we increment
  // the number of numbers that arrive at 89 by 1. Then, it's just a simple
  // matter of looping through every number up to the maximum size.
  //
  // We make 1 observation. The largest digit square sum could be given the
  // maximum size is  9² * 7 = 567, as 9,999,999 is the number that will
  // generate the largest square sum. Therefore, if we store which value the
  // numbers below 567 in an array, we only need to compute the digit sum once
  // in order to find out where it goes.
  
  // Variable to hold the maximum number to check.
  uint maxNumber = 10000000;
  
  // Variable to hold the sum of the square of the digits of the inputted number.
  uint digitSquaredSum = 0;
  
  // Variable to hold the number of numbers that arrive at 89.
  uint numbersArriveAt89Count = 0;
  
  // Variable array to hold where the first 567 numbers arrive at.
  uint first567Numbers[568] = {0};
  
  // Set that the number 1 ends up at 1.
  first567Numbers[1] = 1;
  
  // For all the numbers from 2 up to 567,
  for(int number = 2; number <= 567; number++){
    // Store the start of the chain in the digit squared sum variable.
    digitSquaredSum = number;
    
    // Continually loop until we hit 1 or 89.
    while(YES){
      // Compute the digit squared sum of the current number in the chain.
      digitSquaredSum = [self sumOfDigitsSquared:digitSquaredSum];
      
      // If the digit squared sum is 1,
      if(digitSquaredSum == 1){
        // Set that the current number goes to a 1 chain.
        first567Numbers[number] = 1;
        
        // Break out of the loop.
        break;
      }
      // If the digit squared sum is 89,
      else if(digitSquaredSum == 89){
        // Set that the current number goes to a 89 chain.
        first567Numbers[number] = 89;
        
        // Increment the number of numbers that arrive at 89 by 1.
        numbersArriveAt89Count++;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // For all the numbers from 568 up to the maximum size,
  for(int number = 568; number < maxNumber; number++){
    // Compute the digit squared sum of the current number in the chain.
    digitSquaredSum = [self sumOfDigitsSquared:number];
    
    // Check where the digit sum's chain ends up.
    digitSquaredSum = first567Numbers[digitSquaredSum];
    
    // If the digit squared sum ends up at 89,
    if(digitSquaredSum == 89){
      // Increment the number of numbers that arrive at 89 by 1.
      numbersArriveAt89Count++;
    }
  }
  // Set the answer string to the number of number that arrive at 89.
  self.answer = [NSString stringWithFormat:@"%d", numbersArriveAt89Count];
  
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
  
  // Here, we simply use a helper method to compute the digit square sum, and
  // continually loop until we hit 89 or 1. Every time we hit 89, we increment
  // the number of numbers that arrive at 89 by 1. Then, it's just a simple
  // matter of looping through every number up to the maximum size.
  
  // Variable to hold the maximum number to check.
  uint maxNumber = 10000000;
  
  // Variable to hold the sum of the square of the digits of the inputted number.
  uint digitSquaredSum = 0;
  
  // Variable to hold the number of numbers that arrive at 89.
  uint numbersArriveAt89Count = 0;
  
  // For all the numbers from 2 up to the maximum size,
  for(int number = 2; number < maxNumber; number++){
    // Store the start of the chain in the digit squared sum variable.
    digitSquaredSum = number;
    
    // Continually loop until we hit 1 or 89.
    while(YES){
      // Compute the digit squared sum of the current number in the chain.
      digitSquaredSum = [self sumOfDigitsSquared:digitSquaredSum];
      
      // If the digit squared sum is 1,
      if(digitSquaredSum == 1){
        // Break out of the loop.
        break;
      }
      // If the digit squared sum is 89,
      else if(digitSquaredSum == 89){
        // Increment the number of numbers that arrive at 89 by 1.
        numbersArriveAt89Count++;
        
        // Break out of the loop.
        break;
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
    // Set the answer string to the number of number that arrive at 89.
    self.answer = [NSString stringWithFormat:@"%d", numbersArriveAt89Count];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question92 (Private)

- (uint)sumOfDigitsSquared:(uint)aNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the sum of the square of the digits of the inputted number.
  uint digitSquaredSum = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((uint)(aNumber / powerOf10)) % 10);
    
    // Add the digit squared to the digit squared sum.
    digitSquaredSum += (digit * digit);
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return the sum of the square of the digits.
  return digitSquaredSum;
}

@end