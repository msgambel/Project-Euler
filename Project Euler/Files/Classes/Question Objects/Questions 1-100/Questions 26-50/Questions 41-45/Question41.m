//  Question41.m

#import "Question41.h"
#import "BigInt.h"

@implementation Question41

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"11 April 2003";
  self.hint = @"Only check all the prime numbers from 7,654,321 and down.";
  self.link = @"https://en.wikipedia.org/wiki/Pandigital_number";
  self.text = @"We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.\n\nWhat is the largest n-digit pandigital prime that exists?";
  self.isFun = YES;
  self.title = @"Pandigital prime";
  self.answer = @"7652413";
  self.number = @"41";
  self.rating = @"4";
  self.category = @"Primes";
  self.keywords = @"pandigital,prime,largest,digit,number,exists,exactly,primality,test";
  self.solveTime = @"600";
  self.difficulty = @"Medium";
  self.isChallenging = YES;
  self.completedOnDate = @"10/02/13";
  self.solutionLineCount = @"37";
  self.estimatedComputationTime = @"9.08e-03";
  self.estimatedBruteForceComputationTime = @"6.53";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply check all the numbers from 7,654,321 down to 0, and then
  // check to see if any of the numbers are pandigital. Once we have found
  // one that is, we check if the number is prime using a primality test, and
  // if it is, we set it as the maximum pandigital prime number, and break out
  // of the loop.
  //
  // We know we only have to go up to 7,654,321, as any prime with 8 or 9 digits
  // that is also pandigital must be divisible by 3 (just sum the numbers from
  // 1 to 8 (36), or 1 to 9 (45), and the resulting numbers are divisible by 3),
  // so therefore, they cannot be prime. And since the number must be at most
  // 7-pandigital, there is not need to check any number above 7,654,321.
  
  // Set the max size for the pandigital prime numbers.
  uint maxSize = 7654321;
  
  // Variable to hold the maximum pandigital prime number.
  uint maxPandigitalPrimeNumber = 0;
  
  // Variable to hold the current pandigital number, and use a primality test
  // to see if the number is prime or not.
  BigInt * currentPandigitalNumber = nil;
  
  // For all the numbers from the max size to 0 (decrement by 2, as the number
  // must be odd in order to be prime),
  for(int number = maxSize; number >= 0; number -= 2){
    // If the current prime number is 7-lexographic/pandigital,
    if([self isNumberLexographic:number countZero:NO maxDigit:7]){
      // Set the current pandigital number in preperation of the primality test.
      currentPandigitalNumber = [BigInt createFromInt:number];
      
      // If the current pandigital number is prime,
      if([currentPandigitalNumber isProbablePrime]){
        // Set the maximum pandigital prime number to the current number.
        maxPandigitalPrimeNumber = number;
        
        // Break out of the loop;
        break;
      }
    }
  }
  // Set the answer string to the maximum pandigital prime number.
  self.answer = [NSString stringWithFormat:@"%d", maxPandigitalPrimeNumber];
  
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
  
  // Here, we simply grab all the prime numbers upto 7,654,321, and then count
  // backwards to see if any of the primes are pandigital. Once we have found
  // one that is, we break out of the loop and set it as the answer.
  //
  // We know we only have to go up to 7,654,321, as any prime with 8 or 9 digits
  // that is also pandigital must be divisible by 3 (just sum the numbers from
  // 1 to 8 (36), or 1 to 9 (45), and the resulting numbers are divisible by 3),
  // so therefore, they cannot be prime. And since the number must be at most
  // 7-pandigital, there is not need to check any number above 7,654,321.
  
  // Set the max size for the prime numbers.
  uint maxSize = 7654321;
  
  // Variable to hold the current prime number.
  uint currentPrimeNumber = 0;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // For all the potential prime numbers,
  for(int index = ((int)[primeNumbersArray count] - 1); index >= 0; index--){
    // Grab the current prime number.
    currentPrimeNumber = [[primeNumbersArray objectAtIndex:index] intValue];
    
    // If the current prime number is 7-lexographic/pandigital,
    if([self isNumberLexographic:currentPrimeNumber countZero:NO maxDigit:7]){
      // Break out of the loop;
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
    // Set the answer string to the maximum pandigital prime number.
    self.answer = [NSString stringWithFormat:@"%d", currentPrimeNumber];
    
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