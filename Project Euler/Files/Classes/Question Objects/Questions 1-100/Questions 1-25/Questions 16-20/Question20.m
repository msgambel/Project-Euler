//  Question20.m

#import "Question20.h"
#import "BigInt.h"
#import "Structures.h"

@implementation Question20

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"21 June 2002";
  self.text = @"n! means n x (n  1) x ... x 3 x 2 x 1\n\nFor example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800, and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.\n\nFind the sum of the digits in the number 100!";
  self.title = @"Factorial digit sum";
  self.answer = @"648";
  self.number = @"Problem 20";
  self.estimatedComputationTime = @"1.66e-03";
  self.estimatedBruteForceComputationTime = @"1.82e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Note that every power of 10 adds a 0 to the number, which does not comtribute
  // to the sum of the digits. Therefore, if we factor each number from 2-99 into
  // its prime factors, then remove the the powers of 5 (and same number of powers
  // of 2 in order to make the factor of 10), we can compute a much smaller number!
  //
  // We don't get a large speed preformance increase, but it does allow us to use
  // less memory!
  
  // Variable to hold the current power of the prime number.
  uint currentPower = 0;
  
  // Variable to hold the current number for prime factorization.
  uint currentNumber = 0;
  
  // Variable to hold the current prime number.
  uint currentPrimeNumber = 0;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:100];
  
  // Variable array to hold the prime powers of all the numbers from 2 to 99.
  PrimePower primePowers[[primeNumbersArray count]];
  
  // Variable to hold the prime number.
  BigInt * primeBigInt = nil;
  
  // Variable to hold the result number of the addition. Start at the default
  // value of 0.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the addition.
  BigInt * temporaryNumber = nil;
  
  // For all the prime numbers in the prime number array,
  for(uint primeNumber = 0; primeNumber < [primeNumbersArray count]; primeNumber++){
    // Grab the value of the current prime number.
    currentPrimeNumber = [[primeNumbersArray objectAtIndex:primeNumber] intValue];
    
    // Set the prime number in the prime powers array.
    primePowers[primeNumber] = PrimePowerMake(currentPrimeNumber, 0);
  }
  // Set the number of prime powers of 2 less than 12.
  primePowers[0].power = 8;
  
  // Set the number of prime powers of 3 less than 12.
  primePowers[1].power = 4;
  
  // Set the number of prime powers of 4 less than 12.
  primePowers[2].power = 2;
  
  // Set the number of prime powers of 7 less than 12.
  primePowers[3].power = 1;
  
  // Set the number of prime powers of 11 less than 12.
  primePowers[4].power = 1;
  
  // For all the numbers from 11 to 99,
  for(uint number = 12; number < 100; number++){
    // Set the current number for use when prime factoring.
    currentNumber = number;
    
    // For all the prime numbers in the prime number array,
    for(uint primeNumber = 0; primeNumber < [primeNumbersArray count]; primeNumber++){
      // Grab the current prime number.
      currentPrimeNumber = primePowers[primeNumber].primeNumber;
      
      // If the current prime number is less than or equal to the current
      // factored number,
      if(currentPrimeNumber <= currentNumber){
        // If the current prime number divides the current factored number,
        if((currentPrimeNumber % currentPrimeNumber) == 0){
          // While the current prime number divides the current factored number,
          while((currentNumber % currentPrimeNumber) == 0){
            // Divide out the prime number from the current factored number.
            currentNumber /= currentPrimeNumber;
            
            // Increment the number of powers of the current prime number by 1.
            primePowers[primeNumber].power++;
          }
        }
      }
      // If the current prime number is greater than the current factored number,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // Subtract the number of powers of 5 from the powers of 2.
  primePowers[0].power -= primePowers[2].power;
  
  // Set the powers of 5 to 0, as we removed them above.
  primePowers[2].power = 0;
  
  // For all the prime numbers in the prime number array,
  for(uint primeNumber = 0; primeNumber < [primeNumbersArray count]; primeNumber++){
    // Grab the current prime number.
    primeBigInt = [BigInt createFromInt:primePowers[primeNumber].primeNumber];
    
    // Grab the current power of the prime number.
    currentPower = primePowers[primeNumber].power;
    
    // While the current power of the prime number is greater than 0,
    while(currentPower > 0){
      // Store the multiplication of the prime number and the result number in a
      // temporary variable.
      temporaryNumber = [resultNumber multiply:primeBigInt];
      
      // Set the result number to be the result of the above multiplication.
      resultNumber = temporaryNumber;
      
      // Decrease the current power by 1.
      currentPower--;
    }
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
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
  
  // Here we simply compute 100! and count the digits.
  
  // Variable to hold the result number of the addition. Start at the default
  // value of 0.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the addition.
  BigInt * temporaryNumber = nil;
  
  for(uint number = 2; number < 100; number++){
    // Store the multiplication of the prime number and the result number in a
    // temporary variable.
    temporaryNumber = [resultNumber multiply:[BigInt createFromInt:number]];
    
    // Set the result number to be the result of the above multiplication.
    resultNumber = temporaryNumber;
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end