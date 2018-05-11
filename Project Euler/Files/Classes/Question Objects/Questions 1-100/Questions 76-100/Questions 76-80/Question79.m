//  Question79.m

#import "Question79.h"

@interface Question79 (Private)

- (BOOL)doesPasscode:(uint)aPasscode acceptCharacters:(NSString *)aCharacters;

@end

@implementation Question79

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"17 September 2004";
  self.hint = @"Assume the passcode has no duplicates.";
  self.link = @"https://en.wikipedia.org/wiki/Keystroke_logging";
  self.text = @"A common security method used for online banking is to ask the user for three random characters from a passcode. For example, if the passcode was 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.\n\nThe text file, keylog.txt, contains fifty successful login attempts.\n\nGiven that the three characters are always asked for in order, analyse the file so as to determine the shortest possible secret passcode of unknown length.";
  self.isFun = YES;
  self.title = @"Passcode derivation";
  self.answer = @"73162890";
  self.number = @"79";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"passcode,derivation,login,secret,shortest,import,security,common,method,analyse,files";
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"44";
  self.isChallenging = NO;
  self.completedOnDate = @"20/03/13";
  self.solutionLineCount = @"39";
  self.usesHelperMethods = NO;
  self.estimatedComputationTime = @"3.23e-04";
  self.estimatedBruteForceComputationTime = @"93.9";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply remove all the duplicates in the keylog. Then we loop
  // through all the numbers to see which digits are used. Finally, we record
  // which numbers come before each number that is used in the keylog.
  //
  // Once we know which numbers come before each number, we continually loop
  // through all the numbers to see which one does not have any numbers that
  // come before it. We then remove the number from the list of all the numbers
  // that come before the other numbers. This will allow us to construct the
  // passcode recursively.
  //
  // One caveat to this is that we are assuming that the passcode does not have
  // any duplicate digits. If it were the case that there were multiple copies
  // of a digit, we could keep track of the digits that come after the number as
  // well, which would help us narrow it down.
  
  // Variable to hold the first digit in the accepted keylog.
  uint firstDigit = 0;
  
  // Variable to hold the second digit in the accepted keylog.
  uint secondDigit = 0;
  
  // Variable to hold the third digit in the accepted keylog.
  uint thirdDigit = 0;
  
  // Variable to hold the total number of numbers that come before the current
  // number in the key log.
  uint totalOfNumbersThatComeBefore = 0;
  
  // Variable array to hold which numbers are used in the key log.
  BOOL numbersUsed[10];
  
  // Variable array to hold which numbers come before each number.
  BOOL numbersBeforeNumber[10][10];
  
  // Variable to hold the shortest passcode.
  NSString * shortestPasscode = @"";
  
  // Variable to hold the path to the file that holds the successful attempts data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"keylogQuestion79" ofType:@"txt"];
  
  // Variable to hold the list of successful attempts as a string for parsing.
  NSString * successfulAttemptsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each successful attempt as a string in an array.
  NSArray * successfulAttempts = [[NSSet setWithArray:[successfulAttemptsList componentsSeparatedByString:@"\n"]] allObjects];
  
  // For all the digits from 0 to 9,
  for(int number = 0; number < 10; number++){
    // Mark that the current digit is NOT used in the keylog.
    numbersUsed[number] = NO;
    
    // For all the digits before the current number,
    for(int previousNumber = 0; previousNumber < 10; previousNumber++){
      // Mark that the digit does NOT come before the current digit.
      numbersBeforeNumber[number][previousNumber] = NO;
    }
  }
  // For all the strings in the successful attempts in the keylog file,
  for(NSString * characters in successfulAttempts){
    // Grab the first digit in the accepted keylog.
    firstDigit = [[characters substringWithRange:NSMakeRange(0, 1)] intValue];
    
    // Grab the second digit in the accepted keylog.
    secondDigit = [[characters substringWithRange:NSMakeRange(1, 1)] intValue];
    
    // Grab the third digit in the accepted keylog.
    thirdDigit = [[characters substringWithRange:NSMakeRange(2, 1)] intValue];
    
    // Mark that the first digit is used in the passcode.
    numbersUsed[firstDigit] = YES;
    
    // Mark that the second digit is used in the passcode.
    numbersUsed[secondDigit] = YES;
    
    // Mark that the third digit is used in the passcode.
    numbersUsed[thirdDigit] = YES;
    
    // Mark that the first digit comes before the second digit.
    numbersBeforeNumber[secondDigit][firstDigit] = YES;
    
    // Mark that the first digit comes before the third digit.
    numbersBeforeNumber[thirdDigit][firstDigit] = YES;
    
    // Mark that the second digit comes before the third digit.
    numbersBeforeNumber[thirdDigit][secondDigit] = YES;
  }
  // For all the digits from 0 to 9,
  for(int number = 0; number < 10; number++){
    // If the current digit is used,
    if(numbersUsed[number]){
      // Reset the number of numbers that come before the current number to 0.
      totalOfNumbersThatComeBefore = 0;
      
      // For all the digits before the current number,
      for(int previousNumber = 0; previousNumber < 10; previousNumber++){
        // If the number does come before the current number,
        if(numbersBeforeNumber[number][previousNumber]){
          // Increment the number of numbers that come before the current number
          // by 1.
          totalOfNumbersThatComeBefore++;
        }
      }
      // If no numbers come before the current number,
      if(totalOfNumbersThatComeBefore == 0){
        // Add the current digit to the passcode.
        shortestPasscode = [NSString stringWithFormat:@"%@%d", shortestPasscode, number];
        
        // For all the digits before the current number,
        for(int previousNumber = 0; previousNumber < 10; previousNumber++){
          // Remove the current number from the current previous number, as the
          // current number does not come before the previous number anymore!
          numbersBeforeNumber[previousNumber][number] = NO;
        }
        // Mark that the current number is no longer used for the remainder of
        // the passcode.
        numbersUsed[number] = NO;
        
        // Reset the current number to -1 so that we start again at 0.
        number = -1;
      }
    }
  }
  // Set the answer string to the shortest passcode.
  self.answer = shortestPasscode;
  
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
  
  // Here, we simply loop through all of the numbers until we find a passcode
  // that works. We use a helper method to check if a passcode works with the
  // given keys in the log, and if all of the pass, we have found our shortest
  // acceptable passcode.
  
  // Variable to hold if the current passcode works or not.
  BOOL codeWorks = NO;
  
  // Variable to hold the shorted passcode accepted by characters in the keylog
  // file.
  uint shortestPasscode = 0;
  
  // Variable to hold the path to the file that holds the successful attempts data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"keylogQuestion79" ofType:@"txt"];
  
  // Variable to hold the list of successful attempts as a string for parsing.
  NSString * successfulAttemptsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each successful attempt as a string in an array, while
  // removing all the duplicates.
  NSArray * successfulAttempts = [[NSSet setWithArray:[successfulAttemptsList componentsSeparatedByString:@"\n"]] allObjects];
  
  // Since there are 8 digits the passcode must have, we start with 10,000,000
  // for codes to test, and increase by 1 until we find a suitable passcode,
  for(int passcode = 10000000; passcode < 1000000000; passcode++){
    // Mark that the current passcode could work.
    codeWorks = YES;
    
    // For all the strings in the successful attempts in the keylog file,
    for(NSString * characters in successfulAttempts){
      // If the current passcode does NOT accept the current characters in the
      // keylog,
      if([self doesPasscode:passcode acceptCharacters:characters] == NO){
        // Mark that the current passcode does NOT work.
        codeWorks = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the current passcode works for all the successful attempts in the
    // keylog file,
    if(codeWorks){
      // Store the current passcode as the shortest acceptable passcode.
      shortestPasscode = passcode;
      
      // Break out of the loop.
      break;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the shortest passcode.
    self.answer = [NSString stringWithFormat:@"%d", shortestPasscode];
    
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

#pragma mark - Private Methods

@implementation Question79 (Private)

- (BOOL)doesPasscode:(uint)aPasscode acceptCharacters:(NSString *)aCharacters; {
  // Variable to hold the number of digits there are in the passcode.
  int numberOfDigits = (int)(log10(aPasscode));
  
  // Variable to hold the current digit index of the characters needed to be
  // accepted.
  int currentDigitIndex = (int)aCharacters.length - 1;
  
  // Variable to hold the digit in the passcode we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit in the passcode.
  uint powerOf10 = 1;
  
  // Variable to hold the current digit of the characters needed to be accepted.
  uint currentDigit = [[aCharacters substringWithRange:NSMakeRange(currentDigitIndex, 1)] intValue];
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the passcode.
    digit = (((long long int)(aPasscode / powerOf10)) % 10);
    
    // If the digit is equal to the current digit in the chacters needed to be
    // accepted,
    if(digit == currentDigit){
      // Decrement the current digit index by 1.
      currentDigitIndex--;
      
      // If the current digit index of characters needed to be accepted is less
      // than 0,
      if(currentDigitIndex < 0){
        // Break out of the loop.
        break;
      }
      // Grab the next digit needed to be accepted by the passcode.
      currentDigit = [[aCharacters substringWithRange:NSMakeRange(currentDigitIndex, 1)] intValue];
    }
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return is the passcode accepts the inputted characters of not.
  return (currentDigitIndex >= aCharacters.length);
}

@end