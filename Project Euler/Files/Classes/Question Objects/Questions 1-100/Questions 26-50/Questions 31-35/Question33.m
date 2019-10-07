//  Question33.m

#import "Question33.h"

@interface Question33 (Private)

- (BOOL)isDigitCancellingFractionNumerator:(uint)aNumerator denominator:(uint)aDenominator;

@end

@implementation Question33

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"20 December 2002";
  self.hint = @"Remove all the trivial cases. Then, break the fraction into 2 fractions (tens digits in the first, ones digits in the second), and use some algebra to check for equality.";
  self.link = @"https://en.wikipedia.org/wiki/Fraction_(mathematics)";
  self.text = @"The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.\n\nWe shall consider fractions like, 30/50 = 3/5, to be trivial examples.\n\nThere are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.\n\nIf the product of these four fractions is given in its lowest common terms, find the value of the denominator.";
  self.isFun = YES;
  self.title = @"Digit canceling fractions";
  self.answer = @"100";
  self.number = @"33";
  self.rating = @"4";
  self.category = @"Primes";
  self.keywords = @"division,fractions,curious,numerator,denominator,digit,cancelling,lowest,common,terms,product";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"19";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"02/02/13";
  self.completedOnDate = @"02/02/13";
  self.solutionLineCount = @"61";
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"1.51e-04";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.84e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just use a helper method to figure out if the numerator and
  // denominator have the digit cancelling property, and if they do, we compute
  // the gcd of the numerator and denominator, divide the numerator and
  // denominator by the gcd, and then multply them all together to find the
  // required denominator. We take the gcd one last time after looping through
  // double digit variables, just in case there was 2 separate fractions that
  // had common factors.
  
  // Variable to hold the greatest common divisor of the numerator and denominator.
  uint gcd = 0;
  
  // Variable to hold the product of the numerators that satisfy the conditions.
  uint productNumerator = 1;
  
  // Variable to hold the product of the denominators that satisfy the conditions.
  uint productDenominator = 1;
  
  // For all the numerators from 11 to 99,
  for(int numerator = 11; numerator < 100; numerator++){
    // For all the denominators from the (numerator + 1) (since the fraction must
    // be less than 1) to 99,
    for(int denominator = (numerator + 1); denominator < 100; denominator++){
      // If the numerator and denominator have the digit cancelling property,
      if([self isDigitCancellingFractionNumerator:numerator denominator:denominator]){
        // Compute the gcd of the numerator and denominator.
        gcd = [self gcdOfA:numerator b:denominator];
        
        // Multiply the product of the numerators by the numerator divided by
        // the gcd.
        productNumerator *= (numerator / gcd);
        
        // Multiply the product of the denominators by the denominator divided
        // by the gcd.
        productDenominator *= (denominator / gcd);
      }
    }
  }
  // Compute the gcd of the product of the numerators and the product of the
  // denominators.
  gcd = [self gcdOfA:productNumerator b:productDenominator];
  
  // Divide the product of the denominators by the gcd.
  productDenominator /= gcd;
  
  // Set the answer string to the product of the denominators.
  self.answer = [NSString stringWithFormat:@"%d", productDenominator];
  
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
  
  // Here, we just use a helper method to figure out if the numerator and
  // denominator have the digit cancelling property, and if they do, we multply
  // them all together to find the required denominator. We take the gcd one
  // last time after looping through double digit variables, just in case there
  // was 2 separate fractions that had common factors.
  
  // Variable to hold the greatest common divisor of the numerator and denominator.
  uint gcd = 0;
  
  // Variable to hold the product of the numerators that satisfy the conditions.
  uint productNumerator = 1;
  
  // Variable to hold the product of the denominators that satisfy the conditions.
  uint productDenominator = 1;
  
  // For all the numerators from 11 to 99,
  for(int numerator = 11; numerator < 100; numerator++){
    // For all the denominators from 11 to 99,
    for(int denominator = 11; denominator < 100; denominator++){
      // If the numerator and denominator have the digit cancelling property,
      if([self isDigitCancellingFractionNumerator:numerator denominator:denominator]){
        // Multiply the product of the numerators by the numerator.
        productNumerator *= numerator;
        
        // Multiply the product of the denominators by the denominator.
        productDenominator *= denominator;
      }
    }
  }
  // Compute the gcd of the product of the numerators and the product of the
  // denominators.
  gcd = [self gcdOfA:productNumerator b:productDenominator];
  
  // Divide the product of the denominators by the gcd.
  productDenominator /= gcd;
  
  // Set the answer string to the product of the denominators.
  self.answer = [NSString stringWithFormat:@"%d", productDenominator];
  
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

#pragma mark - Private Methods

@implementation Question33 (Private)

- (BOOL)isDigitCancellingFractionNumerator:(uint)aNumerator denominator:(uint)aDenominator; {
  // The fraction has to be less than 1. So if the denominator is less than or
  // equal to the numerator,
  if(aDenominator <= aNumerator){
    // It is NOT a digit cancelling fraction, so return NO.
    return NO;
  }
  // If the numerator is NOT a double digit number,
  if((aNumerator <= 10) || (aNumerator >= 100)){
    // It is NOT a digit cancelling fraction, so return NO.
    return NO;
  }
  // If the denominator is NOT a double digit number,
  if((aDenominator <= 10) || (aDenominator >= 100)){
    // It is NOT a digit cancelling question, so return NO.
    return NO;
  }
  // If the numerator has a 0 in the units digit,
  if((aNumerator % 10) == 0){
    // It is NOT a digit cancelling fraction, so return NO.
    return NO;
  }
  // If the denominator has a 0 in the units digit,
  if((aDenominator % 10) == 0){
    // It is NOT a digit cancelling fraction, so return NO.
    return NO;
  }
  // Variable to hold the tens digit of the numerator.
  uint numeratorsTensDigit = aNumerator / 10;
  
  // Variable to hold the units digit of the numerator.
  uint numeratorsUnitsDigit = aNumerator % 10;
  
  // Variable to hold the tens digit of the denominator.
  uint denominatorsTensDigit = aDenominator / 10;
  
  // Variable to hold the units digit of the denominator.
  uint denominatorsUnitsDigit = aDenominator % 10;
  
  // Note that checking if a fraction is equal is the same thing as multiplying
  // the denominator of the left hand fraction by the numerator of the right hand
  // fraction and vice-versa. This allows for a more accurate comparison condition,
  // as we do not have to worry about rounding issues.
  
  // If the fraction is equal to the fraction of the tens digit of the numerator
  // and the tens digit of the denominator,
  if((numeratorsTensDigit * aDenominator) == (denominatorsTensDigit * aNumerator)){
    // If the opposite digits are equal (the units digit of the numerator, and
    // the units digit of the denominator),
    if(numeratorsUnitsDigit == denominatorsUnitsDigit){
      // It is a digit cancelling fraction, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the tens digit of the numerator
  // and the units digit of the denominator,
  if((numeratorsTensDigit * aDenominator) == (denominatorsUnitsDigit * aNumerator)){
    // If the opposite digits are equal (the units digit of the numerator, and
    // the tens digit of the denominator),
    if(numeratorsUnitsDigit == denominatorsTensDigit){
      // It is a digit cancelling fraction, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the units digit of the numerator
  // and the tens digit of the denominator,
  if((numeratorsUnitsDigit * aDenominator) == (denominatorsTensDigit * aNumerator)){
    // If the opposite digits are equal (the tens digit of the numerator, and
    // the units digit of the denominator),
    if(numeratorsTensDigit == denominatorsUnitsDigit){
      // It is a digit cancelling fraction, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the units digit of the numerator
  // and the units digit of the denominator,
  if((numeratorsUnitsDigit * aDenominator) == (denominatorsUnitsDigit * aNumerator)){
    // If the opposite digits are equal (the tens digit of the numerator, and
    // the tens digit of the denominator),
    if(numeratorsTensDigit == denominatorsTensDigit){
      // It is a digit cancelling fraction, so return YES.
      return YES;
    }
  }
  // It is NOT a digit cancelling fraction, so return NO.
  return NO;
}

@end