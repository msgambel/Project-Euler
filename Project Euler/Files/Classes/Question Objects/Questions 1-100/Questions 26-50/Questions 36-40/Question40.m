//  Question40.m

#import "Question40.h"

@implementation Question40

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"28 March 2003";
  self.hint = @"There are 9x10^(n-1) n-digit numbers.";
  self.link = @"https://en.wikipedia.org/wiki/Champernowne_constant";
  self.text = @"An irrational decimal fraction is created by concatenating the positive integers:\n\n0.123456789101112131415161718192021...\n\nIt can be seen that the 12th digit of the fractional part is 1.\n\nIf dn represents the nth digit of the fractional part, find the value of the following expression.\n\nd1 x d10 x d100 x d1000 x d10000 x d100000 x d1000000";
  self.isFun = YES;
  self.title = @"Champernowne's constant";
  self.answer = @"210";
  self.number = @"40";
  self.rating = @"4";
  self.category = @"Combinations";
  self.keywords = @"concatenate,digits,constant,champernowne's,positive,integers,expression,fractional,part,number,value";
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.commentCount = @"32";
  self.isChallenging = YES;
  self.completedOnDate = @"09/02/13";
  self.solutionLineCount = @"25";
  self.usesHelperMethods = NO;
  self.estimatedComputationTime = @"2.3e-05";
  self.estimatedBruteForceComputationTime = @"0.386";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we use a trick in counting how many digits each given number has.
  // For example, there are 90 2 digit numbers, and 900 3 digit numbers (this
  // is explained in more detail below). So if we know how many digits each
  // group of numbers has, we can continually add the number of digits up until
  // we arrive at a number larger than the needed index (stored in an array).
  // It is then a simple matter of doing a bit of multiplication and subtraction
  // to find the desired digits.
  
  // Variable to hold the index of the when iterating through the arrays to find
  // the digit asked for.
  uint index = 1;
  
  // Variable to hold the product of the required digits.
  uint product = 1;
  
  // Variable to hold which digit we are using from the number we find.
  uint currentDigit = 0;
  
  // Variable to hold the current length/position of the required number.
  uint currentPosition = 1;
  
  // Variable to hold the digit we need from the number we found.
  uint currentDigitNumber = 0;
  
  // Variable to hold the current number of digits that have already been added.
  uint currentNumberOfDigits = 0;
  
  // Variable array to hold the total number of digits for all the numbers with
  // an equal number of digits. For example, there are 9 single digit numbers,
  // each taking up 1 in length. There are 90 2 digit numbers, each taking up
  // 2 in length. There are 900 3 digit numbers, each taking up 3 in length, etc.
  //
  // Therefore, in order to find the count of the total length of each digit, we
  // have:
  //
  // D_n = 9 * 10^(n - 1) * n
  //
  // We will add in the numbers in the for loop below (Note: This array is
  // indexed 1 to the right of the other arrays).
  uint numberOfDigits[7];
  
  // Variable array to hold the start number of digits that have already been
  // placed when we start a a new group of n-digit numbers.
  uint startingDigits[6];
  
  // Variable array to hold the digits we want to find.
  uint requiredNumbers[6];
  
  // Initialize the single digits count.
  numberOfDigits[0] = 9;
  
  // For all the indices remaining in the above arrays,
  for(int i = 0; i < 6; i++){
    // Use the above equation to input the number of digits for each of the
    // n-digit numbers.
    numberOfDigits[(i + 1)] = 9 * ((uint)pow(10, (i + 1))) * (i + 2);
    
    // The starting number of digits is just the powers of 10, since we are
    // working in base 10!
    startingDigits[i] = ((uint)pow(10, (i + 1)));
    
    // The required numbers are also just the powers of 10!
    requiredNumbers[i] = ((uint)pow(10, (i + 1)));
  }
  // We can easily see that the first required digit is 1, so we will just start
  // the following loop looking for the second digit.
  currentNumberOfDigits += numberOfDigits[0];
  
  // While we are finding the required digits,
  while(index < 6){
    // Compute the position of the required number that holds the required digit.
    currentPosition = (uint)((requiredNumbers[index] - currentNumberOfDigits) / (index + 1));
    
    // Compute the index of the required digit in the number.
    currentDigit = index - (currentPosition % (index + 1));
    
    // Add the starting position of the number to the current position.
    currentPosition += startingDigits[(index - 1)];
    
    // Move the required digit to the units digit.
    currentDigitNumber = (uint)(currentPosition / (uint)pow(10, currentDigit));
    
    // Remove any of the digits other than the units digit.
    currentDigitNumber %= 10;
    
    // Multiply the product by the value of the digit.
    product *= currentDigitNumber;
    
    // Increment the current number of digits by the length of the n-digit numbers.
    currentNumberOfDigits += numberOfDigits[index];
    
    // Increment the index by 1.
    index++;
  }
  // Set the answer string to the product.
  self.answer = [NSString stringWithFormat:@"%d", product];
  
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
  
  // Here, we simply convert the numbers to string, check their length, and add
  // that value to a variable. We then check to see if the variable is larger
  // than the required digits to find (which are stored in an array), and if it
  // if, we grab the digit we need from the string, convert it to an integer,
  // and multiply it to the total product.
  
  // Variable to hold the index of the when iterating through the arrays to find
  // the digit asked for.
  uint index = 0;
  
  // Variable to hold the product of the required digits.
  uint product = 1;
  
  // Variable to hold the current number we are looking at.
  uint currentNumber = 1;
  
  // Variable to hold the current number of digits that have already been added.
  uint currentNumberOfDigits = 1;
  
  // Variable array to hold the digits we want to find.
  uint requiredNumbers[6] = {10, 100, 1000, 10000, 100000, 1000000};
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange;
  
  // Variable to hold the current number as a string.
  NSString * currentNumberAsString = nil;
  
  // While we are finding the required digits,
  while(index < 6){
    // Increment the current number by 1.
    currentNumber++;
    
    // Make the current number a string.
    currentNumberAsString = [NSString stringWithFormat:@"%d", currentNumber];
    
    // Add the length of the string to the current number of digits.
    currentNumberOfDigits += currentNumberAsString.length;
    
    // If the current number of digits is greater than the required number to find.
    if(currentNumberOfDigits > requiredNumbers[index]){
      // Compute the range of the single required digit.
      subStringRange = NSMakeRange((currentNumberAsString.length - (currentNumberOfDigits - requiredNumbers[index]) - 1), 1);
      
      // Multiply the product by the value of the digit.
      product *= [[currentNumberAsString substringWithRange:subStringRange] intValue];
      
      // Increment the index by 1.
      index++;
    }
  }
  // Set the answer string to the product.
  self.answer = [NSString stringWithFormat:@"%d", product];
  
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