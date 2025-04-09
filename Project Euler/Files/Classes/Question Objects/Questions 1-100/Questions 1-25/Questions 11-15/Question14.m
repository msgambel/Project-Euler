//  Question14.m

#import "Question14.h"

@implementation Question14

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"05 April 2002";
  self.hint = @"Ignore even numbers.";
  self.link = @"https://en.wikipedia.org/wiki/Collatz_conjecture";
  self.text = @"The following iterative sequence is defined for the set of positive integers:\n\nn  n/2 (n is even)\nn  3n + 1 (n is odd)\n\nUsing the rule above and starting with 13, we generate the following sequence:\n\n13  40  20  10  5  16  8  4  2  1\n\nIt can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.\n\nWhich starting number, under one million, produces the longest chain?\n\nNOTE: Once the chain starts the terms are allowed to go above one million.";
  self.isFun = YES;
  self.title = @"Longest Collatz sequence";
  self.answer = @"837799";
  self.number = @"14";
  self.rating = @"4";
  self.summary = @"A simple, functional problem (as long as you have a limit). It's gotta be true though, right?";
  self.category = @"Patterns";
  self.isUseful = YES;
  self.keywords = @"chain,collatz,longest,sequence,iterative,positive,integers,one,million,1000000,starting,number,terms,proved,problem,allowed,above";
  self.loadsFile = NO;
  self.memorable = YES;
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"37";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"14/01/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"14/01/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"37";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"0.541";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.41";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We simply interate over all the numbers up to the max number to check and
  // compute the length of the Collatz sequence of the number. We ignore the
  // even numbers, as even the largest even number is only 1 longer than the
  // largest odd value less than half the max number to check. Therefore, if the
  // algorithm produces an odd number less than 500,000, we simply double it to
  // get the final result.
  //
  // We also pre-compute the length of the Collatz sequences for numbers less
  // than 100. This will reduce the number of computations for all numbers.
  
  // Variable to hold the max number to check.
  uint maxNumberToCheck = 1000000;
  
  // Variable to hold the computational value of the Collatz sequence from the
  // start index n.
  long long int startIndex = 0;
  
  // Variable to hold the length of the current Collatz sequence.
  uint currentCollatzLength = 0;
  
  // Variable to hold the length of the longest Collatz sequence.
  uint longestCollatzLength = 0;
  
  // Variable to hold the number with the longest Collatz sequence.
  uint longestCollatzNumber = 1;
  
  // Variable array to hold the precomputed values less than 101.
  uint precomputedCollatzLengths[101];
  
  // Set the value of the 0 Collatz sequence.
  precomputedCollatzLengths[0] = 0;
  
  // Set the value of the 1 Collatz sequence.
  precomputedCollatzLengths[1] = 1;
  
  // For all the positive numbers less than 101,
  for(int n = 2; n < 101; n++){
    // Set the start index to be the current number.
    startIndex = n;
    
    // Reset the length of the current Collatz sequence.
    currentCollatzLength = 0;
    
    // While the start index is greater than 1,
    while(startIndex > 1){
      // Increment the length of the current Collatz sequence by 1.
      currentCollatzLength++;
      
      // If the start index is even,
      if((startIndex % 2) == 0){
        // Divide the number by 2.
        startIndex /= 2;
      }
      // If the start index is odd,
      else{
        // Multiply the start index by 3.
        startIndex *= 3;
        
        // Increment the start index by 1.
        startIndex++;
      }
    }
    // Store the length of the Collatz sequence in the precomputed array.
    precomputedCollatzLengths[n] = currentCollatzLength;
  }
  // For all the positive numbers less than max number to check (increment by 2
  // to ignore the even numbers),
  for(uint n = 101; n < maxNumberToCheck; n += 2){
    // Set the start index to be the current number.
    startIndex = n;
    
    // Reset the length of the current Collatz sequence.
    currentCollatzLength = 0;
    
    // While the start index is greater than 1,
    while(startIndex > 1){
      // Increment the length of the current Collatz sequence by 1.
      currentCollatzLength++;
      
      // If the start index is even,
      if((startIndex % 2) == 0){
        // Divide the number by 2.
        startIndex /= 2;
        
        // Note: We only have to check if the number is less than 101 after we
        //       divide it by 2 (the even case), as if it were odd, we would have
        //       increased it, and hence would already be larger than 101.
        
        // If the value is less than 101,
        if(startIndex < 101){
          // Add the value of the rest of the Collatz length to the current length.
          currentCollatzLength += precomputedCollatzLengths[startIndex];
          
          // Break out of the loop.
          break;
        }
      }
      // If the start index is odd,
      else{
        // Multiply the start index by 3.
        startIndex *= 3;
        
        // Increment the start index by 1.
        startIndex++;
      }
    }
    // If the length of the current Collatz sequence is larger than the previous
    // longest Collatz sequence length,
    if(currentCollatzLength > longestCollatzLength){
      // Set the longest Collatz sequence to the new longest Collatz sequence.
      longestCollatzLength = currentCollatzLength;
      
      // Set the longest Collatz number to the new longest Collatz number.
      longestCollatzNumber = n;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the longest Collatz starting number.
    self.answer = [NSString stringWithFormat:@"%d", longestCollatzNumber];
    
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
  
  // We simply interate over all the numbers up to the max number to check and
  // compute the length of the Collatz sequence of the number.
  
  // Variable to hold the max number to check.
  uint maxNumberToCheck = 1000000;
  
  // Variable to hold the computational value of the Collatz sequence from the
  // start index n.
  long long int startIndex = 0;
  
  // Variable to hold the length of the current Collatz sequence.
  uint currentCollatzLength = 0;
  
  // Variable to hold the length of the longest Collatz sequence.
  uint longestCollatzLength = 0;
  
  // Variable to hold the number with the longest Collatz sequence.
  uint longestCollatzNumber = 1;
  
  // For all the positive numbers less than max number to check,
  for(uint n = 2; n < maxNumberToCheck; n++){
    // Set the start index to be the current number.
    startIndex = n;
    
    // Reset the length of the current Collatz sequence.
    currentCollatzLength = 0;
    
    // While the start index is greater than 1,
    while(startIndex > 1){
      // Increment the length of the current Collatz sequence by 1.
      currentCollatzLength++;
      
      // If the start index is even,
      if((startIndex % 2) == 0){
        // Divide the number by 2.
        startIndex /= 2;
      }
      // If the start index is odd,
      else{
        // Multiply the start index by 3.
        startIndex *= 3;
        
        // Increment the start index by 1.
        startIndex++;
      }
    }
    // If the length of the current Collatz sequence is larger than the previous
    // longest Collatz sequence length,
    if(currentCollatzLength > longestCollatzLength){
      // Set the longest Collatz sequence to the new longest Collatz sequence.
      longestCollatzLength = currentCollatzLength;
      
      // Set the longest Collatz number to the new longest Collatz number.
      longestCollatzNumber = n;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the longest Collatz starting number.
    self.answer = [NSString stringWithFormat:@"%d", longestCollatzNumber];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated brute force computation time to the calculated value. We
    // use scientific notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end