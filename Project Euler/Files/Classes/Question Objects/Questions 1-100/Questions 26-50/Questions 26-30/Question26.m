//  Question26.m

#import "Question26.h"

@implementation Question26

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"13 September 2002";
  self.hint = @"To find the longest chain, use long division.";
  self.link = @"https://en.wikipedia.org/wiki/Repeating_decimal";
  self.text = @"A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:\n\n1/2	= 	0.5\n1/3	= 	0.(3)\n1/4	= 	0.25\n1/5	= 	0.2\n1/6	= 	0.1(6)\n1/7	= 	0.(142857)\n1/8	= 	0.125\n1/9	= 	0.(1)\n1/10	= 	0.1\n\nWhere 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.\n\nFind the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.";
  self.isFun = YES;
  self.title = @"Reciprocal cycles";
  self.answer = @"983";
  self.number = @"26";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"division,fractional,part,unit,decimal,representation,recurring,cycles,longest,reciprocal,denominators,contains,1000";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.isChallenging = NO;
  self.completedOnDate = @"26/01/13";
  self.solutionLineCount = @"33";
  self.estimatedComputationTime = @"1.38e-02";
  self.estimatedBruteForceComputationTime = @"4.36e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // To solve this, we simply do a long division calculation to figure out the
  // longest chain. Once we find a pair of repeating elements in the remainders
  // of the long division computation, we know that it must be a cycle. We loop
  // through all the numbers from 3 to the maximum denominator (999), and check
  // for the longest cycle.
  //
  // For a slight improvement, we note that the longest a cycle can be for a
  // number n is (n-1), as the set of possible remainders is {1, 2, ..., (n-1)},
  // so if we find a cycle with length m, we no longer need to check any of the
  // numbers less than (m+1).
  
  // Variable to hold the numerator of the fraction.
  uint numerator = 1;
  
  // Variable to hold the maximum denominator we are looking at.
  uint maxDenominator = 999;
  
  // Variable to hold the minimum denominator we need to check. Defaulted to 3.
  uint minDenominator = 3;
  
  // Variable to hold the maximum cycle length found.
  uint maxCycleLength = 0;
  
  // Variable to hold the current cycle length for the given denominator.
  uint currentCycleLength = 0;
  
  // Variable to hold the current index of the remainder we are looking at.
  uint currentRemainderIndex = 0;
  
  // Variable to hold the denominator with the max cycle length.
  uint denominatorWithMaxCycleLength = 0;
  
  // Variable array to hold the remainders when performing the long division
  // for each denominator.
  uint remainderArray[maxDenominator];
  
  // For all the elements in the remainder array,
  for(int remainderIndex = 0; remainderIndex < maxDenominator; remainderIndex++){
    // Default the remainder value to 0.
    remainderArray[remainderIndex] = 0;
  }
  // For all the denominators from the maximum denominator to the current minimum
  // denominator.
  for(int denominator = maxDenominator; denominator > minDenominator; denominator--){
    // Reset the numerator to 1.
    numerator = 1;
    
    // Reset the current cycle length to 0.
    currentCycleLength = 0;
    
    // For all the elements used in the remainder array,
    for(int remainderIndex = 0; remainderIndex < currentRemainderIndex; remainderIndex++){
      // Reset the remainder value to 0.
      remainderArray[remainderIndex] = 0;
    }
    // Reset the current remainder index to 0.
    currentRemainderIndex = 0;
    
    // While the current cycle length is 0 (i.e.: we have not cound the cycle length yet),
    while(currentCycleLength == 0){
      // If the denominator is greater than the numerator,
      if(denominator > numerator){
        // Multiply the numerator by 10.
        numerator *= 10;
      }
      // If the denominator is less than or equal to the numerator,
      else{
        // Compute the remainder when dividing the numerator by the denominator
        // using the mod function.
        numerator %= denominator;
        
        // If the numerator is now equal to 0,
        if(numerator == 0){
          // The denominator divides 10^n for some n. Therefore, there is no
          // repeating cycle, so break out of the loop.
          break;
        }
        // For all the remainders found up to this point,
        for(int remainderIndex = 0; remainderIndex < currentRemainderIndex; remainderIndex++){
          // If the numerator is eqaul to a previous remainder,
          if(remainderArray[remainderIndex] == numerator){
            // We have found a cycle, so compute the cycle length.
            currentCycleLength = (currentRemainderIndex - remainderIndex);
            
            // Break out of the loop.
            break;
          }
        }
        // Set the remainder at the current index to the numerator.
        remainderArray[currentRemainderIndex] = numerator;
        
        // Increment the number of remainders found by 1.
        currentRemainderIndex++;
      }
    }
    // If the current cycle length is greater than the previously found max cycle
    // length,
    if(currentCycleLength > maxCycleLength){
      // Set the max cycle length to be the current cycle length.
      maxCycleLength = currentCycleLength;
      
      // Set the denominator with the max cycle length to be the current denominator.
      denominatorWithMaxCycleLength = denominator;
      
      // Set the minimum denominator to be the current cycle length plus 1.
      minDenominator = currentCycleLength + 1;
    }
  }
  // Set the answer string to the denominator with the max cycle length.
  self.answer = [NSString stringWithFormat:@"%d", denominatorWithMaxCycleLength];
  
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
  
  // To solve this, we simply do a long division calculation to figure out the
  // longest chain. Once we find a pair of repeating elements in the remainders
  // of the long division computation, we know that it must be a cycle. We loop
  // through all the numbers from 3 to the maximum denominator (999), and check
  // for the longest cycle.
  
  // Variable to hold the numerator of the fraction.
  uint numerator = 1;
  
  // Variable to hold the maximum denominator we are looking at.
  uint maxDenominator = 999;
  
  // Variable to hold the maximum cycle length found.
  uint maxCycleLength = 0;
  
  // Variable to hold the current cycle length for the given denominator.
  uint currentCycleLength = 0;
  
  // Variable to hold the current index of the remainder we are looking at.
  uint currentRemainderIndex = 0;
  
  // Variable to hold the denominator with the max cycle length.
  uint denominatorWithMaxCycleLength = 0;
  
  // Variable array to hold the remainders when performing the long division
  // for each denominator.
  uint remainderArray[maxDenominator];
  
  // For all the elements in the remainder array,
  for(int remainderIndex = 0; remainderIndex < maxDenominator; remainderIndex++){
    // Default the remainder value to 0.
    remainderArray[remainderIndex] = 0;
  }
  // For all the denominators from 3 to the maximum denominator,
  for(int denominator = 3; denominator <= maxDenominator; denominator++){
    // Reset the numerator to 1.
    numerator = 1;
    
    // Reset the current cycle length to 0.
    currentCycleLength = 0;
    
    // For all the elements used in the remainder array,
    for(int remainderIndex = 0; remainderIndex < currentRemainderIndex; remainderIndex++){
      // Reset the remainder value to 0.
      remainderArray[remainderIndex] = 0;
    }
    // Reset the current remainder index to 0.
    currentRemainderIndex = 0;
    
    // While the current cycle length is 0 (i.e.: we have not cound the cycle length yet),
    while(currentCycleLength == 0){
      // If the denominator is greater than the numerator,
      if(denominator > numerator){
        // Multiply the numerator by 10.
        numerator *= 10;
      }
      // If the denominator is less than or equal to the numerator,
      else{
        // Compute the remainder when dividing the numerator by the denominator
        // using the mod function.
        numerator %= denominator;
        
        // If the numerator is now equal to 0,
        if(numerator == 0){
          // The denominator divides 10^n for some n. Therefore, there is no
          // repeating cycle, so break out of the loop.
          break;
        }
        // For all the remainders found up to this point,
        for(int remainderIndex = 0; remainderIndex < currentRemainderIndex; remainderIndex++){
          // If the numerator is eqaul to a previous remainder,
          if(remainderArray[remainderIndex] == numerator){
            // We have found a cycle, so compute the cycle length.
            currentCycleLength = (currentRemainderIndex - remainderIndex);
            
            // Break out of the loop.
            break;
          }
        }
        // Set the remainder at the current index to the numerator.
        remainderArray[currentRemainderIndex] = numerator;
        
        // Increment the number of remainders found by 1.
        currentRemainderIndex++;
      }
    }
    // If the current cycle length is greater than the previously found max cycle
    // length,
    if(currentCycleLength > maxCycleLength){
      // Set the max cycle length to be the current cycle length.
      maxCycleLength = currentCycleLength;
      
      // Set the denominator with the max cycle length to be the current denominator.
      denominatorWithMaxCycleLength = denominator;
    }
  }
  // Set the answer string to the denominator with the max cycle length.
  self.answer = [NSString stringWithFormat:@"%d", denominatorWithMaxCycleLength];
  
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