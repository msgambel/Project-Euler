//  Question2.m

#import "Question2.h"

@implementation Question2

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 October 2001";
  self.hint = @"The sum of an even number and odd number is odd, and the sum of an odd number and an odd number is even. What's the pattern of the numbers in the fibonacci numbers?";
  self.link = @"https://en.wikipedia.org/wiki/Fibonacci_number";
  self.text = @"Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:\n\n1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...\n\nBy considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.";
  self.isFun = YES;
  self.title = @"Even Fibonacci numbers";
  self.answer = @"4613732";
  self.number = @"2";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"fibonacci,sequence,numbers,sum,even,valued,terms,exceed,four,million,4000000,odd,positive,generated,previous";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.commentCount = @"15";
  self.isChallenging = NO;
  self.completedOnDate = @"02/01/13";
  self.solutionLineCount = @"11";
  self.usesHelperMethods = NO;
  self.estimatedComputationTime = @"2.1e-05";
  self.estimatedBruteForceComputationTime = @"4.7e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Notice that the third Fibonacci number after an even Fibonacci number is
  // also even. The sequence goes:
  //
  // 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
  //
  // Which is:
  //
  // Odd, Even, Odd, Odd, Even, Odd, Odd, Even, ...
  //
  // Notice that once you hit two Odd numbers in a row, the next Fibonacci number
  // must be Even, as the sum of two Odd numbers is Even. The Even number must
  // always follow with two Odd numbers, and the previous and successive numbers
  // are both Odd.
  //
  // Therefore, we need only find the first Even Fibonacci number (luckily, that
  // is quite easy!), find the third Fibonacci number after it, and then repeat
  // the process until the largest Fibonacci number is found that is less than
  // the max size defined above.
  
  // Set the variables needed for computing the Fibonacci numbers. Recall:
  //
  // f_i_plus_2 = f_i_plus_1 + f_i, where (f_1 = 1, f_2 = 2).
  //
  // Since we know f_1 = 1 is odd, we can just start our even cycle on f_2 = 2.
  
  // Set the max size for the Fibonacci numbers.
  uint maxSize = 4000000;
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the variables for the Even, Odd1, Odd2 Fibonacci sequence, and seed them.
  uint fEven = 2;
  uint fOdd1 = 3;
  uint fOdd2 = fEven + fOdd1;
  
  // While our Even Fibonacci number if less than our max size,
  while(fEven < maxSize){
    // Add the Even Fibonacci number to our sum.
    sum += fEven;
    
    // Compute and store the next 3 Fibonacci numbers.
    fEven = fOdd1 + fOdd2;
    fOdd1 = fEven + fOdd2;
    fOdd2 = fEven + fOdd1;
  }
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
  
  // Set the max size for the Fibonacci numbers.
  uint maxSize = 4000000;
  
  // Set the variables needed for computing the Fibonacci numbers. Recall:
  //
  // f_i_plus_2 = f_i_plus_1 + f_i, where (f_1 = 1, f_2 = 2).
  
  uint f_i = 1;
  uint f_i_plus_1 = 2;
  uint f_i_plus_2 = f_i_plus_1 + f_i;
  
  // Allocate an arry to hold all the Fibonacci numbers. We could use a normal
  // int array, but this method allows for one of arbitrary size.
  
  NSMutableArray * fibonacciNumbersArray = [[NSMutableArray alloc] init];
  
  // Add in the first 2 Fibonacci numbers.
  [fibonacciNumbersArray addObject:[NSNumber numberWithInt:f_i]];
  [fibonacciNumbersArray addObject:[NSNumber numberWithInt:f_i_plus_1]];
  
  // Loop over the Fibonacci numbers to add in all the Fibonacci numbers that
  // are less than the max size defined above.
  while(f_i_plus_2 < maxSize){
    // Add in the current largest Fibonacci number.
    [fibonacciNumbersArray addObject:[NSNumber numberWithInt:f_i_plus_2]];
    
    // Set the previous 2 Fibonacci numbers to the 2 largest.
    f_i = f_i_plus_1;
    f_i_plus_1 = f_i_plus_2;
    
    // Compute the new largest Fibonacci number.
    f_i_plus_2 = f_i_plus_1 + f_i;
  }
  // Set a variable that can hold the current Fibonacci number when looping
  // through the stored Fibonacci numbers. This is not really needed, but it
  // does make it easier to understand.
  uint currentFibonacciNumber = 0;
  
  // Loop through all the stored Fibonacci numbers.
  for(int i = 0; i < [fibonacciNumbersArray count]; i++){
    // Grab the current Fibonacci number.
    currentFibonacciNumber = [[fibonacciNumbersArray objectAtIndex:i] intValue];
    
    // If the current Fibonacci number is even,
    if((currentFibonacciNumber % 2) == 0){
      // Add it to the sum.
      sum += currentFibonacciNumber;
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