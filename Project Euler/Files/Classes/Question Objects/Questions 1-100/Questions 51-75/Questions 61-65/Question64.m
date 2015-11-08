//  Question64.m

#import "Question64.h"

@implementation Question64

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"27 February 2004";
  self.hint = @"There are equations to compute the representations of each number.";
  self.text = @"All square roots are periodic when written as continued fractions and can be written in the form:\n\n(Please visit site, as UITextView's cannot render any of the required font!)\n\nIt can be seen that the sequence is repeating. For conciseness, we use the notation 23 = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.\n\nThe first ten continued fraction representations of (irrational) square roots are:\n\n2=[1;(2)], period=1\n3=[1;(1,2)], period=2\n5=[2;(4)], period=1\n6=[2;(2,4)], period=2\n7=[2;(1,1,1,4)], period=4\n8=[2;(1,4)], period=2\n10=[3;(6)], period=1\n11=[3;(3,6)], period=2\n12= [3;(2,6)], period=2\n13=[3;(1,1,1,1,6)], period=5\n\nExactly four continued fractions, for N <= 13, have an odd period.\n\nHow many continued fractions for N <= 10000 have an odd period?";
  self.isFun = NO;
  self.title = @"Odd period square roots";
  self.answer = @"1322";
  self.number = @"64";
  self.rating = @"3";
  self.keywords = @"square,roots,continued,fractions,representations,periodic,odd,ten,thousand,10000,count,notation,blocks,repeats,indefinitely";
  self.difficulty = @"Easy";
  self.solutionLineCount = @"43";
  self.estimatedComputationTime = @"1.61e-02";
  self.estimatedBruteForceComputationTime = @"1.61e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the following equations to compute the representation
  // of each number. For a more detailed explaination, visit:
  //
  // http://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Continued_fraction_expansion
  //
  // Esstentially, we  loop to compute a_n, d_n, and m_n, and then store their
  // values in an array. We check to see if there is a repeat for ALL of the
  // values, and if there is, we break out of the loop. We finally check if the
  // period is odd, and if it is, we add 1 to the total number of numbers less
  // than the maximum size that have an odd period.
  
  // Variable to mark is a repeat is found.
  BOOL repeatFound = NO;
  
  // Variable to hold the starting value in the representation of each number.
  uint a_0 = 0;
  
  // Variable to hold the nth value in the representation of each number.
  uint a_n = 0;
  
  // Variable to hold the nth denominator in the representation of each number.
  uint d_n = 0;
  
  // Variable to hold the nth numerator in the representation of each number.
  uint m_n = 0;
  
  // Variable to hold the maximum size we have to look at.
  uint maxSize = 10000;
  
  // Variable to hold the current periods length.
  uint periodLength = 0;
  
  // Variable to hold the number of elements in the current representation.
  uint representationCount = 0;
  
  // Variable to hold the number of representations with odd period.
  uint representationsWithOddPeriod = 0;
  
  // Variable array to hold the a_n values of the current representation.
  uint representationA_N[500] = {0};
  
  // Variable array to hold the d_n values of the current representation.
  uint representationD_N[500] = {0};
  
  // Variable array to hold the m_n values of the current representation.
  uint representationM_N[500] = {0};
  
  // For all the numbers from 2 up to the maximum size,
  for(uint number = 2; number < maxSize; number++){
    // If the number is NOT a perfect sqaure,
    if([self isNumberAPerfectSquare:number] == NO){
      // Reset that a repeat has NOT been found.
      repeatFound = NO;
      
      // Set a_0 = floor(sqrt(number)).
      a_0 = ((uint)sqrt(((double)number)));
      
      // Set a_0 = a_0.
      a_n = a_0;
      
      // Set d_0 = 1.
      d_n = 1;
      
      // Set m_0 = 0.
      m_n = 0;
      
      // Reset the number of elements in the representation to 0.
      representationCount = 0;
      
      // While a repeat has NOT been found,
      while(repeatFound == NO){
        // Compute m_{n+1}.
        m_n = (d_n * a_n) - m_n;
        
        // Compute d_{n+1}.
        d_n = ((uint)((number - (m_n * m_n)) / d_n));
        
        // Compute a_{n+1}.
        a_n = ((uint)((a_0 + m_n) / d_n));
        
        // Store a_{n+1} in the representation array.
        representationA_N[representationCount] = a_n;
        
        // Store d_{n+1} in the representation array.
        representationD_N[representationCount] = d_n;
        
        // Store m_{n+1} in the representation array.
        representationM_N[representationCount] = m_n;
        
        // Increment the number of elements in the representation by 1.
        representationCount++;
        
        // If the number of elements in the representation is even,
        if((representationCount % 2) == 0){
          // Compute the current period length.
          periodLength = representationCount / 2;
          
          // Assume that a repeat HAS been found.
          repeatFound = YES;
          
          // For all the representations for the current period length,
          for(int i = 0; i < periodLength; i++){
            // If the current period does NOT have a match in one of the
            // variables representations,
            if((representationA_N[i] != representationA_N[(i + periodLength)]) ||
               (representationD_N[i] != representationD_N[(i + periodLength)]) ||
               (representationM_N[i] != representationM_N[(i + periodLength)])){
              
              // Mark that the repeat is still NOT found.
              repeatFound = NO;
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
      // If the current period length is odd,
      if((periodLength % 2) == 1){
        // Increment the number of representations with odd period by 1.
        representationsWithOddPeriod++;
      }
    }
  }
  // Set the answer string to the number of representations with odd period.
  self.answer = [NSString stringWithFormat:@"%d", representationsWithOddPeriod];
  
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
  
  // Here, we simply use the following equations to compute the representation
  // of each number. For a more detailed explaination, visit:
  //
  // http://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Continued_fraction_expansion
  //
  // Esstentially, we  loop to compute a_n, d_n, and m_n, and then store their
  // values in an array. We check to see if there is a repeat for ALL of the
  // values, and if there is, we break out of the loop. We finally check if the
  // period is odd, and if it is, we add 1 to the total number of numbers less
  // than the maximum size that have an odd period.
  
  // Variable to mark is a repeat is found.
  BOOL repeatFound = NO;
  
  // Variable to hold the starting value in the representation of each number.
  uint a_0 = 0;
  
  // Variable to hold the nth value in the representation of each number.
  uint a_n = 0;
  
  // Variable to hold the nth denominator in the representation of each number.
  uint d_n = 0;
  
  // Variable to hold the nth numerator in the representation of each number.
  uint m_n = 0;
  
  // Variable to hold the maximum size we have to look at.
  uint maxSize = 10000;
  
  // Variable to hold the current periods length.
  uint periodLength = 0;
  
  // Variable to hold the number of elements in the current representation.
  uint representationCount = 0;
  
  // Variable to hold the number of representations with odd period.
  uint representationsWithOddPeriod = 0;
  
  // Variable array to hold the a_n values of the current representation.
  uint representationA_N[500] = {0};
  
  // Variable array to hold the d_n values of the current representation.
  uint representationD_N[500] = {0};
  
  // Variable array to hold the m_n values of the current representation.
  uint representationM_N[500] = {0};
  
  // For all the numbers from 2 up to the maximum size,
  for(uint number = 2; number < maxSize; number++){
    // If the number is NOT a perfect sqaure,
    if([self isNumberAPerfectSquare:number] == NO){
      // Reset that a repeat has NOT been found.
      repeatFound = NO;
      
      // Set a_0 = floor(sqrt(number)).
      a_0 = ((uint)sqrt(((double)number)));
      
      // Set a_0 = a_0.
      a_n = a_0;
      
      // Set d_0 = 1.
      d_n = 1;
      
      // Set m_0 = 0.
      m_n = 0;
      
      // Reset the number of elements in the representation to 0.
      representationCount = 0;
      
      // While a repeat has NOT been found,
      while(repeatFound == NO){
        // Compute m_{n+1}.
        m_n = (d_n * a_n) - m_n;
        
        // Compute d_{n+1}.
        d_n = ((uint)((number - (m_n * m_n)) / d_n));
        
        // Compute a_{n+1}.
        a_n = ((uint)((a_0 + m_n) / d_n));
        
        // Store a_{n+1} in the representation array.
        representationA_N[representationCount] = a_n;
        
        // Store d_{n+1} in the representation array.
        representationD_N[representationCount] = d_n;
        
        // Store m_{n+1} in the representation array.
        representationM_N[representationCount] = m_n;
        
        // Increment the number of elements in the representation by 1.
        representationCount++;
        
        // If the number of elements in the representation is even,
        if((representationCount % 2) == 0){
          // Compute the current period length.
          periodLength = representationCount / 2;
          
          // Assume that a repeat HAS been found.
          repeatFound = YES;
          
          // For all the representations for the current period length,
          for(int i = 0; i < periodLength; i++){
            // If the current period does NOT have a match in one of the
            // variables representations,
            if(representationA_N[i] != representationA_N[(i + periodLength)] ||
               representationD_N[i] != representationD_N[(i + periodLength)] ||
               representationM_N[i] != representationM_N[(i + periodLength)]){
              
              // Mark that the repeat is still NOT found.
              repeatFound = NO;
              
              // Break out of the loop.
              break;
            }
          }
        }
      }
      // If the current period length is odd,
      if((periodLength % 2) == 1){
        // Increment the number of representations with odd period by 1.
        representationsWithOddPeriod++;
      }
    }
  }
  // Set the answer string to the number of representations with odd period.
  self.answer = [NSString stringWithFormat:@"%d", representationsWithOddPeriod];
  
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