//  Question45.m

#import "Question45.h"

@implementation Question45

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"28 February 2003";
  self.hint = @"Using some simple algebra, solve when the radical is a perfect square, since all Triangle, Pentagonal, and Hexagonal numbers must be integers.";
  self.link = @"https://en.wikipedia.org/wiki/Pandigital_number";
  self.text = @"Take the number 192 and multiply it by each of 1, 2, and 3:\n\n192 x 1 = 192\n192 x 2 = 384\n192 x 3 = 576\n\nBy concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)\n\nThe same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).\n\nWhat is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?";
  self.isFun = YES;
  self.title = @"Pandigital mutiples";
  self.answer = @"1533776805";
  self.number = @"45";
  self.rating = @"4";
  self.category = @"Combinations";
  self.keywords = @"pandigital,multiples,triangle,pentagonal,hexagonal,concatenated,product,9,nine,digit,number,formed,integer,odd,largest";
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"15";
  self.isChallenging = NO;
  self.startedOnDate = @"14/02/13";
  self.completedOnDate = @"14/02/13";
  self.solutionLineCount = @"11";
  self.usesHelperMethods = YES;
  self.estimatedComputationTime = @"8.31e-04";
  self.estimatedBruteForceComputationTime = @"8.31e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note that a Hexogonal number is equal to a Triangle number if and
  // only if n is odd, and H_n = T_{2n - 1}. To see this, a simple calculation:
  //
  // If T_n = H_m:
  //
  // => (1/2)n(n + 1) = m(2m - 1)
  // => n(n + 1) = 2m(2m - 1)
  // => n² + n = 4m² - 2m
  //
  // Let n = am + b, for some constants a and b.
  //
  // => (am + b)² + (am + b) = 4m² - 2m
  // => a²m² + 2abm + b² + am + b = 4m²-2m
  //
  // Therefore, a² = 4 => a = 2.
  //
  // => (4b + 2)m + b² + b = -2m
  //
  // Therefore, 4b + 2 = -2, b² = -b => b = -1.
  //
  // Therefore, we have n = 2m - 1.
  //
  // Now, looking at the equality H_n = P_m, we arrive at:
  //
  // => (1/2)n(3n - 1) = m(2m - 1)
  // => 2m² - m = H_n
  //
  // Using the Quadratic Equation, we arrive at:
  //
  // 1 +/- sqrt(1 + 8 * H_n)
  // -----------------------
  //            4
  //
  // Therefore, we need only check when the radical: sqrt(1 + 8 * H_n) is an
  // integer, since all Triangle, Pentagonal, and Hexagonal numbers must be
  // integers.
  
  // Variable to hold the current radical squared.
  long long int currentRadicalSquared = 0;
  
  // Variable to hold the current Hexagonal number.
  long long int currentHexagonalNumber = 0;
  
  // For all the numbers to check up to, starting after the once given in the
  // Question, and iterating by 2, as the n must be odd.
  for(long long int n = 167; n < 50000; n += 2){
    // Conpute the current Hexagonal number
    currentHexagonalNumber = n * (3 * n - 1) / 2;
    
    // Compute the current radical squared.
    currentRadicalSquared = 1 + 8 * currentHexagonalNumber;
    
    // If the current radical squared is a perfect square,
    if([self isNumberAPerfectSquare:currentRadicalSquared]){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the next triangle number, which is also hexagonal,
  // and pentagonal.
  self.answer = [NSString stringWithFormat:@"%llu", currentHexagonalNumber];
  
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
  
  // Here, we note that a Hexogonal number is equal to a Triangle number if and
  // only if n is odd, and H_n = T_{2n - 1}. To see this, a simple calculation:
  //
  // If T_n = H_m:
  //
  // => (1/2)n(n + 1) = m(2m - 1)
  // => n(n + 1) = 2m(2m - 1)
  // => n² + n = 4m² - 2m
  //
  // Let n = am + b, for some constants a and b.
  //
  // => (am + b)² + (am + b) = 4m² - 2m
  // => a²m² + 2abm + b² + am + b = 4m²-2m
  //
  // Therefore, a² = 4 => a = 2.
  //
  // => (4b + 2)m + b² + b = -2m
  //
  // Therefore, 4b + 2 = -2, b² = -b => b = -1.
  //
  // Therefore, we have n = 2m - 1.
  //
  // Now, looking at the equality H_n = P_m, we arrive at:
  //
  // => (1/2)n(3n - 1) = m(2m - 1)
  // => 2m² - m = H_n
  //
  // Using the Quadratic Equation, we arrive at:
  //
  // 1 +/- sqrt(1 + 8 * H_n)
  // -----------------------
  //            4
  //
  // Therefore, we need only check when the radical: sqrt(1 + 8 * H_n) is an
  // integer, since all Triangle, Pentagonal, and Hexagonal numbers must be
  // integers.
  
  // Variable to hold the current radical squared.
  long long int currentRadicalSquared = 0;
  
  // Variable to hold the current Hexagonal number.
  long long int currentHexagonalNumber = 0;
  
  // For all the numbers to check up to, starting after the once given in the
  // Question, and iterating by 2, as the n must be odd.
  for(long long int n = 167; n < 50000; n += 2){
    // Conpute the current Hexagonal number
    currentHexagonalNumber = n * (3 * n - 1) / 2;
    
    // Compute the current radical squared.
    currentRadicalSquared = 1 + 8 * currentHexagonalNumber;
    
    // If the current radical squared is a perfect square,
    if([self isNumberAPerfectSquare:currentRadicalSquared]){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the next triangle number, which is also hexagonal,
  // and pentagonal.
  self.answer = [NSString stringWithFormat:@"%llu", currentHexagonalNumber];
  
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