//  Question21.m

#import "Question21.h"
#import "Global.h"

@implementation Question21

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"05 July 2002";
  self.hint = @"There's a formula that uses the prime powers to calculate d(n).";
  self.text = @"Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).\n\nIf d(a) = b and d(b) = a, where a  b, then a and b are an amicable pair and each of a and b are called amicable numbers.\n\nFor example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.\n\nEvaluate the sum of all the amicable numbers under 10000.";
  self.isFun = YES;
  self.title = @"Amicable numbers";
  self.answer = @"31626";
  self.number = @"21";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"divisors,proper,amicable,pair,numbers,sum,10000,ten,thousand,evalute,under,prime,factorization";
  self.solveTime = @"30";
  self.difficulty = @"Easy";
  self.completedOnDate = @"21/01/13";
  self.solutionLineCount = @"57";
  self.estimatedComputationTime = @"1.71e-02";
  self.estimatedBruteForceComputationTime = @"9.36e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note an interesting fact about the sum of the divisors of a number:
  //
  // If n = \prod_{k}p_{k}^{a_{k}}, with a_{k} >= 1, and p_{k} unique prime factors,
  //
  // Then: d(n) = \prod_{k}(\sum_{i = 0}^{k}p_{k}^{i})
  //
  // More explanation can be found here:
  //
  // http://math.stackexchange.com/questions/22721/is-there-a-formula-to-calculate-the-sum-of-all-proper-divisors-of-a-number
  //
  // Therefore, we use a helper method to compute the sum of the prime powers,
  // and simply compute the prime factorization of each number, and multiply
  // the sums together!
  //
  // Note: This could be improved even further, as we could simply compute the
  //       divisor sum for each of the prime powers, then multply out all of
  //       the combinations of the prime powers in order to generate every
  //       number less than the maximum size. This saves extra multiplications
  //       of the prime powers.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 10000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the current number of divisors for the current number.
  uint currentNumberOfDivisors = 0;
  
  // Variable array to hold the sum of the divisors for every number up to the
  // max size.
  uint sumOfDivisors[maxSize];
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:sqrtOfCurrentNumber];
  
  // For all the prime numbers in the prime numbers array,
  for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
    // Grab the current prime number from the prime numbers array.
    primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
    
    // Multiply the current max size by the current prime number.
    currentMaxSize *= primeNumber;
    
    // Increment the maximum number of prime factors by 1.
    maxNumberOfPrimeFactors++;
    
    // If the current max size is greater than the max size,
    if(currentMaxSize > maxSize){
      // Break out of the loop.
      break;
    }
  }
  // Variable to hold the current prime power struct when factoring the current
  // number.
  PrimePower currentPrimePower = PrimePowerZero;
  
  // Variable to hold the current prime power structs when factoring the current
  // number.
  PrimePower currentPrimePowers[maxNumberOfPrimeFactors];
  
  // For all the prime factors up to the maximum number of prime factors,
  for(int i = 0; i < maxNumberOfPrimeFactors; i++){
    // Set the current prime factors to zero by default.
    currentPrimePowers[i] = PrimePowerZero;
  }
  // Set the sum of the divisors of 0 to be 0. Technically, it is infinite, as
  // every number divides 0, but it adds nothing to help us.
  sumOfDivisors[0] = 0;
  
  // Set the sum of the divisors of 1 to be 1.
  sumOfDivisors[1] = 1;
  
  // For all the numbers from 2 to the max size,
  for(int number = 2; number < maxSize; number++){
    // Grab the current number for use in factoring.
    currentNumber = number;
    
    // Recompute the square root of the current minimum number, in order to
    // speed up the computation.
    sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
    
    // Reset the prime power index to 0, as we haven't found any prime factors
    // yet!
    primePowerIndex = 0;
    
    // For all the prime numbers in the prime numbers array,
    for(int currentPrimeNumber = 0; currentPrimeNumber < [primeNumbersArray count]; currentPrimeNumber++){
      // Grab the current prime number from the prime numbers array.
      primeNumber = [[primeNumbersArray objectAtIndex:currentPrimeNumber] intValue];
      
      // If the current prime number is less than or equal to the square root of
      // the current number,
      if(primeNumber <= sqrtOfCurrentNumber){
        // If the current prime number divides the current number,
        if((currentNumber % primeNumber) == 0){
          // Set the current prime power to be the prime number.
          currentPrimePower = PrimePowerMake(primeNumber, 0);
          
          // While the current prime number divides the current number,
          while((currentNumber % primeNumber) == 0){
            // Divide out the prime number from the number.
            currentNumber /= primeNumber;
            
            // Increment the current prime powers power by 1.
            currentPrimePower.power++;
          }
          // Recompute the square root of the current number, in order to speed
          // up the computation.
          sqrtOfCurrentNumber = ((uint)sqrt(currentNumber));
          
          // Set the current prime power to the current prime powers index.
          currentPrimePowers[primePowerIndex] = currentPrimePower;
          
          // Increment the current prime power index by 1.
          primePowerIndex++;
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
    if(currentNumber > 1){
      // Set the current prime number (which is the current number) to the current
      // prime power. Since this number is prime, there is no need to loop to
      // find the power, as it must be 1.
      currentPrimePower = PrimePowerMake(currentNumber, 1);
      
      // Set the current prime power to be the prime number.
      currentPrimePowers[primePowerIndex] = currentPrimePower;
      
      // Increment the current prime power index by 1.
      primePowerIndex++;
    }
    // Set the sum of the divisors for this number to 1.
    sumOfDivisors[number] = 1;
    
    // For all the prime factors of this number,
    for(int i = 0; i < primePowerIndex; i++){
      // Multiply the sum of the divisors by the sum of the powers for the
      // current prime power.
      sumOfDivisors[number] *= [self sumOfPowersForPrimePower:currentPrimePowers[i]];
      
      // Reset the current prime power to zero.
      currentPrimePowers[i] = PrimePowerZero;
    }
  }
  // For all the numbers from 2 to the max size,
  for(int number = 2; number < maxSize; number++){
    // Subtract off the number from the sum of the divisors, as we only want
    // proper divisors.
    sumOfDivisors[number] -= number;
  }
  // For all the numbers from 2 to the max size,
  for(int number = 2; number < maxSize; number++){
    // Grab the current sum of the divisors.
    currentNumberOfDivisors = sumOfDivisors[number];
    
    // If the current number of divisors is less than the max size (we need to
    // check to make sure we are looking up a valid array index),
    if(currentNumberOfDivisors < maxSize){
      // If the number is Amicable,
      if(number == sumOfDivisors[currentNumberOfDivisors]){
        // If the number is not perfect,
        if(number != currentNumberOfDivisors){
          // Add the number to the sum.
          sum += number;
        }
      }
    }
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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
  
  // Here, we simply try to find all of the proper divisors of the numbers up to
  // the maximum size, and then sum them up. We then check each number to see if
  // the sum of the proper divisors is equal to the number itself, and if it is,
  // the number is amicable, and we sum that number to the total sum.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 10000;
  
  // Variable to hold the current number of divisors for the current number.
  uint currentNumberOfDivisors = 0;
  
  // Variable array to hold the sum of the divisors for every number up to the
  // max size.
  uint sumOfDivisors[maxSize];
  
  // Variable used to compute the maximum number to check for the proper divisors
  // of the current number.
  uint maxDivisorSize = 1;
  
  // Set the sum of the divisors of 0 to be 0. Technically, it is infinite, as
  // every number divides 0, but it adds nothing to help us.
  sumOfDivisors[0] = 0;
  
  // Set the sum of the divisors of 1 to be 1.
  sumOfDivisors[1] = 1;
  
  // For all the numbers from 2 to the max size,
  for(int number = 2; number < maxSize; number++){
    // Set the sum of the divisors to 1, as 1 is always a divisor!
    sumOfDivisors[number] = 1;
    
    // If the number is even,
    if((number % 2) == 0){
      // Set the max size of the divisor to half of the number.
      maxDivisorSize = number / 2;
    }
    // If the number is NOT even,
    else{
      // Set the max size of the divisor to a third of the number.
      maxDivisorSize = ((uint)(number / 3)) + 1;
    }
    // For all the potential divisors of the current number,
    for(int divisor = 2; divisor <= maxDivisorSize; divisor++){
      // If the potential divisor is a divisor,
      if((number % divisor) == 0){
        // Add the divisor to the sum of the divisors for the current number.
        sumOfDivisors[number] += divisor;
      }
    }
  }
  // For all the numbers from 2 to the max size,
  for(int number = 2; number < maxSize; number++){
    // Grab the current number of divisors.
    currentNumberOfDivisors = sumOfDivisors[number];
    
    // If the current number of divisors is less than the max size (we need to
    // check to make sure we are looking up a valid array index),
    if(currentNumberOfDivisors < maxSize){
      // If the number is Amicable,
      if(number == sumOfDivisors[currentNumberOfDivisors]){
        // If the number is not perfect,
        if(number != currentNumberOfDivisors){
          // Add the number to the sum.
          sum += number;
        }
      }
    }
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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