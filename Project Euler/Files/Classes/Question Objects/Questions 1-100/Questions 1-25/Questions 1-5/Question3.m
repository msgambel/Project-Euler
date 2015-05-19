//  Question3.m

#import "Question3.h"

@implementation Question3

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"2 November 2001";
  self.hint = @"The largest prime factor to check when decomposing a number is the square root of the number. Finding the prime numbers up to the square root is easy.";
  self.text = @"The prime factors of 13195 are 5, 7, 13 and 29.\n\nWhat is the largest prime factor of the number 600851475143?";
  self.isFun = YES;
  self.title = @"Largest prime factor";
  self.answer = @"6857";
  self.number = @"3";
  self.rating = @"4";
  self.keywords = @"prime,factors,largest,natural,numbers,sieve,maximum,square,root";
  self.difficulty = @"Meh";
  self.estimatedComputationTime = @"5.34e-04";
  self.estimatedBruteForceComputationTime = @"1.89e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We need to find all the factors of the large number. Therefore, we need to
  // find all the primes, as well as the factors. We use a basic sieve technique
  // to find the primes. We also note that once we find a factor of the number,
  // we can repeat the process by dividing out the factor from the number, and
  // using the resulting number. But as a bonus, we know that this resulting
  // number does NOT have any prime factors under the factor we divided out by.
  // Therefore, by repeating the process, once the resulting number is smaller
  // than the current number we are checking is prime, we know that it must be
  // a prime number itself, which will be the largest prime factor!
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [[NSMutableArray alloc] init];
  
  // Add in the first prime, 2, to the prime array.
  [primeNumbersArray addObject:[NSNumber numberWithInt:2]];
  
  // BOOL variable to mark if a current number is prime.
  BOOL isPrime = NO;
  
  // Set the number to factor. We use long long int, as this number is large.
  long long int numberToFactor = 600851475143;
  
  // We need only check the prime numbers up to the square root of the number.
  long long int largestNumberToCheck = (long long int)sqrt((double)numberToFactor);
  
  // Variable to hold the current prime number, used to minimize computations.
  long long int currentPrimeNumber = 0;
  
  // Variable to hold the square root of the current number, used to minimize computations.
  long long int sqrtOfCurrentNumber = 0;
  
  // Loop through all the prime numbers already found. No need to check the even
  // numbers, as they are always divisible by 2, and are therefore no prime. Since
  // we start at 3, incrementing by 2 will mean that currentNumber is always odd.
  for(int currentNumber = 3; currentNumber < largestNumberToCheck; currentNumber += 2){
    // Reset the marker to see if the current number is prime.
    isPrime = YES;
    
    // Compute the square root of the current number.
    sqrtOfCurrentNumber = (long long int)sqrtf(currentNumber);
    
    // Loop through all the prime numbers already found.
    for(NSNumber * number in primeNumbersArray){
      // Grab the current prime number.
      currentPrimeNumber = [number longLongValue];
      
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
      // Add the number to the array of prime numbers.
      [primeNumbersArray addObject:[NSNumber numberWithInt:currentNumber]];
      
      // If the current number (which is prime) divides the number to factor,
      if((numberToFactor % currentNumber) == 0){
        // Loop by continually dividing out by the current prime number. This
        // removes any powers of the current prime factor.
        while((numberToFactor % currentNumber) == 0){
          // Divide the number to factor by the current prime number.
          numberToFactor /= currentNumber;
        }
        // Reset the largest number to check to be the square root of the new
        // number to factor.
        largestNumberToCheck = (long long int)sqrt((double)numberToFactor);
      }
    }
  }
  // Set the answer string to the number to factor, which is the largest prime factor.
  self.answer = [NSString stringWithFormat:@"%llu", numberToFactor];
  
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
  
  // We need to find all the factors of the large number. Therefore, we need to
  // find all the primes, as well as the factors. We use a basic sieve technique
  // to find the primes. If a number is prime, we check if it is a factor of the
  // number, and if it is, we divide out by that number.
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [[NSMutableArray alloc] init];
  
  // Add in the first prime, 2, to the prime array.
  [primeNumbersArray addObject:[NSNumber numberWithInt:2]];
  
  // BOOL variable to mark if a current number is prime.
  BOOL isPrime = NO;
  
  // Set the number to factor. We use long long int, as this number is large.
  long long int numberToFactor = 600851475143;
  
  // We need only check the prime numbers up to the square root of the number.
  long long int largestNumberToCheck = (long long int)sqrt((double)numberToFactor);
  
  // Variable to hold the largest prime factor.
  long long int largestPrimeFactor = 0;
  
  // Loop through all the prime numbers already found. No need to check the even
  // numbers, as they are always divisible by 2, and are therefore no prime. Since
  // we start at 3, incrementing by 2 will mean that currentNumber is always odd.
  for(int currentNumber = 3; currentNumber < largestNumberToCheck; currentNumber += 2){
    // Reset the marker to see if the current number is prime.
    isPrime = YES;
    
    // Loop through all the prime numbers already found.
    for(NSNumber * number in primeNumbersArray){
      // If the current prime number divides our current number,
      if((currentNumber % [number longLongValue]) == 0){
        // The current number is not prime, so exit the loop.
        isPrime = NO;
        break;
      }
    }
    // If the current number was marked as a prime number,
    if(isPrime){
      // Add the number to the array of prime numbers.
      [primeNumbersArray addObject:[NSNumber numberWithInt:currentNumber]];
      
      // If the current prime number divides our current number,
      if((numberToFactor % currentNumber) == 0){
        // Set the largest prime factor to be the current prime number.
        largestPrimeFactor = currentNumber;
        
        // Loop by continually dividing out by the current prime number. This
        // removes any powers of the current prime factor.
        while((numberToFactor % currentNumber) == 0){
          // Divide the number by the current prime number.
          numberToFactor /= largestPrimeFactor;
        }
        // If the resulting number to factor is 1,
        if(numberToFactor == 1){
          // We've found all the factors, so break out of the loop.
          break;
        }
      }
    }
  }
  // Set the answer string to the largest prime factor.
  self.answer = [NSString stringWithFormat:@"%llu", largestPrimeFactor];
  
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