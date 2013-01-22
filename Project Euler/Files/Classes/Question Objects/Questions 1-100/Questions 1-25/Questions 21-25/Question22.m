//  Question22.m

#import "Question22.h"

@interface Question22 (Private)

- (uint)nameScoreForString:(NSString *)aString;

@end

@implementation Question22

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 July 2002";
  self.text = @"Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.\n\nFor example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 x 53 = 49714.\n\nWhat is the total of all the name scores in the file?";
  self.title = @"Names scores";
  self.answer = @"871198282";
  self.number = @"Problem 22";
  self.estimatedComputationTime = @"7.15e-02";
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
  
  // Variable array to hold each name as a string.
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
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
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
  
  // Variable array to hold each name as a string.
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
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question22 (Private)

- (uint)nameScoreForString:(NSString *)aString; {
  // Variable to hold the names score.
  uint nameScore = 0;
  
  // Variable to hold the current index range for the reversed string.
  NSRange subStringRange = NSMakeRange(0, 0);
  
  // Variable to hold the current index of the string.
  NSInteger characterIndex = [aString length];
  
  // Constant array to hold the letters of the alphabet.
  const NSArray * lettersArray = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
  
  // While the character index is greater than 0,
  while(characterIndex > 0){
    // Decrease the characterIndex by 1, which is equivalent to looking at the
    // next letter to the left.
    characterIndex--;
    
    // Compute the range of the next letter
    subStringRange = NSMakeRange(characterIndex, 1);
    
    // Add the letters position in the letter array to the name score. Add 1 as
    // well, as the array is 0 indexed.
    nameScore += ([lettersArray indexOfObject:[aString substringWithRange:subStringRange]] + 1);
  }
  // Return the name score.
  return nameScore;
}

@end