//  Question62.m

#import "Question62.h"

@implementation Question62

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"30 January 2004";
  self.hint = @"Compute all the cubes with the same number of digits first.";
  self.text = @"The cube, 41063625 (345³), can be permuted to produce two other cubes: 56623104 (384³) and 66430125 (405³). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.\n\nFind the smallest cube for which exactly five permutations of its digits are cube.";
  self.isFun = YES;
  self.title = @"Cubic permutations";
  self.answer = @"127035954683";
  self.number = @"62";
  self.rating = @"4";
  self.keywords = @"cube,cubic,permutations,digits,exactly,5,five,smallest,unique,minimum,number";
  self.difficulty = @"Medium";
  self.solutionLineCount = @"45";
  self.estimatedComputationTime = @"0.731";
  self.estimatedBruteForceComputationTime = @"0.831";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute all of the cubes with a given number of digits. We
  // then compute the sum of the digits of the cube, and sort the cubes into
  // separate arrays based on the sum of its digits. We compute the sum of the
  // digits with a helper method. Then, using another previously made helper
  // method, we check the arrays with the same digit sums to see if we can find
  // any permutations. If there is a cube with five other permutations that are
  // also in the array, we store the smallest cube, and break out of the loop.
  
  // Variable to hold the maximum value of n such that n³ has the current number
  // of digits.
  uint maxN = 0;
  
  // Variable to hold the minimum value of n such that n³ has the current number
  // of digits.
  uint minN = 0;
  
  // Variable to hold the digit sum of the current cube.
  uint digitSum = 0;
  
  // Variable to hold the number of permutations the current cube has.
  uint numberOfPermutations = 0;
  
  // Variable to hold the required number of permuations of the cube.
  uint requiredNumberOfPermutations = 5;
  
  // Variable to hold the current counts of the cubes with the same digit sum.
  uint cubedCounts[120] = {0};
  
  // Variable to hold the value of the current cube.
  long long int nCubed = 0;
  
  // Variable to hold the smallest cube with five permutations that are also
  // cubes.
  long long int smallestCube = 0;
  
  // Variable array to hold the cubed values of the cubes with the same number
  // of digits.
  long long int cubedValues[120][250];
  
  // (Note: I choose 12 here because it is sufficient, and because Threads on
  // the iPhone have a stack that is capped at 512 KB. It becomes a much more
  // difficult problem if I can't use the arrays as I have been, and once we get
  // to 14 digits, we overflow. For more information, visit:
  //
  // http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Multithreading/CreatingThreads/CreatingThreads.html
  
  // For all the number of digits from 1 up to 12,
  for(uint numberOfDigits = 1; numberOfDigits <= 12; numberOfDigits++){
    // For all the potential digit sums the cubes can have,
    for(int i = 0; i < 120; i++){
      // Reset the number of cubes with the same digit sum to 0.
      cubedCounts[i] = 0;
      
      // For all the potential cubes with the same digit sum,
      for(int j = 0; j < 250; j++){
        // Reset the cubes value to 0.
        cubedValues[i][j] = 0;
      }
    }
    // Compute the maximum value of n such that n³ has the current number of
    // digits.
    maxN = ((uint)pow(pow(10.0, ((double)(numberOfDigits))), (1.0 / 3.0)));
    
    // Compute the minimum value of n such that n³ has the current number of
    // digits.
    minN = ((uint)pow(pow(10.0, ((double)(numberOfDigits - 1))), (1.0 / 3.0))) + 1;
    
    for(long int n = minN; n < maxN; n++){
      // Compute n³.
      nCubed = (long long int)pow(n, 3);
      
      // Compute the digit sum of n³.
      digitSum = [self sumOfDigits:nCubed];
      
      // Store n³ in the array with the same digit sum as above.
      cubedValues[digitSum][cubedCounts[digitSum]] = nCubed;
      
      // Increment the number of cubes with the current digit sum by 1.
      cubedCounts[digitSum]++;
    }
    // For all the potential digit sums the cubes can have,
    for(int i = 0; i < 120; i++){
      // For all the potential cubes with the same digit sum,
      for(int j = 0; j < cubedCounts[i]; j++){
        // Reset the number of permutations to 1.
        numberOfPermutations = 1;
        
        // If the current cubed value has not been removed already,
        if(cubedValues[i][j] > 0){
          // For all the potential cubes with the same digit sum that are larger
          // than the currently selected sum,
          for(int k = (j + 1); k < cubedCounts[i]; k++){
            // If the smallest cube is a permutation of the current larger cube,
            if([self number:cubedValues[i][j] isAPermutationOfNumber:cubedValues[i][k]]){
              // Remove the current larger cubed value from the array, as it no
              // longer needs to be checked (it's a permutation of the current
              // smaller cube).
              cubedValues[i][k] = 0;
              
              // Increment the number of permutations by 1.
              numberOfPermutations++;
            }
          }
          // If the number of permutations is equal to the required number of
          // permutations,
          if(numberOfPermutations == requiredNumberOfPermutations){
            // Store the smallest cube.
            smallestCube = cubedValues[i][j];
            
            // Break out of the loop.
            break;
          }
        }
      }
      // If the smallest cube with five permutations that are also cubes has been
      // found,
      if(smallestCube > 0){
        // Break out of the loop.
        break;
      }
    }
    // If the smallest cube with five permutations that are also cubes has been
    // found,
    if(smallestCube > 0){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the smallest cube with five permutations that are
  // also cubes.
  self.answer = [NSString stringWithFormat:@"%llu", smallestCube];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm just removes cubes that have already been checked.
  
  // Here, we simply compute all of the cubes with a given number of digits. We
  // then compute the sum of the digits of the cube, and sort the cubes into
  // separate arrays based on the sum of its digits. We compute the sum of the
  // digits with a helper method. Then, using another previously made helper
  // method, we check the arrays with the same digit sums to see if we can find
  // any permutations. If there is a cube with five other permutations that are
  // also in the array, we store the smallest cube, and break out of the loop.
  
  // Variable to hold the maximum value of n such that n³ has the current number
  // of digits.
  uint maxN = 0;
  
  // Variable to hold the minimum value of n such that n³ has the current number
  // of digits.
  uint minN = 0;
  
  // Variable to hold the digit sum of the current cube.
  uint digitSum = 0;
  
  // Variable to hold the number of permutations the current cube has.
  uint numberOfPermutations = 0;
  
  // Variable to hold the required number of permuations of the cube.
  uint requiredNumberOfPermutations = 5;
  
  // Variable to hold the current counts of the cubes with the same digit sum.
  uint cubedCounts[120] = {0};
  
  // Variable to hold the value of the current cube.
  long long int nCubed = 0;
  
  // Variable to hold the smallest cube with five permutations that are also
  // cubes.
  long long int smallestCube = 0;
  
  // Variable array to hold the cubed values of the cubes with the same number
  // of digits.
  long long int cubedValues[120][250];
  
  // (Note: I choose 12 here because it is sufficient, and because Threads on
  // the iPhone have a stack that is capped at 512 KB. It becomes a much more
  // difficult problem if I can't use the arrays as I have been, and once we get
  // to 14 digits, we overflow. For more information, visit:
  //
  // http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Multithreading/CreatingThreads/CreatingThreads.html
  
  // For all the number of digits from 1 up to 12,
  for(uint numberOfDigits = 1; numberOfDigits <= 12; numberOfDigits++){
    // For all the potential digit sums the cubes can have,
    for(int i = 0; i < 120; i++){
      // Reset the number of cubes with the same digit sum to 0.
      cubedCounts[i] = 0;
      
      // For all the potential cubes with the same digit sum,
      for(int j = 0; j < 250; j++){
        // Reset the cubes value to 0.
        cubedValues[i][j] = 0;
      }
    }
    // Compute the maximum value of n such that n³ has the current number of
    // digits.
    maxN = ((uint)pow(pow(10.0, ((double)(numberOfDigits))), (1.0 / 3.0)));
    
    // Compute the minimum value of n such that n³ has the current number of
    // digits.
    minN = ((uint)pow(pow(10.0, ((double)(numberOfDigits - 1))), (1.0 / 3.0))) + 1;
    
    for(long int n = minN; n < maxN; n++){
      // Compute n³.
      nCubed = (long long int)pow(n, 3);
      
      // Compute the digit sum of n³.
      digitSum = [self sumOfDigits:nCubed];
      
      // Store n³ in the array with the same digit sum as above.
      cubedValues[digitSum][cubedCounts[digitSum]] = nCubed;
      
      // Increment the number of cubes with the current digit sum by 1.
      cubedCounts[digitSum]++;
    }
    // For all the potential digit sums the cubes can have,
    for(int i = 0; i < 120; i++){
      // For all the potential cubes with the same digit sum,
      for(int j = 0; j < cubedCounts[i]; j++){
        // Reset the number of permutations to 1.
        numberOfPermutations = 1;
        
        // For all the potential cubes with the same digit sum that are larger
        // than the currently selected sum,
        for(int k = (j + 1); k < cubedCounts[i]; k++){
          // If the smallest cube is a permutation of the current larger cube,
          if([self number:cubedValues[i][j] isAPermutationOfNumber:cubedValues[i][k]]){
            // Increment the number of permutations by 1.
            numberOfPermutations++;
          }
        }
        // If the number of permutations is equal to the required number of
        // permutations,
        if(numberOfPermutations == requiredNumberOfPermutations){
          // Store the smallest cube.
          smallestCube = cubedValues[i][j];
          
          // Break out of the loop.
          break;
        }
      }
      // If the smallest cube with five permutations that are also cubes has been
      // found,
      if(smallestCube > 0){
        // Break out of the loop.
        break;
      }
    }
    // If the smallest cube with five permutations that are also cubes has been
    // found,
    if(smallestCube > 0){
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the smallest cube with five permutations that are
  // also cubes.
  self.answer = [NSString stringWithFormat:@"%llu", smallestCube];
  
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