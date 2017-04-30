//  Question39.m

#import "Question39.h"

@implementation Question39

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"14 March 2003";
  self.hint = @"Without loss of generality, a < b < c.";
  self.link = @"https://en.wikipedia.org/wiki/Triangle#Right_triangles";
  self.text = @"If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.\n\n{20,48,52}, {24,45,51}, {30,40,50}\n\nFor which value of p <= 1000, is the number of solutions maximised?";
  self.isFun = YES;
  self.title = @"Integer right triangles";
  self.answer = @"840";
  self.number = @"39";
  self.rating = @"4";
  self.category = @"Combinations";
  self.keywords = @"pythagorean,triple,perimeter,right,angle,length,sides,maximized,integral,1000,one,thousand,solutions,integer,triangles,pair,maximum";
  self.solveTime = @"60";
  self.difficulty = @"Easy";
  self.isChallenging = NO;
  self.completedOnDate = @"08/02/13";
  self.solutionLineCount = @"27";
  self.estimatedComputationTime = @"2.43e-03";
  self.estimatedBruteForceComputationTime = @"2.43e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply check if a pair (a, b) generates a pythagorean triple, and
  // if it does, compute the perimeter, and increment the number of pythagorean
  // triples with that perimeter by 1. Then we check all the perimeters up to
  // the maximum perimeter to see which perimeter has the most pythagorean
  // triples associated with it.
  
  // Variable to hold the computed hypotenuse of the current pair (a, b).
  uint c = 0;
  
  // Variable to hold the perimeter of the current triple (a, b, c).
  uint perimeter = 0;
  
  // Variable to hold the max perimeter to check up to.
  uint maxPerimeter = 1000;
  
  // Variable to hold the max size of the a's to check. Since the perimeter is
  // equal to a + b + c, and a < b < c, then the largest a can be is a third
  // (1/3) of the perimeter.
  uint maximumAToCheck = ((uint)(maxPerimeter / 3));
  
  // Variable to hold the max size of the b's to check. Since the perimeter is
  // equal to a + b + c, and a < b < c, then the largest b can be is a half
  // (1/2) of the perimeter, as a can be small.
  uint maximumBToCheck = ((uint)(maxPerimeter / 2));
  
  // Variable to hold the index of the perimeter with the most pythagorean
  // triples associated with it.
  uint maxPerimaterIndex = 0;
  
  // Variable to hold the perimeter with the most pythagorean triples associated
  // with it.
  uint maxPerimaterTotal = 0;
  
  // Variable array to hold the the number of pythagorean triples associated
  // with it.
  uint perimeterTotals[(maxPerimeter + 1)];
  
  // For all the possible perimeters to check,
  for(int i = 0; i <= maxPerimeter; i++){
    // Set the number of pythagorean triples associated with it to 0.
    perimeterTotals[i] = 0;
  }
  // For all the a's of the pythagorean triples,
  for(int a = 3; a < maximumAToCheck; a++){
    // For all the b's of the pythagorean triples,
    for(int b = (a + 1); b < maximumBToCheck; b++){
      // Compute the hypotenuse².
      c = (a * a) + (b * b);
      
      // Compute the perimeter of the current triangle.
      perimeter = ((uint)sqrt(c)) + a + b;
      
      // If the perimeter to check is NOT valid.
      if(perimeter > 1000){
        // Break out of the loop.
        break;
      }
      // If the hypotenuse is a perfect sqaure,
      if([self isNumberAPerfectSquare:c]){
        // The triple (a, b, c) is a pythagorean triple, so increment the number
        // of pythagorean triples associated with the perimeter by 1.
        perimeterTotals[perimeter]++;
      }
    }
  }
  // For all the possible perimeters to check,
  for(int index = 0; index <= maxPerimeter; index++){
    // If the current perimeter has more pythagorean triples associated with it
    // than the perimeter with the current maximum,
    if(perimeterTotals[index] > maxPerimaterTotal){
      // Set the maximum number of pythagorean triples to the number associated
      // with the curent perimeter.
      maxPerimaterTotal = perimeterTotals[index];
      
      // Set the maximum perimeter index to the current index.
      maxPerimaterIndex = index;
    }
  }
  // Set the answer string to the maximum perimeter index.
  self.answer = [NSString stringWithFormat:@"%d", maxPerimaterIndex];
  
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
  
  // Here, we simply check if a pair (a, b) generates a pythagorean triple, and
  // if it does, compute the perimeter, and increment the number of pythagorean
  // triples with that perimeter by 1. Then we check all the perimeters up to
  // the maximum perimeter to see which perimeter has the most pythagorean
  // triples associated with it.
  
  // Variable to hold the computed hypotenuse of the current pair (a, b).
  uint c = 0;
  
  // Variable to hold the perimeter of the current triple (a, b, c).
  uint perimeter = 0;
  
  // Variable to hold the max perimeter to check up to.
  uint maxPerimeter = 1000;
  
  // Variable to hold the max size of the a's to check. Since the perimeter is
  // equal to a + b + c, and a < b < c, then the largest a can be is a third
  // (1/3) of the perimeter.
  uint maximumAToCheck = ((uint)(maxPerimeter / 3));
  
  // Variable to hold the max size of the b's to check. Since the perimeter is
  // equal to a + b + c, and a < b < c, then the largest a can be is a half
  // (1/2) of the perimeter, as a can be small.
  uint maximumBToCheck = ((uint)(maxPerimeter / 2));
  
  // Variable to hold the index of the perimeter with the most pythagorean
  // triples associated with it.
  uint maxPerimaterIndex = 0;
  
  // Variable to hold the perimeter with the most pythagorean triples associated
  // with it.
  uint maxPerimaterTotal = 0;
  
  // Variable array to hold the the number of pythagorean triples associated
  // with it.
  uint perimeterTotals[(maxPerimeter + 1)];
  
  // For all the possible perimeters to check,
  for(int i = 0; i <= maxPerimeter; i++){
    // Set the number of pythagorean triples associated with it to 0.
    perimeterTotals[i] = 0;
  }
  // For all the a's of the pythagorean triples,
  for(int a = 3; a < maximumAToCheck; a++){
    // For all the b's of the pythagorean triples,
    for(int b = (a + 1); b < maximumBToCheck; b++){
      // Compute the hypotenuse².
      c = (a * a) + (b * b);
      
      // Compute the perimeter of the current triangle.
      perimeter = ((uint)sqrt(c)) + a + b;
      
      // If the perimeter to check is NOT valid.
      if(perimeter > 1000){
        // Break out of the loop.
        break;
      }
      // If the hypotenuse is a perfect sqaure,
      if([self isNumberAPerfectSquare:c]){
        // The triple (a, b, c) is a pythagorean triple, so increment the number
        // of pythagorean triples associated with the perimeter by 1.
        perimeterTotals[perimeter]++;
      }
    }
  }
  // For all the possible perimeters to check,
  for(int index = 0; index <= maxPerimeter; index++){
    // If the current perimeter has more pythagorean triples associated with it
    // than the perimeter with the current maximum,
    if(perimeterTotals[index] > maxPerimaterTotal){
      // Set the maximum number of pythagorean triples to the number associated
      // with the curent perimeter.
      maxPerimaterTotal = perimeterTotals[index];
      
      // Set the maximum perimeter index to the current index.
      maxPerimaterIndex = index;
    }
  }
  // Set the answer string to the maximum perimeter index.
  self.answer = [NSString stringWithFormat:@"%d", maxPerimaterIndex];
  
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