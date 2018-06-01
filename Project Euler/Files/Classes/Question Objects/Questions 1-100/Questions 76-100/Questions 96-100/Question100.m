//  Question100.m

#import "Question100.h"

@implementation Question100

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"15 July 2005";
  self.hint = @"Use some algebra and the quadratic formula!";
  self.link = @"https://en.wikipedia.org/wiki/Quadratic_equation";
  self.text = @"If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)(14/20) = 1/2.\n\nThe next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box containing eighty-five blue discs and thirty-five red discs.\n\nBy finding the first arrangement to contain over 10^12 = 1,000,000,000,000 discs in total, determine the number of blue discs that the box would contain.";
  self.isFun = YES;
  self.title = @"Arranged probability";
  self.answer = @"756872327473";
  self.number = @"100";
  self.rating = @"5";
  self.category = @"Probability";
  self.keywords = @"arranged,probability,blue,red,disks,50,fifty,random,percent,half,1/2,box,contain";
  self.solveTime = @"60";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.commentCount = @"15";
  self.isChallenging = YES;
  self.completedOnDate = @"10/04/13";
  self.solutionLineCount = @"7";
  self.usesHelperMethods = NO;
  self.estimatedComputationTime = @"2.4e-05";
  self.estimatedBruteForceComputationTime = @"2.4e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply do a bit of math to figure out the solution. Let T be the
  // total number of disks, and R be the number of red disks. Therefore, the
  // number of blue disks is (T - R). Therefore, we have:
  //
  //       (T - R) * (T - R - 1)   1
  // (1)   --------------------- = -
  //          T    *   (T - 1)     2
  //
  //
  // => 2(T² - TR - T - TR + R² + R) = T² - T
  // => T² - (4R + 1)T + 2(R² + R) = 0
  //
  // Therefore, using the quadratic formula, we have:
  //
  //        (4R + 1) + sqrt((4R + 1)² - 4 * (2(R² + R)))
  // => T = --------------------------------------------
  //                              2
  //
  //        (4R + 1) + sqrt(16R² + 8R + 1 - 8R² - 8R)
  // => T = -----------------------------------------
  //                            2
  //
  //            (4R + 1) + sqrt(8R² + 1)
  // => (2) T = ------------------------
  //                       2
  //
  // Therefore, the only time we can get (1) to work with integer values is when
  // (3) (8R² + 1) is a perfect sqaure. Now we could just try all m values in
  // order to find which values allow (3) to be a perfect square, but this would
  // require use of the BigInt class, and there would also be a large number of
  // values to test.
  //
  // Instead, we can use the fact that the next value that will satisfy (2) will
  // be in the same ratio as the radical under the square root, namely, sqrt(8),
  // or 2*sqrt(2). Notice that to get the number of blue disks from (2), we must
  // substract off the number of red disks, which is of course equal to R.
  // Therefore, we need only compute the number of blue disks at each iteration,
  // and multiply it by the radical each time in order to find the answer! It
  // ends up being only a few multiplications!
  
  // Variable to hold the multiple for each increase.
  double radical = (2.0 * sqrt(2.0) + 3.0);
  
  // Variable to hold the number of blue disks in each iteration. Start it at
  // 3, as that is the first case where (3/4)*(2/3) = 1/2.
  long long int numberOfBlueDisks = 3;
  
  // Variable to hold the minimum required number of disks.
  long long int requiredNumberOfDisks = 1000000000000;
  
  // Compute the maximum number of iterations, which is just the log of the
  // required number of disks with the radical as the base.
  int maxIteration = ((uint)(log(requiredNumberOfDisks) / log(radical)));
  
  // For all the iterations up to the maximum,
  for(int i = 0; i < maxIteration; i++){
    // Multiply the number of blue disks by the radical.
    numberOfBlueDisks *= radical;
    
    // Subtract 2 off the number of blue disks, as they would be added to the
    // red disks total in order to keep the ratio.
    numberOfBlueDisks -= 2;
  }
  // Set the answer string to the number of blue disks.
  self.answer = [NSString stringWithFormat:@"%llu", numberOfBlueDisks];
  
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
  
  // Here, we simply do a bit of math to figure out the solution. Let T be the
  // total number of disks, and R be the number of red disks. Therefore, the
  // number of blue disks is (T - R). Therefore, we have:
  //
  //       (T - R) * (T - R - 1)   1
  // (1)   --------------------- = -
  //          T    *   (T - 1)     2
  //
  //
  // => 2(T² - TR - T - TR + R² + R) = T² - T
  // => T² - (4R + 1)T + 2(R² + R) = 0
  //
  // Therefore, using the quadratic formula, we have:
  //
  //        (4R + 1) + sqrt((4R + 1)² - 4 * (2(R² + R)))
  // => T = --------------------------------------------
  //                              2
  //
  //        (4R + 1) + sqrt(16R² + 8R + 1 - 8R² - 8R)
  // => T = -----------------------------------------
  //                            2
  //
  //            (4R + 1) + sqrt(8R² + 1)
  // => (2) T = ------------------------
  //                       2
  //
  // Therefore, the only time we can get (1) to work with integer values is when
  // (3) (8R² + 1) is a perfect sqaure. Now we could just try all m values in
  // order to find which values allow (3) to be a perfect square, but this would
  // require use of the BigInt class, and there would also be a large number of
  // values to test.
  //
  // Instead, we can use the fact that the next value that will satisfy (2) will
  // be in the same ratio as the radical under the square root, namely, sqrt(8),
  // or 2*sqrt(2). Notice that to get the number of blue disks from (2), we must
  // substract off the number of red disks, which is of course equal to R.
  // Therefore, we need only compute the number of blue disks at each iteration,
  // and multiply it by the radical each time in order to find the answer! It
  // ends up being only a few multiplications!
  
  // Variable to hold the multiple for each increase.
  double radical = (2.0 * sqrt(2.0) + 3.0);
  
  // Variable to hold the number of blue disks in each iteration. Start it at
  // 3, as that is the first case where (3/4)*(2/3) = 1/2.
  long long int numberOfBlueDisks = 3;
  
  // Variable to hold the minimum required number of disks.
  long long int requiredNumberOfDisks = 1000000000000;
  
  // Compute the maximum number of iterations, which is just the log of the
  // required number of disks with the radical as the base.
  int maxIteration = ((uint)(log(requiredNumberOfDisks) / log(radical)));
  
  // For all the iterations up to the maximum,
  for(int i = 0; i < maxIteration; i++){
    // Multiply the number of blue disks by the radical.
    numberOfBlueDisks *= radical;
    
    // Subtract 2 off the number of blue disks, as they would be added to the
    // red disks total in order to keep the ratio.
    numberOfBlueDisks -= 2;
  }
  // Set the answer string to the number of blue disks.
  self.answer = [NSString stringWithFormat:@"%llu", numberOfBlueDisks];
  
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