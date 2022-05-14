//  Question73.m

#import "Question73.h"
#import "Global.h"

@implementation Question73

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"02 July 2004";
  self.hint = @"Use the Euler Totient Function to generate all of the numbers that are relatively prime to a given number. Also, 2 | φ(n) for all n >= 3.";
  self.link = @"http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula";
  self.text = @"Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.\n\nIf we list the set of reduced proper fractions for d <= 8 in ascending order of size, we get:\n\n1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8\n\nIt can be seen that there are 3 fractions between 1/3 and 1/2.\n\nHow many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions for d <= 12,000?";
  self.isFun = YES;
  self.title = @"Counting fractions in a range";
  self.answer = @"7295372";
  self.number = @"73";
  self.rating = @"3";
  self.category = @"Counting";
  self.keywords = @"counting,fractions,reduced,proper,ascending,order,interval,positive,integers,HCF,sorted,euler,totient";
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.commentCount = @"64";
  self.attemptsCount = @"3";
  self.isChallenging = YES;
  self.startedOnDate = @"14/03/13";
  self.educationLevel = @"Undergraduate";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"14/03/13";
  self.solutionLineCount = @"119";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = YES;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"1.67e-02";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.67e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note simply compute all the prime factors of each number, and then
  // compute the Euler Totient Function. This in turn will give us the number of
  // numbers that are relatively prime to the current number. Since each one of
  // the numbers are relatively prime to the current number, they must generate
  // a proper fraction! Then, we simply add up the φ(n)'s for each n less than
  // the maximum size, and we get our total!
  //
  // Now in order to get the number of reduced proper fractions inbetween 1/3 and
  // 1/2, we note the following:
  //
  // 1) 2 | φ(n) for all n >= 3. Therefore, the sum will always be odd.
  //
  // Therefore, the sum of all the reduced proper fractions will always be odd
  // for n >= 3.
  //
  // 2) If 3 !| \sum_{n=1}^{m} φ(n), then 3 of the reduced proper fractions will
  //                                 be greater than 1/3.
  //
  // This comes from the fact that the distribution of the reduced proper
  // fractions will sit closer to the centre (i.e.: 1/2).
  //
  // Combining 1) and 2), we can use the total sum to generate the number of
  // reduced proper fractions STRICTLY between 1/3 and 1/2.
  //
  // For more information about the Euler Totient Function, visit:
  //
  // http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula
  
  // Set the max size for the numbers.
  uint maxSize = 12000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the numerator of the totient function of the current number.
  uint totientNumerator = 0;
  
  // Variable to hold the denominator of the totient function of the current number.
  uint totientDenominator = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable to hold the total number of reduced proper fractions.
  uint totalReducedProperFractions = 0;
  
  // Variable to hold the total number of reduced proper fractions inbetween the
  // 1/3 to 1/2 interval.
  uint totalReducedProperFractionsInInterval = 0;
  
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
  // For all the numbers from 2 to the max size,
  for(int number = 2; number <= maxSize; number++){
    // If the number is NOT a prime number,
    if([self isPrime:number] == NO){
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
      // Reset the current totient's numerator to 1.
      totientNumerator = 1;
      
      // Reset the current totient's denominator to 1.
      totientDenominator = 1;
      
      // For all the prime factors of this number,
      for(int i = 0; i < primePowerIndex; i++){
        // Compute the numerator of φ(n).
        totientNumerator *= (currentPrimePowers[i].primeNumber - 1);
        
        // Compute the numerator of φ(n).
        totientDenominator *= (currentPrimePowers[i].primeNumber);
      }
      // Add φ(n) to the total number of reduced proper fractions.
      totalReducedProperFractions += ((number / totientDenominator) * totientNumerator);
    }
    // If the number is a prime number,
    else{
      // Add φ(n) = (p-1) to the total number of reduced proper fractions.
      totalReducedProperFractions += (number - 1);
    }
  }
  // Compute the number reduced proper fractions less than 1/2.
  totalReducedProperFractionsInInterval = (totalReducedProperFractions / 2);
  
  // If the number of reduced proper fractions is divisible by 3,
  if((totalReducedProperFractions % 3) == 0){
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2.
    totalReducedProperFractionsInInterval -= (totalReducedProperFractions / 3);
  }
  // If the number of reduced proper fractions is equal to 1 mod 3,
  else if((totalReducedProperFractions % 3) == 1){
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2
    // (We note that the additional 3 we are subtracting from comes from the fact
    //  that the distribution of the remaining fractions must lie above 1/3).
    totalReducedProperFractionsInInterval -= (((totalReducedProperFractions + 2) / 3) + 3);
  }
  // If the number of reduced proper fractions is equal to 2 mod 3,
  else{
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2
    // (We note that the additional 3 we are subtracting from comes from the fact
    //  that the distribution of the remaining fractions must lie above 1/3).
    totalReducedProperFractionsInInterval -= (((totalReducedProperFractions + 1) / 3) + 3);
  }
  // Set the answer string to the total number of reduced proper fractions
  // inbetween the 1/3 to 1/2 interval.
  self.answer = [NSString stringWithFormat:@"%d", totalReducedProperFractionsInInterval];
  
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
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we note simply compute all the prime factors of each number, and then
  // compute the Euler Totient Function. This in turn will give us the number of
  // numbers that are relatively prime to the current number. Since each one of
  // the numbers are relatively prime to the current number, they must generate
  // a proper fraction! Then, we simply add up the φ(n)'s for each n less than
  // the maximum size, and we get our total!
  //
  // Now in order to get the number of reduced proper fractions inbetween 1/3 and
  // 1/2, we note the following:
  //
  // 1) 2 | φ(n) for all n >= 3. Therefore, the sum will always be odd.
  //
  // Therefore, the sum of all the reduced proper fractions will always be odd
  // for n >= 3.
  //
  // 2) If 3 !| \sum_{n=1}^{m} φ(n), then 3 of the reduced proper fractions will
  //                                 be greater than 1/3.
  //
  // This comes from the fact that the distribution of the reduced proper
  // fractions will sit closer to the centre (i.e.: 1/2).
  //
  // Combining 1) and 2), we can use the total sum to generate the number of
  // reduced proper fractions STRICTLY between 1/3 and 1/2.
  //
  // For more information about the Euler Totient Function, visit:
  //
  // http://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula
  
  // Set the max size for the numbers.
  uint maxSize = 12000;
  
  // Variable to hold the current prime number form the prime numbers array.
  uint primeNumber = 0;
  
  // Variable to hold the current number for use when factoring the number.
  uint currentNumber = 0;
  
  // Variable used to compute the maximum number of prime factors a number less
  // than the max size can have.
  uint currentMaxSize = 1;
  
  // Variable to hold the index of the current prime power struct when factoring
  // the current number.
  uint primePowerIndex = 0;
  
  // Variable to hold the numerator of the totient function of the current number.
  uint totientNumerator = 0;
  
  // Variable to hold the denominator of the totient function of the current number.
  uint totientDenominator = 0;
  
  // Variable to hold the square root of the max size, used to minimize computations.
  uint sqrtOfCurrentNumber = ((uint)sqrt(maxSize));
  
  // Variable to hold the maximum number of prime factors a number less than the
  // max size can have.
  uint maxNumberOfPrimeFactors = 1;
  
  // Variable to hold the total number of reduced proper fractions.
  uint totalReducedProperFractions = 0;
  
  // Variable to hold the total number of reduced proper fractions inbetween the
  // 1/3 to 1/2 interval.
  uint totalReducedProperFractionsInInterval = 0;
  
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
  // For all the numbers from 2 to the max size,
  for(int number = 2; number <= maxSize; number++){
    // If the number is NOT a prime number,
    if([self isPrime:number] == NO){
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
      // Reset the current totient's numerator to 1.
      totientNumerator = 1;
      
      // Reset the current totient's denominator to 1.
      totientDenominator = 1;
      
      // For all the prime factors of this number,
      for(int i = 0; i < primePowerIndex; i++){
        // Compute the numerator of φ(n).
        totientNumerator *= (currentPrimePowers[i].primeNumber - 1);
        
        // Compute the numerator of φ(n).
        totientDenominator *= (currentPrimePowers[i].primeNumber);
      }
      // Add φ(n) to the total number of reduced proper fractions.
      totalReducedProperFractions += ((number / totientDenominator) * totientNumerator);
    }
    // If the number is a prime number,
    else{
      // Add φ(n) = (p-1) to the total number of reduced proper fractions.
      totalReducedProperFractions += (number - 1);
    }
  }
  // Compute the number reduced proper fractions less than 1/2.
  totalReducedProperFractionsInInterval = (totalReducedProperFractions / 2);
  
  // If the number of reduced proper fractions is divisible by 3,
  if((totalReducedProperFractions % 3) == 0){
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2.
    totalReducedProperFractionsInInterval -= (totalReducedProperFractions / 3);
  }
  // If the number of reduced proper fractions is equal to 1 mod 3,
  else if((totalReducedProperFractions % 3) == 1){
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2
    // (We note that the additional 3 we are subtracting from comes from the fact
    //  that the distribution of the remaining fractions must lie above 1/3).
    totalReducedProperFractionsInInterval -= (((totalReducedProperFractions + 2) / 3) + 3);
  }
  // If the number of reduced proper fractions is equal to 2 mod 3,
  else{
    // Subtract the number of reduced proper fractions less than 1/3 in order
    // to get the number of reduced proper fractions STRICTLY between 1/3 and 1/2
    // (We note that the additional 3 we are subtracting from comes from the fact
    //  that the distribution of the remaining fractions must lie above 1/3).
    totalReducedProperFractionsInInterval -= (((totalReducedProperFractions + 1) / 3) + 3);
  }
  // Set the answer string to the total number of reduced proper fractions
  // inbetween the 1/3 to 1/2 interval.
  self.answer = [NSString stringWithFormat:@"%d", totalReducedProperFractionsInInterval];
  
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