//  Question206.m

#import "Question206.h"

@implementation Question206

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"06 September 2008";
  self.text = @"Find the unique positive integer whose square has the form\n\n1_2_3_4_5_6_7_8_9_0,\n\nwhere each “_” is a single digit.";
  self.title = @"Concealed Square";
  self.answer = @"1389019170";
  self.number = @"206";
  self.keywords = @"concealed,square,perfect,positive,integer";
  self.estimatedComputationTime = @"4.53";
  self.estimatedBruteForceComputationTime = @"4.53";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply look at all possible numbers of the given form and check if
  // they are a perfect square or NOT.
  
  // Variable to mark if we have found the unique square or not.
  BOOL foundSquare = NO;
  
  // Variable to hold the known fixed numbers of the unique square.
  long long int baseOfSquare = 10203040506070809;
  
  // Variable to hold the potential square number.
  long long int potentialSquare = 0;
  
  // For all the digits 0 to 9 in the first location,
  for(long long int digit1 = 0; digit1 < 10; digit1++){
    // Reset the potential square to the known digits of the unique square, and
    // add on the current digit in the first location.
    potentialSquare = baseOfSquare + (digit1 * 1000000000000000);
    
    // For all the digits 0 to 9 in the second location,
    for(long long int digit2 = 0; digit2 < 10; digit2++){
      // Add on the current digit in the second location.
      potentialSquare += (digit2 * 10000000000000);
      
      // For all the digits 0 to 9 in the third location,
      for(long long int digit3 = 0; digit3 < 10; digit3++){
        // Add on the current digit in the third location.
        potentialSquare += (digit3 * 100000000000);
        
        // For all the digits 0 to 9 in the fourth location,
        for(long long int digit4 = 0; digit4 < 10; digit4++){
          // Add on the current digit in the fourth location.
          potentialSquare += (digit4 * 1000000000);
          
          // For all the digits 0 to 9 in the fifth location,
          for(long long int digit5 = 0; digit5 < 10; digit5++){
            // Add on the current digit in the fifth location.
            potentialSquare += (digit5 * 10000000);
            
            // For all the digits 0 to 9 in the sixth location,
            for(long long int digit6 = 0; digit6 < 10; digit6++){
              // Add on the current digit in the sixth location.
              potentialSquare += (digit6 * 100000);
              
              // For all the digits 0 to 9 in the seventh location,
              for(long long int digit7 = 0; digit7 < 10; digit7++){
                // Add on the current digit in the seventh location.
                potentialSquare += (digit7 * 1000);
                
                // For all the digits 0 to 9 in the eighth location,
                for(long long int digit8 = 0; digit8 < 10; digit8++){
                  // Add on the current digit in the eighth location.
                  potentialSquare += (digit8 * 10);
                  
                  // If the potential square is a perfect square,
                  if([self isNumberAPerfectSquare:potentialSquare]){
                    // Mark that we have found the unique square.
                    foundSquare = YES;
                    
                    // Break out of the loop.
                    break;
                  }
                  // Remove the current digit in the eighth location.
                  potentialSquare -= (digit8 * 10);
                }
                // If we have found the unique square,
                if(foundSquare){
                  // Break out of the loop.
                  break;
                }
                // Remove the current digit in the seventh location.
                potentialSquare -= (digit7 * 1000);
              }
              // If we have found the unique square,
              if(foundSquare){
                // Break out of the loop.
                break;
              }
              // Remove the current digit in the sixth location.
              potentialSquare -= (digit6 * 100000);
            }
            // If we have found the unique square,
            if(foundSquare){
              // Break out of the loop.
              break;
            }
            // Remove the current digit in the fifth location.
            potentialSquare -= (digit5 * 10000000);
          }
          // If we have found the unique square,
          if(foundSquare){
            // Break out of the loop.
            break;
          }
          // Remove the current digit in the fourth location.
          potentialSquare -= (digit4 * 1000000000);
        }
        // If we have found the unique square,
        if(foundSquare){
          // Break out of the loop.
          break;
        }
        // Remove the current digit in the third location.
        potentialSquare -= (digit3 * 100000000000);
      }
      // If we have found the unique square,
      if(foundSquare){
        // Break out of the loop.
        break;
      }
      // Remove the current digit in the second location.
      potentialSquare -= (digit2 * 10000000000000);
    }
    // If we have found the unique square,
    if(foundSquare){
      // Break out of the loop.
      break;
    }
    // Remove the current digit in the first location.
    potentialSquare -= (digit1 * 1000000000000000);
  }
  // Set the answer string to the square root of the unique square. Remember to
  // add a 0 at the end, as we did NOT include the 9th digit in our calculations
  // above.
  self.answer = [NSString stringWithFormat:@"%llu0", ((long long int)(sqrt((double)potentialSquare)))];
  
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
  
  // Here, we simply look at all possible numbers of the given form and check if
  // they are a perfect square or NOT.
  
  // Variable to mark if we have found the unique square or not.
  BOOL foundSquare = NO;
  
  // Variable to hold the known fixed numbers of the unique square.
  long long int baseOfSquare = 10203040506070809;
  
  // Variable to hold the potential square number.
  long long int potentialSquare = 0;
  
  // For all the digits 0 to 9 in the first location,
  for(long long int digit1 = 0; digit1 < 10; digit1++){
    // Reset the potential square to the known digits of the unique square, and
    // add on the current digit in the first location.
    potentialSquare = baseOfSquare + (digit1 * 1000000000000000);
    
    // For all the digits 0 to 9 in the second location,
    for(long long int digit2 = 0; digit2 < 10; digit2++){
      // Add on the current digit in the second location.
      potentialSquare += (digit2 * 10000000000000);
      
      // For all the digits 0 to 9 in the third location,
      for(long long int digit3 = 0; digit3 < 10; digit3++){
        // Add on the current digit in the third location.
        potentialSquare += (digit3 * 100000000000);
        
        // For all the digits 0 to 9 in the fourth location,
        for(long long int digit4 = 0; digit4 < 10; digit4++){
          // Add on the current digit in the fourth location.
          potentialSquare += (digit4 * 1000000000);
          
          // For all the digits 0 to 9 in the fifth location,
          for(long long int digit5 = 0; digit5 < 10; digit5++){
            // Add on the current digit in the fifth location.
            potentialSquare += (digit5 * 10000000);
            
            // For all the digits 0 to 9 in the sixth location,
            for(long long int digit6 = 0; digit6 < 10; digit6++){
              // Add on the current digit in the sixth location.
              potentialSquare += (digit6 * 100000);
              
              // For all the digits 0 to 9 in the seventh location,
              for(long long int digit7 = 0; digit7 < 10; digit7++){
                // Add on the current digit in the seventh location.
                potentialSquare += (digit7 * 1000);
                
                // For all the digits 0 to 9 in the eighth location,
                for(long long int digit8 = 0; digit8 < 10; digit8++){
                  // Add on the current digit in the eighth location.
                  potentialSquare += (digit8 * 10);
                  
                  // If the potential square is a perfect square,
                  if([self isNumberAPerfectSquare:potentialSquare]){
                    // Mark that we have found the unique square.
                    foundSquare = YES;
                    
                    // Break out of the loop.
                    break;
                  }
                  // Remove the current digit in the eighth location.
                  potentialSquare -= (digit8 * 10);
                }
                // If we have found the unique square,
                if(foundSquare){
                  // Break out of the loop.
                  break;
                }
                // Remove the current digit in the seventh location.
                potentialSquare -= (digit7 * 1000);
              }
              // If we have found the unique square,
              if(foundSquare){
                // Break out of the loop.
                break;
              }
              // Remove the current digit in the sixth location.
              potentialSquare -= (digit6 * 100000);
            }
            // If we have found the unique square,
            if(foundSquare){
              // Break out of the loop.
              break;
            }
            // Remove the current digit in the fifth location.
            potentialSquare -= (digit5 * 10000000);
          }
          // If we have found the unique square,
          if(foundSquare){
            // Break out of the loop.
            break;
          }
          // Remove the current digit in the fourth location.
          potentialSquare -= (digit4 * 1000000000);
        }
        // If we have found the unique square,
        if(foundSquare){
          // Break out of the loop.
          break;
        }
        // Remove the current digit in the third location.
        potentialSquare -= (digit3 * 100000000000);
      }
      // If we have found the unique square,
      if(foundSquare){
        // Break out of the loop.
        break;
      }
      // Remove the current digit in the second location.
      potentialSquare -= (digit2 * 10000000000000);
    }
    // If we have found the unique square,
    if(foundSquare){
      // Break out of the loop.
      break;
    }
    // Remove the current digit in the first location.
    potentialSquare -= (digit1 * 1000000000000000);
  }
  // Set the answer string to the square root of the unique square. Remember to
  // add a 0 at the end, as we did NOT include the 9th digit in our calculations
  // above.
  self.answer = [NSString stringWithFormat:@"%llu0", ((long long int)(sqrt((double)potentialSquare)))];
  
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