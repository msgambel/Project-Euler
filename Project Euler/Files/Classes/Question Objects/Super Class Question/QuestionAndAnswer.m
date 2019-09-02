//  QuestionAndAnswer.m

#import "QuestionAndAnswer.h"
#import "Global.h"

@interface QuestionAndAnswer (Private)

- (NSMutableArray *)arrayOfPrimeNumbersUpTo:(uint)aLimit count:(uint)aCount;
- (NSMutableArray *)slowArrayOfPrimeNumbersUpTo:(uint)aLimit count:(uint)aCount;

@end

@implementation QuestionAndAnswer

@synthesize date = _date;
@synthesize hint = _hint;
@synthesize link = _link;
@synthesize text = _text;
@synthesize isFun = _isFun;
@synthesize title = _title;
@synthesize answer = _answer;
@synthesize number = _number;
@synthesize rating = _rating;
@synthesize category = _category;
@synthesize delegate = _delegate;
@synthesize keywords = _keywords;
@synthesize solveTime = _solveTime;
@synthesize technique = _technique;
@synthesize difficulty = _difficulty;
@synthesize isComputing = _isComputing;
@synthesize commentCount = _commentCount;
@synthesize attemptsCount = _attemptsCount;
@synthesize isChallenging = _isChallenging;
@synthesize startedOnDate = _startedOnDate;
@synthesize completedOnDate = _completedOnDate;
@synthesize solutionLineCount = _solutionLineCount;
@synthesize usesHelperMethods = _usesHelperMethods;
@synthesize requiresMathematics = _requiresMathematics;
@synthesize hasMultipleSolutions = _hasMultipleSolutions;
@synthesize estimatedComputationTime = _estimatedComputationTime;
@synthesize usesFunctionalProgramming = _usesFunctionalProgramming;
@synthesize estimatedBruteForceComputationTime = _estimatedBruteForceComputationTime;

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    // The best link to visit for any Project Euler problem!
    _link = @"https://projecteuler.net/";
    
    // All Project Euler questions start out fun!
    _isFun = YES;
    
    // Set the default solve time to be N/A.
    _solveTime = @"N/A";
    
    // Set that we are not computing by default.
    _isComputing = NO;
    
    // Problems need at least 0 lines of code to be solved!
    _solutionLineCount = @"0";
    
    // Always call initialize when the object is created.
    [self initialize];
    
    // Note: We can set the _isComputing flag to NO as it is a propetry. This
    //       allows us to cancel the computation if the user deems it is taking
    //       too long. This is all done with NSOperations. If the question is
    //       solved faster than the user can respond, we ignore using this flag.
    //       Otherwise, we will inject it throughout the computation methods so
    //       that it will terminate the computation.
  }
  return self;
}

#pragma mark - Setup

- (void)initialize; {
  // This method will hold all the precomputed values for the given question.
}

#pragma mark - Methods

- (void)computeAnswer; {
  // This method computes the answer with an optimized solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeButtonPressed:(UIButton *)aButton;
}

- (void)computeAnswerByBruteForce; {
  // This method computes the answer with a brute force solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton;
}

- (void)swapIndex1:(uint)aIndex1 withIndex2:(uint)aIndex2 inArray:(int *)aArray; {
  // This is the cleaver way of swapping values. Instead of making a temporary
  // variable, we simply use a bit of math. To swap values a and b, use:
  //
  //                        a's value              b's value
  // 1) a = a + b            (a + b)                   b
  // 2) b = a - b            (a + b)            (a + b) - b = a
  // 3) a = a - b        (a + b) - a = b               a
  //
  // Note: This only works for signed values!
  
  // Add the second array value to the first array value as in 1).
  aArray[aIndex1] += aArray[aIndex2];
  
  // Set the second array value to the first array value minus the second array
  // value as in 2).
  aArray[aIndex2] = aArray[aIndex1] - aArray[aIndex2];
  
  // Subtract the second array value to the first array value as in 3).
  aArray[aIndex1] -= aArray[aIndex2];
}

- (BOOL)isPrime:(int)aNumber; {
  // Return is the smallest factor of the number is the number itself!
  return ([self leastFactorOf:aNumber] == aNumber);
}

- (BOOL)isNumberAPerfectSquare:(long long int)aNumber; {
  // This helper method returns is a number is a perfect square of not. Note:
  // that this method only works for small numbers (less than 2,147,483,647). In
  // order to extend this to larger numbers, use techniques like Newtons method
  // (which should converge quickly), or a binary search.
  
  // Variable to hold the floored square root of the number.
  long long int squareRoot = (uint)sqrt((double)aNumber);
  
  // Square the floored square root of the number.
  squareRoot *= squareRoot;
  
  // Return if the squared floored square root of the number is equal to the number.
  return (aNumber == squareRoot);
}

- (BOOL)isStringAPalindrome:(NSString *)aString; {
  // This method takes in a string and sees if the string is a Palindrome or not.
  // It is much more versatile, because the "digits" can be anything, not just
  // numbers. It is, however, slower.
  //
  // Note: While we could improve the runtime by modifying the code to check
  //       the right and left "digits" (just as in the Question 4 Private method),
  //       for ease and clarity, we just reverse the string and compare if the
  //       new string is equal to the old one. It is very straight-forward to
  //       merge these two methods together.
  //
  // Note 2: We now use the helper method below to reverse the string, though
  //         it is exactly the same method as was used here before.
  //
  // Check and return is the string and reversedString are equal.
  return [aString isEqualToString:[self reversedString:aString]];
}

- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number of digits is NOT 8 or 9,
  if((numberOfDigits > 9) || (numberOfDigits < 8)){
    // Return that the number is NOT 9-Lexographic.
    return NO;
  }
  // Variable to hold if the number is lexographic or not.
  BOOL numberIsLexographic = YES;
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable array to hold if the digit in the number has been used or not.
  BOOL isDigitUsed[10];
  
  // For all the digits from 0 to 9,
  for(int digit = 0; digit < 10; digit++){
    // Default that the digit has not been used or not.
    isDigitUsed[digit] = NO;
  }
  // If the number is in the 100 millions, or does NOT count the 0,
  if(numberOfDigits == 8 || !doesCountZero){
    // Set that the 0 digit is already used (it's the left-most digit).
    isDigitUsed[0] = YES;
  }
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // If the digit has already been used,
    if(isDigitUsed[digit]){
      // Set that the number is NOT a 9-lexographic number.
      numberIsLexographic = NO;
      
      // Break out of the loop.
      break;
    }
    // If the digit has NOT already been used,
    else{
      // Set that the digit has been used.
      isDigitUsed[digit] = YES;
    }
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is lexographic or not.
  return numberIsLexographic;
}

- (BOOL)anInt:(uint)aNumber isAPermutationOfInt:(int)aSecondNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigitsInFirstNumber = (int)(log10(aNumber));
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigitsInSecondNumber = (int)(log10(aSecondNumber));
  
  // If the two inputted numbers do not have the same number of digits,
  if(numberOfDigitsInFirstNumber != numberOfDigitsInSecondNumber){
    // They cannot be permutations of each other, so return NO.
    return NO;
  }
  // Variable to hold if the numbers are permutations of each other or not.
  BOOL isAPermutation = YES;
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  int powerOf10 = 1;
  
  // Variable array to hold the number of each digits in the first number.
  uint digitsUsedInFirstNumber[10];
  
  // Variable array to hold the number of each digits in the second number.
  uint digitsUsedInSecondNumber[10];
  
  // For all the base-10 digits,
  for(int digit = 0; digit <= 9; digit++){
    // Set the default number of digits used to 0 for the current digit in the
    // first number.
    digitsUsedInFirstNumber[digit] = 0;
    
    // Set the default number of digits used to 0 for the current digit in the
    // second number.
    digitsUsedInSecondNumber[digit] = 0;
  }
  // While the number of digits is positive,
  while(numberOfDigitsInFirstNumber >= 0){
    // Grab the current digit from the first number.
    digit = (((uint)(aNumber / powerOf10)) % 10);
    
    // Increment the number of digits used in the first number for the current
    // digit by 1.
    digitsUsedInFirstNumber[digit]++;
    
    // Grab the current digit from the second number.
    digit = (((uint)(aSecondNumber / powerOf10)) % 10);
    
    // Increment the number of digits used in the second number for the current
    // digit by 1.
    digitsUsedInSecondNumber[digit]++;
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigitsInFirstNumber--;
  }
  // For all the base-10 digits,
  for(int digit = 0; digit <= 9; digit++){
    // If the number of digits used in the first number and the second number
    // are not equal,
    if(digitsUsedInFirstNumber[digit] != digitsUsedInSecondNumber[digit]){
      // They cannot be permutations of each other, so set the return value to NO.
      isAPermutation = NO;
      
      // Break out of the loop.
      break;
    }
  }
  // Return if the number is a permutation or not.
  return isAPermutation;
}

- (BOOL)number:(long long int)aNumber isAPermutationOfNumber:(long long int)aSecondNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigitsInFirstNumber = (int)(log10(aNumber));
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigitsInSecondNumber = (int)(log10(aSecondNumber));
  
  // If the two inputted numbers do not have the same number of digits,
  if(numberOfDigitsInFirstNumber != numberOfDigitsInSecondNumber){
    // They cannot be permutations of each other, so return NO.
    return NO;
  }
  // Variable to hold if the numbers are permutations of each other or not.
  BOOL isAPermutation = YES;
  
  // Variable array to hold the number of each digits in the first number.
  uint digitsUsedInFirstNumber[10];
  
  // Variable array to hold the number of each digits in the second number.
  uint digitsUsedInSecondNumber[10];
  
  // For all the base-10 digits,
  for(int digit = 0; digit <= 9; digit++){
    // Set the default number of digits used to 0 for the current digit in the
    // first number.
    digitsUsedInFirstNumber[digit] = 0;
    
    // Set the default number of digits used to 0 for the current digit in the
    // second number.
    digitsUsedInSecondNumber[digit] = 0;
  }
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  long long int powerOf10 = 1;
  
  // While the number of digits is positive,
  while(numberOfDigitsInFirstNumber >= 0){
    // Grab the current digit from the first number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // Increment the number of digits used in the first number for the current
    // digit by 1.
    digitsUsedInFirstNumber[digit]++;
    
    // Grab the current digit from the second number.
    digit = (((long long int)(aSecondNumber / powerOf10)) % 10);
    
    // Increment the number of digits used in the second number for the current
    // digit by 1.
    digitsUsedInSecondNumber[digit]++;
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigitsInFirstNumber--;
  }
  // For all the base-10 digits,
  for(int digit = 0; digit <= 9; digit++){
    // If the number of digits used in the first number and the second number
    // are not equal,
    if(digitsUsedInFirstNumber[digit] != digitsUsedInSecondNumber[digit]){
      // They cannot be permutations of each other, so set the return value to NO.
      isAPermutation = NO;
      
      // Break out of the loop.
      break;
    }
  }
  // Return if the number is a permutation or not.
  return isAPermutation;
}

- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero maxDigit:(uint)aMaxDigit; {
  // If the maximum digit is NOT a valid base 10 digit,
  if((aMaxDigit > 9) || (aMaxDigit == 0)){
    // Return that the number is NOT lexographic.
    return NO;
  }
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the maximum number of digits the inputted number can have.
  int maximumNumberOfDigits = aMaxDigit;
  
  // If we do count 0 as a valid digit,
  if(doesCountZero){
    // Increment the maximum number of digits the inputted number can have by 1.
    maximumNumberOfDigits++;
  }
  // If the number of digits is greater than or equal to the max number of digits,
  if(numberOfDigits >= maximumNumberOfDigits){
    // Return that the number is NOT lexographic.
    return NO;
  }
  // Variable to hold if the number is lexographic or not.
  BOOL numberIsLexographic = YES;
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable array to hold if the digit in the number has been used or not.
  BOOL isDigitUsed[10];
  
  // For all the digits from 0 to the maximum digit,
  for(int digit = 0; digit <= aMaxDigit; digit++){
    // Default that the digit has not been used or not.
    isDigitUsed[digit] = NO;
  }
  // For all the digits from 0 to the maximum digit,
  for(int digit = (aMaxDigit + 1); digit <= 9; digit++){
    // Default that the digit has not been used or not.
    isDigitUsed[digit] = YES;
  }
  // If we do NOT count the 0,
  if(!doesCountZero){
    // Set that the 0 digit is already used (it's the left-most digit).
    isDigitUsed[0] = YES;
  }
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // If the digit has already been used,
    if(isDigitUsed[digit]){
      // Set that the number is NOT a 9-lexographic number.
      numberIsLexographic = NO;
      
      // Break out of the loop.
      break;
    }
    // If the digit has NOT already been used,
    else{
      // Set that the digit has been used.
      isDigitUsed[digit] = YES;
    }
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is lexographic or not.
  return numberIsLexographic;
}

- (uint)gcdOfA:(uint)aA b:(uint)aB; {
  // Variable to hold the greatest common divisor of the 2 input numbers.
  uint gcd = 1;
  
  // Variable to hold the maximum number of the 2 input numbers.
  uint currentMax = MAX(aA, aB);
  
  // Variable to hold the minimum number of the 2 input numbers.
  uint currentMin = MIN(aA, aB);
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the square root of the current number, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(currentMin));
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:sqrtOfCurrentNumber];
  
  // For all the prime numbers in the prime numbers array,
  for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
    // Grab the current prime number from the prime numbers array.
    primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
    
    // If the current prime number is less than or equal to the square root of
    // the current minimum number,
    if(primeNumber <= sqrtOfCurrentNumber){
      // If the current prime number divides the current minimum number,
      if((currentMin % primeNumber) == 0){
        // While the current prime number divides the current minimum number,
        while((currentMin % primeNumber) == 0){
          // If the current prime number divides the current maximum number,
          if((currentMax % primeNumber) == 0){
            // Divide out the prime number from the maximum number.
            currentMax /= primeNumber;
            
            // Multiply the greatest common divisor by the prime number, since
            // it divides both the maximum and minimum numbers.
            gcd *= primeNumber;
          }
          // Divide out the prime number from the minimum number.
          currentMin /= primeNumber;
        }
        // Recompute the square root of the current minimum number, in order to
        // speed up the computation.
        sqrtOfCurrentNumber = ((uint)sqrt(currentMin));
      }
    }
    // If the current prime number is greater than or equal to the square root
    // of the current prime number,
    else{
      // Break out of the loop.
      break;
    }
  }
  // If the current minimum number is NOT equal to 1 after the above factoring,
  // it must be a prime number itself,
  if(currentMin > 1){
    // If the current prime number (which is the current minimum number) divides
    // the current maximum number,
    if((currentMax % currentMin) == 0){
      // Multiply the greatest common divisor by the prime number, since
      // it divides both the maximum and minimum numbers.
      gcd *= currentMin;
    }
  }
  // Return the greatest common divisor of the 2 input numbers.
  return gcd;
}

- (uint)leastFactorOf:(uint)aNumber; {
  // Here, we use the arithmetic progression trick 30k + 7 to check all the
  // possible factors a number can have. Notice that 2 * 3 * 5 = 30. Using this
  // fact, we can just check all the numbers coprime to 2, 3, and 5 in the range
  // of (30k + 7, 30(k+1) + 7) for all integers k.
  //
  // This process is very similar to the Sieve of Eratosthenes, though we don't
  // store the prime values we find, nor do we check if the factor we are
  // testingis prime.
  
  // If the number is 0 or 1,
  if(aNumber <= 1){
    // Return 1 as the least factor of the number.
    return 1;
  }
  // If the number is divisible by 2,
  if((aNumber % 2) == 0){
    // Return 2 as the least factor of the number.
    return 2;
  }
  // If the number is divisible by 3,
  if((aNumber % 3) == 0){
    // Return 3 as the least factor of the number.
    return 3;
  }
  // If the number is divisible by 5,
  if((aNumber % 5) == 0){
    // Return 5 as the least factor of the number.
    return 5;
  }
  // Compute the square root of the number.
  uint squareRoot = (uint)sqrt(aNumber);
  
  // For all the values in the arithmetic progression 30k + 7, up to the square
  // root of the inputted number,
  for(uint i = 7; i <= squareRoot; i += 30){
    // If the number is divisible by i,
    if((aNumber % i) == 0){
      // Return i as the least factor of the number.
      return i;
    }
    // If the number is divisible by (i + 4),
    if((aNumber % (i + 4)) == 0){
      // Return (i + 4) as the least factor of the number.
      return i + 4;
    }
    // If the number is divisible by (i + 6),
    if((aNumber % (i + 6)) == 0){
      // Return (i + 6) as the least factor of the number.
      return i + 6;
    }
    // If the number is divisible by (i + 10),
    if((aNumber % (i + 10)) == 0){
      // Return (i + 10) as the least factor of the number.
      return i + 10;
    }
    // If the number is divisible by (i + 12),
    if((aNumber % (i + 12)) == 0){
      // Return (i + 12) as the least factor of the number.
      return i + 12;
    }
    // If the number is divisible by (i + 16),
    if((aNumber % (i + 16)) == 0){
      // Return (i + 16) as the least factor of the number.
      return i + 16;
    }
    // If the number is divisible by (i + 22),
    if((aNumber % (i + 22)) == 0){
      // Return (i + 22) as the least factor of the number.
      return i + 22;
    }
    // If the number is divisible by (i + 24),
    if((aNumber % (i + 24)) == 0){
      // Return (i + 24) as the least factor of the number.
      return i + 24;
    }
  }
  // Return the number itself as the least factor of the number, as the number
  // must be prime.
  return aNumber;
}

- (uint)sumOfDigits:(long long int)aNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the sum of the digits of the inputted number.
  uint digitSum = 0;
  
  // Variable to hold the power of 10 for the current digit.
  long long int powerOf10 = 1;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab and sum the current digit from the input number.
    digitSum += (((long long int)(aNumber / powerOf10)) % 10);
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return the sum of the digits.
  return digitSum;
}

- (uint)sumOfDigitsFactorials:(uint)aNumber; {
  // Constant array to hold the value of the factorials from 0 to 9.
  const uint factorialValues[10] = {1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880};
  
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable to hold the sum of the factorial of the digits of the inputted
  // number.
  uint digitFactorialSum = 0;
  
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((uint)(aNumber / powerOf10)) % 10);
    
    // Add the factorial of the digit to the digit factorial sum.
    digitFactorialSum += factorialValues[digit];
    
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return the sum of the factorial of the digits.
  return digitFactorialSum;
}

- (uint)digitSumOfNumber:(NSString *)aNumber; {
  // Variable to hold the current digit.
  uint currentDigit = 0;
  
  // Variable to hold the current index of the string.
  int currentIndex = (int)[aNumber length];
  
  // Variable to hold the digit sum.
  uint digitSum = 0;
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange;
  
  // While the current index is greater than 0,
  while(currentIndex > 0){
    // Decrease the currentIndex by 1, which is equivalent to looking at the
    // next digit to the right.
    currentIndex--;
    
    // Compute the range of the next "digit".
    subStringRange = NSMakeRange(currentIndex, 1);
    
    // Compute the current digit given the by current index.
    currentDigit = [[aNumber substringWithRange:subStringRange] intValue];
    
    // Increase the digit sum by the value of the digit.
    digitSum += currentDigit;
  }
  // Return the digit sum.
  return digitSum;
}

- (uint)nameScoreForString:(NSString *)aString; {
  // Variable to hold the names score.
  uint nameScore = 0;
  
  // Variable to hold the current index range for the reversed string.
  NSRange subStringRange;
  
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

- (uint)sumOfPowersForPrimePower:(PrimePower)aPrimePower; {
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // For all the powers from 0 to the prime powers power,
  for(int i = 0; i <= aPrimePower.power; i++){
    // Add the prime power to the sum.
    sum += ((uint)pow(((double)aPrimePower.primeNumber), ((double)i)));
  }
  // Return the sum.
  return sum;
}

- (uint)gcdOfA:(uint)aA b:(uint)aB primeNumbersArray:(NSArray *)aPrimeNumbersArray; {
  // Variable to hold the greatest common divisor of the 2 input numbers.
  uint gcd = 1;
  
  // Variable to hold the maximum number of the 2 input numbers.
  uint currentMax = MAX(aA, aB);
  
  // Variable to hold the minimum number of the 2 input numbers.
  uint currentMin = MIN(aA, aB);
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the square root of the current number, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(currentMin));
  
  // For all the prime numbers in the prime numbers array,
  for(int currentPrimeNumber = 0; currentPrimeNumber < [aPrimeNumbersArray count]; currentPrimeNumber++){
    // Grab the current prime number from the prime numbers array.
    primeNumber = [[aPrimeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
    
    // If the current prime number is less than or equal to the square root of
    // the current minimum number,
    if(primeNumber <= sqrtOfCurrentNumber){
      // If the current prime number divides the current minimum number,
      if((currentMin % primeNumber) == 0){
        // While the current prime number divides the current minimum number,
        while((currentMin % primeNumber) == 0){
          // If the current prime number divides the current maximum number,
          if((currentMax % primeNumber) == 0){
            // Divide out the prime number from the maximum number.
            currentMax /= primeNumber;
            
            // Multiply the greatest common divisor by the prime number, since
            // it divides both the maximum and minimum numbers.
            gcd *= primeNumber;
          }
          // Divide out the prime number from the minimum number.
          currentMin /= primeNumber;
        }
        // Recompute the square root of the current minimum number, in order to
        // speed up the computation.
        sqrtOfCurrentNumber = ((uint)sqrt(currentMin));
      }
    }
    // If the current prime number is greater than or equal to the square root
    // of the current prime number,
    else{
      // Break out of the loop.
      break;
    }
  }
  // If the current minimum number is NOT equal to 1 after the above factoring,
  // it must be a prime number itself,
  if(currentMin > 1){
    // If the current prime number (which is the current minimum number) divides
    // the current maximum number,
    if((currentMax % currentMin) == 0){
      // Multiply the greatest common divisor by the prime number, since
      // it divides both the maximum and minimum numbers.
      gcd *= currentMin;
    }
  }
  // Return the greatest common divisor of the 2 input numbers.
  return gcd;
}

- (double)log:(double)x withBase:(double)aBase; {
  // This helper method computes the log of a value with a given base.
  return (log(x) / log(aBase));
}

- (double)flooredLog:(double)x withBase:(double)aBase; {
  // This helper method computes the rounded log of a value with a given base.
  return ((double)((uint)[self log:x withBase:aBase]));
}

- (NSString *)reversedString:(NSString *)aString; {
  // Variable to hold the current index range for the reversed string.
  NSRange subStringRange;
  
  // Variable to hold the current index of the string.
  NSInteger characterIndex = [aString length];
  
  // Variable to hold the reversed string.
  NSMutableString * reversedString = [NSMutableString string];
  
  // While the character index is greater than 0,
  while(characterIndex > 0){
    // Decrease the characterIndex by 1, which is equivalent to looking at the
    // next character to the left.
    characterIndex--;
    
    // Compute the range of the next character.
    subStringRange = NSMakeRange(characterIndex, 1);
    
    // Add the character to the reversedString.
    [reversedString appendString:[aString substringWithRange:subStringRange]];
  }
  // Return the reversed string.
  return reversedString;
}

- (NSString *)rotateStringLeftByOne:(NSString *)aString; {
  // If the string's length is greater than 1,
  if([aString length] > 1){
    // Grab the first character of the string, and add it to the end of the last
    // remaining characters of the string, and return the reordered string.
    return [NSString stringWithFormat:@"%@%@", [aString substringWithRange:NSMakeRange(1, ([aString length] - 1))], [aString substringWithRange:NSMakeRange(0, 1)]];
  }
  // If the string's length is less than or equal to 1,
  else{
    // Return the string.
    return aString;
  }
}

- (NSMutableArray *)arrayOfPrimeNumbersOfSize:(uint)aSize; {
  // By expanding out the Taylor Series of the result of the Prime Number Theorem,
  //
  // TT (n) ~ n / ln(n),
  //
  // We arrive at the fact that the nth prime is about size:
  //
  // n * ln(n) - n * ln(ln(n)) + O(n * ln(ln(ln(n))))
  //
  // Therefore, if we add a fairly large constant factor of 1.2 to the first term,
  // we should be able to get a fairly accurate upper limit of it's size.
  
  // Compute the limit based on the end size of the array (i.e.: The number of
  // primes in the array).
  uint limit = (uint)(1.2 * aSize * log(aSize));
  
  if(limit <= MaxSizeOfSieveOfAtkinson){
    // Return the array of prime numbers based on the computed limit, and the size,
    // computed using the Sieve of Atkinson.
    return [self arrayOfPrimeNumbersUpTo:limit count:aSize];
  }
  else if(limit <= MaxSizeOfSieveOfEratosthenes){
    // Return the array of prime numbers based on the computed limit, and the size,
    // computed using the Sieve of Eratosthenes.
    return [self slowArrayOfPrimeNumbersUpTo:limit count:aSize];
  }
  else{
    // Print out in the console that the requested size of the array is too large.
    NSLog(@"The size: %d is too big!!! Less than %d please!", limit, MaxSizeOfSieveOfEratosthenes);
    
     // Return nil, as we cannot create a list of primes as large as requested.
    return nil;
  }
}

- (NSMutableArray *)arrayOfPrimeNumbersLessThan:(uint)aLimit; {
  if(aLimit <= MaxSizeOfSieveOfAtkinson){
    // Return the array of prime numbers based on the limit. A size of 0 means that
    // the method doesn't care about the number of primes in the array. Compute
    // using the Sieve of Atkinson.
    return [self arrayOfPrimeNumbersUpTo:aLimit count:0];
  }
  else if(aLimit <= MaxSizeOfSieveOfEratosthenes){
    // Return the array of prime numbers based on the limit. A size of 0 means that
    // the method doesn't care about the number of primes in the array. Compute
    // using the Sieve of Eratosthenes.
    return [self slowArrayOfPrimeNumbersUpTo:aLimit count:0];
  }
  else{
    // Print out in the console that the requested size of the array is too large.
    NSLog(@"The size: %d is too big!!! Less than %d please!", aLimit, MaxSizeOfSieveOfEratosthenes);
    
    // Return nil, as we cannot create a list of primes as large as requested.
    return nil;
  }
}

@end

#pragma mark - Private Methods

@implementation QuestionAndAnswer (Private)

- (NSMutableArray *)arrayOfPrimeNumbersUpTo:(uint)aLimit count:(uint)aCount; {
  // There may be more efficient data structure arrangements than this (there are!),
  // but this is the algorithm from Wikipedia. http://en.wikipedia.org/wiki/Sieve_of_Atkin
  //
  // For a full detailed mathematical description and proof of this method, visit:
  //
  // http://www.ams.org/journals/mcom/2004-73-246/S0025-5718-03-01501-1/S0025-5718-03-01501-1.pdf
  
  // The array that will hold all the prime numbers.
  NSMutableArray * primesArray = [[NSMutableArray alloc] init];
  
  // The array that will hold if the number at the index is a prime or not.
  BOOL sieve[(aLimit + 1)];
  
  // Initialize results array.
  for(int i = 4; i < (aLimit + 1); i++){
    // Set by default that a number is NOT prime.
    sieve[i] = NO;
  }
  // Precompute the square root of the limit.
  uint limitSquareRoot = (uint)sqrt((double)aLimit);
  
  // The sieve works only for integers > 3, so set the trivial values.
  sieve[0] = NO;
  sieve[1] = NO;
  sieve[2] = YES;
  sieve[3] = YES;
  
  // Loop through all possible integer values for x and y up to the square root
  // of the max prime for the sieve. We don't need any larger values for x or y,
  // since the max value for x or y will be the square root of n. In the quadratics,
  // the theorem showed that the quadratics will produce all primes that also
  // satisfy their wheel factorizations, so we can produce the value of n from
  // the quadratic first, and then filter n through the wheel quadratic.
  
  // For all integers for x less than or equal to the square root of the limit,
  for(int x = 1; x <= limitSquareRoot; x++){
    // For all integers for y less than or equal to the square root of the limit,
    for(int y = 1; y <= limitSquareRoot; y++){
      // First quadratic using m = 12 and r in R1 = {r : 1, 5}.
      int n = (4 * x * x) + (y * y);
      
      if(n <= aLimit && (n % 12 == 1 || n % 12 == 5)){
        sieve[n] = !sieve[n];
      }
      // Second quadratic using m = 12 and r in R2 = {r : 7}.
      n = (3 * x * x) + (y * y);
      
      if(n <= aLimit && (n % 12 == 7)){
        sieve[n] = !sieve[n];
      }
      // Third quadratic using m = 12 and r in R3 = {r : 11}.
      n = (3 * x * x) - (y * y);
      
      if(x > y && n <= aLimit && (n % 12 == 11)){
        sieve[n] = !sieve[n];
      }
      // Note: that R1 union R2 union R3 is the set R = {r : 1, 5, 7, 11}, which
      // is all values 0 < r < 12 where r is a relative prime of 12. Thus all
      // primes become candidates.
    }
  }
  // Remove all perfect squares, since the quadratic wheel factorization filter
  // removes only some of them.
  for(int n = 5; n <= limitSquareRoot; n++){
    // If it is a prime number,
    if(sieve[n]){
      // Grab the square of the prime number.
      long long int x = n * n;
      
      // For all the multiples of the square number,
      for(long long int i = x; i <= aLimit; i += x){
        // Set that this multiple is not a prime.
        sieve[i] = NO;
      }
    }
  }
  // If the count is greater than 0, we only add the primes up to the count to
  // the primes array.
  if(aCount > 0){
    // Variable to hold the current number of primes added.
    uint currentCount = 0;
    
    // Add in all the primes to the primes array.
    for(int i = 0; i <= aLimit; i++){
      // If the number is a prime number,
      if(sieve[i]){
        // Add the prime number to the array.
        [primesArray addObject:[NSNumber numberWithInt:i]];
        
        // Increase the current count of the primes by 1.
        currentCount++;
        
        // If the current count equals the requested number of primes,
        if(currentCount == aCount){
          // Break out of the loop.
          break;
        }
      }
    }
  }
  // If the count is equal to 0, we add all the found primes to the array.
  else{
    // Add in all the primes to the primes array.
    for(int i = 0; i <= aLimit; i++){
      // If the number is a prime number,
      if(sieve[i]){
        // Add the prime number to the array.
        [primesArray addObject:[NSNumber numberWithInt:i]];
      }
    }
  }
  // Return the prime numbers array.
  return primesArray;
}

- (NSMutableArray *)slowArrayOfPrimeNumbersUpTo:(uint)aLimit count:(uint)aCount; {
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [[NSMutableArray alloc] init];
  
  // Add in the first prime, 2, to the prime array.
  [primeNumbersArray addObject:[NSNumber numberWithInt:2]];
  
  // BOOL variable to mark if a current number is prime.
  BOOL isPrime = NO;
  
  // Variable to hold the current prime number, used to minimize computations.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the square root of the current number, used to minimize computations.
  uint sqrtOfCurrentNumber = 0;
  
  // If the count is greater than 0, we want an exact count. This saves us from
  // making the check count repeatedly if we don't actually care about the number
  // of primes returned.
  if(aCount > 0){
    // Loop through all the prime numbers already found. No need to check the even
    // numbers, as they are always divisible by 2, and are therefore no prime. Since
    // we start at 3, incrementing by 2 will mean that currentNumber is always odd.
    for(int currentNumber = 3; currentNumber < aLimit; currentNumber += 2){
      // Reset the marker to see if the current number is prime.
      isPrime = YES;
      
      // Compute the square root of the current number.
      sqrtOfCurrentNumber = (int)sqrtf(currentNumber);
      
      // Loop through all the prime numbers already found.
      for(NSNumber * number in primeNumbersArray){
        // Grab the current prime number.
        currentPrimeNumber = [number intValue];
        
        // If the current prime number is less than the square root of the current number,
        if(currentPrimeNumber <= sqrtOfCurrentNumber){
          // If the current prime number divides our current number,
          if((currentNumber % currentPrimeNumber) == 0){
            // The current number is not prime, so exit the loop.
            isPrime = NO;
            break;
          }
        }
        else{
          // Since the number is bigger than the square root of the current number,
          // exit the loop.
          break;
        }
      }
      // If the current number was marked as a prime number,
      if(isPrime){
        // If we are no longer computing,
        if(!_isComputing){
          // Break out of the loop.
          break;
        }
        // Add the number to the array of prime numbers.
        [primeNumbersArray addObject:[NSNumber numberWithInt:currentNumber]];
        
        // If the current count equals the requested number of primes,
        if([primeNumbersArray count] == aCount){
          // Break out of the loop.
          break;
        }
      }
    }
  }
  // If the count is NOT greater than 0, we don't care about the count.
  else{
    // Loop through all the prime numbers already found. No need to check the even
    // numbers, as they are always divisible by 2, and are therefore no prime. Since
    // we start at 3, incrementing by 2 will mean that currentNumber is always odd.
    for(int currentNumber = 3; currentNumber < aLimit; currentNumber += 2){
      // Reset the marker to see if the current number is prime.
      isPrime = YES;
      
      // Compute the square root of the current number.
      sqrtOfCurrentNumber = (int)sqrtf(currentNumber);
      
      // Loop through all the prime numbers already found.
      for(NSNumber * number in primeNumbersArray){
        // Grab the current prime number.
        currentPrimeNumber = [number intValue];
        
        // If the current prime number is less than the square root of the current number,
        if(currentPrimeNumber <= sqrtOfCurrentNumber){
          // If the current prime number divides our current number,
          if((currentNumber % currentPrimeNumber) == 0){
            // The current number is not prime, so exit the loop.
            isPrime = NO;
            break;
          }
        }
        else{
          // Since the number is bigger than the square root of the current number,
          // exit the loop.
          break;
        }
      }
      // If the current number was marked as a prime number,
      if(isPrime){
        // If we are no longer computing,
        if(!_isComputing){
          // Break out of the loop.
          break;
        }
        // Add the number to the array of prime numbers.
        [primeNumbersArray addObject:[NSNumber numberWithInt:currentNumber]];
      }
    }
  }
  // Return the prime numbers array.
  return primeNumbersArray;
}

@end