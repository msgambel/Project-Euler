//  Question74.m

#import "Question74.h"

@implementation Question74

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"16 July 2004";
  self.hint = @"Store the chain length of the first 100 numbers in an array.";
  self.link = @"https://en.wikipedia.org/wiki/Factorial";
  self.text = @"The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:\n\n1! + 4! + 5! = 1 + 24 + 120 = 145\n\nPerhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:\n\n169 -> 363601 -> 1454 -> 169\n871 -> 45361 -> 871\n872 -> 45362 -> 872\n\nIt is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,\n\n69 -> 363600 -> 1454 -> 169 -> 363601 (-> 1454)\n78 -> 45360 -> 871 -> 45361 (-> 871)\n540 -> 145 (-> 145)\n\nStarting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.\n\nHow many chains, with a starting number below one million, contain exactly sixty non-repeating terms?";
  self.isFun = YES;
  self.title = @"Digit factorial chains";
  self.answer = @"402";
  self.number = @"74";
  self.rating = @"4";
  self.summary = @"How many chains starting below 1,000,000 have exactly 60 non-repeating terms?";
  self.category = @"Patterns";
  self.isUseful = NO;
  self.keywords = @"digit,factorial,chains,length,loop,sixty,60,unique,property,non-repeating,terms,contain,exactly";
  self.loadsFile = NO;
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"34";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"15/03/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"15/03/13";
  self.solutionLineCount = @"37";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"4.81";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"4.81";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to compute the sum of the factorials of
  // the digits. We then store the values of the chain in an array, and once a
  // repeat is found, we break out of the loop. We check the length of the chain
  // to see if it is the required length, and if it is, we increment the number
  // of numbers who produce a chain with the required length by 1.
  
  // Variable to mark if we have found a repeat in the chain.
  BOOL repeatFound = NO;
  
  // Variable to hold the maximum size the numbers we are looking at can be.
  uint maxSize = 1000000;
  
  // Variable to hold the current value in the current chain.
  uint currentValue = 0;
  
  // Variable thold the number of values in the chain for the current number.
  uint currentChainLength = 0;
  
  // Variable to hold the required chain length the numbers must have.
  uint requiredChainLength = 60;
  
  // Variable to hold the number of numbers who produce a chain with the
  // required length.
  uint numbersWithRequiredChainLength = 0;
  
  // Variable array to hold the current chains values.
  uint chain[100] = {0};
  
  // For all the numbers from 1 up to the maximum size,
  for(uint number = 1; number < maxSize; number++){
    // Reset that we have yet to find a repeat in the chain.
    repeatFound = NO;
    
    // Set the current value to be the current number.
    currentValue = number;
    
    // Set the number as the first value in the chain.
    chain[0] = number;
    
    // Reset the current chains length to 1.
    currentChainLength = 1;
    
    // While we have NOT found a repeat in the chain,
    while(repeatFound == NO){
      // Compute the sum of the factorials of the digits of the current value in
      // the chain.
      currentValue = [self sumOfDigitsFactorials:currentValue];
      
      // For all of the values currently in the chain,
      for(int chainIndex = 0; chainIndex < currentChainLength; chainIndex++){
        // If the current value in the chain is equal to a previous value in the
        // chain,
        if(currentValue == chain[chainIndex]){
          // Mark that we have found a repeat in the chain.
          repeatFound = YES;
          
          // Break out of the loop.
          break;
        }
      }
      // If we have NOT found a repeat in the chain,
      if(repeatFound == NO){
        // Add the current value to the chain.
        chain[currentChainLength] = currentValue;
        
        // Increment the number of values in the chain by 1.
        currentChainLength++;
      }
    }
    // If the number of non-repeating values in the chain is equal to the
    // required length,
    if(currentChainLength == requiredChainLength){
      // Increment the number of numbers who produce a chain with the required
      // length by 1.
      numbersWithRequiredChainLength++;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the numbers with the required factorial chain length.
    self.answer = [NSString stringWithFormat:@"%d", numbersWithRequiredChainLength];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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
  
  // Here, we simply use a helper method to compute the sum of the factorials of
  // the digits. We then store the values of the chain in an array, and once a
  // repeat is found, we break out of the loop. We check the length of the chain
  // to see if it is the required length, and if it is, we increment the number
  // of numbers who produce a chain with the required length by 1.
  
  // Variable to mark if we have found a repeat in the chain.
  BOOL repeatFound = NO;
  
  // Variable to hold the maximum size the numbers we are looking at can be.
  uint maxSize = 1000000;
  
  // Variable to hold the current value in the current chain.
  uint currentValue = 0;
  
  // Variable thold the number of values in the chain for the current number.
  uint currentChainLength = 0;
  
  // Variable to hold the required chain length the numbers must have.
  uint requiredChainLength = 60;
  
  // Variable to hold the number of numbers who produce a chain with the
  // required length.
  uint numbersWithRequiredChainLength = 0;
  
  // Variable array to hold the current chains values.
  uint chain[100] = {0};
  
  // For all the numbers from 1 up to the maximum size,
  for(uint number = 1; number < maxSize; number++){
    // Reset that we have yet to find a repeat in the chain.
    repeatFound = NO;
    
    // Set the current value to be the current number.
    currentValue = number;
    
    // Set the number as the first value in the chain.
    chain[0] = number;
    
    // Reset the current chains length to 1.
    currentChainLength = 1;
    
    // While we have NOT found a repeat in the chain,
    while(repeatFound == NO){
      // Compute the sum of the factorials of the digits of the current value in
      // the chain.
      currentValue = [self sumOfDigitsFactorials:currentValue];
      
      // For all of the values currently in the chain,
      for(int chainIndex = 0; chainIndex < currentChainLength; chainIndex++){
        // If the current value in the chain is equal to a previous value in the
        // chain,
        if(currentValue == chain[chainIndex]){
          // Mark that we have found a repeat in the chain.
          repeatFound = YES;
          
          // Break out of the loop.
          break;
        }
      }
      // If we have NOT found a repeat in the chain,
      if(repeatFound == NO){
        // Add the current value to the chain.
        chain[currentChainLength] = currentValue;
        
        // Increment the number of values in the chain by 1.
        currentChainLength++;
      }
    }
    // If the number of non-repeating values in the chain is equal to the
    // required length,
    if(currentChainLength == requiredChainLength){
      // Increment the number of numbers who produce a chain with the required
      // length by 1.
      numbersWithRequiredChainLength++;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    
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