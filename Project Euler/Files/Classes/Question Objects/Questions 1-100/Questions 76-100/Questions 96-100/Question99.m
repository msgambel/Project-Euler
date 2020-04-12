//  Question99.m

#import "Question99.h"

@implementation Question99

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"01 July 2005";
  self.hint = @"Use the log function!";
  self.link = @"https://en.wikipedia.org/wiki/Logarithm";
  self.text = @"Comparing two numbers written in index form like 2^11 and 3^7 is not difficult, as any calculator would confirm that 2^11 = 2048 < 3^7 = 2187.\n\nHowever, confirming that 632382^518061 > 519432^525806 would be much more difficult, as both numbers contain over three million digits.\n\nUsing base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file containing one thousand lines with a base/exponent pair on each line, determine which line number has the greatest numerical value.\n\nNOTE: The first two lines in the file represent the numbers in the example given above.";
  self.isFun = YES;
  self.title = @"Largest exponential";
  self.answer = @"709";
  self.number = @"99";
  self.rating = @"4";
  self.category = @"Powers";
  self.keywords = @"largest,exponential,compare,ordering,import,log,pair,base,maximum,line,number,file,greatest";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"28";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"09/04/13";
  self.completedOnDate = @"09/04/13";
  self.solutionLineCount = @"21";
  self.usesCustomObjects = NO;
  self.usesHelperMethods = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"4.44e-03";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"4.44e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply note the following:
  //
  // a^b > c^d <=> log(a^b) > log(c^d) <=> b * log(a) > d * log(c)
  //
  // To summarize, applying log to both sides will respect the equality.
  // Therefore, we need only parse the file and separate the base/exponent pairs
  // in each line, and compute:
  //
  // exponent * log(base)
  //
  // Then, we compare the maximum value already found with the current value to
  // get the maximum value for all the base/exponent pairs.
  
  // Variable to hold the line number with the maximum base/exponent pair.
  uint lineNumberWithMaxValue = 0;
  
  // Variable to hold the current log(base^exponent) = exponent * log(base).
  double currentValue = 0.0;
  
  // Variable to hold the maximum log(base^exponent) = exponent * log(base).
  double maximumValue = 0.0;
  
  // Variable to hold the current base as a string for each line in the file.
  NSString * base = nil;
  
  // Variable to hold the path to the file that holds the base and exponent data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"base_expQuestion99" ofType:@"txt"];
  
  // Variable to hold the current exponent as a string for each line in the file.
  NSString * exponent = nil;
  
  // Variable to hold the base/exponent pair while interating through each line
  // in the file.
  NSString * baseExponentPair = nil;
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfBaseExponentPair = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the list of base/exponent pair contained in the above string.
  NSArray * baseExponentArray = [listOfBaseExponentPair componentsSeparatedByString:@"\n"];
  
  // Variable to hold the current base/expoenent pair separated into an array.
  NSArray * currentBaseExponentArray = nil;
  
  // For all the base/exponent pairs in the array,
  for(int index = 0; index < [baseExponentArray count]; index++){
    // Grab the base/exponent pair in the current line.
    baseExponentPair = [baseExponentArray objectAtIndex:index];
    
    // Put the base and exponent strings into an array.
    currentBaseExponentArray = [baseExponentPair componentsSeparatedByString:@","];
    
    // Grab the current base.
    base = [currentBaseExponentArray objectAtIndex:0];
    
    // Grab the current exponent.
    exponent = [currentBaseExponentArray objectAtIndex:1];
    
    // Compute log(base^exponent) = exponent * log(base).
    currentValue = [exponent doubleValue] * log([base doubleValue]);
    
    // If the current value is greater than the currently found maximum value,
    if(currentValue > maximumValue){
      // Set the maximum value to current value.
      maximumValue = currentValue;
      
      // Store the current index as the line number with the maximum value.
      lineNumberWithMaxValue = index;
    }
  }
  // Increment the line number with the maximum value found by 1, as the array
  // is 0 indexed, and we want the line number, which is 1 indexed.
  lineNumberWithMaxValue++;
  
  // Set the answer string to the line number with maximum value.
  self.answer = [NSString stringWithFormat:@"%d", lineNumberWithMaxValue];
  
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
  
  // Here, we simply note the following:
  //
  // a^b > c^d <=> log(a^b) > log(c^d) <=> b * log(a) > d * log(c)
  //
  // To summarize, applying log to both sides will respect the equality.
  // Therefore, we need only parse the file and separate the base/exponent pairs
  // in each line, and compute:
  //
  // exponent * log(base)
  //
  // Then, we compare the maximum value already found with the current value to
  // get the maximum value for all the base/exponent pairs.
  
  // Variable to hold the line number with the maximum base/exponent pair.
  uint lineNumberWithMaxValue = 0;
  
  // Variable to hold the current log(base^exponent) = exponent * log(base).
  double currentValue = 0.0;
  
  // Variable to hold the maximum log(base^exponent) = exponent * log(base).
  double maximumValue = 0.0;
  
  // Variable to hold the current base as a string for each line in the file.
  NSString * base = nil;
  
  // Variable to hold the path to the file that holds the base and exponent data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"base_expQuestion99" ofType:@"txt"];
  
  // Variable to hold the current exponent as a string for each line in the file.
  NSString * exponent = nil;
  
  // Variable to hold the base/exponent pair while interating through each line
  // in the file.
  NSString * baseExponentPair = nil;
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfBaseExponentPair = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the list of base/exponent pair contained in the above string.
  NSArray * baseExponentArray = [listOfBaseExponentPair componentsSeparatedByString:@"\n"];
  
  // Variable to hold the current base/expoenent pair separated into an array.
  NSArray * currentBaseExponentArray = nil;
  
  // For all the base/exponent pairs in the array,
  for(int index = 0; index < [baseExponentArray count]; index++){
    // Grab the base/exponent pair in the current line.
    baseExponentPair = [baseExponentArray objectAtIndex:index];
    
    // Put the base and exponent strings into an array.
    currentBaseExponentArray = [baseExponentPair componentsSeparatedByString:@","];
    
    // Grab the current base.
    base = [currentBaseExponentArray objectAtIndex:0];
    
    // Grab the current exponent.
    exponent = [currentBaseExponentArray objectAtIndex:1];
    
    // Compute log(base^exponent) = exponent * log(base).
    currentValue = [exponent doubleValue] * log([base doubleValue]);
    
    // If the current value is greater than the currently found maximum value,
    if(currentValue > maximumValue){
      // Set the maximum value to current value.
      maximumValue = currentValue;
      
      // Store the current index as the line number with the maximum value.
      lineNumberWithMaxValue = index;
    }
  }
  // Increment the line number with the maximum value found by 1, as the array
  // is 0 indexed, and we want the line number, which is 1 indexed.
  lineNumberWithMaxValue++;
  
  // Set the answer string to the line number with maximum value.
  self.answer = [NSString stringWithFormat:@"%d", lineNumberWithMaxValue];
  
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