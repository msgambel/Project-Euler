//  Question35.m

#import "Question35.h"

@interface Question35 (Private)

- (BOOL)primeNumberHasValidRotateableDigits:(uint)aNumber;
- (uint)rotateNumberRightByOne:(uint)aNumber;

@end

@implementation Question35

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"17 January 2003";
  self.hint = @"The only digits a circular prime could have are 1, 3, 7, and 9.";
  self.text = @"The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.\n\nThere are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.\n\nHow many circular primes are there below one million?";
  self.isFun = YES;
  self.title = @"Circular primes";
  self.answer = @"55";
  self.number = @"35";
  self.rating = @"5";
  self.keywords = @"primes,rotation,circular,digits,one,million,1000000,permutations,less,even,odd,hash,table";
  self.difficulty = @"Medium";
  self.solutionLineCount = @"81";
  self.estimatedComputationTime = @"0.99";
  self.estimatedBruteForceComputationTime = @"1.42";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we get the prime numbers less than 1,000,000, and remove all the primes
  // that have digits in them that lead to a number that is not prime. The way
  // to tell is simple: if a digit is even or a multiply of 5, it CANNOT be rotated
  // to a prime, as the rotation would move it to the units digit, and the resulting
  // number would not be prime!
  //
  // We use a Hash Table to mark which numbers are prime or not. Then, we use a
  // helper method to rotate the prime number, and check the Hash Table to see if
  // the rotated number is prime or not. We keep rotating until the rotated number
  // is equal to the original prime number. If it makes it all the way around,
  // we increment the number of primes that all rotations are also prime by 1.
  
  // Variable to mark if a current number is prime or not.
  BOOL isPrime = YES;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Variable to hold the number of circular primes found.
  uint numberOfCircularPrimesFound = 0;
  
  // Variable to hold the current rotated prime number.
  uint rotatedPrimeNumber = 0;
  
  // Variable to hold the original prime number.
  uint originalPrimeNumber = 0;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // Variable array to hold the list of prime numbers that can be rotated.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // For all the prime numbers found,
  for(NSNumber * primeNumber in primeNumbersArray){
    // If the prime number has valid rotateable digits,
    if([self primeNumberHasValidRotateableDigits:[primeNumber intValue]]){
      // Add the prime number tp the updated prime numbers array.
      [updatedPrimeNumbersArray addObject:primeNumber];
    }
  }
  // For all the prime numbers found that have valid rotateable digits,
  for(NSNumber * primeNumber in updatedPrimeNumbersArray){
    // Add the prime number as a key to the Hash Table to easily look if the number
    // is prime or not.
    [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
  }
  // For all the prime numbers found that have valid rotateable digits,
  for(NSNumber * primeNumber in updatedPrimeNumbersArray){
    // Mark that the current number is prime.
    isPrime = YES;
    
    // Grab the current prime number.
    originalPrimeNumber = [primeNumber intValue];
    
    // Rotate the current number to the right by 1 digit.
    rotatedPrimeNumber = [self rotateNumberRightByOne:originalPrimeNumber];
    
    // While the rotated number is NOT eqaul to the current prime number,
    while(originalPrimeNumber != rotatedPrimeNumber){
      // If the rotated number is prime (using the Hash Table),
      if([[primesDictionary objectForKey:[NSString stringWithFormat:@"%d", rotatedPrimeNumber]] boolValue]){
        // Rotate the number to the right again by 1 digit.
        rotatedPrimeNumber = [self rotateNumberRightByOne:rotatedPrimeNumber];
      }
      // If the rotated number is NOT prime,
      else{
        // Mark that the rotated number is NOT prime.
        isPrime = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the current prime and all of its rotations are prime,
    if(isPrime){
      // Increment the number of circular primes found by 1.
      numberOfCircularPrimesFound++;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }// If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the number of circular primes found.
    self.answer = [NSString stringWithFormat:@"%d", numberOfCircularPrimesFound];
    
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
  // mark which numbers are prime or not. Then, we use a helper method to rotate
  // the prime number as a string, and check the Hash Table to see if the
  // rotated number is prime or not. We keep rotating until the rotated number is
  // equal to the original prime number. If it makes it all the way around, we
  // increment the number of primes that all rotations are also prime by 1.
  
  // Variable to mark if a current number is prime or not.
  BOOL isPrime = YES;
  
  // Set the maximum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Variable to hold the number of circular primes found.
  uint numberOfCircularPrimesFound = 0;
  
  // Variable to hold the current rotated prime number as a string.
  NSString * rotatedPrimeNumber = nil;
  
  // Variable to hold the original prime number as a string.
  NSString * originalPrimeNumber = nil;
  
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
    
    // Grab the current prime number as a string.
    originalPrimeNumber = [primeNumber stringValue];
    
    // Rotate the current string to the left by 1 character.
    rotatedPrimeNumber = [self rotateStringLeftByOne:originalPrimeNumber];
    
    // While the rotated number is NOT eqaul to the current prime number as a
    // string,
    while(![originalPrimeNumber isEqualToString:rotatedPrimeNumber]){
      // If the rotated number is prime (using the Hash Table),
      if([[primesDictionary objectForKey:rotatedPrimeNumber] boolValue]){
        // Rotate the current string to the left again by 1 character.
        rotatedPrimeNumber = [self rotateStringLeftByOne:rotatedPrimeNumber];
      }
      // If the rotated number is NOT prime,
      else{
        // Mark that the rotated number is NOT prime.
        isPrime = NO;
        
        // Break out of the loop.
        break;
      }
    }
    // If the current prime and all of its rotations are prime,
    if(isPrime){
      // Increment the number of circular primes found by 1.
      numberOfCircularPrimesFound++;
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the number of circular primes found.
    self.answer = [NSString stringWithFormat:@"%d", numberOfCircularPrimesFound];
    
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

@implementation Question35 (Private)

- (BOOL)primeNumberHasValidRotateableDigits:(uint)aNumber; {
  // We need only iterate through the digits of the prime, and check that the
  // digits are either 1, 3, 7, or 9. The other digits would eventually lead to
  // a number that is not prime, as the digit would move to the last digit. This
  // would lead to an even number, or a multiple of 5, which are not prime!
  //
  // Also, there is no need to check the units digit, as if it is a prime number
  // being entered, the units digit must apply by the above rules!
  
  // If the inputted number is less than 2,
  if(aNumber < 2){
    // It can't be a prime number, so return NO.
    return NO;
  }
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the prime number is a single digit number,
  if(numberOfDigits == 0){
    // It has valid prime number digits, so return YES.
    return YES;
  }
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the current digit while iterating.
  uint currentNumber = aNumber;
  
  // Constant array to hold if the digit is valid or not. The only valid digits
  // are 1, 3, 7, and 9.
  BOOL isDigitValid[10] = {NO, YES, NO, YES, NO, NO, NO, YES, NO, YES};
  
  // While the number of digits is positive,
  while(numberOfDigits > 0){
    // Divide the current number by 10.
    currentNumber /= 10;
    
    // Grab the current digit from the input number.
    digit = currentNumber % 10;
    
    // If the digit is NOT valid,
    if(isDigitValid[digit]){
      // Break out of the loop.
      break;
    }
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number has valid digits or not.
  return isDigitValid[digit];
}

- (uint)rotateNumberRightByOne:(uint)aNumber; {
  // If the inputted number is equal to 0,
  if(aNumber == 0){
    // We can't take the log of the number, and the rotation of 0 is 0, so return
    // the number, 0.
    return aNumber;
  }
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number is a single digit number,
  if(numberOfDigits == 0){
    // The rotation of a single digit number is the number itself, so return the
    // number.
    return aNumber;
  }
  // Variable to hold the units digit of the number.
  uint unitsDigit = aNumber % 10;
  
  // Variable to hold the other digits of the number.
  uint currentNumber = ((uint)(aNumber / 10));
  
  // Move the units digit to the front of the number, and return the result.
  return ((uint)pow(10, numberOfDigits)) * unitsDigit + currentNumber;
}

@end