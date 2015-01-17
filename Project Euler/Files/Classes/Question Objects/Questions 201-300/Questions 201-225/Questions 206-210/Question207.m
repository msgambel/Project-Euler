//  Question207.m

#import "Question207.h"

@implementation Question207

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"06 September 2008";
  self.hint = @"Use the quadratic equation, and a clever substitution.";
  self.text = @"For some positive integers k, there exists an integer partition of the form\n\n4^t = 2^t + k,\n\nwhere 4^t, 2^t, and k are all positive integers and t is a real number.\n\nThe first two such partitions are 4^1 = 2^1 + 2 and 4^1.5849625... = 2^1.5849625... + 6.\n\nPartitions where t is also an integer are called perfect.\n\nFor any m >= 1 let P(m) be the proportion of such partitions that are perfect with k <= m. Thus P(6) = 1/2.\n\nIn the following table are listed some values of P(m)\n\nP(5) = 1/1\nP(10) = 1/2\nP(15) = 2/3\nP(20) = 1/2\nP(25) = 1/2\nP(30) = 2/5\n...\nP(180) = 1/4\nP(185) = 3/13\n\nFind the smallest m for which P(m) < 1/12345";
  self.title = @"Integer partition equations";
  self.answer = @"44043947822";
  self.number = @"207";
  self.rating = @"5";
  self.keywords = @"integer,partition,equations,two,2,power,quadratic,smallest,form";
  self.estimatedComputationTime = @"1.19e-02";
  self.estimatedBruteForceComputationTime = @"1.19e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the quadratic equation to solve our problem. Write:
  //
  // (1) 4^t = 2^t + k
  //
  // as x² = x + k, with x = 2^t. Therefore,
  //
  // (2) x² - x - k = 0;
  //
  // Then, by the quadratic equation, we have:
  //
  //         1 + sqrt(1 + 4k)
  // (3) x = ----------------
  //                2
  //
  // Subbing back in x = 2^t, we arrive at:
  //
  // (4) 2^(t+1) = 1 + sqrt(1 + 4k)
  //
  // Notice that (1 + 4k) describes every odd square, as if n is odd, write
  // n = 2m + 1. Then,
  //
  // (5) n² = (2m + 1)² = 4m² + 4m + 1 = 4(m² + m) + 1 = 4k + 1
  //
  // (with k = (m² + m)). Therefore, we need only check if an odd square plus 1
  // will be a power of 2. If it is, the odd square will generate a perfect
  // partition.
  //
  // Note: We could make this even faster by counting the powers of two
  //       separately from the odd squares. So if the target fraction is smaller
  //       than the one in the question, we could actually compute the valid
  //       partitions easier!
  
  // Variable to hold the numerator of P(m).
  uint numerator = 1;
  
  // Variable to hold the denominator of P(m).
  uint denominator = 2;
  
  // Variable to hold the current odd square we are examining.
  long long int oddSquare = 5;
  
  // Variable to hold the log (base 2) of the odd square.
  double logOfSquare = 0;
  
  // Variable to hold the target fraction for P(m).
  double targetFraction = 1.0 / 12345.0;
  
  // While we have not yet hit our target fraction,
  while((((double)numerator) / ((double)denominator)) >= targetFraction){
    // Move to the next odd square by incrementing by 2.
    oddSquare += 2;
    
    // Increment the denominator by 1.
    denominator++;
    
    // Compute the log (base 2) of the odd square plus 1 via equation (4).
    logOfSquare = log2((double)(oddSquare + 1));
    
    // If the odd square plus 1 is a power of 2,
    if(((double)((uint)logOfSquare)) == logOfSquare){
      // Increment the numerator by 1.
      numerator++;
    }
  }
  // Set the answer string to the smallest m which gives us our fraction using
  // equation (5).
  self.answer = [NSString stringWithFormat:@"%llu", ((oddSquare * oddSquare) - 1) / 4];
  
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
  
  // Here, we simply use the quadratic equation to solve our problem. Write:
  //
  // (1) 4^t = 2^t + k
  //
  // as x² = x + k, with x = 2^t. Therefore,
  //
  // (2) x² - x - k = 0;
  //
  // Then, by the quadratic equation, we have:
  //
  //         1 + sqrt(1 + 4k)
  // (3) x = ----------------
  //                2
  //
  // Subbing back in x = 2^t, we arrive at:
  //
  // (4) 2^(t+1) = 1 + sqrt(1 + 4k)
  //
  // Notice that (1 + 4k) describes every odd square, as if n is odd, write
  // n = 2m + 1. Then,
  //
  // (5) n² = (2m + 1)² = 4m² + 4m + 1 = 4(m² + m) + 1 = 4k + 1
  //
  // (with k = (m² + m)). Therefore, we need only check if an odd square plus 1
  // will be a power of 2. If it is, the odd square will generate a perfect
  // partition.
  //
  // Note: We could make this even faster by counting the powers of two
  //       separately from the odd squares. So if the target fraction is smaller
  //       than the one in the question, we could actually compute the valid
  //       partitions easier!
  
  // Variable to hold the numerator of P(m).
  uint numerator = 1;
  
  // Variable to hold the denominator of P(m).
  uint denominator = 2;
  
  // Variable to hold the current odd square we are examining.
  long long int oddSquare = 5;
  
  // Variable to hold the log (base 2) of the odd square.
  double logOfSquare = 0;
  
  // Variable to hold the target fraction for P(m).
  double targetFraction = 1.0 / 12345.0;
  
  // While we have not yet hit our target fraction,
  while((((double)numerator) / ((double)denominator)) >= targetFraction){
    // Move to the next odd square by incrementing by 2.
    oddSquare += 2;
    
    // Increment the denominator by 1.
    denominator++;
    
    // Compute the log (base 2) of the odd square plus 1 via equation (4).
    logOfSquare = log2((double)(oddSquare + 1));
    
    // If the odd square plus 1 is a power of 2,
    if(((double)((uint)logOfSquare)) == logOfSquare){
      // Increment the numerator by 1.
      numerator++;
    }
  }
  // Set the answer string to the smallest m which gives us our fraction using
  // equation (5).
  self.answer = [NSString stringWithFormat:@"%llu", ((oddSquare * oddSquare) - 1) / 4];
  
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