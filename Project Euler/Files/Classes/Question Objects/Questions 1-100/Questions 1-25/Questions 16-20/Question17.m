//  Question17.m

#import "Question17.h"

@interface Question17 (Private)

- (void)setUpDigitCountsArrays;
- (uint)numberOfCharactersForNumberLessThan100:(uint)aNumber;
- (uint)numberOfCharactersForNumberLessThan1000:(uint)aNumber;

@end

@implementation Question17

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"17 May 2002";
  self.hint = @"Store how many letters are said in each of the hundreds, teens, tens, and units digits, and sum them all for every number.";
  self.link = @"http://www.calculator.org/calculate-online/mathematics/text-number.aspx";
  self.text = @"If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.\n\nIf all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?\n\nNOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of \"and\" when writing out numbers is in compliance with British usage.";
  self.isFun = YES;
  self.title = @"Number letter counts";
  self.answer = @"21124";
  self.number = @"17";
  self.rating = @"4";
  self.summary = @"Count the letters in each English number, and sum them. A dictionary may help.";
  self.category = @"Counting";
  self.isUseful = NO;
  self.keywords = @"letters,sum,words,numbers,counts,british,usage,written,one,thousand,1000,contains,spaces,hyphens,compliance";
  self.loadsFile = NO;
  self.memorable = NO;
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"20";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"17/01/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"17/01/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"17";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.5e-05";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"5.2e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we have a convience method that stores the number of letters in each
  // digit of the units, teens, tens, and hudreds numbers. Then, we simply loop
  // through all of the numbers up to 1,000, and add up the count.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set up the digits count arrays for the digits of the units, tens, and hundreds
  // digits.
  [self setUpDigitCountsArrays];
  
  // For all the numbers from 1 - 99,
  for(int number = 1; number < 100; number++){
    // Add up the number of characters from this number to the sum.
    sum += [self numberOfCharactersForNumberLessThan100:number];
  }
  // We multiply by 10 here, as the number of times the numbers 1 - 99 appear
  // is when the hundreds digits is 0, 1, 2, ... , 9, which is 10 times.
  sum *= 10;
  
  // For all the hundreds numbers, 100, 200, ..., 900 (there are 10 9 of them),
  for(int number = 1; number < 10; number++){
    // Add the number of characters for the hundreds number, add on the letters
    // in the word "and", and multiply by 100, as they each appear 100 times
    // (100, 101, ..., 198, 199, 200, ... , 999).
    sum += (_hundredsDigitCounts[number] + 3) * 100;
  }
  // We include the "and" above, which means we must subtract off the "and" count
  // (i.e.: 3) for the numbers 100, 200, ..., 900.
  
  // For the numbers 100, 200, ..., 900,
  for(int number = 1; number < 10; number++){
    // Subtract off the number of characters in the word "and" (i.e.: 3).
    sum -= 3; // Subtract off extra and for 100, 200, ..., 900.
  }
  // Add on the number of characters in the number One Thousand.
  sum += 11;
  
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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
  
  // Here, we have a convience method that stores the number of letters in each
  // digit of the units, teens, tens, and hudreds numbers. Then, we simply loop
  // through all of the numbers up to 1,000, and add up the count.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set up the digits count arrays for the digits of the units, tens, and hundreds
  // digits.
  [self setUpDigitCountsArrays];
  
  // For all the numbers from 1 - 999,
  for(int number = 1; number < 1000; number++){
    // Add up the number of characters from this number to the sum.
    sum += [self numberOfCharactersForNumberLessThan1000:number];
  }
  // Add on the number of characters in the number One Thousand.
  sum += 11;
  
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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

#pragma mark - Private Methods

@implementation Question17 (Private)

- (void)setUpDigitCountsArrays; {
  // Here, we set up the default counts for each of the digits.
  
  // Set up the units digit counts.
  
  _unitsDigitCounts[0] = 0; // Zero is never said!
  _unitsDigitCounts[1] = 3; // One has 3 letters.
  _unitsDigitCounts[2] = 3; // Two has 3 letters.
  _unitsDigitCounts[3] = 5; // Three has 5 letters.
  _unitsDigitCounts[4] = 4; // Four has 4 letters.
  _unitsDigitCounts[5] = 4; // Five has 4 letters.
  _unitsDigitCounts[6] = 3; // Six has 3 letters.
  _unitsDigitCounts[7] = 5; // Seven has 5 letters.
  _unitsDigitCounts[8] = 5; // Eight has 5 letters.
  _unitsDigitCounts[9] = 4; // Nine has 4 letters.
  
  // Set up the tens digit counts.
  
  _tensDigitCounts[0] = 0; // Zero is never said!
  _tensDigitCounts[1] = 3; // Ten has 3 letters.
  _tensDigitCounts[2] = 6; // Twenty has 6 letters.
  _tensDigitCounts[3] = 6; // Thirty has 6 letters.
  _tensDigitCounts[4] = 5; // Forty has 5 letters.
  _tensDigitCounts[5] = 5; // Fifty has 5 letters.
  _tensDigitCounts[6] = 5; // Sixty has 5 letters.
  _tensDigitCounts[7] = 7; // Seventy has 7 letters.
  _tensDigitCounts[8] = 6; // Eighty has 6 letters.
  _tensDigitCounts[9] = 6; // Ninety has 6 letters.
  
  // Set up the teens digit counts.
  
  _teensDigitCounts[0] = 3; // Ten has 3 letters.
  _teensDigitCounts[1] = 6; // Eleven has 6 letters.
  _teensDigitCounts[2] = 6; // Twelve has 6 letters.
  _teensDigitCounts[3] = 8; // Thirteen has 8 letters.
  _teensDigitCounts[4] = 8; // Fourteen has 8 letters.
  _teensDigitCounts[5] = 7; // Fifteen has 7 letters.
  _teensDigitCounts[6] = 7; // Sixteen has 7 letters.
  _teensDigitCounts[7] = 9; // Seventeen has 9 letters.
  _teensDigitCounts[8] = 8; // Eighteen has 8 letters.
  _teensDigitCounts[9] = 8; // Nineteen has 8 letters.
  
  // Set up the hundreds digit counts.
  
  _hundredsDigitCounts[0] = 0;  // Zero is never said!
  _hundredsDigitCounts[1] = 10; // One Hundred has 10 letters.
  _hundredsDigitCounts[2] = 10; // Two Hundred has 10 letters.
  _hundredsDigitCounts[3] = 12; // Three Hundred has 12 letters.
  _hundredsDigitCounts[4] = 11; // Four Hundred has 11 letters.
  _hundredsDigitCounts[5] = 11; // Five Hundred has 11 letters.
  _hundredsDigitCounts[6] = 10; // Six Hundred has 10 letters.
  _hundredsDigitCounts[7] = 12; // Seven Hundred has 12 letters.
  _hundredsDigitCounts[8] = 12; // Eight Hundred has 12 letters.
  _hundredsDigitCounts[9] = 11; // Nine Hundred has 11 letters.
}

- (uint)numberOfCharactersForNumberLessThan100:(uint)aNumber; {
  // This method compute the number of characters for numbers less than 100. We
  // simply compute the value of each of the digits and check the lookup array.
  
  // If the number is larger than 99,
  if(aNumber >= 100){
    // Make a note of it in the log.
    NSLog(@"You entered a number: %d > 100!!!", aNumber);
    
    // Return 0, which adds nothing to the sum.
    return 0;
  }
  // If the number is less than 100,
  else{
    // Grab the tens digit.
    uint tensDigit = aNumber / 10;
    
    // Grab the units digit.
    uint unitsDigit = aNumber % 10;
    
    // If the tens digit is 1 (i.e.: the teens),
    if(tensDigit == 1){
      // Return the teens number of characters.
      return _teensDigitCounts[unitsDigit];
    }
    // If the tens digit is NOT 1 (i.e.: NOT the teens),
    else{
      // Return the sum of the tens digit character count, and the units digit
      // character count.
      return (_tensDigitCounts[tensDigit] + _unitsDigitCounts[unitsDigit]);
    }
  }
}

- (uint)numberOfCharactersForNumberLessThan1000:(uint)aNumber; {
  // This method compute the number of characters for numbers less than 1000. We
  // simply compute the value of each of the digits and check the lookup array.
  
  // If the number is larger than 999,
  if(aNumber >= 1000){
    // Make a note of it in the log.
    NSLog(@"You entered a number: %d > 1000!!!", aNumber);
    
    // Return 0, which adds nothing to the sum.
    return 0;
  }
  // If the number is less than 1000,
  else{
    // Variable to hold the number of characters for the given number.
    uint returnValue = 0;
    
    // Grab the tens digit.
    uint tensDigit = ((aNumber / 10) % 10);
    
    // Grab the units digit.
    uint unitsDigit = (aNumber % 10);
    
    // Grab the hundreds digit.
    uint hundredsDigit = (aNumber / 100);
    
    // Variable to hold the number of characters in the word "and".
    uint numberOfLettersInAnd = 3;
    
    // If the number is mod 100 is 0,
    if((tensDigit == 0) && (unitsDigit == 0)){
      // Set the return value to just the hundreds digit character count.
      returnValue = _hundredsDigitCounts[hundredsDigit];
    }
    // If the number is mod 100 is greater than 0,
    else{
      // If the tens digit is 1 (i.e.: the teens),
      if(tensDigit == 1){
        // Set the return value to the teens number of characters.
        returnValue = _teensDigitCounts[unitsDigit];
      }
      // If the tens digit is NOT 1 (i.e.: NOT the teens),
      else{
        // Set the return value to the sum of the tens digit character count,
        // and the units digit character count.
        returnValue = (_tensDigitCounts[tensDigit] + _unitsDigitCounts[unitsDigit]);
      }
      // Add the hundreds digit character count to the return value.
      returnValue += _hundredsDigitCounts[hundredsDigit];
      
      // If the hundreds digit is greater than 0,
      if(hundredsDigit > 0){
        // Add the number of characters in the word "and".
        returnValue += numberOfLettersInAnd;
      }
    }
    // Return the number of characters for the given number.
    return returnValue;
  }
}

@end