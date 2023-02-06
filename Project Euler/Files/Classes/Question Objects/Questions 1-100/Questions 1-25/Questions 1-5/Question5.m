//  Question5.m

#import "Question5.h"

@implementation Question5

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"30 November 2001";
  self.hint = @"Factorials include all the numbers from 1 to n. They also include all the primes from 1 to n. So what do the maximum prime powers give us?";
  self.link = @"https://en.wikipedia.org/wiki/Factorial";
  self.text = @"2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.\n\nWhat is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?";
  self.isFun = YES;
  self.title = @"Smallest multiple";
  self.answer = @"232792560";
  self.number = @"5";
  self.rating = @"4";
  self.category = @"Primes";
  self.keywords = @"divisible,factorial,evenly,smallest,positive,numbers,20,twenty,remainder,primes,maximum,divisible,without";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = NO;
  self.commentCount = @"13";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"05/01/13";
  self.trickRequired = NO;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"05/01/13";
  self.solutionLineCount = @"7";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"3.9e-05";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"5.81e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We know that every number from 1 to n must evenly divide our resultant number.
  // Therefore, we need only find the maximum prime power less than n, and multiply
  // those prime numbers together.
  
  // Variable to hold the maximum number in the problem.
  uint maxNumber = 20;
  
  // Variable to hold the easily divisible number.
  long long int easilyDivisibleNumber = 1;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxNumber];
  
  // For all the prime numbers in the prime number array,
  for(NSNumber * number in primeNumbersArray){
    // Multiply the easily divisible number by the prime power that divides the
    // max number.
    easilyDivisibleNumber *= (uint)pow([number doubleValue], [self flooredLog:maxNumber withBase:[number doubleValue]]);
  }
  // Set the answer string to the easily divisble number.
  self.answer = [NSString stringWithFormat:@"%llu", easilyDivisibleNumber];
  
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
  
  // Here, we will compute n!, loop through all the primes less than n, and divide
  // out all the extra multiples of the primes that occur.
  
  // Variable to determine if we need to keep looping or not.
  BOOL keepLooping = YES;
  
  // Variable to hold the maximum number in the problem.
  uint maxNumber = 20;
  
  // Variable to hold the easily divisible number.
  long long int easilyDivisibleNumber = 1;
  
  // Array that holds the primes numbers. The method is defined in the super class.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxNumber];
  
  // Compute maxNumber!.
  for(int i = maxNumber; i > 1; i--){
    easilyDivisibleNumber *= i;
  }
  // For all the prime numbers in the prime number array,
  for(NSNumber * number in primeNumbersArray){
    // Set the default of the keepLooping variable to YES. We are guaranteed that
    // all the prime numbers divide the easilyDivisible, as it's starting value
    // is maxNumber!, which has each prime number less that maxNumber as a factor.
    keepLooping = YES;
    
    // While we should keep looping,
    while(keepLooping){
      // Divide out the current prime number from the easily divisible number.
      easilyDivisibleNumber /= [number intValue];
      
      // For all the numbers from maxNumber to 2,
      for(int i = maxNumber; i > 1; i--){
        // If each number does NOT divide the easily divisible number,
        if((easilyDivisibleNumber % i) != 0){
          // Multiply the the easily divisible number by the factor we previously
          // divided out by.
          easilyDivisibleNumber *= [number intValue];
          
          // Set that we should stop looping.
          keepLooping = NO;
          
          // Exit the for loop.
          break;
        }
      }
    }
  }
  // Set the answer string to the easily divisble number.
  self.answer = [NSString stringWithFormat:@"%llu", easilyDivisibleNumber];
  
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