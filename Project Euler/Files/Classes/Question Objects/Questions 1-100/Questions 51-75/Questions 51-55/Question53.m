//  Question53.m

#import "Question53.h"
#import "BigInt.h"

@implementation Question53

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"26 September 2003";
  self.hint = @"(n choose r) = (n choose (n-r)).";
  self.link = @"https://en.wikipedia.org/wiki/Binomial_coefficient";
  self.text = @"There are exactly ten ways of selecting three from five, 12345:\n\n123, 124, 125, 134, 135, 145, 234, 235, 245, and 345\n\nIn combinatorics, we use the notation, 5C3 = 10.\n\nIn general,\n\nnCr = n! / r!(nr)!,\n\nwhere r <= n, n! = nx(n-1)...3x2x1, and 0! = 1.\n\nIt is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.\n\nHow many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are greater than one-million?";
  self.isFun = NO;
  self.title = @"Combinatoric selections";
  self.answer = @"4075";
  self.number = @"53";
  self.rating = @"5";
  self.category = @"Combinations";
  self.isUseful = YES;
  self.keywords = @"choose,sum,combinatoric,selections,not,greater,distinct,exceeds,one,million,1000000,value,selecting";
  self.loadsFile = NO;
  self.solveTime = @"60";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = YES;
  self.commentCount = @"22";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"22/02/13";
  self.trickRequired = NO;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"22/02/13";
  self.solutionLineCount = @"15";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"3.7e-05";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"3.93";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute n choose r only up to a point. Note that:
  //
  // n choose 1 = 100 / 1
  //
  // n choose 2 = 100 * 99 / 1 * 2
  //
  // n choose 3 = 100 * 99 * 98 / 1 * 2 * 3, etc.
  //
  // So if the current iteration is m, and we multiple by (n-m) and divide by m,
  // we can compare to see if the number is greater than 1,000,000, and if it is,
  // we can increment the number of results that are larger enough.
  //
  // Another observation: (n choose r) = (n choose (n-r)).
  //
  // Therefore, once we find an r value such that n choose r is greater than
  // 1,000,000, we know that n choose r, (r+1), ..., ((n-r)-1), and (n-r) will
  // also generate a large enough result. Counting how many there are is simple:
  //
  // \sum_{i = r}^{(n-r)} 1 =   \sum_{i = 0}^{n} 1
  //                          - \sum_{i = 0}^{r-1} 1
  //                          - \sum_{i = (((n-r)+1)}^{n}
  //
  //                        = (n+1) - (r+1) - (n-((n-r)+1))
  //                        = (n+1) - (r+1) - (r-1)
  //                        = (n+1) - (2r)
  //
  // So once we find an r value such that n choose r is greater than 1,000,000,
  // we increment the number of results that are larger enough by ((n+1) - (2r)).
  
  // Variable to hold the current numerator when multiplying n, (n-1), (n-2), ...
  int currentNumerator = 0;
  
  // Variable to hold the minimum size, 1,000,000.
  uint minSize = 1000000;
  
  // Variable to hold the current iteration value of n choose r.
  uint nChooseR = 0;
  
  // Variable to hold the number of results larger than the minimum size.
  uint numberOfResultsLargeEnough = 0;
  
  // For all the n from 1 to 100,
  for(int n = 23; n <= 100; n++){
    // Grab the next index to iterate over for the numerator.
    currentNumerator = (n - 1);
    
    // Start the n Choose r at its starting value, n / 1.
    nChooseR = n;
    
    // For all r from 1 to 10 (no need to check beyond 10, as n choose 10 is
    // greater than 1,000,000 for all n >= 23),
    for(int r = 2; r <= 10; r++){
      // Multiple n choose r by the next numerator multiple in the iteration.
      nChooseR *= currentNumerator;
      
      // Divide n choose r by the next denominator multiple in the iteration.
      nChooseR /= r;
      
      // Decrement the next numerator multiple in the iteration by 1.
      currentNumerator--;
      
      // If the current iteration of n choose r is large enough,
      if(nChooseR > minSize){
        // Increment the number of results that are larger enough by the amount
        // described above.
        numberOfResultsLargeEnough += ((n + 1) - (2 * r));
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the number of results larger than the minimum size.
  self.answer = [NSString stringWithFormat:@"%d", numberOfResultsLargeEnough];
  
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
  
  // Here, we simply compute all the possible n choose r values using our BigInt
  // class and see which values are larger than 1,000,000.
  
  // Variable to hold the number of results larger than the minimum size.
  uint numberOfResultsLargeEnough = 0;
  
  // Variable to hold the minimum size, 1,000,000.
  BigInt * minSize = [BigInt createFromInt:1000000];
  
  // Variable thold hold n choose r.
  BigInt * nChooseR = nil;
  
  // For all the n from 1 to 100,
  for(int n = 1; n <= 100; n++){
    // For all r from 0 to n,
    for(int r = 0; r <= n; r++){
      // Compute n choose r.
      nChooseR = [BigInt n:n chooseR:r];
      
      // If n choose r is greater than 1,000,000,
      if([nChooseR greaterThanOrEqualTo:minSize]){
        // Increment the number of results that are large enough by 1.
        numberOfResultsLargeEnough++;
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
    // Set the answer string to the number of results larger than the minimum size.
    self.answer = [NSString stringWithFormat:@"%d", numberOfResultsLargeEnough];
    
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