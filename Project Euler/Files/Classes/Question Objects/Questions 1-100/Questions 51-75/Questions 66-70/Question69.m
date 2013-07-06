//  Question69.m

#import "Question69.h"

@implementation Question69

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"07 May 2004";
  self.text = @"Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.\n\nn	Relatively Prime     φ(n)    n/φ(n)\n2	1	1	2\n3	1,2	2	1.5\n4	1,3	2	2\n5	1,2,3,4	4	1.25\n6	1,5	2	3\n7	1,2,3,4,5,6	6	1.1666...\n8	1,3,5,7	4	2\n9	1,2,4,5,7,8	6	1.5\n10	1,3,7,9	4	2.5\n\nIt can be seen that n=6 produces a maximum n/φ(n) for n <= 10.\n\nFind the value of n <= 1,000,000 for which n/φ(n) is a maximum.";
  self.title = @"Totient maximum";
  self.answer = @"510510";
  self.number = @"69";
  self.keywords = @"totient,maximum,phi,euler,function,relatively,prime";
  self.estimatedComputationTime = @"2.8e-05";
  self.estimatedBruteForceComputationTime = @"2.8e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply note that in order to maximize (n/φ(n)), we just need to
  // minimize φ(n). But the totient function is just the number of numbers that
  // are relatively prime to n. So the more distinct prime factors n has, the
  // less numbers that are relatively prime to n. Therefore, we just need to
  // multiply the smallest primes until we get a number just below the maximum
  // size, and we're done!
  
  // Variable to hold the number that minimizes φ(n).
  uint n = 2 * 3 * 5 * 7 * 11 * 13 * 17;
    
  // Set the answer string to the number that minimizes φ(n).
  self.answer = [NSString stringWithFormat:@"%d", n];
  
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
  
  // Here, we simply note that in order to maximize (n/φ(n)), we just need to
  // minimize φ(n). But the totient function is just the number of numbers that
  // are relatively prime to n. So the more distinct prime factors n has, the
  // less numbers that are relatively prime to n. Therefore, we just need to
  // multiply the smallest primes until we get a number just below the maximum
  // size, and we're done!
  
  // Variable to hold the number that minimizes φ(n).
  uint n = 2 * 3 * 5 * 7 * 11 * 13 * 17;
  
  // Set the answer string to the number that minimizes φ(n).
  self.answer = [NSString stringWithFormat:@"%d", n];
  
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