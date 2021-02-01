//  Question55.m

#import "Question55.h"
#import "BigInt.h"

@implementation Question55

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"24 October 2003";
  self.hint = @"Store the previous Lychrel numbers as you find them to compare against later sequences.";
  self.link = @"https://en.wikipedia.org/wiki/Lychrel_number";
  self.text = @"If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.\n\nNot all numbers produce palindromes so quickly. For example,\n\n349 + 943 = 1292,\n1292 + 2921 = 4213\n4213 + 3124 = 7337\n\nThat is, 349 took three iterations to arrive at a palindrome.\n\nAlthough no one has proved it yet, it is thought that some numbers, like 196, never produce a palindrome. A number that never forms a palindrome through the reverse and add process is called a Lychrel number. Due to the theoretical nature of these numbers, and for the purpose of this problem, we shall assume that a number is Lychrel until proven otherwise. In addition you are given that for every number below ten-thousand, it will either (i) become a palindrome in less than fifty iterations, or, (ii) no one, with all the computing power that exists, has managed so far to map it to a palindrome. In fact, 10677 is the first number to be shown to require over fifty iterations before producing a palindrome: 4668731596684224866951378664 (53 iterations, 28-digits).\n\nSurprisingly, there are palindromic numbers that are themselves Lychrel numbers; the first example is 4994.\n\nHow many Lychrel numbers are there below ten-thousand?\n\nNOTE: Wording was modified slightly on 24 April 2007 to emphasise the theoretical nature of Lychrel numbers.";
  self.isFun = YES;
  self.title = @"Lychrel numbers";
  self.answer = @"249";
  self.number = @"55";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"lychrel,numbers,palindrome,sum,add,reverse,iterations,below,10000,ten,thousand,50,fifty,palindromic,theoretical,nature,producing";
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"42";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"24/02/13";
  self.solvableByHand = NO;
  self.completedOnDate = @"24/02/13";
  self.solutionLineCount = @"43";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = YES;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"1.67";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"12.5";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply take the number, reverse it, add them together and check if
  // the sum is a Lychrel number or not. We start by assuming that all the
  // numbers from 1 up to 10,000 are Lychrel. If the number is NOT a Lychrel
  // number, we decrement the number os Lychrel numbers by 1.
  //
  // In order to get some speed gains, we only use the BigInt implementation
  // when the numbers get to be close to the maximum size of a long long int.
  
  // Variable to mark when we need to move from using uint's to the BigInt
  // implementation.
  BOOL useBigInt = NO;
  
  // Veriable to hold the maximum Lychrel number to check.
  uint maxSize = 10000;
  
  // Variable to hold the maximum interations to perform.
  uint maxIterations = 50;
  
  // Variable to hold the number of Lychrel numbers found. We decrememnt this
  // number by 1 if the current number is NOT a Lychrel number, and the -1 comes
  // from the fact that 0 is NOT a Lychrel number.
  uint numberOfLychrelNumbers = maxSize - 1;
  
  // Variable to hold the current number in a long long form.
  long long int currentNumber = 0;
  
  // Variable to hold the current reversed number in a long long form.
  long long int reversedNumber = 0;
  
  // Variable to hold the sum of the number and its reveresed number.
  BigInt * sum = nil;
  
  // Variable to hold the current number in the iteration.
  BigInt * currentBigInt = nil;
  
  // Variable to hold the reversed current number in the iteration.
  BigInt * reversedBigInt = nil;
  
  // For all the numbers from 1 to the maximum Lychrel number to look for,
  for(int number = 1; number < maxSize; number++){
    // Grab the current number.
    currentNumber = number;
    
    // Reset that we are NOT to start out using the BigInt implementation.
    useBigInt = NO;
    
    // We iterate up to 50 times,
    for(int numberOfIterations = 0; numberOfIterations < maxIterations; numberOfIterations++){
      // If we are to use the BigInt implementation,
      if(useBigInt){
        // Compute and store the reversed current BigInt.
        reversedBigInt = [BigInt createFromString:[self reversedString:[currentBigInt toStringWithRadix:10]] andRadix:10];
        
        // Add the current BigInt to its reversed self.
        sum = [currentBigInt add:reversedBigInt];
        
        // Set the current BigInt to be the sum.
        currentBigInt = sum;
        
        // If the current BigInt is a palindrome,
        if([self isStringAPalindrome:[currentBigInt toStringWithRadix:10]]){
          // The number is NOT a Lychrel number, so decrement the number of
          // Lychrel numbers by 1.
          numberOfLychrelNumbers--;
          
          // Break out of the loop.
          break;
        }
      }
      // If we are NOT to use the BigInt implementation,
      else{
        // Compute and store the reversed current number.
        reversedNumber = [[self reversedString:[NSString stringWithFormat:@"%llu", currentNumber]] longLongValue];
        
        // Add the reversed number to the current number.
        currentNumber += reversedNumber;
        
        // If the current number is a palindrome,
        if([self isStringAPalindrome:[NSString stringWithFormat:@"%llu", currentNumber]]){
          // The number is NOT a Lychrel number, so decrement the number of
          // Lychrel numbers by 1.
          numberOfLychrelNumbers--;
          
          // Break out of the loop.
          break;
        }
        // If the current number is greater than 1,000,000,000,000,000,000,
        if(currentNumber > 1000000000000000000){
          // Set the current BigInt the current number.
          currentBigInt = [BigInt createFromInt:number];
          
          // Set that we should now use the BigInt in our computations.
          useBigInt = YES;
        }
      }
      // If we are no longer computing,
      if(!_isComputing){
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
    // Set the answer string to the number of lychrel numbers.
    self.answer = [NSString stringWithFormat:@"%d", numberOfLychrelNumbers];
    
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
  
  // Note: This is basically the same algorithm as the optimal one. The only
  //       difference is that we only use BigInt objects for the math.
  
  // Here, we simply take the number, reverse it, add them together and check if
  // the sum is a Lychrel number or not. We start by assuming that all the
  // numbers from 1 up to 10,000 are Lychrel. If the number is NOT a Lychrel
  // number, we decrement the number os Lychrel numbers by 1.
  
  // Veriable to hold the maximum Lychrel number to check.
  uint maxSize = 10000;
  
  // Variable to hold the maximum interations to perform.
  uint maxIterations = 50;
  
  // Variable to hold the number of Lychrel numbers found. We decrememnt this
  // number by 1 if the current number is NOT a Lychrel number, and the -1 comes
  // from the fact that 0 is NOT a Lychrel number.
  uint numberOfLychrelNumbers = maxSize - 1;
  
  // Variable to hold the sum of the number and its reveresed number.
  BigInt * sum = nil;
  
  // Variable to hold the current number in the iteration.
  BigInt * currentNumber = nil;
  
  // Variable to hold the reversed current number in the iteration.
  BigInt * reversedNumber = nil;
  
  // For all the numbers from 1 to the maximum Lychrel number to look for,
  for(int number = 1; number < maxSize; number++){
    // Grab the current number.
    currentNumber = [BigInt createFromInt:number];
    
    // We iterate up to 50 times,
    for(int numberOfIterations = 0; numberOfIterations < maxIterations; numberOfIterations++){
      // Compute and store the reversed current number.
      reversedNumber = [BigInt createFromString:[self reversedString:[currentNumber toStringWithRadix:10]] andRadix:10];
      
      // Add the current number to its reversed self.
      sum = [currentNumber add:reversedNumber];
      
      // Set the current number to be the sum.
      currentNumber = sum;
      
      // If the current number is a palindrome,
      if([self isStringAPalindrome:[currentNumber toStringWithRadix:10]]){
        // The number is NOT a Lychrel number, so decrement the number of
        // Lychrel numbers by 1.
        numberOfLychrelNumbers--;
        
        // Break out of the loop.
        break;
      }
      // If we are no longer computing,
      if(!_isComputing){
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
    // Set the answer string to the number of lychrel numbers.
    self.answer = [NSString stringWithFormat:@"%d", numberOfLychrelNumbers];
    
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