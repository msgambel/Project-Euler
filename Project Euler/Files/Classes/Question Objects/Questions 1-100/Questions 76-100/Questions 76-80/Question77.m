//  Question77.m

#import "Question77.h"

@implementation Question77

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"27 August 2004";
  self.hint = @"Use a recursive method to figure out the number of combinations of primes for a given value.";
  self.text = @"It is possible to write ten as the sum of primes in exactly five different ways:\n\n7 + 3\n5 + 5\n5 + 3 + 2\n3 + 3 + 2 + 2\n2 + 2 + 2 + 2 + 2\n\nWhat is the first value which can be written as the sum of primes in over five thousand different ways?";
  self.isFun = YES;
  self.title = @"Prime summations";
  self.answer = @"71";
  self.number = @"77";
  self.rating = @"5";
  self.category = @"Primes";
  self.keywords = @"primes,summations,five,thousand,5000,positive,different,permutations,ways,written,as,sum,possible";
  self.solveTime = @"90";
  self.difficulty = @"Easy";
  self.isChallenging = NO;
  self.completedOnDate = @"18/03/13";
  self.solutionLineCount = @"51";
  self.estimatedComputationTime = @"4.84e-04";
  self.estimatedBruteForceComputationTime = @"4.84e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a method similar to Question 31. Essentially, we loop
  // through the numbers, adding on the prime partitions of the previous values.
  // The only difference here is that instead of looking at the partitions of
  // each number where the partitions are integers, here, the partitions are
  // only allowed to be prime numbers. Therefore, we are looking at the prime
  // numbers index in the prime numbers array, and not the value itself.
  
  // Variable to hold the current prime number we are using as a partition
  // length.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the required number of prime partitions the number must
  // have.
  uint requiredNumberOfPartitions = 5000;
  
  // Variable to hold the number with the required number of prime partitions.
  uint numberWithRequiredNumberOfPartitions = 5000;
  
  // Variable to hold the number of prime partitions for each number less than
  // the current number we are looking at.
  uint numberOfPartitions[101] = {0};
  
  // Array to hold the prime numbers up to 100.
  NSArray * primesArray = [self arrayOfPrimeNumbersLessThan:100];
  
  // For all the values starting from the first prime number 2 up to 100,
  for(int minValue = 2; minValue < 100; minValue++){
    // For all of the numbers from 0 to 100,
    for(int i = 0; i <= 100; i++){
      // Reset the number of partitions for this number to 0.
      numberOfPartitions[i] = 0;
    }
    // Set that the number 2 can be partitioned into prime numbers only 1 way.
    numberOfPartitions[0] = 1;
    
    // For all the prime numbers in the prime numbers array,
    for(int primeNumberIndex = 0; primeNumberIndex < [primesArray count]; primeNumberIndex++){
      // Grab the current prime number for the given index.
      currentPrimeNumber = [[primesArray objectAtIndex:primeNumberIndex] intValue];
      
      // For all the partition values from the current prime number to the
      // minimum value with the required number of partition we are currently
      // examining,
      for(int i = currentPrimeNumber; i <= minValue; i++){
        // Add the number of prime partitions for the previous number.
        numberOfPartitions[i] += numberOfPartitions[(i - currentPrimeNumber)];
      }
    }
    // If the number of partitions for the current minimum value is greater than
    // the required number of prime partitions,
    if(numberOfPartitions[minValue] > requiredNumberOfPartitions){
      // Store the current minimum value.
      numberWithRequiredNumberOfPartitions = minValue;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the number with the required number of prime
  // partitions.
  self.answer = [NSString stringWithFormat:@"%d", numberWithRequiredNumberOfPartitions];
  
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
  
  // Here, we simply use a method similar to Question 31. Essentially, we loop
  // through the numbers, adding on the prime partitions of the previous values.
  // The only difference here is that instead of looking at the partitions of
  // each number where the partitions are integers, here, the partitions are
  // only allowed to be prime numbers. Therefore, we are looking at the prime
  // numbers index in the prime numbers array, and not the value itself.
  
  // Variable to hold the current prime number we are using as a partition
  // length.
  uint currentPrimeNumber = 0;
  
  // Variable to hold the required number of prime partitions the number must
  // have.
  uint requiredNumberOfPartitions = 5000;
  
  // Variable to hold the number with the required number of prime partitions.
  uint numberWithRequiredNumberOfPartitions = 5000;
  
  // Variable to hold the number of prime partitions for each number less than
  // the current number we are looking at.
  uint numberOfPartitions[101] = {0};
  
  // Array to hold the prime numbers up to 100.
  NSArray * primesArray = [self arrayOfPrimeNumbersLessThan:100];
  
  // For all the values starting from the first prime number 2 up to 100,
  for(int minValue = 2; minValue < 100; minValue++){
    // For all of the numbers from 0 to 100,
    for(int i = 0; i <= 100; i++){
      // Reset the number of partitions for this number to 0.
      numberOfPartitions[i] = 0;
    }
    // Set that the number 2 can be partitioned into prime numbers only 1 way.
    numberOfPartitions[0] = 1;
    
    // For all the prime numbers in the prime numbers array,
    for(int primeNumberIndex = 0; primeNumberIndex < [primesArray count]; primeNumberIndex++){
      // Grab the current prime number for the given index.
      currentPrimeNumber = [[primesArray objectAtIndex:primeNumberIndex] intValue];
      
      // For all the partition values from the current prime number to the
      // minimum value with the required number of partition we are currently
      // examining,
      for(int i = currentPrimeNumber; i <= minValue; i++){
        // Add the number of prime partitions for the previous number.
        numberOfPartitions[i] += numberOfPartitions[(i - currentPrimeNumber)];
      }
    }
    // If the number of partitions for the current minimum value is greater than
    // the required number of prime partitions,
    if(numberOfPartitions[minValue] > requiredNumberOfPartitions){
      // Store the current minimum value.
      numberWithRequiredNumberOfPartitions = minValue;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the number with the required number of prime
  // partitions.
  self.answer = [NSString stringWithFormat:@"%d", numberWithRequiredNumberOfPartitions];
  
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