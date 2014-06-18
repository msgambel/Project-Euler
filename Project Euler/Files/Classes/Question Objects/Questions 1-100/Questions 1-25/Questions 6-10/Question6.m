//  Question6.m

#import "Question6.h"

@implementation Question6

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"14 December 2001";
  self.hint = @"There's a closed form solution for summing the numbers from 1 to n. There's also a closed form solution for summing their squares.";
  self.text = @"The sum of the squares of the first ten natural numbers is,\n\n1² + 2² + ... + 10² = 385\n\nThe square of the sum of the first ten natural numbers is,\n\n(1 + 2 + ... + 10)² = 55² = 3025\n\nHence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640.\n\nFind the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.";
  self.title = @"Sum square difference";
  self.answer = @"25164150";
  self.number = @"6";
  self.keywords = @"square,sum,difference,100,one,hundred,natural,numbers,positive,of,the,first,closed,form,solution";
  self.estimatedComputationTime = @"2.3e-05";
  self.estimatedBruteForceComputationTime = @"2.4e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We need to compute:
  //
  // (\sum_{i=1}^{n}i)² - \sum_{i=1}^{n}(i²)
  //
  // We note that there is a closed form solution for each of these 2 sums:
  //
  // (1) \sum_{i=1}^{n}i = (n * (n+1) / 2).
  //
  // (2) \sum_{i=1}^{n}(i²) = ((n * (n+1) * (2n+1)) / 6).
  
  // Set the sum to 0 before we start iterating over all the numbers.
  long long int sum = 0;
  
  // Set the max size for the number.
  uint maxSize = 100;
  
  // Use equation (1) for the first part of the sum.
  sum = ((maxSize * (maxSize + 1)) / 2);
  
  // Square equation (1).
  sum *= sum;
  
  // Use equation (2) for the second part of the sum.
  sum -= ((maxSize * (maxSize + 1) * (2 * maxSize + 1)) / 6);
  
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
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
  
  // We need to compute:
  //
  // (\sum_{i=1}^{n}i)² - \sum_{i=1}^{n}(i²)
  //
  // Therefore, we will simply compute each value, and sum them together.
  
  // Set the sum to 0 before we start iterating over all the numbers.
  long long int sum = 0;
  
  // Set the max size for the number.
  uint maxSize = 100;
  
  // For all the numbers from 1 to the maxSize,
  for(int i = 1; i <= maxSize; i++){
    // Add the number to the sum.
    sum += i;
  }
  // Square the sum.
  sum *= sum;
  
  // For all the numbers from 1 to the maxSize,
  for(int i = 1; i <= maxSize; i++){
    // Subtract the square of the number from the sum.
    sum -= (i * i);
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
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