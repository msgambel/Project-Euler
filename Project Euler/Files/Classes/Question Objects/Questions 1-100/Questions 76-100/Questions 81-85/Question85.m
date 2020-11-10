//  Question85.m

#import "Question85.h"
#import "Macros.h"

@implementation Question85

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"17 December 2004";
  self.hint = @"Use a recursive method that stores how many sub-rectangles a given rectangle has.";
  self.link = @"https://en.wikipedia.org/wiki/Triangular_number";
  self.text = @"By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains eighteen rectangles:\n\nImages Missing!\n\nAlthough there exists no rectangular grid that contains exactly two million rectangles, find the area of the grid with the nearest solution.";
  self.isFun = YES;
  self.title = @"Counting rectangles";
  self.answer = @"2772";
  self.number = @"85";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"rectangles,grid,size,counting,triangle,numbers,2000000,two,million,nearest,solution,area,sub";
  self.solveTime = @"300";
  self.technique = @"Math";
  self.difficulty = @"Medium";
  self.commentCount = @"21";
  self.attemptsCount = @"2";
  self.isChallenging = YES;
  self.startedOnDate = @"26/03/13";
  self.solvableByHand = YES;
  self.completedOnDate = @"26/03/13";
  self.solutionLineCount = @"13";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.13e-04";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.13e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply notice a simple pattern. Consider the grid 1x1. This has 1
  // sub-rectangle, of size 1x1. Now consider the grid 1x2. This has 2
  // sub-rectangles of size 1x1, but also another rectangle of size 1x2. Next,
  // consider the grid 1x3. This has 3 sub-rectangles of size 1x1, 2
  // sub-rectangles of size 1x2, and 1 sub-rectangle of size 1x3. Notice the
  // pattern. For a grid of size 1xn, there will be:
  //
  // n   sub-rectangles of size 1x1,
  // n-1 sub-rectangles of size 1x2,
  // n-2 sub-rectangles of size 1x3,
  //  .
  //  .
  //  .
  //  2 sub-rectangles of size 1x(n-1),
  //  1 sub-rectangles of size 1xn.
  //
  // But this sum is just the the nth Triangle number! Repeating the argument
  // for the width (multiplying the 2 values together), we arrive at:
  //
  // Sub-rectangles in grid widthxheight = Triangle(width) * Triangle(height).
  //
  // One thing we must make note of is the following; The question asks for the
  // grid with the number of sub-rectangles closest to the target number of
  // sub-rectangles. It does NOT say that the gird must have AT LEAST the number
  // of sub-rectangles in the target. Therefore, we must compute the distance
  // from the current number of sub-rectangles to the target, instead of just
  // checking if the current number of sub-rectangles is larger than the target.
  
  // Variable to hold the area of the grid with the closest number of
  // sub-rectangles to the target.
  uint closestArea = 0;
  
  // Variable to hold the number of sub-rectangles for a given width and height.
  uint numberOfRectangles = 0;
  
  // Variable to hold the distance from the number of sub-rectangles for the
  // current width and height to the target.
  uint distanceAwayFromTarget = 0;
  
  // Variable to hold the target number of sub-rectangles in a grid.
  uint targetNumberOfRectangles = 2000000;
  
  // Variable to hold the closest distance to the target found thus far.
  uint closestDistanceToTheTarget = targetNumberOfRectangles * 2;
  
  // Variable to hold the maximum width and height the grid can have. We take
  // the square root twice, as the number of sub-rectangles the grid will have
  // is approximately x⁴/4.
  uint maximumWidthAndHeight = (uint)sqrt(sqrt(targetNumberOfRectangles)) * 4;
  
  // For all the possible widths the grid could have,
  for(int width = 1; width < maximumWidthAndHeight; width++){
    // For all the possible heights the grid could have,
    for(int height = 1; height < maximumWidthAndHeight; height++){
      // Compute the number of sub-rectangles in the current grid. Recall that
      // the triangle numbers are equal to the sum of all the numbers from 1 to n.
      numberOfRectangles = TriangleNumber(width) * TriangleNumber(height);
      
      // Compute the distance of the current number of sub-rectangles to the
      // target number of sub-rectangles. This distance is an absolute value,
      // as the number of sub-rectangles could be less than the target, but
      // still closer to the target then any of the numbers greater than the
      // target.
      distanceAwayFromTarget = abs((int)numberOfRectangles - (int)targetNumberOfRectangles);
      
      // If the current distance is less than the closest distance to the target
      // found thus far,
      if(distanceAwayFromTarget < closestDistanceToTheTarget){
        // Set the current distance to be the closest distance found thus far.
        closestDistanceToTheTarget = distanceAwayFromTarget;
        
        // Store the area of the current grid that now has the closest number
        // of sub-rectangles to the target.
        closestArea = width * height;
      }
    }
  }
  // Set the answer string to area of the current grid that has the closest
  // number of sub-rectangles to the target.
  self.answer = [NSString stringWithFormat:@"%d", closestArea];
  
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
  
  // Here, we simply notice a simple pattern. Consider the grid 1x1. This has 1
  // sub-rectangle, of size 1x1. Now consider the grid 1x2. This has 2
  // sub-rectangles of size 1x1, but also another rectangle of size 1x2. Next,
  // consider the grid 1x3. This has 3 sub-rectangles of size 1x1, 2
  // sub-rectangles of size 1x2, and 1 sub-rectangle of size 1x3. Notice the
  // pattern. For a grid of size 1xn, there will be:
  //
  // n   sub-rectangles of size 1x1,
  // n-1 sub-rectangles of size 1x2,
  // n-2 sub-rectangles of size 1x3,
  //  .
  //  .
  //  .
  //  2 sub-rectangles of size 1x(n-1),
  //  1 sub-rectangles of size 1xn.
  //
  // But this sum is just the the nth Triangle number! Repeating the argument
  // for the width (multiplying the 2 values together), we arrive at:
  //
  // Sub-rectangles in grid widthxheight = Triangle(width) * Triangle(height).
  //
  // One thing we must make note of is the following; The question asks for the
  // grid with the number of sub-rectangles closest to the target number of
  // sub-rectangles. It does NOT say that the gird must have AT LEAST the number
  // of sub-rectangles in the target. Therefore, we must compute the distance
  // from the current number of sub-rectangles to the target, instead of just
  // checking if the current number of sub-rectangles is larger than the target.
  
  // Variable to hold the area of the grid with the closest number of
  // sub-rectangles to the target.
  uint closestArea = 0;
  
  // Variable to hold the number of sub-rectangles for a given width and height.
  uint numberOfRectangles = 0;
  
  // Variable to hold the distance from the number of sub-rectangles for the
  // current width and height to the target.
  uint distanceAwayFromTarget = 0;
  
  // Variable to hold the target number of sub-rectangles in a grid.
  uint targetNumberOfRectangles = 2000000;
  
  // Variable to hold the closest distance to the target found thus far.
  uint closestDistanceToTheTarget = targetNumberOfRectangles * 2;
  
  // Variable to hold the maximum width and height the grid can have. We take
  // the square root twice, as the number of sub-rectangles the grid will have
  // is approximately x⁴/4.
  uint maximumWidthAndHeight = (uint)sqrt(sqrt(targetNumberOfRectangles)) * 4;
  
  // For all the possible widths the grid could have,
  for(int width = 1; width < maximumWidthAndHeight; width++){
    // For all the possible heights the grid could have,
    for(int height = 1; height < maximumWidthAndHeight; height++){
      // Compute the number of sub-rectangles in the current grid. Recall that
      // the triangle numbers are equal to the sum of all the numbers from 1 to n.
      numberOfRectangles = TriangleNumber(width) * TriangleNumber(height);
      
      // Compute the distance of the current number of sub-rectangles to the
      // target number of sub-rectangles. This distance is an absolute value,
      // as the number of sub-rectangles could be less than the target, but
      // still closer to the target then any of the numbers greater than the
      // target.
      distanceAwayFromTarget = abs((int)numberOfRectangles - (int)targetNumberOfRectangles);
      
      // If the current distance is less than the closest distance to the target
      // found thus far,
      if(distanceAwayFromTarget < closestDistanceToTheTarget){
        // Set the current distance to be the closest distance found thus far.
        closestDistanceToTheTarget = distanceAwayFromTarget;
        
        // Store the area of the current grid that now has the closest number
        // of sub-rectangles to the target.
        closestArea = width * height;
      }
    }
  }
  // Set the answer string to area of the current grid that has the closest
  // number of sub-rectangles to the target.
  self.answer = [NSString stringWithFormat:@"%d", closestArea];
  
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