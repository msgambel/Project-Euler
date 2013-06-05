//  Question88.m

#import "Question88.h"

@implementation Question88

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 February 2005";
  self.text = @"A natural number, N, that can be written as the sum and product of a given set of at least two natural numbers, {a1, a2, ... , ak} is called a product-sum number: N = a1 + a2 + ... + ak = a1  a2  ...  ak.\n\nFor example, 6 = 1 + 2 + 3 = 1 x 2 x 3.\n\nFor a given set of size, k, we shall call the smallest N with this property a minimal product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6 are as follows.\n\nk=2: 4 = 2 x 2 = 2 + 2\nk=3: 6 = 1 x 2 x 3 = 1 + 2 + 3\nk=4: 8 = 1 x 1 x 2 x 4 = 1 + 1 + 2 + 4\nk=5: 8 = 1 x 1 x 2 x 2  2 = 1 + 1 + 2 + 2 + 2\nk=6: 12 = 1 x 1 x 1 x 1 x 2 x 6 = 1 + 1 + 1 + 1 + 2 + 6\n\nHence for 2 <= k <= 6, the sum of all the minimal product-sum numbers is 4+6+8+12 = 30; note that 8 is only counted once in the sum.\n\nIn fact, as the complete set of minimal product-sum numbers for 2 <= k <= 12 is {4, 6, 8, 12, 15, 16}, the sum is 61.\n\nWhat is the sum of all the minimal product-sum numbers for 2 <= k <= 12000?";
  self.title = @"Product-sum numbers";
  self.answer = @"7587457";
  self.number = @"88";
  self.keywords = @"minimal,product,sum,recursive,product,k";
  self.estimatedComputationTime = @"0.881";
  self.estimatedBruteForceComputationTime = @"0.881";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply
  
  // Variable to mark the maximum size of the minimal product-sum numbers to
  // examine.
  const uint maxSize = 12000;
  
  BOOL shouldAddNumber = NO;
  
  uint k = 0;
  
  uint sumOfFactors = 0;
  
  uint currentNumber = 0;
  
  uint currentSquareRoot = 0;
  
  uint totalMinimalProductSum = 4;
  
  uint minimalProductSums[(maxSize + 1)] = {0};
  
  minimalProductSums[2] = 4;
  
  NSMutableArray * sumOfFactorsArray = [[NSMutableArray alloc] initWithCapacity:maxSize];
  
  NSMutableArray * factorsForNumber = nil;
  
  NSMutableArray * currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
  
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  for(int i = 0; i < 3; i++){
    currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil];
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
  
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  for(int n = 5; n <= (1.1 * maxSize); n++){
    if([self isPrime:n]){
      currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(n-1)], nil];
    }
    else{
      shouldAddNumber = NO;
      currentNumber = n;
      currentSquareRoot = ((uint)sqrt((double)n));
      currentFactorsForNumber = [[NSMutableArray alloc] init];
      
      for(int factor = 2; factor <= currentSquareRoot; factor++){
        if((n % factor) == 0){
          currentNumber = n / factor;
          
          factorsForNumber = [sumOfFactorsArray objectAtIndex:currentNumber];
          
          for(NSNumber * number in factorsForNumber){
            sumOfFactors = [number intValue] + (factor - 1);
            
            if(n > sumOfFactors){
              k = n - sumOfFactors;
              
              if(k <= maxSize){
                if(minimalProductSums[k] == 0){
                  minimalProductSums[k] = n;
                  shouldAddNumber = YES;
                }
                
              }
              [currentFactorsForNumber addObject:[NSNumber numberWithInt:sumOfFactors]];
            }
          }
        }
      }
      if(shouldAddNumber){
        totalMinimalProductSum += n;
      }
      [currentFactorsForNumber addObject:[NSNumber numberWithInt:(n-1)]];
    }
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Set the answer string to the.
  self.answer = [NSString stringWithFormat:@"%d", totalMinimalProductSum];
  
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
  
  // Here, we simply
  
  const uint maxSize = 12000;
  
  BOOL shouldAddNumber = NO;
  
  uint k = 0;
  
  uint sumOfFactors = 0;
  
  uint currentNumber = 0;
  
  uint currentSquareRoot = 0;
  
  uint totalMinimalProductSum = 4;
  
  uint minimalProductSums[(maxSize + 1)] = {0};
  
  minimalProductSums[2] = 4;
  
  NSMutableArray * sumOfFactorsArray = [[NSMutableArray alloc] initWithCapacity:maxSize];
  
  NSMutableArray * factorsForNumber = nil;
  
  NSMutableArray * currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
  
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  for(int i = 0; i < 3; i++){
    currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil];
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
  
  [sumOfFactorsArray addObject:currentFactorsForNumber];
  
  for(int n = 5; n <= (1.1 * maxSize); n++){
    if([self isPrime:n]){
      currentFactorsForNumber = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(n-1)], nil];
    }
    else{
      shouldAddNumber = NO;
      currentNumber = n;
      currentSquareRoot = ((uint)sqrt((double)n));
      currentFactorsForNumber = [[NSMutableArray alloc] init];
      
      for(int factor = 2; factor <= currentSquareRoot; factor++){
        if((n % factor) == 0){
          currentNumber = n / factor;
          
          factorsForNumber = [sumOfFactorsArray objectAtIndex:currentNumber];
          
          for(NSNumber * number in factorsForNumber){
            sumOfFactors = [number intValue] + (factor - 1);
            
            if(n > sumOfFactors){
              k = n - sumOfFactors;
              
              if(k <= maxSize){
                if(minimalProductSums[k] == 0){
                  minimalProductSums[k] = n;
                  shouldAddNumber = YES;
                }
              
            }
            [currentFactorsForNumber addObject:[NSNumber numberWithInt:sumOfFactors]];
          }
        }
      }
    }
    if(shouldAddNumber){
      totalMinimalProductSum += n;
    }
      [currentFactorsForNumber addObject:[NSNumber numberWithInt:(n-1)]];
    }
    [sumOfFactorsArray addObject:currentFactorsForNumber];
  }
  // Set the answer string to the.
  self.answer = [NSString stringWithFormat:@"%d", totalMinimalProductSum];
  
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