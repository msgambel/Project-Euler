//  Question66.m

#import "Question66.h"

@implementation Question66

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"26 March 2004";
  self.hint = @"Use Pell's Equation.";
  self.link = @"http://mathworld.wolfram.com/PellEquation.html";
  self.text = @"Consider quadratic Diophantine equations of the form:\n\nx² – Dy² = 1\n\nFor example, when D=13, the minimal solution in x is 649² – 131*80² = 1.\n\nIt can be assumed that there are no solutions in positive integers when D is square.\n\nBy finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:\n\n3² – 2*2² = 1\n2² – 3*1² = 1\n9² – 5*4² = 1\n5² – 6*2² = 1\n8² – 7*3² = 1\n\nHence, by considering minimal solutions in x for D <= 7, the largest x is obtained when D=5.\n\nFind the value of D <= 1000 in minimal solutions of x for which the largest value of x is obtained.";
  self.isFun = YES;
  self.title = @"Diophantine equation";
  self.answer = @"661";
  self.number = @"66";
  self.rating = @"3";
  self.category = @"Patterns";
  self.keywords = @"diophantine,equations,continued,fractions,expansions,pells,periods,minimal,solutions,largest,value,quadratic,length";
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.commentCount = @"49";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"07/03/13";
  self.educationLevel = @"Undergraduate";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"07/03/13";
  self.solutionLineCount = @"47";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"6.31e-04";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"6.31e-04";
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
  //
  // Now, what to do with the period length? Well, we can just use the solution
  // to Pell's Equation. For a more detailed explaination, visit:
  //
  // http://mathworld.wolfram.com/PellEquation.html
  //
  // Essentially, we only need to store the maximum periods length! Since the
  // larger the period, the larger the solution to the Pell's Equation. We make
  // note of the fact that if the period length is odd, then the solution is
  // (p_r, q_r), and even is (p_{2r+1}, q_{2r+1}). In our case, odd and even
  // are switched, as they include 2a_0 in the length, and we do not.
  //
  // Therefore, it is a simple matter of storing which number generates the
  // largest period!
  
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
  uint maxSize = 1000;
  
  // Variable to hold the current periods length.
  uint periodLength = 0;
  
  // Variable to hold the maximum period found.
  uint maximumPeriod = 0;
  
  // Variable to hold the number of elements in the current representation.
  uint representationCount = 0;
  
  // Variable to hold the number that generates the maximum period.
  uint maximumPeriodNumber = 0;
  
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
        // Multiply the period's length by 2, since the minimum is 2r+1 when r
        // is odd.
        periodLength *= 2;
      }
      // If the period length is greater than or equal to the maximum period
      // length (we check equals to as well, as the larger the number, the
      // larger the decimal expansions value),
      if(periodLength >= maximumPeriod){
        // Set the maximum periods length to the current periods length.
        maximumPeriod = periodLength;
        
        // Set the number with the maximum period length to the current number.
        maximumPeriodNumber = number;
      }
    }
  }
  // Set the answer string to the number with the maximum period length.
  self.answer = [NSString stringWithFormat:@"%d", maximumPeriodNumber];
  
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
  //
  // Now, what to do with the period length? Well, we can just use the solution
  // to Pell's Equation. For a more detailed explaination, visit:
  //
  // http://mathworld.wolfram.com/PellEquation.html
  //
  // Essentially, we only need to store the maximum periods length! Since the
  // larger the period, the larger the solution to the Pell's Equation. We make
  // note of the fact that if the period length is odd, then the solution is
  // (p_r, q_r), and even is (p_{2r+1}, q_{2r+1}). In our case, odd and even
  // are switched, as they include 2a_0 in the length, and we do not.
  //
  // Therefore, it is a simple matter of storing which number generates the
  // largest period!
  
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
  uint maxSize = 1000;
  
  // Variable to hold the current periods length.
  uint periodLength = 0;
  
  // Variable to hold the maximum period found.
  uint maximumPeriod = 0;
  
  // Variable to hold the number of elements in the current representation.
  uint representationCount = 0;
  
  // Variable to hold the number that generates the maximum period.
  uint maximumPeriodNumber = 0;
  
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
        // Multiply the period's length by 2, since the minimum is 2r+1 when r
        // is odd.
        periodLength *= 2;
      }
      // If the period length is greater than or equal to the maximum period
      // length (we check equals to as well, as the larger the number, the
      // larger the decimal expansions value),
      if(periodLength >= maximumPeriod){
        // Set the maximum periods length to the current periods length.
        maximumPeriod = periodLength;
        
        // Set the number with the maximum period length to the current number.
        maximumPeriodNumber = number;
      }
    }
  }
  // Set the answer string to the number with the maximum period length.
  self.answer = [NSString stringWithFormat:@"%d", maximumPeriodNumber];
  
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