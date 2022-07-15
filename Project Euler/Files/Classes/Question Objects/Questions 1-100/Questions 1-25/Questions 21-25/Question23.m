//  Question23.m

#import "Question23.h"
#import "Global.h"

@implementation Question23

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"02 August 2002";
  self.hint = @"There's a formula that uses the prime powers to calculate d(n). Can you use this formula to tell if a number is abundant or not?";
  self.link = @"https://en.wikipedia.org/wiki/Prime_power";
  self.text = @"A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.\n\nA number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.\n\nAs 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.\n\nFind the sum of all the positive integers which cannot be written as the sum of two abundant numbers.";
  self.isFun = YES;
  self.title = @"Non-abundant sums";
  self.answer = @"4179871";
  self.number = @"23";
  self.rating = @"4";
  self.category = @"Primes";
  self.keywords = @"factorization,divisors,primes,perfect,number,non,abundant,sums,positive,integers,proper,less,than,limit,non-abundant,written,combinations";
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"75";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"23/01/13";
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"23/01/13";
  self.solutionLineCount = @"105";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = YES;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"0.138";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.734";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just find all the abundent numbers up to the max size, then add all
  // possible combinations together, and in a BOOL array, set index (the sum) to
  // be that the number IS the sum of two digit numbers.
  //
  // We use the prime factorization method (described in Question 21) to determine
  // if the number is abundent of not.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 28123;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable to hold the sum of the divisors for every number up to the max size.
  uint sumOfDivisors = 0;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the sum of the "small" and "large" abundent numbers when
  // seeing which numbers are the sum of two abundent numbers.
  uint abundentNumberSum = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Temporary variable to hold the "small" abundent number when computing which
  // numbers are the sum of two abundent numbers.
  uint smallerAbundentNumber = 0;
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable to hold the number of abundent numbers.
  uint numberOfAbundentNumbers = 0;
  
  // Variable array to hold if the number from 1 to the max size is the sum of
  // two abundent numbers or not.
  BOOL isNumberTheSumOfTwoAbundentNumbers[maxSize];
  
  // Variable array to hold the abundent numbers up to the max size.
  uint abundentNumbers[maxSize];
  
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
  // For all the numbers from 12 to the max size,
  for(int number = 12; number < maxSize; number++){
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
    sumOfDivisors = 1;
    
    // For all the prime factors of this number,
    for(int i = 0; i < maxNumberOfPrimeFactors; i++){
      // If the current prime power is actually a factor,
      if(currentPrimePowers[i].primeNumber > 0){
        // Multiply the sum of the divisors by the sum of the powers for the
        // current prime power.
        sumOfDivisors *= [self sumOfPowersForPrimePower:currentPrimePowers[i]];
      }
      // Reset the current prime power to zero.
      currentPrimePowers[i] = PrimePowerZero;
    }
    // If the sum of the divisors is greater than double the number (Note: we DID
    // include the number itself),
    if(sumOfDivisors > (2 * number)){
      // Set this number as the next abundent number.
      abundentNumbers[numberOfAbundentNumbers] = number;
      
      // Increase the number of abundent numbers by 1.
      numberOfAbundentNumbers++;
    }
  }
  // For all the numbers up to the max size,
  for(int number = 0; number < maxSize; number++){
    // Default the number to NOT the sum of an abundent number.
    isNumberTheSumOfTwoAbundentNumbers[number] = NO;
  }
  // For all the abundent numbers,
  for(int smallNumber = 0; smallNumber < numberOfAbundentNumbers; smallNumber++){
    // Grab the current "small" abundent number,
    smallerAbundentNumber = abundentNumbers[smallNumber];
    
    // For all the abundent numbers from the smaller abundent number to the last
    // abundent number,
    for(int largeNumber = smallNumber; largeNumber < numberOfAbundentNumbers; largeNumber++){
      // Compute the sum of the current "large" abundent number to the "small"
      // abundent number.
      abundentNumberSum = (smallerAbundentNumber + abundentNumbers[largeNumber]);
      
      // If the sum is less than the max size,
      if(abundentNumberSum < maxSize){
        // Set that this number CAN be written as the sum of 2 abundent numbers.
        isNumberTheSumOfTwoAbundentNumbers[abundentNumberSum] = YES;
      }
      // If the sum is greater than or equal to the max size,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // For all the numbers up to the max size,
  for(int number = 1; number < maxSize; number++){
    // If the number is NOT the sum of an abundent number,
    if(isNumberTheSumOfTwoAbundentNumbers[number] == NO){
      // Add the number to the sum.
      sum += number;
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
  
  // Here, we just find all the abundent numbers up to the max size, then add all
  // possible combinations together, and in a BOOL array, set index (the sum) to
  // be that the number IS the sum of two digit numbers.
  //
  // We brute force the sum of the divisors by checking all the numbers less than
  // half the number to see if they are a divisor or not.
  
  // Variable to hold the sum. Default the sum to 0.
  uint sum = 0;
  
  // Set the max size for the Amicable numbers.
  uint maxSize = 28123;
  
  // Variable to hold the sum of the divisors for every number up to the max size.
  uint sumOfDivisors = 0;
  
  // Variable used to compute the maximum number to check for the proper divisors
  // of the current number.
  uint maxDivisorSize = 1;
  
  // Variable to hold the sum of the "small" and "large" abundent numbers when
  // computing which numbers are the sum of two abundent numbers.
  uint abundentNumberSum = 0;
  
  // Temporary variable to hold the "small" abundent number when computing which
  // numbers are the sum of two abundent numbers.
  uint smallerAbundentNumber = 0;
  
  // Variable to hold the number of abundent numbers.
  uint numberOfAbundentNumbers = 0;
  
  // Variable array to hold if the number from 1 to the max size is the sum of
  // two abundent numbers or not.
  BOOL isNumberTheSumOfTwoAbundentNumbers[maxSize];
  
  // Variable array to hold the abundent numbers up to the max size.
  uint abundentNumbers[maxSize];
  
  // For all the numbers from 12 to the max size,
  for(int number = 12; number < maxSize; number++){
    // Set the sum of the divisors to 1, as 1 is always a divisor!
    sumOfDivisors = 1;
    
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
        sumOfDivisors += divisor;
      }
    }
    // If the sum of the divisors is greater than the number (Note: we did NOT
    // include the number itself), 
    if(sumOfDivisors > number){
      // Set this number as the next abundent number.
      abundentNumbers[numberOfAbundentNumbers] = number;
      
      // Increase the number of abundent numbers by 1.
      numberOfAbundentNumbers++;
    }
  }
  // For all the numbers up to the max size,
  for(int number = 0; number < maxSize; number++){
    // Default the number to NOT the sum of an abundent number.
    isNumberTheSumOfTwoAbundentNumbers[number] = NO;
  }
  // For all the abundent numbers,
  for(int smallNumber = 0; smallNumber < numberOfAbundentNumbers; smallNumber++){
    // Grab the current "small" abundent number,
    smallerAbundentNumber = abundentNumbers[smallNumber];
    
    // For all the abundent numbers from the smaller abundent number to the last
    // abundent number,
    for(int largeNumber = smallNumber; largeNumber < numberOfAbundentNumbers; largeNumber++){
      // Compute the sum of the current "large" abundent number to the "small"
      // abundent number.
      abundentNumberSum = (smallerAbundentNumber + abundentNumbers[largeNumber]);
      
      // If the sum is less than the max size,
      if(abundentNumberSum < maxSize){
        // Set that this number CAN be written as the sum of 2 abundent numbers.
        isNumberTheSumOfTwoAbundentNumbers[abundentNumberSum] = YES;
      }
      // If the sum is greater than or equal to the max size,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // For all the numbers up to the max size,
  for(int number = 1; number < maxSize; number++){
    // If the number is NOT the sum of an abundent number,
    if(isNumberTheSumOfTwoAbundentNumbers[number] == NO){
      // Add the number to the sum.
      sum += number;
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