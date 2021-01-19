//  Question42.m

#import "Question42.h"
#import "BinaryObject.h"

@implementation Question42

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"25 April 2003";
  self.hint = @"Figure out the maximum triangle number by computing the length of the longest word in the words.txt file, and multiplying it by 26 (the max value a letter can have).";
  self.link = @"https://en.wikipedia.org/wiki/Triangular_number";
  self.text = @"The nth term of the sequence of triangle numbers is given by, t(n) = ½n(n+1); so the first ten triangle numbers are:\n\n1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...\n\nBy converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t(10). If the word value is a triangle number then we shall call the word a triangle word.\n\nUsing words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?";
  self.isFun = YES;
  self.title = @"Coded triangle numbers";
  self.answer = @"162";
  self.number = @"42";
  self.rating = @"3";
  self.category = @"Combinations";
  self.keywords = @"sum,triangle,numbers,english,words,import,coded,sequence,2000,two,thousand,common,alphabetical,maximum,compute,value,many";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"33";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"11/02/13";
  self.solvableByHand = NO;
  self.completedOnDate = @"11/02/13";
  self.solutionLineCount = @"25";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"1.59e-02";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.63e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We simply use a helper method to compute the value of each word, and then
  // compare it against all the possible triangle numbers. We figure out the
  // maximum triangle number by computing the length of the longest word in the
  // words file, then multiplying it by 26 (the max value a letter can have),
  // and then using the inverse function of a triangle number to compute the
  // maximum index.
  //
  // We compute the triangle numbers quicker by noting that the nth triangle
  // number is the sum of all the numbers from 1 to n.
  //
  // We also skip any more checking of the words value against the triangle
  // numbers if the current triangle number is greater than the words value, as
  // the triangle numbers are an increasing sequence.
  
  // Variable to hold the path to the file that holds the triangle data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"wordsQuestion42" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfWords = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
   // Variable array to the list of words contained in the above string.
  NSArray * wordsArray = [listOfWords componentsSeparatedByString:@"\",\""];
  
  // Variable to hold the maximum value of a letter in the alphabet (z).
  uint maximumValue = 26;
  
  // Variable to hold the current word's value.
  uint currentWordsValue = 0;
  
  // Variable to hold the maximum word length of all the words in the words array.
  uint maximumWordLength = 0;
  
  // Variable to hold the largest required triangle number given the list of words.
  uint largestRequiredTriangleNumber = 0;
  
  // Variable to hold the number of words whose value is a triangle number.
  uint numberOfWordsWhoseValueIsATriangleNumber = 0;
  
  // For all the words in the words array,
  for(NSString * word in wordsArray){
    // If the word's length is greater than the maximum length already found,
    if(word.length > maximumWordLength){
      // Set the maximum word length to be
      maximumWordLength = (uint)word.length;
    }
  }
  // Compute the largests triangle number required, using the largest possible
  // value a word can have, and inverting the function that compute a triangle
  // number.
  largestRequiredTriangleNumber = (2 * ((uint)sqrt(maximumWordLength * maximumValue))) + 1;
  
  // Variable array to hold all the required triangle numbers.
  uint triangleNumbers[largestRequiredTriangleNumber];
  
  // Set the first triangle number in the triangle numbers array.
  triangleNumbers[0] = 0;
  
  // Set the second triangle number in the triangle numbers array.
  triangleNumbers[1] = 1;
  
  // For all the required triangle numbers,
  for(int triangleNumber = 2; triangleNumber < largestRequiredTriangleNumber; triangleNumber++){
    // Compute the triangle number's value, and set it in the triangle number's
    // array. Instead of using the function, use the previous value, and add the
    // current triangle number index as well. Recall that the triangle numbers
    // are really the sum of all the number from 1 to n.
    triangleNumbers[triangleNumber] = triangleNumbers[(triangleNumber - 1)] + triangleNumber;
  }
  // For all the words in the words array,
  for(NSString * word in wordsArray){
    // Compute the current words value with the helper method.
    currentWordsValue = [self nameScoreForString:word];
    
    // For all the required triangle numbers,
    for(int triangleNumber = 1; triangleNumber < largestRequiredTriangleNumber; triangleNumber++){
      // If the current words value is equal to the current triangle number,
      if(currentWordsValue == triangleNumbers[triangleNumber]){
        // Increment the number of words whose value is a triangle number by 1.
        numberOfWordsWhoseValueIsATriangleNumber++;
        
        // Break out of the loop.
        break;
      }
      // If the current words value is less than the current triangle number,
      else if(currentWordsValue < triangleNumbers[triangleNumber]){
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the number of words whose value is a triangle number.
  self.answer = [NSString stringWithFormat:@"%d", numberOfWordsWhoseValueIsATriangleNumber];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm just uses better tricks for avoiding computation.
  
  // We simply use a helper method to compute the value of each word, and then
  // compare it against all the possible triangle numbers. We figure out the
  // maximum triangle number by computing the length of the longest word in the
  // words file, then multiplying it by 26 (the max value a letter can have),
  // and then using the inverse function of a triangle number to compute the
  // maximum index.
  
  // Variable to hold the path to the file that holds the triangle data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"wordsQuestion42" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfWords = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the list of words contained in the above string.
  NSArray * wordsArray = [listOfWords componentsSeparatedByString:@"\",\""];
  
  // Variable to hold the maximum value of a letter in the alphabet (z).
  uint maximumValue = 26;
  
  // Variable to hold the current word's value.
  uint currentWordsValue = 0;
  
  // Variable to hold the maximum word length of all the words in the words array.
  uint maximumWordLength = 0;
  
  // Variable to hold the largest required triangle number given the list of words.
  uint largestRequiredTriangleNumber = 0;
  
  // Variable to hold the number of words whose value is a triangle number.
  uint numberOfWordsWhoseValueIsATriangleNumber = 0;
  
  // For all the words in the words array,
  for(NSString * word in wordsArray){
    // If the word's length is greater than the maximum length already found,
    if(word.length > maximumWordLength){
      // Set the maximum word length to be
      maximumWordLength = (uint)word.length;
    }
  }
  // Compute the largests triangle number required, using the largest possible
  // value a word can have, and inverting the function that compute a triangle
  // number.
  largestRequiredTriangleNumber = (2 * ((uint)sqrt(maximumWordLength * maximumValue))) + 1;
  
  // Variable array to hold all the required triangle numbers.
  uint triangleNumbers[largestRequiredTriangleNumber];
  
  // For all the required triangle numbers,
  for(int triangleNumber = 0; triangleNumber < largestRequiredTriangleNumber; triangleNumber++){
    // Compute the triangle number's value, and set it in the triangle number's
    // array.
    triangleNumbers[triangleNumber] = ((triangleNumber * (triangleNumber + 1)) / 2);
  }
  // For all the words in the words array,
  for(NSString * word in wordsArray){
    // Compute the current words value with the helper method.
    currentWordsValue = [self nameScoreForString:word];
    
    // For all the required triangle numbers,
    for(int triangleNumber = 0; triangleNumber < largestRequiredTriangleNumber; triangleNumber++){
      // If the current words value is equal to the current triangle number,
      if(currentWordsValue == triangleNumbers[triangleNumber]){
        // Increment the number of words whose value is a triangle number by 1.
        numberOfWordsWhoseValueIsATriangleNumber++;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the number of words whose value is a triangle number.
  self.answer = [NSString stringWithFormat:@"%d", numberOfWordsWhoseValueIsATriangleNumber];
  
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