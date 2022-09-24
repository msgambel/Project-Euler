//  Question94.m

#import "Question94.h"

@implementation Question94

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"29 April 2005";
  self.hint = @"Pythagoras to the rescue!";
  self.link = @"https://en.wikipedia.org/wiki/Equilateral_triangle";
  self.text = @"It is easily proved that no equilateral triangle exists with integral length sides and integral area. However, the almost equilateral triangle 5-5-6 has an area of 12 square units.\n\nWe shall define an almost equilateral triangle to be a triangle for which two sides are equal and the third differs by no more than one unit.\n\nFind the sum of the perimeters of all almost equilateral triangles with integral side lengths and area and whose perimeters do not exceed one billion (1,000,000,000).";
  self.isFun = YES;
  self.title = @"Almost equilateral triangles";
  self.answer = @"518408346";
  self.number = @"94";
  self.rating = @"4";
  self.category = @"Sums";
  self.keywords = @"almost,equilateral,triangles,alternating,perimeters,sides,square,units,1000000000,one,billion,lengths,exceed,integral,area";
  self.solveTime = @"150";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"31";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"04/04/13";
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"04/04/13";
  self.solutionLineCount = @"25";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"0.819";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"15.3";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the fact that the almost equilateral triangles are
  // essentially a right triangle mirrored with itself. Therefore, computing the
  // area of the almost equilateral triangles boils down to computing the height
  // of one of the right triangles. Using a² + b² = c², we can compute the
  // height squared with a simple subtraction. If the height squared ends up
  // being a perfect square, then the area of the triangle must be an integer.
  //
  // In order to speed this up, we make note of a few observations:
  //
  // 1) The hypotenuse must be odd, since if it is even, the base must be odd,
  //    which implies the area of one of the right triangles is not an integer.
  //
  // 2) Once we find an almost equilateral triangle that is plus 1, the next one
  //    must be an almost equilateral triangle that is minus 1, as the angle
  //    between the hypotenuse and base is cyclic in its pattern.
  //
  // 3) Once we find an almost equilateral triangle, the next one must have a
  //    hypotenuse that is at least 3 times the length as the current one, as
  //    the next time the angle between the hypotenuse and base will only lead
  //    to a rational height with a larger enough increase.
  
  // Variable to mark if we are looking for a base with plus 1 or minus 1. Start
  // with plus 1, as 5,5,6 is the first almost equilateral triangle with this
  // porperty.
  BOOL lookingForPlus1 = YES;
  
  // Variable to hold the maximum size the hypotenuse can have, as the perimeter
  // must be less than 1,000,000,000.
  long long int maxSize = (uint)(1000000000 / 3);
  
  // Variable to hold half the base of the current almost equilateral triangle.
  long long int halfBase = 0;
  
  // Variable to hold the height squared of the current almost equilateral
  // triangle.
  long long int heightSquared = 0;
  
  // Variable to hold the sum of the perimeters of all the almost equilateral
  // triangles less than the maximum size.
  long long int sumOfAlmostEquilateralTrianglePerimeters = 0;
  
  // For all the hypotenuse's of the almost equilateral triangles,
  for(long long int hypotenuse = 3; hypotenuse < maxSize; hypotenuse += 2){
    // If we are looking for a base which is plus 1 the hypotenuse,
    if(lookingForPlus1){
      // Compute half the base of the current almost equilateral triangle.
      halfBase = (hypotenuse + 1) / 2;
      
      // Compute half the height squared of the current almost equilateral
      // triangle.
      heightSquared = (hypotenuse * hypotenuse) - (halfBase * halfBase);
      
      // If the height squared is a perfect square,
      if([self isNumberAPerfectSquare:heightSquared]){
        // Increment the sum of all the almost equilateral triangle perimeters
        // by the perimeter of the current almost equilateral triangle.
        sumOfAlmostEquilateralTrianglePerimeters += (hypotenuse + hypotenuse + halfBase + halfBase);
        
        // Mark that we are now looking for a base which is the hypotenuse minus 1.
        lookingForPlus1 = NO;
        
        // Multiply the current hypotenuse by 3, as none of the triangles
        // inbetween can have this property.
        hypotenuse *= 3;
      }
    }
    // If we are looking for a base which is minus 1 the hypotenuse,
    else{
      // Compute half the base of the current almost equilateral triangle.
      halfBase = (hypotenuse - 1) / 2;
      
      // Compute half the height squared of the current almost equilateral
      // triangle.
      heightSquared = (hypotenuse * hypotenuse) - (halfBase * halfBase);
      
      // If the height squared is a perfect square,
      if([self isNumberAPerfectSquare:heightSquared]){
        // Increment the sum of all the almost equilateral triangle perimeters
        // by the perimeter of the current almost equilateral triangle.
        sumOfAlmostEquilateralTrianglePerimeters += (hypotenuse + hypotenuse + halfBase + halfBase);
        
        // Mark that we are now looking for a base which is the hypotenuse plus 1.
        lookingForPlus1 = YES;
        
        // Multiply the current hypotenuse by 3, as none of the triangles
        // inbetween can have this property.
        hypotenuse *= 3;
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the sum of all the almost equilateral triangle
    // perimeters.
    self.answer = [NSString stringWithFormat:@"%llu", sumOfAlmostEquilateralTrianglePerimeters];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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
  
  // Note: This is basically the same algorithm as the optimal one. The only
  //       difference is we check every number, and don't use any optimizations.
  
  // Here, we simply use the fact that the almost equilateral triangles are
  // essentially a right triangle mirrored with itself. Therefore, computing the
  // area of the almost equilateral triangles boils down to computing the height
  // of one of the right triangles. Using a² + b² = c², we can compute the
  // height squared with a simple subtraction. If the height squared ends up
  // being a perfect square, then the area of the triangle must be an integer.
  
  // Variable to hold the maximum size the hypotenuse can have, as the perimeter
  // must be less than 1,000,000,000.
  long long int maxSize = (uint)(1000000000 / 3);
  
  // Variable to hold half the base of the current almost equilateral triangle.
  long long int halfBase = 0;
  
  // Variable to hold the height squared of the current almost equilateral
  // triangle.
  long long int heightSquared = 0;
  
  // Variable to hold the sum of the perimeters of all the almost equilateral
  // triangles less than the maximum size.
  long long int sumOfAlmostEquilateralTrianglePerimeters = 0;
  
  // For all the hypotenuse's of the almost equilateral triangles,
  for(long long int hypotenuse = 3; hypotenuse < maxSize; hypotenuse += 2){
    // Compute half the base of the current almost equilateral triangle.
    halfBase = (hypotenuse + 1) / 2;
    
    // Compute half the height squared of the current almost equilateral
    // triangle.
    heightSquared = (hypotenuse * hypotenuse) - (halfBase * halfBase);
    
    // If the height squared is a perfect square,
    if([self isNumberAPerfectSquare:heightSquared]){
      // Increment the sum of all the almost equilateral triangle perimeters
      // by the perimeter of the current almost equilateral triangle.
      sumOfAlmostEquilateralTrianglePerimeters += (hypotenuse + hypotenuse + halfBase + halfBase);
    }
    // Compute half the base of the current almost equilateral triangle.
    halfBase = (hypotenuse - 1) / 2;
    
    // Compute half the height squared of the current almost equilateral
    // triangle.
    heightSquared = (hypotenuse * hypotenuse) - (halfBase * halfBase);
    
    // If the height squared is a perfect square,
    if([self isNumberAPerfectSquare:heightSquared]){
      // Increment the sum of all the almost equilateral triangle perimeters
      // by the perimeter of the current almost equilateral triangle.
      sumOfAlmostEquilateralTrianglePerimeters += (hypotenuse + hypotenuse + halfBase + halfBase);
    }
  }
  // Set the answer string to the sum of all the almost equilateral triangle
  // perimeters.
  self.answer = [NSString stringWithFormat:@"%llu", sumOfAlmostEquilateralTrianglePerimeters];
  
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