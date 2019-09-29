//  Question25.m

#import "Question25.h"
#import "BigInt.h"

@implementation Question25

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"30 August 2002";
  self.hint = @"There's a closed form expression for Fibonacci numbers.";
  self.link = @"https://en.wikipedia.org/wiki/Fibonacci_number";
  self.text = @"The Fibonacci sequence is defined by the recurrence relation:\n\nFn = Fn1 + Fn2, where F1 = 1 and F2 = 1.\n\nHence the first 12 terms will be:\n\nF1 = 1\nF2 = 1\nF3 = 2\nF4 = 3\nF5 = 5\nF6 = 8\nF7 = 13\nF8 = 21\nF9 = 34\nF10 = 55\nF11 = 89\nF12 = 144\nThe 12th term, F12, is the first term to contain three digits.\n\n\nWhat is the first term in the Fibonacci sequence to contain 1000 digits?";
  self.isFun = YES;
  self.title = @"1000-digit Fibonacci number";
  self.answer = @"4782";
  self.number = @"25";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"fibonacci,closed,form,recurrance,terms,sequence,digits,contains,1000,one,thousand,first,number,expression,logarithm";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"11";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"25/01/13";
  self.completedOnDate = @"25/01/13";
  self.solutionLineCount = @"3";
  self.usesHelperMethods = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"4.6e-05";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"3.25e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we use the closed form expression to find the first term with 1000
  // digits. For more information, visit:
  //
  // http://en.wikipedia.org/wiki/Fibonacci_number#Closed-form_expression
  //
  // F_n = (floor)(\phi^{n} / \sqrt(5) + 1 / 2), where \phi = (1 + \sqrt(5)) / 2.
  //
  // Therefore, by applying a logarithm to both sides, and doing some
  // approximations, we arrive at the index. The equation is:
  //
  // (floor)(((digitOfF_n + log_{10}(2 * \sqrt(5))) / log10(\phi)) - (1/2))
  //
  // Then we just put in the values, and we are done!
  
  // Variable to hold the required number of digits. We subtract off 1, to get
  // the real number for the computation.
  uint requiredNumberOfDigits = 1000 - 1;
  
  // Variable to hold the value of \phi.
  double phi = (1.0 + sqrt(5.0)) / 2.0;
  
  // Variable to hold the fibonacci term with the required number of digits. Plus
  // in the formula above.
  uint fibonacciTerm = (uint)(((requiredNumberOfDigits + log10(2.0 * sqrt(5))) / log10(phi)) - 0.5);
  
  // Set the answer string to the fibonacci term.
  self.answer = [NSString stringWithFormat:@"%d", fibonacciTerm];
  
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
  
  // Here, we simply compute the fibonacci numbers until one of them is greater
  // than 10^999.
  
  // Variable to hold the fibonacci term with the required number of digits.
  // Default the term to 3, as we will have precomputed the first 3 terms.
  uint fibonacciTerm = 3;
  
  // Variable to hold the value we will continually multiply with.
  BigInt * baseNumber = [BigInt createFromInt:10];
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // While looping 1000 - 1 times,
  for(int i = 0; i < 999; i++){
    // Store the multiplication of the base number 10 and the result number in a
    // temporary variable.
    temporaryNumber = [baseNumber multiply:resultNumber];
    
    // Set the result number to be the result of the above computation.
    resultNumber = temporaryNumber;
  }
  
  // Set the BigInt variables needed for computing the Fibonacci numbers. Recall:
  //
  // f_i_plus_2 = f_i_plus_1 + f_i, where (f_1 = 1, f_2 = 2).
  
  BigInt * f_i = [BigInt createFromInt:1];
  BigInt * f_i_plus_1 = [BigInt createFromInt:1];
  BigInt * f_i_plus_2 = [f_i add:f_i_plus_1];
  
  // Loop over the Fibonacci numbers to add in all the Fibonacci numbers that
  // are less than the max size defined above.
  while([f_i_plus_2 lessThan:resultNumber]){
    // Increase the fibonacci term by 1.
    fibonacciTerm++;
    
    // Set the previous 2 Fibonacci numbers to the 2 largest.
    f_i = f_i_plus_1;
    f_i_plus_1 = f_i_plus_2;
    
    // Compute the new largest Fibonacci number.
    f_i_plus_2 =[f_i add:f_i_plus_1];
  }
  // Set the answer string to the fibonacci term.
  self.answer = [NSString stringWithFormat:@"%d", fibonacciTerm];
  
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