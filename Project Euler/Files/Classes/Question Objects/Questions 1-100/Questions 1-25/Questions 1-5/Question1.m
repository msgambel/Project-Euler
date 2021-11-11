//  Question1.m

#import "Question1.h"

@interface Question1 (Private)

- (uint)sumOfNumbersFrom:(uint)aStart to:(uint)aEnd divisibleBy:(uint)aNumber;

@end

@implementation Question1

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"05 October 2001";
  self.hint = @"There's a formula for summing the numbers from 1 to n. What happens when all the numbers in the sum have a common factor?";
  self.link = @"https://en.wikipedia.org/wiki/Project_Euler#Example_problem_and_solutions";
  self.text = @"If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.\n\nFind the sum of all the multiples of 3 or 5 below 1000.";
  self.isFun = YES;
  self.title = @"Multiples of 3 and 5";
  self.answer = @"233168";
  self.number = @"1";
  self.rating = @"5";
  self.category = @"Counting";
  self.keywords = @"sums,triangle,numbers,multiples,3,three,5,five,1000,one,thousand,first,problem,question,list";
  self.solveTime = @"10";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.commentCount = @"11";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"01/01/13";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"01/01/13";
  self.solutionLineCount = @"11";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"2.1e-05";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.7e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Set the max number of the sum. We want less than 1000.
  uint maxNumber = 1000 - 1;
  
  // Sum the numbers from 0 to the max number which are divisible by 3.
  uint sum = [self sumOfNumbersFrom:0 to:maxNumber divisibleBy:3];
  
  // Add the numbers from 0 to the max number which are divisible by 5.
  sum += [self sumOfNumbersFrom:0 to:maxNumber divisibleBy:5];
  
  // Subtract the numbers from 0 to the max number which are divisible by 15.
  // This must be done, as we have double counted these number in the above 2
  // sums.
  sum -= [self sumOfNumbersFrom:0 to:maxNumber divisibleBy:15];
  
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // For all the integers from 1 to 999,
  for(int i = 1; i < 1000; i++){
    // If the number is divisible by 3 or 5,
    if(((i % 3) == 0) ||((i % 5) == 0)){
      // Add it to the sum.
      sum += i;
    }
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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

#pragma mark - Private Methods

@implementation Question1 (Private)

- (uint)sumOfNumbersFrom:(uint)aStart to:(uint)aEnd divisibleBy:(uint)aNumber; {
  // This helper method is used to compute the sum of positive numbers from a start
  // number to an end number. Notice that if the values are divisible by x, then
  // the sequence of numbers is:
  //
  // x, 2x, 3x, 4x, 5x, ...
  //
  // If we divide out by x, we have the positive integers, which have a closed
  // form solution:
  //
  // \sum_{i = 0}^{n} i = ((n * (n + 1)) / 2)
  //
  // Therefore, the sum of the numbers divisible by x is:
  //
  // \sum_{i = 0}^{n'} x * i = x * ((n' * (n' + 1)) / 2), where (n' = n / x).
  //
  // If the start number is not 0, we simply subtract off the sum of the numbers
  // divisible by x upto the start number from the sum of the numbers divisible
  // by x upto the end number.
  
  // Compute the new start and end values.
  uint newEnd = (aEnd / aNumber);
  uint newStart = (aStart / aNumber);
  
  // Compute the sum based on the new end number, explained above.
  uint sum = ((aNumber * newEnd * (newEnd + 1)) / 2);
  
  // Subtract the sum based on the new start number, explained above.
  sum -= ((aNumber * newStart * (newStart + 1)) / 2);
  
  // Return the sum.
  return sum;
}

@end