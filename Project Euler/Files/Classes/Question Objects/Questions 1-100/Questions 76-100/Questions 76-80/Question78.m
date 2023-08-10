//  Question78.m

#import "Question78.h"
#import "Macros.h"

@implementation Question78

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"10 September 2004";
  self.hint = @"Use the Pentagonal number theorem.";
  self.link = @"http://en.wikipedia.org/wiki/Pentagonal_number_theorem";
  self.text = @"Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can separated into piles in exactly seven different ways, so p(5)=7.\n\nOOOOO\nOOOO   O\nOOO   OO\nOOO   O   O\nOO   OO   O\nOO   O   O   O\nO   O   O   O   O\n\nFind the least value of n for which p(n) is divisible by one million.";
  self.isFun = YES;
  self.title = @"Coin partitions";
  self.answer = @"55374";
  self.number = @"78";
  self.rating = @"3";
  self.category = @"Combinations";
  self.isUseful = YES;
  self.keywords = @"coin,paritions,divisible,unique,piles,separated,1000000,one,million,least,value";
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.commentCount = @"35";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"19/03/13";
  self.trickRequired = NO;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = YES;
  self.completedOnDate = @"19/03/13";
  self.solutionLineCount = @"29";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.261";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.261";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the pentagonal number theorem to compute p(n) for all n
  // until 1,000,000 divides p(n). Since p(n) grows exponentially, and we only
  // care about the last 6 digits, we simply mod p(n) by 1,000,000 at every step
  // of the computation, as anything larger doesn't matter. The recursive
  // definition is:
  //
  // p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + ...
  //
  // where we are subtracting off the generalized pentagonal number less than n.
  // For more detailed information, visit:
  //
  // http://en.wikipedia.org/wiki/Pentagonal_number_theorem
  
  // Variable to hold the sign of the current term in the expansion. Recall the
  // pattern goes +,+,-,-,+,+,-,-,... .
  int sign = 0;
  
  // Variable to hold the current pentagonal number in the expansion.
  int currentPentagonalNumber = 0;
  
  // Variable to hold the generalized pentagonal number for the current
  // partition in the expansion.
  int generalizedPentagonalNumber = 0;
  
  // Variable to hold the number with the required number of partitions.
  int numberWithRequiredNumberOfPartitions = 0;
  
  // Variable array to hold the number of partitions of each number n.
  int p[60001] = {0};
  
  // Set the default value of p(0) = 1;
  p[0] = 1;
  
  // For all the number from 1 to 60,000 (chosen at to be the same size as the
  // array p above, since we are not dynamically allocating memory),
  for(int n = 1; n < 60001; n++){
    // Reset the sign of the current term to 0.
    sign = 0;
    
    // Continually loop until we've reached the last term in the expansion,
    while(YES){
      // Compute the current pentagonal number.
      currentPentagonalNumber = ((int)(sign / 2) + 1);
      
      // If the sign is even,
      if((sign % 2) == 0){
        // Compute the generalized pentagonal number of the positive pentagonal
        // number.
        generalizedPentagonalNumber = PentagonalNumber(currentPentagonalNumber);
      }
      // If the sign is odd,
      else{
        // Compute the generalized pentagonal number of the negative pentagonal
        // number, which will still be a positive number.
        generalizedPentagonalNumber = PentagonalNumber(-currentPentagonalNumber);
      }
      // If the generalized pentagonal number is greater than the current number,
      if(generalizedPentagonalNumber > n){
        // Break out of the loop.
        break;
      }
      // If the sign is 0 or 1 mod 4,
      if((sign % 4) < 2){
        // Add the term in the expansion to the number of partitions for the
        // current number.
        p[n] += p[n - generalizedPentagonalNumber];
      }
      // If the sign is 2 or 3 mod 4,
      else{
        // Subtract the term in the expansion to the number of partitions for the
        // current number.
        p[n] -= p[n - generalizedPentagonalNumber];
      }
      // Keep only the last 6 digits of the number of partitions of the current
      // number.
      p[n] %= 1000000;
      
      // If the number of partitions is a negative number,
      if(p[n] < 0){
        // Increment the number of partitions of the current number by 1,000,000,
        // as there was an error when taking the modulo above.
        p[n] += 1000000;
      }
      // Increment the sign by 1 to move to the next term.
      sign++;
    }
    // If the number of partitions of the current number is 0 (i.e.: divisible
    // by 1,000,000, as we removed all but the last 6 digits of the numbers),
    if(p[n] == 0){
      // Store the number with the required number of partitions.
      numberWithRequiredNumberOfPartitions = n;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the number with the required number of partitions.
  self.answer = [NSString stringWithFormat:@"%d", numberWithRequiredNumberOfPartitions];
  
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
  
  // Here, we simply use the pentagonal number theorem to compute p(n) for all n
  // until 1,000,000 divides p(n). Since p(n) grows exponentially, and we only
  // care about the last 6 digits, we simply mod p(n) by 1,000,000 at every step
  // of the computation, as anything larger doesn't matter. The recursive
  // definition is:
  //
  // p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + ...
  //
  // where we are subtracting off the generalized pentagonal number less than n.
  // For more detailed information, visit:
  //
  // http://en.wikipedia.org/wiki/Pentagonal_number_theorem
  
  // Variable to hold the sign of the current term in the expansion. Recall the
  // pattern goes +,+,-,-,+,+,-,-,... .
  int sign = 0;
  
  // Variable to hold the current pentagonal number in the expansion.
  int currentPentagonalNumber = 0;
  
  // Variable to hold the generalized pentagonal number for the current
  // partition in the expansion.
  int generalizedPentagonalNumber = 0;
  
  // Variable to hold the number with the required number of partitions.
  int numberWithRequiredNumberOfPartitions = 0;
  
  // Variable array to hold the number of partitions of each number n.
  int p[60001] = {0};
  
  // Set the default value of p(0) = 1;
  p[0] = 1;
  
  // For all the number from 1 to 60,000 (chosen at to be the same size as the
  // array p above, since we are not dynamically allocating memory),
  for(int n = 1; n < 60001; n++){
    // Reset the sign of the current term to 0.
    sign = 0;
    
    // Continually loop until we've reached the last term in the expansion,
    while(YES){
      // Compute the current pentagonal number.
      currentPentagonalNumber = ((int)(sign / 2) + 1);
      
      // If the sign is even,
      if((sign % 2) == 0){
        // Compute the generalized pentagonal number of the positive pentagonal
        // number.
        generalizedPentagonalNumber = PentagonalNumber(currentPentagonalNumber);
      }
      // If the sign is odd,
      else{
        // Compute the generalized pentagonal number of the negative pentagonal
        // number, which will still be a positive number.
        generalizedPentagonalNumber = PentagonalNumber(-currentPentagonalNumber);
      }
      // If the generalized pentagonal number is greater than the current number,
      if(generalizedPentagonalNumber > n){
        // Break out of the loop.
        break;
      }
      // If the sign is 0 or 1 mod 4,
      if((sign % 4) < 2){
        // Add the term in the expansion to the number of partitions for the
        // current number.
        p[n] += p[n - generalizedPentagonalNumber];
      }
      // If the sign is 2 or 3 mod 4,
      else{
        // Subtract the term in the expansion to the number of partitions for the
        // current number.
        p[n] -= p[n - generalizedPentagonalNumber];
      }
      // Keep only the last 6 digits of the number of partitions of the current
      // number.
      p[n] %= 1000000;
      
      // If the number of partitions is a negative number,
      if(p[n] < 0){
        // Increment the number of partitions of the current number by 1,000,000,
        // as there was an error when taking the modulo above.
        p[n] += 1000000;
      }
      // Increment the sign by 1 to move to the next term.
      sign++;
    }
    // If the number of partitions of the current number is 0 (i.e.: divisible
    // by 1,000,000, as we removed all but the last 6 digits of the numbers),
    if(p[n] == 0){
      // Store the number with the required number of partitions.
      numberWithRequiredNumberOfPartitions = n;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the number with the required number of partitions.
  self.answer = [NSString stringWithFormat:@"%d", numberWithRequiredNumberOfPartitions];
  
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