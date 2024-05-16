//  Question22.m

#import "Question22.h"

@implementation Question22

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 July 2002";
  self.hint = @"Make a helper method that takes a string and returns it's score.";
  self.link = @"https://en.wikipedia.org/wiki/ASCII";
  self.text = @"Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.\n\nFor example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 x 53 = 49714.\n\nWhat is the total of all the name scores in the file?";
  self.isFun = YES;
  self.title = @"Names scores";
  self.answer = @"871198282";
  self.number = @"22";
  self.rating = @"5";
  self.category = @"Sums";
  self.isUseful = NO;
  self.keywords = @"alphabetical,order,import,names,scores,first,sum,total,5000,five,thousand,sorting,file,position,working";
  self.loadsFile = YES;
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"15";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"22/01/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"22/01/13";
  self.solutionLineCount = @"17";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"7.15e-02";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"7.15e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply sort the array, and use a helper function to compute the
  // name score. Then we loop through all the sorted names, multiply the name
  // score by the position in the array, and add it to the sum.
  
  // Variable to hold the sum. Default the sum to 0.
  long long int sum = 0;
  
  // Variable to hold the path to the file that holds the names data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"namesQuestion22" ofType:@"txt"];
  
  // Variable to hold the names as a string for parsing.
  NSString * namesString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to hold each name in the above string as a string.
  NSArray * namesArray = [namesString componentsSeparatedByString:@","];
  
  // Variable array that holds the sorted names of the array.
  NSArray * sortedNamesArray = [namesArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  
  // For all the names in the sorted array,
  for(int index = 0; index < [sortedNamesArray count]; index++){
    // Compute the names score, and multiply it by the position in the array.
    // Add 1 to the index as well, as the array is 0 indexed.
    sum += ([self nameScoreForString:[sortedNamesArray objectAtIndex:index]] * (index + 1));
  }
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
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we simply sort the array, and use a helper function to compute the
  // name score. Then we loop through all the sorted names, multiply the name
  // score by the position in the array, and add it to the sum.
  
  // Variable to hold the sum. Default the sum to 0.
  long long int sum = 0;
  
  // Variable to hold the path to the file that holds the names data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"namesQuestion22" ofType:@"txt"];
  
  // Variable to hold the names as a string for parsing.
  NSString * namesString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to hold each name in the above string as a string.
  NSArray * namesArray = [namesString componentsSeparatedByString:@","];
  
  // Variable array that holds the sorted names of the array.
  NSArray * sortedNamesArray = [namesArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  
  // For all the names in the sorted array,
  for(int index = 0; index < [sortedNamesArray count]; index++){
    // Compute the names score, and multiply it by the position in the array.
    // Add 1 to the index as well, as the array is 0 indexed.
    sum += ([self nameScoreForString:[sortedNamesArray objectAtIndex:index]] * (index + 1));
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