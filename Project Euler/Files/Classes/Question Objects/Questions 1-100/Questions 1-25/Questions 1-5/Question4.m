//  Question4.m

#import "Question4.h"

@interface Question4 (Private)

- (BOOL)isNumberAPalindrome:(uint)aNumber;

@end

@implementation Question4

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"16 November 2001";
  self.hint = @"Start from the top and work backwards.";
  self.link = @"https://en.wikipedia.org/wiki/Palindromic_number";
  self.text = @"A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91x99.\n\nFind the largest palindrome made from the product of two 3-digit numbers.";
  self.isFun = YES;
  self.title = @"Largest palindrome product";
  self.answer = @"906609";
  self.number = @"4";
  self.rating = @"3";
  self.category = @"Combinations";
  self.isUseful = YES;
  self.keywords = @"palindrome,largest,product,3,three,digit,numbers,2,two,read,positive,made,from";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.commentCount = @"20";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"04/01/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"04/01/13";
  self.solutionLineCount = @"15";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"7.97e-04";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"4.8e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // This is a fairly simple task. We loop through all the positive three digit
  // integers and compute their product. We have a helper method to check if the
  // product (passed in int form) is a Palindrome. If it is, we simple check to
  // see if it is the largest one found.
  // 
  // We do make some optimizations from brute force method. We only multiply
  // three digit positive integers where the left number in the product is
  // larger than the right. This saves on repetition, as the Integers form a Ring
  // where the multiplicative operator is commutative. (999*998 = 998*999).
  //
  // We start from 999, as the larger three digit positive integers are the most
  // likely to give us out result.
  
  // Variable to hold the product of the two numbers.
  uint product = 0;
  
  // Variable to hold the largest Palindrome.
  uint largestPalindrome = 0;
  
  // For all the three digit positive integers.
  for(int i = 999; i > 99; i--){
    // Compute the square of the current integer.
    product = i * i;
    
    // If the product is larger than the currently found largest Palindrome,
    if(product > largestPalindrome){
      // For all the three digit positive integers less than or equal to i.
      for(int j = i; j > 99; j--){
        // Compute the product of the two integers.
        product = i * j;
        
        // If the product is larger than the currently found largest Palindrome,
        if(product > largestPalindrome){
          // If the product is a Palindrome,
          if([self isNumberAPalindrome:product]){
            // Set the largest found Palindrome to be the current product.
            largestPalindrome = product;
          }
        }
        else{
          // If this product is smaller then the largest Palindrome already found,
          // then all the following products must also be smaller, so break out of
          // the loop.
          break;
        }
      }
    }
    else{
      // If i * i is smaller then the largest Palindrome already found, then all
      // the following products must also be smaller, as j <= i, so break out of
      // the loop.
      break;
    }
  }
  // Set the answer string to the largest Palindrome.
  self.answer = [NSString stringWithFormat:@"%d", largestPalindrome];
  
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
  
  // This is a fairly simple task. We loop through all the positive three digit
  // integers and compute their product. We have a helper method to check if the
  // product (passed in NSString form) is a Palindrome. If it is, we simple check
  // to see if it is the largest one found.
  // 
  // We start from 999, as the larger three digit positive integers are the most
  // likely to give us out result.
  
  // Variable to hold the product of the two numbers.
  uint product = 0;
  
  // Variable to hold the largest Palindrome.
  uint largestPalindrome = 0;
  
  // For all the three digit positive integers.
  for(int i = 999; i > 99; i--){
    // For all the three digit positive integers.
    for(int j = 999; j > 99; j--){
      // Compute the product of the two integers.
      product = i * j;
      
      // If the product is larger than the currently found largest Palindrome,
      if(product > largestPalindrome){
        // If the product is a Palindrome,
        if([self isStringAPalindrome:[NSString stringWithFormat:@"%d", product]]){
          // Set the largest found Palindrome to be the current product.
          largestPalindrome = product;
        }
      }
      else{
        // If this product is smaller then the largest Palindrome already found,
        // then all the following products must also be smaller, so break out of
        // the loop.
        break;
      }
    }
  }
  // Set the answer string to the largest Palindrome.
  self.answer = [NSString stringWithFormat:@"%d", largestPalindrome];
  
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

@implementation Question4 (Private)

- (BOOL)isNumberAPalindrome:(uint)aNumber; {
  // This method figured out if the number is a Palindrome or not by grabbing
  // a left digit, its pair on the right, and compairing them to make sure they
  // are equal. This works only on integer values, and does significantly speed
  // up the comparisons, though it is not as versitle as the next method.
  
  // Variable to mark if the number is a Palindrome or not.
  BOOL isPalindrome = YES;
  
  // Variables to hold the right and left digits to compare.
  uint currentLeftDigit = 0;
  uint currentRightDigit = 0;
  
  // Variable to hold the number of digits in the number. Add 1 to the log base 10
  // value of the number, as log(10^n) = n, and there are n+1 digits in 10^n.
  uint numberOfDigits = ((uint)log10f((float)aNumber)) + 1;
  
  // Variable to hold the midPoint of the digits of the number.
  uint midPoint = 0;
  
  // Variable to hold the current left index of the number we are iterating over.
  uint currentIndex = numberOfDigits - 1;
  
  // If there are an even number of digits (where n is the number of digits),
  // then we have to make n / 2 comparisons. If there are an odd number of digits,
  // the we have to make (n - 1) / 2 comparisons, as the middle digit is always
  // equal to itself!
  
  // If there is a even number of digits,
  if((numberOfDigits % 2) == 0){
    // Compute the midpoint of the number.
    midPoint = numberOfDigits / 2;
    
    // While the current index is greater than or equal to the midPoint,
    while(currentIndex >= midPoint){
      // Compute the left and right digits given the current index.
      currentLeftDigit = ((uint)(aNumber / pow(10.0, (double)currentIndex))) % 10;
      currentRightDigit = ((uint)(aNumber / pow(10.0, (double)(numberOfDigits - currentIndex - 1)))) % 10;
      
      // If the two digits are NOT of equal value,
      if(currentLeftDigit != currentRightDigit){
        // The number is NOT a Palindrome, so mark it as such, and exit the loop.
        isPalindrome = NO;
        break;
      }
      // Decrease the currentIndex by 1, which is equivalent to looking at the
      // next digit to the right.
      currentIndex--;
    }
  }
  // If there is a odd number of digits,
  else{
    // Compute the midpoint of the number.
    midPoint = (numberOfDigits - 1) / 2;
    
    // While the current index is strictly greater than to the midPoint,
    while(currentIndex > midPoint){
      // Compute the left and right digits given the current index.
      currentLeftDigit = ((uint)(aNumber / pow(10.0, (double)currentIndex))) % 10;
      currentRightDigit = ((uint)(aNumber / pow(10.0, (double)(numberOfDigits - currentIndex - 1)))) % 10;
      
      // If the two digits are NOT of equal value,
      if(currentLeftDigit != currentRightDigit){
        // The number is NOT a Palindrome, so mark it as such, and exit the loop.
        isPalindrome = NO;
        break;
      }
      // Decrease the currentIndex by 1, which is equivalent to looking at the
      // next digit to the right.
      currentIndex--;
    }
  }
  // Return if the number is a Palindrome or not.
  return isPalindrome;
}

@end