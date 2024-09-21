//  Question38.m

#import "Question38.h"

@implementation Question38

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"28 February 2003";
  self.hint = @"Start with the 4 digit numbers, and work your way down.";
  self.link = @"https://en.wikipedia.org/wiki/Pandigital_number";
  self.text = @"Take the number 192 and multiply it by each of 1, 2, and 3:\n\n192 x 1 = 192\n192 x 2 = 384\n192 x 3 = 576\n\nBy concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)\n\nThe same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).\n\nWhat is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?";
  self.isFun = YES;
  self.title = @"Pandigital multiples";
  self.answer = @"932718654";
  self.number = @"38";
  self.rating = @"5";
  self.summary = @"Find the largest 1-9 pandigital 9-digit number formed by a concatenated product.";
  self.category = @"Patterns";
  self.isUseful = NO;
  self.keywords = @"pandigital,multiples,digit,concatenated,product,integer,formed,largest,multiply,lexographic,number";
  self.loadsFile = NO;
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = NO;
  self.commentCount = @"13";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"07/02/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"07/02/13";
  self.solutionLineCount = @"27";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"1.91e-04";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.76e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply check the 4 digit numbers starting with 9, and work our way
  // down. We know that 9 * (1, 2, 3, 4, 5) gives the pandigital: 918273645, so
  // we need only check the numbers that start with a 9.
  //
  // The 2-digit numbers are out, as even in the lower bound (i.e.: starting
  // with 91), we see that 91 * (1, 2, 3) gives 91182273, which is an 8-digit
  // number, and 91 * (1, 2, 3, 4) gives 91182273364, which is an 11-digit number,
  // so none of the combinations can be a 9-pandigital number.
  //
  // The 3-digit numbers are out, as even in the lower bound (i.e.: starting
  // with 912), we see that 912 * (1, 2, 3) gives 91218242736, which is an
  // 11-digit number, so none of the combinations can be a 9-pandigital number.
  //
  // The 5-digit numbers (and above) are out, as even in the lower bound (i.e.:
  // starting with 91234), we see that 912 * (1, 2) gives 91234182468, which is
  // an 11-digit number, so none of the combinations can be a 9-pandigital number.
  //
  // Therefore, we need only check the 4-digit numbers starting with 9. Once we
  // find one, we can stop, as we are counting down from highest to lowest.
  
  // Variable to hold the potential pandigital number.
  uint potentialPandigitalNumber = 0;
  
  // For all the 4-digit numbers starting with 9, from highest to lowest,
  for(int i = 9876; i >= 9123; i--){
    // Compute the potential pandigital number.
    potentialPandigitalNumber = (i * 100000) + (2 * i);
    
    // If the number is pandigital/lexographic,
    if([self isNumberLexographic:potentialPandigitalNumber countZero:NO]){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the maximum pandigital number.
  self.answer = [NSString stringWithFormat:@"%d", potentialPandigitalNumber];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The only
  //       difference is computing the pandigital number with string composition.
  
  // Here, we simply check the 4 digit numbers starting with 9, and work our way
  // down. We know that 9 * (1, 2, 3, 4, 5) gives the pandigital: 918273645, so
  // we need only check the numbers that start with a 9.
  //
  // The 2-digit numbers are out, as even in the lower bound (i.e.: starting
  // with 91), we see that 91 * (1, 2, 3) gives 91182273, which is an 8-digit
  // number, and 91 * (1, 2, 3, 4) gives 91182273364, which is an 11-digit number,
  // so none of the combinations can be a 9-pandigital number.
  //
  // The 3-digit numbers are out, as even in the lower bound (i.e.: starting
  // with 912), we see that 912 * (1, 2, 3) gives 91218242736, which is an
  // 11-digit number, so none of the combinations can be a 9-pandigital number.
  //
  // The 5-digit numbers (and above) are out, as even in the lower bound (i.e.:
  // starting with 91234), we see that 912 * (1, 2) gives 91234182468, which is
  // an 11-digit number, so none of the combinations can be a 9-pandigital number.
  //
  // Therefore, we need only check the 4-digit numbers starting with 9. Once we
  // find one, we can stop, as we are counting down from highest to lowest.
  
  // Variable to hold the potential pandigital number as a string.
  NSString * potentialPandigitalNumber = nil;
  
  // For all the 4-digit numbers starting with 9, from highest to lowest,
  for(int i = 9876; i >= 9123; i--){
    // Compute the potential pandigital number as a string.
    potentialPandigitalNumber = [NSString stringWithFormat:@"%d%d", i, (2 * i)];
    
    // If the number is pandigital/lexographic,
    if([self isNumberLexographic:[potentialPandigitalNumber longLongValue] countZero:NO]){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the maximum pandigital number.
  self.answer = potentialPandigitalNumber;
  
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