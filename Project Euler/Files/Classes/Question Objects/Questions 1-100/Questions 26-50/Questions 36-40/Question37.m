//  Question37.m

#import "Question37.h"

@interface Question37 (Private)

- (uint)truncateUnitsDigitOfNumber:(uint)aNumber;
- (uint)truncateMostSignificantDigitOfNumber:(uint)aNumber;
- (NSString *)truncateLeftMostCharacterOfString:(NSString *)aString;
- (NSString *)truncateRightMostCharacterOfString:(NSString *)aString;

@end

@implementation Question37

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"14 February 2003";
  self.text = @"The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.\n\nFind the sum of the only eleven primes that are both truncatable from left to right and right to left.\n\nNOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.";
  self.title = @"Truncatable primes";
  self.answer = @"748317";
  self.number = @"34";
  self.keywords = @"primes,left,right,truncatable,continuously,remove,digits";
  self.estimatedComputationTime = @"0.99";
  self.estimatedBruteForceComputationTime = @"1.14";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we get the prime numbers less than 1,000,000, and use a Hash Table to
  // mark which numbers are prime or not. Then, we use a helper method to
  // truncate the units digit of the prime number, and check the Hash Table to
  // see if the truncated number is prime or not. We keep truncating the units
  // digit until the truncated number is equal to 0. If it is, do the same
  // process, this time truncating the most significant digit. If this test also
  // passes, we add the prime number to the sum of primes that all truncations,
  // both left and right, are also prime.
  
  // Variable to mark if a current number is prime or not.
  BOOL isPrime = YES;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Variable to hold the sum of the truncated primes found.
  uint sumOfTruncatedPrimesFound = 0;
  
  // Variable to hold the current truncated prime number.
  uint truncatedPrimeNumber = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Mark that the current number is prime.
    isPrime = YES;
    
    // Truncate the current prime number's units digit.
    truncatedPrimeNumber = [self truncateUnitsDigitOfNumber:[primeNumber intValue]];
    
    // While the truncate number is NOT equal to the empty string,
    while(truncatedPrimeNumber > 0){
      // If the truncated number is prime (using the Hash Table),
      if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", truncatedPrimeNumber]] boolValue]){
        // Truncate the current prime number's units digit.
        truncatedPrimeNumber = [self truncateUnitsDigitOfNumber:truncatedPrimeNumber];
      }
      // If the truncated number is NOT prime,
      else{
        // Mark that the truncated number is NOT prime.
        isPrime = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the current prime and all of its truncations are prime,
    if(isPrime){
      // Truncate the current prime number's most significant digit.
      truncatedPrimeNumber = [self truncateMostSignificantDigitOfNumber:[primeNumber intValue]];
      
      // While the truncate number is NOT equal to the empty string,
      while(truncatedPrimeNumber > 0){
        // If the truncated number is prime (using the Hash Table),
        if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", truncatedPrimeNumber]] boolValue]){
          // Truncate the current prime number's most significant digit.
          truncatedPrimeNumber = [self truncateMostSignificantDigitOfNumber:truncatedPrimeNumber];
        }
        // If the truncated number is NOT prime,
        else{
          // Mark that the truncated number is NOT prime.
          isPrime = NO;
          
          // Break out of the loop.
          break;
        }
      }
      // If the current prime and all of its truncations are prime,
      if(isPrime){
        // If the current prime is NOT single digits (2, 3, 5, and 7 don't count),
        if([primeNumber intValue] > 9){
          // Add the prime number the sum of truncated primes found.
          sumOfTruncatedPrimesFound += [primeNumber intValue];
        }
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the sum of truncated primes found.
    self.answer = [NSString stringWithFormat:@"%d", sumOfTruncatedPrimesFound];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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
  
  // Here, we get the prime numbers less than 1,000,000, and use a Hash Table to
  // mark which numbers are prime or not. Then, we use a helper method to
  // truncate the left-most character of the prime number as a string, and check
  // the Hash Table to see if the truncated number is prime or not. We keep
  // truncating the left-most character until the truncated number is equal to
  // the empty string. If it is, do the same process, this time truncating the
  // right-most character. If this test also passes, we add the prime number to
  // the sum of primes that all truncations, both left and right, are also prime.
  
  // Variable to mark if a current number is prime or not.
  BOOL isPrime = YES;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Variable to hold the sum of the truncated primes found.
  uint sumOfTruncatedPrimesFound = 0;
  
  // Variable to hold the current truncated prime number as a string.
  NSString * truncatedPrimeNumber = nil;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // Mark that the current number is prime.
    isPrime = YES;
    
    // Truncate the current string to the left by 1 character.
    truncatedPrimeNumber = [self truncateLeftMostCharacterOfString:[primeNumber stringValue]];
    
    // While the truncate number is NOT equal to the empty string,
    while(truncatedPrimeNumber.length > 0){
      // If the truncated number is prime (using the Hash Table),
      if([[primesDictionary objectForKey:truncatedPrimeNumber] boolValue]){
        // Truncate the current string to the left again by 1 character.
        truncatedPrimeNumber = [self truncateLeftMostCharacterOfString:truncatedPrimeNumber];
      }
      // If the truncated number is NOT prime,
      else{
        // Mark that the truncated number is NOT prime.
        isPrime = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the current prime and all of its truncations are prime,
    if(isPrime){
      // Truncate the current string to the right by 1 character.
      truncatedPrimeNumber = [self truncateRightMostCharacterOfString:[primeNumber stringValue]];
      
      // While the truncate number is NOT equal to the empty string,
      while(truncatedPrimeNumber.length > 0){
        // If the truncated number is prime (using the Hash Table),
        if([[primesDictionary objectForKey:truncatedPrimeNumber] boolValue]){
          // Truncate the current string to the right again by 1 character.
          truncatedPrimeNumber = [self truncateRightMostCharacterOfString:truncatedPrimeNumber];
        }
        // If the truncated number is NOT prime,
        else{
          // Mark that the truncated number is NOT prime.
          isPrime = NO;
          
          // Break out of the loop.
          break;
        }
      }
      // If the current prime and all of its truncations are prime,
      if(isPrime){
        // If the current prime is NOT single digits (2, 3, 5, and 7 don't count),
        if([primeNumber stringValue].length > 1){
          // Add the prime number the sum of truncated primes found.
          sumOfTruncatedPrimesFound += [primeNumber intValue];
        }
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the sum of truncated primes found.
    self.answer = [NSString stringWithFormat:@"%d", sumOfTruncatedPrimesFound];
    
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

@implementation Question37 (Private)

- (uint)truncateUnitsDigitOfNumber:(uint)aNumber; {
  // If the inputted number is equal to 0,
  if(aNumber == 0){
    // We can't take the log of the number, so return 0.
    return 0;
  }
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number is a single digit number,
  if(numberOfDigits == 0){
    // The truncation of a single digit number is 0, so return 0.
    return 0;
  }
  // Return the number without the units digit.
  return ((uint)(aNumber / 10));
}

- (uint)truncateMostSignificantDigitOfNumber:(uint)aNumber; {
  // If the inputted number is equal to 0,
  if(aNumber == 0){
    // We can't take the log of the number, so return 0.
    return 0;
  }
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number is a single digit number,
  if(numberOfDigits == 0){
    // The truncation of a single digit number is 0, so return 0.
    return 0;
  }
  // Compute the power of 10 that holds the most significant digit.
  double powerOf10 = pow(10.0, ((double) numberOfDigits));
  
  // Variable to hold the most significant digit of the number.
  uint mostSignificantDigit = ((uint)(aNumber / powerOf10));
  
  // Return the number minus the most significant digit.
  return (aNumber - (mostSignificantDigit * ((uint)powerOf10)));
}

- (NSString *)truncateLeftMostCharacterOfString:(NSString *)aString; {
  // If the string's length is greater than 1,
  if([aString length] > 1){
    // Return the last (n-1) characters.
    return [aString substringWithRange:NSMakeRange(1, ([aString length] - 1))];
  }
  // If the string's length is less than or equal to 1,
  else{
    // Return the emptystring.
    return @"";
  }
}

- (NSString *)truncateRightMostCharacterOfString:(NSString *)aString; {
  // If the string's length is greater than 1,
  if([aString length] > 1){
    // Return the first (n-1) characters.
    return [aString substringWithRange:NSMakeRange(0, ([aString length] - 1))];
  }
  // If the string's length is less than or equal to 1,
  else{
    // Return the emptystring.
    return @"";
  }
}

@end