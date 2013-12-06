//  Question71.m

#import "Question71.h"

@implementation Question71

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 June 2004";
  self.text = @"Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.\n\nIf we list the set of reduced proper fractions for d <= 8 in ascending order of size, we get:\n\n1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8\n\nIt can be seen that 2/5 is the fraction immediately to the left of 3/7.\n\nBy listing the set of reduced proper fractions for d <= 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.";
  self.title = @"Ordered fractions";
  self.answer = @"428570";
  self.number = @"71";
  self.keywords = @"counting,fractions,reduced,proper,ascending,order,interval,positive,integers,numerator,left";
  self.estimatedComputationTime = @"1.87e-04";
  self.estimatedBruteForceComputationTime = @"127";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply do some basic algebra:
  //
  // Let a/b be the target fraction, and x/y be the cloest fraction less than
  // the target fraction is the given range. Then:
  //
  //       a   x    ay - bx
  //  1)   - - - =  -------
  //       b   y      by
  //
  // If we to minimize 1), we need to make the numerator 1, and the denominator
  // as large as possible. Therefore, we have:
  //
  //  2)   ay = 1 mod b.
  //
  // So the larger the y value is, the smaller the result will be, and the x
  // is computed accordingly. Therefore, we will start form the highest possible
  // denominator, working down until we satisfy 2), and then check to make sure
  // gcd(x,y) = 1. Then, we are done!
  
  // Variable to hold the current numerator during calculations.
  uint numerator = 0;
  
  // Variable to hold the maximum size the denominator can be.
  uint maxDenominator = 1000000;
  
  // Variable to hold the numerator of the closest fraction to our target fraction.
  uint closestNumerator = 0;
  
  // Variable to hold the target fractions numerator.
  uint targetFractionsNumerator = 3;
  
  // Variable to hold the target fractions denominator.
  uint targetFractionsDenominator = 7;
  
  // For all the denominators from the maximum size counting down to 0,
  for(uint denominator = maxDenominator; denominator > 0; denominator--){
    // Compute the top left part of the numerator.
    numerator = targetFractionsNumerator * denominator;
    
    // If the top left part of the numerator is congruent to 1 mod the
    // denominator of the target fraction,
    if((numerator % targetFractionsDenominator) == 1){
      // Subtract 1 from the top left part of the numerator.
      numerator--;
      
      // Divide the numerator by the target fraction denominator to get the
      // closest numerators value.
      numerator /= targetFractionsDenominator;
      
      // If the numerator is coprime to the denominator,
      if([self gcdOfA:numerator b:denominator] == 1){
        // Store the current numerator as the closest numerator.
        closestNumerator = numerator;
        
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the closest numerator.
  self.answer = [NSString stringWithFormat:@"%d", closestNumerator];
  
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
  
  // Here, we simply compute all the fractions for each denominator to see which
  // result gives the closest fraction that is less than the target fraction. To
  // make this a bit quicker, we use the fact that 2/5 is the cloest found thus
  // far in order to start at a minimum numerator which will skip a bunch of
  // numerators that will lead to fractions that are too small.
  
  // Variable to hold the minimum numerator.
  uint minNumerator = 0;
  
  // Variable to hold the maximum size the denominator can be.
  uint maxDenominator = 1000000;
  
  // Variable to hold the numerator of the closest fraction to our target fraction.
  uint closestNumerator = 0;
  
  // Variable to hold the target fraction.
  double targetFraction = 3.0 / 7.0;
  
  // Variable to hold the current distance between the target fraction and current
  // fraction.
  double currentDistance = 1.0;
  
  // Variable to hold the current fraction.
  double currentFraction = 0.0;
  
  // Variable to hold the smallest distance found.
  double smallestDistance = 1.0;
  
  // For all the possible denominators from 2 to the maximum size,
  for(uint denominator = 2; denominator <= maxDenominator; denominator++){
    // Compute the minimum numerator. (0.4 = 2/5, which was given in the question.)
    minNumerator = ((uint)(0.4 * ((double)denominator)));
    
    // For all the possbile numerators from the minimum numerator to the current
    // denominator,
    for(uint numerator = minNumerator; numerator <= denominator; numerator++){
      // Compute the current fraction.
      currentFraction = ((double)numerator) / ((double)denominator);
      
      // If the current fraction is less than the target fraction,
      if(currentFraction < targetFraction){
        // Compute the current distance from the current fraction to the target
        // fraction.
        currentDistance = targetFraction - currentFraction;
        
        // If the current distance is less than the smallest distance found,
        if(currentDistance < smallestDistance){
          // Set the smallest distance to be the current distance.
          smallestDistance = currentDistance;
          
          // Set the closest numerator to be the current numerator.
          closestNumerator = numerator;
        }
      }
      // If the current fraction is greater than or equal to the target fraction,
      else{
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the closest numerator.
  self.answer = [NSString stringWithFormat:@"%d", closestNumerator];
  
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