//  Question58.m

#import "Question58.h"

@implementation Question58

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"05 December 2003";
  self.hint = @"You only need to compute the value of 1 corner.";
  self.link = @"https://en.wikipedia.org/wiki/Primality_test#Pseudocode";
  self.text = @"Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.\n\n37 36 35 34 33 32 31\n38 17 16 15 14 13 30\n39 18  5   4   3  12 29\n40 19  6   1   2  11 28\n41 20  7   8   9  10 27\n42 21 22 23 24 25 26\n43 44 45 46 47 48 49\n\nIt is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ~ 62%.\n\nIf one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?";
  self.isFun = YES;
  self.title = @"Spiral primes";
  self.answer = @"26241";
  self.number = @"58";
  self.rating = @"5";
  self.category = @"Patterns";
  self.isUseful = NO;
  self.keywords = @"spiralling,ratio,primes,both,diagonals,anticlockwise,square,side,length,formed,layer,wrapped,falls,below,10,ten,percent";
  self.loadsFile = NO;
  self.solveTime = @"60";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"32";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"27/02/13";
  self.trickRequired = NO;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"27/02/13";
  self.solutionLineCount = @"47";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.915e-02";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.921e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute the bottom right hand corner number of each box,
  // starting from the box with side length 5, and check which values along the
  // diagonal are prime. We set the inner bottom right hand corner at the end of
  // the loop to save a multiplication, as well as a subtraction of the side
  // length by 1 to figure out the edge length to save a division. To check if
  // the number is prime, we get all the primes up to a maximum size and store
  // which numbers are prime in a Hash Table.
  
  // Variable to hold the edge length with the ratio of primes to total numbers
  // on the diagonal is less than the required percentage.
  uint requiredEdgeLength = 0;
  
  // Variable to hold the edge length of the numbers.
  uint edgeLength = 0;
  
  // Variable to hold the largest edge length of the box in question.
  uint maxSideLength = 50000;
  
  // Variable to hold the bottom right corner number in the box.
  uint bottomRightCornerNumber = 0;
  
  // Variable to hold the number of primes along the diagonals in the box.
  uint numberOfPrimesOnDiagonal = 3;
  
  // Variable to hold the number of numbers along the diagonals in the box. Set
  // it to 1 to take into account the centre.
  uint numberOfNumbersOnDiagonal = 5;
  
  // Variable to hold the current ratio of primes to total numbers on the diagonal.
  float currentRatio = 0.0;
  
  // Variable to hold the required percentage.
  float requiredPercentage = 10.0 / 100.0;
  
  // For all the odd side lengths up to the maximum side length,
  for(uint sideLength = 5; sideLength <= maxSideLength; sideLength += 2){
    // Compute the bottom right corner numbers value. It's the square of the side length!
    bottomRightCornerNumber = sideLength * sideLength;
    
    // Increment the total number of numbers on the diagonal by 4.
    numberOfNumbersOnDiagonal += 4;
    
    // Compute the edge length of the box.
    edgeLength = sideLength - 1;
    
    // No need to check the bottom right corner, as the number is always a square!
    
    // If the bottom left corner is a prime,
    if([self isPrime:(bottomRightCornerNumber - edgeLength)]){
      // Increment the number of primes on the diagonal by 1.
      numberOfPrimesOnDiagonal++;
    }
    // If the top left corner is a prime,
    if([self isPrime:(bottomRightCornerNumber - (2 * edgeLength))]){
      // Increment the number of primes on the diagonal by 1.
      numberOfPrimesOnDiagonal++;
    }
    // If the sidelength is divisible by 3, 3| (sidelength - 3*endlength), so it
    // is not a prime.
    if((sideLength % 3) != 0){
      // If the top right corner is a prime,
      if([self isPrime:(bottomRightCornerNumber - (3 * edgeLength))]){
        // Increment the number of primes on the diagonal by 1.
        numberOfPrimesOnDiagonal++;
      }
    }
    // Compute the current ratio of primes on the diagonal to total number of
    // numbers on the diagonal.
    currentRatio = (((float)numberOfPrimesOnDiagonal) / ((float)numberOfNumbersOnDiagonal));
    
    // If the current ratio is less than the required percentage,
    if(currentRatio < requiredPercentage){
      // Set the required edge length to be the current side length.
      requiredEdgeLength = sideLength;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the edge length with the ratio of primes to total
  // numbers on the diagonal is less than the required percentage.
  self.answer = [NSString stringWithFormat:@"%d", requiredEdgeLength];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm just ignores cases where possible.
  
  // Here, we simply compute the bottom right hand corner number of each box,
  // starting from the box with side length 3, and check which values along the
  // diagonal are prime. We set the inner bottom right hand corner at the end of
  // the loop to save a multiplication, as well as a subtraction of the side
  // length by 1 to figure out the edge length to save a division. To check if
  // the number is prime, we get all the primes up to a maximum size and store
  // which numbers are prime in a Hash Table.
  
  // Variable to hold the edge length with the ratio of primes to total numbers
  // on the diagonal is less than the required percentage.
  uint requiredEdgeLength = 0;
  
  // Variable to hold the edge length of the numbers.
  uint edgeLength = 0;
  
  // Variable to hold the largest edge length of the box in question.
  uint maxSideLength = 50000;
  
  // Variable to hold the bottom right corner number in the box.
  uint bottomRightCornerNumber = 0;
  
  // Variable to hold the number of primes along the diagonals in the box.
  uint numberOfPrimesOnDiagonal = 0;
  
  // Variable to hold the number of numbers along the diagonals in the box. Set
  // it to 1 to take into account the centre.
  uint numberOfNumbersOnDiagonal = 1;
  
  // Variable to hold the current ratio of primes to total numbers on the diagonal.
  float currentRatio = 0.0f;
  
  // Variable to hold the required percentage.
  float requiredPercentage = 10.0f / 100.0f;
  
  // For all the odd side lengths up to the maximum side length,
  for(uint sideLength = 3; sideLength <= maxSideLength; sideLength += 2){
    // Compute the bottom right corner numbers value. It's the square of the side length!
    bottomRightCornerNumber = sideLength * sideLength;
    
    // Increment the total number of numbers on the diagonal by 4.
    numberOfNumbersOnDiagonal += 4;
    
    // Compute the edge length of the box.
    edgeLength = sideLength - 1;
    
    // If the bottom left corner is a prime,
   if([self isPrime:(bottomRightCornerNumber - edgeLength)]){
      // Increment the number of primes on the diagonal by 1.
      numberOfPrimesOnDiagonal++;
    }
    // If the top left corner is a prime,
    if([self isPrime:(bottomRightCornerNumber - (2 * edgeLength))]){
      // Increment the number of primes on the diagonal by 1.
      numberOfPrimesOnDiagonal++;
    }
    // If the top right corner is a prime,
    if([self isPrime:(bottomRightCornerNumber - (3 * edgeLength))]){
      // Increment the number of primes on the diagonal by 1.
      numberOfPrimesOnDiagonal++;
    }
    // Compute the current ratio of primes on the diagonal to total number of
    // numbers on the diagonal.
    currentRatio = (((float)numberOfPrimesOnDiagonal) / ((float)numberOfNumbersOnDiagonal));
    
    // If the current ratio is less than the required percentage,
    if(currentRatio < requiredPercentage){
      // Set the required edge length to be the current side length.
      requiredEdgeLength = sideLength;
      
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the edge length with the ratio of primes to total
  // numbers on the diagonal is less than the required percentage.
  self.answer = [NSString stringWithFormat:@"%d", requiredEdgeLength];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end