//  Question131.m

#import "Question131.h"

@implementation Question131

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"10 November 2006";
  self.hint = @"Difference of cubes will solve this problem!";
  self.link = @"https://www.cliffsnotes.com/study-guides/algebra/algebra-ii/factoring-polynomials/sum-or-difference-of-cubes";
  self.text = @"There are some prime values, p, for which there exists a positive integer, n, such that the expression n³ + n²p is a perfect cube.\n\nFor example, when p = 19, 8³ + 8²x19 = 12³.\n\nWhat is perhaps most surprising is that for each prime with this property the value of n is unique, and there are only four such primes below one-hundred.\n\nHow many primes below one million have this remarkable property?";
  self.isFun = YES;
  self.title = @"Prime cube partnership";
  self.answer = @"173";
  self.number = @"131";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"primes,cube,partnership,factoring,positive,integer,property,difference,of,cubes,one,million,1000000,value,unique";
  self.solveTime = @"60";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"18";
  self.isChallenging = NO;
  self.completedOnDate = @"14/04/13";
  self.solutionLineCount = @"37";
  self.usesHelperMethods = YES;
  self.estimatedComputationTime = @"1.77e-04";
  self.estimatedBruteForceComputationTime = @"1.77e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use some clever substitution to solve the equation. Notice
  // for 2 any positive numbers a and b, we have:
  //
  // (1) (a³ - b³) = (a - b)(a² + ab + b²)
  //
  // Take n a positive integer, and define a = n³ + n², and b = n³. Then we
  // have (by (1)):
  //
  // (2) (a³ - b³) = (a - b)(a² + ab + b²)
  //               = ((n³ + n²) - (n³))((n³ + n²)² + (n³ + n²)(n³) + (n³)²)
  //               = (n²)((n⁶ + 2n⁵ + n⁴) + (n⁶ + n⁵) + (n⁶))
  //               = (n²)(3n⁶ + 3n⁵ + n⁴)
  //               = (n⁶)(3n² + 3n + 1)
  //               = b²(3n² + 3n + 1)
  //
  // Notice that (2) is exactly the same form that the question is asking.
  // Therefore, we need only check if:
  //
  // (3) (3n² + 3n + 1) is a prime less than 1,000,000.
  //
  // This is quite straight-forward at this stage.
  
  // Variable to hold the potential prime number from (3).
  uint potentialPrime = 0;
  
  // Variable to hold the maximum size of the prime number.
  uint maximumPrimeSize = 1000000;
  
  // Variable to hold the maximum size of n by (3).
  uint maximumValueOfN = (uint)sqrt(maximumPrimeSize / 3);
  
  // Variable to hold the number of primes with this cube property.
  uint primesWithCubeProperty = 0;
  
  // For all the positive integers up to the maximum values,
  for(int n = 1; n < maximumValueOfN; n++){
    // Comupte the potential prime by (3)
    potentialPrime = (3 * n * n) + (3 * n) + 1;
    
    // If the potential prime is greater than the maximum prime size,
    if(potentialPrime > maximumPrimeSize){
      // Break out of the loop.
      break;
    }
    // If the potential prime is a prime number,
    if([self isPrime:potentialPrime]){
      // Increment the number of primes with the cube property by 1.
      primesWithCubeProperty++;
    }
  }
  // Set the answer string to the number of prime numbers with the cube property.
  self.answer = [NSString stringWithFormat:@"%d", primesWithCubeProperty];
  
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
  
  // Here, we simply use some clever substitution to solve the equation. Notice
  // for 2 any positive numbers a and b, we have:
  //
  // (1) (a³ - b³) = (a - b)(a² + ab + b²)
  //
  // Take n a positive integer, and define a = n³ + n², and b = n³. Then we
  // have (by (1)):
  //
  // (2) (a³ - b³) = (a - b)(a² + ab + b²)
  //               = ((n³ + n²) - (n³))((n³ + n²)² + (n³ + n²)(n³) + (n³)²)
  //               = (n²)((n⁶ + 2n⁵ + n⁴) + (n⁶ + n⁵) + (n⁶))
  //               = (n²)(3n⁶ + 3n⁵ + n⁴)
  //               = (n⁶)(3n² + 3n + 1)
  //               = b²(3n² + 3n + 1)
  //
  // Notice that (2) is exactly the same form that the question is asking.
  // Therefore, we need only check if:
  //
  // (3) (3n² + 3n + 1) is a prime less than 1,000,000.
  //
  // This is quite straight-forward at this stage.
  
  // Variable to hold the potential prime number from (3).
  uint potentialPrime = 0;
  
  // Variable to hold the maximum size of the prime number.
  uint maximumPrimeSize = 1000000;
  
  // Variable to hold the maximum size of n. We could just have a break in the
  // loop, but this is easier because of (3).
  uint maximumValueOfN = (uint)sqrt(maximumPrimeSize / 3);
  
  // Variable to hold the number of primes with this cube property.
  uint primesWithCubeProperty = 0;
  
  // For all the positive integers up to the maximum values,
  for(int n = 1; n < maximumValueOfN; n++){
    // Comupte the potential prime by (3)
    potentialPrime = (3 * n * n) + (3 * n) + 1;
    
    // If the potential prime is greater than the maximum prime size,
    if(potentialPrime > maximumPrimeSize){
      // Break out of the loop.
      break;
    }
    // If the potential prime is a prime number,
    if([self isPrime:potentialPrime]){
      // Increment the number of primes with the cube property by 1.
      primesWithCubeProperty++;
    }
  }
  // Set the answer string to the number of prime numbers with the cube property.
  self.answer = [NSString stringWithFormat:@"%d", primesWithCubeProperty];
  
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