//  Question44.m

#import "Question44.h"

@implementation Question44

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"23 May 2003";
  self.hint = @"Using some basic algebra and the quadratic equation, find the radical that is a perfect square.";
  self.link = @"https://en.wikipedia.org/wiki/Pentagonal_number";
  self.text = @"Pentagonal numbers are generated by the formula, Pn=n(3n-1)/2. The first ten pentagonal numbers are:\n\n1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...\n\nIt can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their difference, 70 - 22 = 48, is not pentagonal.\n\nFind the pair of pentagonal numbers, Pj and Pk, for which their sum and difference is pentagonal and D = |Pk - Pj| is minimised; what is the value of D?";
  self.isFun = YES;
  self.title = @"Pentagon numbers";
  self.answer = @"5482660";
  self.number = @"44";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"pair,pentagonal,numbers,sum,difference,generated,formula,recursion,difference,quadratic,equations,factoring,radicals";
  self.solveTime = @"120";
  self.difficulty = @"Easy";
  self.isChallenging = NO;
  self.completedOnDate = @"13/02/13";
  self.solutionLineCount = @"29";
  self.estimatedComputationTime = @"7.91e-02";
  self.estimatedBruteForceComputationTime = @"7.91e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note the following:
  //
  // (1) P_{i+1} = 3i + 1 + P_i.
  //
  // To see this, note:
  //
  //   (1/2)(i+1)(3(i+1) - 1) - (1/2)i(3i - 1)
  // = (1/2)(3i² + 2i + 3i + 2 - 3i² + i)
  // = (1/2)(6i + 2)
  // = 3i + 1
  //
  // Let P_n, P_k, P_j, P_m be the 4 pentagonal numbers required. Then:
  //
  // (2) P_j = P_k + P_n, and P_m = P_j + P_k = 2P_k + P_n.
  //
  // Then, we have the equations:
  //
  // 3i² - i = 2P_j and 3g² - g = 2P_m
  //
  // Using the quadratic equation, we arrive at:
  //
  //     1 + sqrt(1 + 24 * P_j)         1 + sqrt(1 + 24 * P_m)
  // (3) ----------------------   and   ----------------------
  //                6                              6
  //
  // Therefore, using (2) and (3), if we show that the radical is a perfect
  // square, we only need to know P_n and P_k. Also,
  //
  //      1 + sqrt(1 + 24 * P_j)         1 + sqrt(1 + 24 * P_j + 24 * P_k)
  // (3') ----------------------   and   ---------------------------------
  //                 6                                   6
  //
  // So if the radicals are both perfect squares, and the fraction evaluates to
  // an integer, we have our solution, which by (2) will be: P_k
  
  // Variable to hold the maximum number of pentagonal numbers needs.
  uint maxSize = 5000;
  
  // Variable to hold the difference of P_k - P_j.
  uint difference = 0;
  
  // Variable to hold the current pentagonal numbers index.
  uint currentIndex = 1;
  
  // Variable to hold the current square root of the radical.
  long long int currentRoot = 0;
  
  // Variable to hold th ecurrent radical.
  long long int currentRadical = 0;
  
  // Variable to hold the current pentagonal number.
  long long int currentPentagonalNumber = 0;
  
  // Variable to hold all the pentagonal numbers found.
  long long int pentagonalNumber[maxSize];
  
  // For all the pentagonal numbers,
  for(int number = 0; number < maxSize; number++){
    // Default the pentagonal number to 0.
    pentagonalNumber[number] = 0;
  }
  // Set the first pentagonal number to 1.
  pentagonalNumber[1] = 1;
  
  // While we haven't found the required pentagonal numbers,
  while(difference == 0){
    // Compute the next pentagonal number P_k. Recall (1): P_{i+1} = 3i + 1 + P_i.
    currentPentagonalNumber = (3 * currentIndex + 1) + pentagonalNumber[currentIndex];
    
    // For all the previously found pentagonal numbers,
    for(int number = 1; number < currentIndex; number++){
      // Compute the radical for P_j.
      currentRadical = 1 + 24 * (pentagonalNumber[number] + currentPentagonalNumber);
      
      // If the radical is a perfect square,
      if([self isNumberAPerfectSquare:currentRadical]){
        // Compute the numerator of the root.
        currentRoot = 1 + ((long long int)sqrt(currentRadical));
        
        // If the root is an integer (i.e.: the denominator divides the
        // numerator, where the denominator is 6),
        if((currentRoot % 6) == 0){
          // Compute the radical for P_m.
          currentRadical += (24 * pentagonalNumber[number]);
          
          // If the radical is a perfect square,
          if([self isNumberAPerfectSquare:currentRadical]){
            // Compute the numerator of the root.
            currentRoot = 1 + ((long long int)sqrt(currentRadical));
            
            // If the root is an integer (i.e.: the denominator divides the
            // numerator, where the denominator is 6),
            if((currentRoot % 6) == 0){
              // Set the difference to be the current pentagonal number P_k.
              difference = (uint)currentPentagonalNumber;
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
    }
    // Increment the number of pentagonal numbers found by 1.
    currentIndex++;
    
    // Set the current pentagonal number in the pentagonal numbers array.
    pentagonalNumber[currentIndex] = currentPentagonalNumber;
  }
  // Set the answer string to the .
  self.answer = [NSString stringWithFormat:@"%d", difference];
  
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
  
  // Here, we note the following:
  //
  // (1) P_{i+1} = 3i + 1 + P_i.
  //
  // To see this, note:
  //
  //   (1/2)(i+1)(3(i+1) - 1) - (1/2)i(3i - 1)
  // = (1/2)(3i² + 2i + 3i + 2 - 3i² + i)
  // = (1/2)(6i + 2)
  // = 3i + 1
  //
  // Let P_n, P_k, P_j, P_m be the 4 pentagonal numbers required. Then:
  //
  // (2) P_j = P_k + P_n, and P_m = P_j + P_k = 2P_k + P_n.
  //
  // Then, we have the equations:
  //
  // 3i² - i = 2P_j and 3g² - g = 2P_m
  //
  // Using the quadratic equation, we arrive at:
  //
  //     1 + sqrt(1 + 24 * P_j)         1 + sqrt(1 + 24 * P_m)
  // (3) ----------------------   and   ----------------------
  //                6                              6
  //
  // Therefore, using (2) and (3), if we show that the radical is a perfect
  // square, we only need to know P_n and P_k. Also,
  //
  //      1 + sqrt(1 + 24 * P_j)         1 + sqrt(1 + 24 * P_j + 24 * P_k)
  // (3') ----------------------   and   ---------------------------------
  //                 6                                   6
  //
  // So if the radicals are both perfect squares, and the fraction evaluates to
  // an integer, we have our solution, which by (2) will be: P_k
  
  // Variable to hold the maximum number of pentagonal numbers needs.
  uint maxSize = 5000;
  
  // Variable to hold the difference of P_k - P_j.
  uint difference = 0;
  
  // Variable to hold the current pentagonal numbers index.
  uint currentIndex = 1;
  
  // Variable to hold the current square root of the radical.
  long long int currentRoot = 0;
  
  // Variable to hold th ecurrent radical.
  long long int currentRadical = 0;
  
  // Variable to hold the current pentagonal number.
  long long int currentPentagonalNumber = 0;
  
  // Variable to hold all the pentagonal numbers found.
  long long int pentagonalNumber[maxSize];
  
  // For all the pentagonal numbers,
  for(int number = 0; number < maxSize; number++){
    // Default the pentagonal number to 0.
    pentagonalNumber[number] = 0;
  }
  // Set the first pentagonal number to 1.
  pentagonalNumber[1] = 1;
  
  // While we haven't found the required pentagonal numbers,
  while(difference == 0){
    // Compute the next pentagonal number P_k. Recall (1): P_{i+1} = 3i + 1 + P_i.
    currentPentagonalNumber = (3 * currentIndex + 1) + pentagonalNumber[currentIndex];
    
    // For all the previously found pentagonal numbers,
    for(int number = 1; number < currentIndex; number++){
      // Compute the radical for P_j.
      currentRadical = 1 + 24 * (pentagonalNumber[number] + currentPentagonalNumber);
      
      // If the radical is a perfect square,
      if([self isNumberAPerfectSquare:currentRadical]){
        // Compute the numerator of the root.
        currentRoot = 1 + ((long long int)sqrt(currentRadical));
        
        // If the root is an integer (i.e.: the denominator divides the
        // numerator, where the denominator is 6),
        if((currentRoot % 6) == 0){
          // Compute the radical for P_m.
          currentRadical += (24 * pentagonalNumber[number]);
          
          // If the radical is a perfect square,
          if([self isNumberAPerfectSquare:currentRadical]){
            // Compute the numerator of the root.
            currentRoot = 1 + ((long long int)sqrt(currentRadical));
            
            // If the root is an integer (i.e.: the denominator divides the
            // numerator, where the denominator is 6),
            if((currentRoot % 6) == 0){
              // Set the difference to be the current pentagonal number P_k.
              difference = (uint)currentPentagonalNumber;
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
    }
    // Increment the number of pentagonal numbers found by 1.
    currentIndex++;
    
    // Set the current pentagonal number in the pentagonal numbers array.
    pentagonalNumber[currentIndex] = currentPentagonalNumber;
  }
  // Set the answer string to the .
  self.answer = [NSString stringWithFormat:@"%d", difference];
  
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