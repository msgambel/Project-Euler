//  Question76.m

#import "Question76.h"

@interface Question76 (Private)

- (uint)numberOfPartionsForNumber:(uint)aNumber withSmallestValue:(uint)aSmallestValue; 

@end

@implementation Question76

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"13 August 2004";
  self.hint = @"A recursive function would do well here.";
  self.link = @"http://en.wikipedia.org/wiki/Partition_(number_theory)";
  self.text = @"It is possible to write five as a sum in exactly six different ways:\n\n4 + 1\n3 + 2\n3 + 1 + 1\n2 + 2 + 1\n2 + 1 + 1 + 1\n1 + 1 + 1 + 1 + 1\n\nHow many different ways can one hundred be written as a sum of at least two positive integers?";
  self.isFun = YES;
  self.title = @"Counting summations";
  self.answer = @"190569291";
  self.number = @"76";
  self.rating = @"4";
  self.category = @"Counting";
  self.keywords = @"counting,summations,one,hundred,100,two,2,positive,integers,different,ways,at,least,write,exactly";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"13";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"17/03/13";
  self.trickRequired = NO;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"17/03/13";
  self.solutionLineCount = @"13";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"4.71e-04";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = YES;
  self.estimatedBruteForceComputationTime = @"4.71e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to recursively compute the number of
  // partitions for a given value. There is a ton of information on this topic.
  // For more detailed reading, visit:
  //
  // http://en.wikipedia.org/wiki/Partition_(number_theory)
  
  // First, we reset the stored value of partitions for all the possible
  // combinations of numbers and their smallest partition value.
  
  // For all of the numbers from 0 to 100,
  for(int i = 0; i <= 100; i++){
    // For all the parition values from 0 to 100,
    for(int j = 0; j <= 100; j++){
      // Reset the number of partitions with this partition value to 0.
      _numberOfPartitions[i][j] = 0;
    }
  }
  // Variable to hold the number of proper partitions, so use the helper method
  // to compute the number of partitions, and subtract 1 off as we do not
  // include 100.
  uint properPartitions = [self numberOfPartionsForNumber:100 withSmallestValue:1] - 1;
  
  // Set the answer string to the proper integer partitions of 100.
  self.answer = [NSString stringWithFormat:@"%d", properPartitions];
  
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
  
  // Here, we simply use a helper method to recursively compute the number of
  // partitions for a given value. There is a ton of information on this topic.
  // For more detailed reading, visit:
  //
  // http://en.wikipedia.org/wiki/Partition_(number_theory)
  
  // First, we reset the stored value of partitions for all the possible
  // combinations of numbers and their smallest partition value.
  
  // For all of the numbers from 0 to 100,
  for(int i = 0; i <= 100; i++){
    // For all the parition values from 0 to 100,
    for(int j = 0; j <= 100; j++){
      // Reset the number of partitions with this partition value to 0.
      _numberOfPartitions[i][j] = 0;
    }
  }
  // Variable to hold the number of proper partitions, so use the helper method
  // to compute the number of partitions, and subtract 1 off as we do not
  // include 100.
  uint properPartitions = [self numberOfPartionsForNumber:100 withSmallestValue:1] - 1;
  
  // Set the answer string to the proper integer partitions of 100.
  self.answer = [NSString stringWithFormat:@"%d", properPartitions];
  
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

#pragma mark - Private Methods

@implementation Question76 (Private)

- (uint)numberOfPartionsForNumber:(uint)aNumber withSmallestValue:(uint)aSmallestValue; {
  // Variable to hold the number of partitions for the inputted number with the
  // smallest partition value.
  uint numberOfPartitions = 1;
  
  // If the inputted number is greater than 1,
  if(aNumber > 1){
    // For all the partition values from 1 to half the inputted number,
    for(int i = 1; i <= (uint)(aNumber / 2); i++){
      // If the partition value is greater than the inputted smallest partition
      // value,
      if(i >= aSmallestValue){
        // If the number of partitions for this smaller value and the current
        // partition value have NOT been computed yet,
        if(_numberOfPartitions[(aNumber - i)][i] == 0){
          // Compute the number of partitions for this smaller value and the
          // current partition value and store it in the two dimensional array
          // for quick look up later.
          _numberOfPartitions[(aNumber - i)][i] = [self numberOfPartionsForNumber:(aNumber - i) withSmallestValue:i];
        }
        // Add the number of partitions for this smaller value and the current
        // partition value to the total number of partitions for the inputted
        // number.
        numberOfPartitions += _numberOfPartitions[(aNumber - i)][i];
      }
    }
  }
  // Return the number of partitions for the inputted number with the smallest
  // partition value.
  return numberOfPartitions;
}

@end