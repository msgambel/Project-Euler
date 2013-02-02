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
  self.text = @"The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.\n\nWe shall consider fractions like, 30/50 = 3/5, to be trivial examples.\n\nThere are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.\n\nIf the product of these four fractions is given in its lowest common terms, find the value of the denominator.";
  self.title = @"Digit canceling fractions";
  self.answer = @"100";
  self.number = @"Problem 33";
  self.estimatedComputationTime = @"1.51e-04";
  self.estimatedBruteForceComputationTime = @"2.84e-04";
}

#pragma mark - Methods

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

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
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
        
        NSLog(@"num: %d, den: %d, gcd: %d", numerator, denominator, gcd);
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
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
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
    // It is NOT a digit cancelling question, so return NO.
    return NO;
  }
  // If the numerator is NOT a double digit number,
  if((aNumerator <= 10) || (aNumerator >= 100)){
    // It is NOT a digit cancelling question, so return NO.
    return NO;
  }
  // If the denominator is NOT a double digit number,
  if((aDenominator <= 10) || (aDenominator >= 100)){
    // It is NOT a digit cancelling question, so return NO.
    return NO;
  }
  // If the numerator has a 0 in the units digit,
  if((aNumerator % 10) == 0){
    // It is NOT a digit cancelling question, so return NO.
    return NO;
  }
  // If the denominator has a 0 in the units digit,
  if((aDenominator % 10) == 0){
    // It is NOT a digit cancelling question, so return NO.
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
      // It is a digit cancelling question, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the tens digit of the numerator
  // and the units digit of the denominator,
  if((numeratorsTensDigit * aDenominator) == (denominatorsUnitsDigit * aNumerator)){
    // If the opposite digits are equal (the units digit of the numerator, and
    // the tens digit of the denominator),
    if(numeratorsUnitsDigit == denominatorsTensDigit){
      // It is a digit cancelling question, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the units digit of the numerator
  // and the tens digit of the denominator,
  if((numeratorsUnitsDigit * aDenominator) == (denominatorsTensDigit * aNumerator)){
    // If the opposite digits are equal (the tens digit of the numerator, and
    // the units digit of the denominator),
    if(numeratorsTensDigit == denominatorsUnitsDigit){
      // It is a digit cancelling question, so return YES.
      return YES;
    }
  }
  // If the fraction is equal to the fraction of the units digit of the numerator
  // and the units digit of the denominator,
  if((numeratorsUnitsDigit * aDenominator) == (denominatorsUnitsDigit * aNumerator)){
    // If the opposite digits are equal (the tens digit of the numerator, and
    // the tens digit of the denominator),
    if(numeratorsTensDigit == denominatorsTensDigit){
      // It is a digit cancelling question, so return YES.
      return YES;
    }
  }
  // It is NOT a digit cancelling question, so return NO.
  return NO;
}

@end