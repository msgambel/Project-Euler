//  Question91.m

#import "Question91.h"

@implementation Question91

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"18 March 2005";
  self.hint = @"The inner product of two orthogonal vectors is 0.";
  self.link = @"https://en.wikipedia.org/wiki/Pythagorean_theorem";
  self.text = @"The points P (x1, y1) and Q (x2, y2) are plotted at integer co-ordinates and are joined to the origin, O(0,0), to form ΔOPQ.\n\nMissing Image!!!\n\nThere are exactly fourteen triangles containing a right angle that can be formed when each co-ordinate lies between 0 and 2 inclusive; that is,\n\n0 <= x1, y1, x2, y2 <= 2.\n\nMissing Images!!!\n\nGiven that 0 <= x1, y1, x2, y2 <= 50, how many right triangles can be formed?";
  self.isFun = YES;
  self.title = @"Right triangles with integer coordinates";
  self.answer = @"14234";
  self.number = @"91";
  self.rating = @"4";
  self.category = @"Counting";
  self.keywords = @"right,triangles,with,integer,coordinates,vectors,inner,product,orthogonal,points,formed";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"22";
  self.isChallenging = NO;
  self.completedOnDate = @"01/04/13";
  self.solutionLineCount = @"15";
  self.estimatedComputationTime = @"0.105";
  self.estimatedBruteForceComputationTime = @"0.105";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the fact that the inner product of two orthogonal
  // vectors is 0. We iterate over all possbile points that form a triangle,
  // making sure that the points don't all lie on the same line. Wehn then
  // compute the inner product of the two lines to see if they are orthogonal,
  // and if they are, we increment the total number of right triangles by 1.
  //
  // The trivial cases are triangles of the form:
  //               ___
  //    /|        |  /        |\
  //   / |        | /         | \
  //  /__|        |/          |__\
  //
  // Since the point (0,0) must always be a point of the triangle. For a
  // sidelength of n, since there are n choices for the x coordinate, and n
  // choices for the y coordinate, and 3 possible configurations, there are
  // 3n² trivial cases.
  
  // Variable to hold the sidelength of the grid we are looking at.
  uint sideLength = 50;
  
  // Variable to hold the total number of right triangles. We add on the trivial
  // cases for ease of computation.
  uint totalRightTriangles = 3 * sideLength * sideLength;
  
  // Variable to compute the slope of the line from (x1,y1) to (x2,y2).
  float slope1 = 0;
  
  // Variable to compute the inverse of the slope of the line from (x1,y1) to
  // (x2,y2).
  float slope2Inverse = 0;
  
  // For all the x1's from 0 to the side length,
  for(int x1 = 0; x1 <= sideLength; x1++){
    // For all the y1's from 0 to the side length,
    for(int y1 = 0; y1 <= sideLength; y1++){
      // For all the x2's from 0 to the side length,
      for(int x2 = 0; x2 <= sideLength; x2++){
        // For all the y2's from 0 to the side length,
        for(int y2 = 0; y2 <= sideLength; y2++){
          // Make sure the points don't lie on the same line.
          if((x1 * y2 - x2 * y1) != 0){
            // Make sure there's no division by 0 errors.
            if((x1 != 0) && (y1 != 0)){
              // Compute the slope of the line from (x1,y1) to (x2,y2).
              slope1 = (((float)(y2 - y1)) / ((float)(x1)));
              
              // Compute the inverse of the slope of the line from (x1,y1) to
              // (x2,y2).
              slope2Inverse = (((float)(x2 - x1)) / ((float)y1));
              
              // If the inner product is equal to 0,
              if(((slope1 + slope2Inverse) == 0.0f)){
                // Increment the total number of right angle triangles by 1.
                totalRightTriangles++;
              }
            }
          }
        }
      }
    }
  }
  // Set the answer string to the total number of right triangles.
  self.answer = [NSString stringWithFormat:@"%d", totalRightTriangles];
  
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
  
  // Here, we simply use the fact that the inner product of two orthogonal
  // vectors is 0. We iterate over all possbile points that form a triangle,
  // making sure that the points don't all lie on the same line. Wehn then
  // compute the inner product of the two lines to see if they are orthogonal,
  // and if they are, we increment the total number of right triangles by 1.
  //
  // The trivial cases are triangles of the form:
  //               ___
  //    /|        |  /        |\
  //   / |        | /         | \
  //  /__|        |/          |__\
  //
  // Since the point (0,0) must always be a point of the triangle. For a
  // sidelength of n, since there are n choices for the x coordinate, and n
  // choices for the y coordinate, and 3 possible configurations, there are
  // 3n² trivial cases.
  
  // Variable to hold the sidelength of the grid we are looking at.
  uint sideLength = 50;
  
  // Variable to hold the total number of right triangles. We add on the trivial
  // cases for ease of computation.
  uint totalRightTriangles = 3 * sideLength * sideLength;
  
  // Variable to compute the slope of the line from (x1,y1) to (x2,y2).
  float slope1 = 0;
  
  // Variable to compute the inverse of the slope of the line from (x1,y1) to
  // (x2,y2).
  float slope2Inverse = 0;
  
  // For all the x1's from 0 to the side length,
  for(int x1 = 0; x1 <= sideLength; x1++){
    // For all the y1's from 0 to the side length,
    for(int y1 = 0; y1 <= sideLength; y1++){
      // For all the x2's from 0 to the side length,
      for(int x2 = 0; x2 <= sideLength; x2++){
        // For all the y2's from 0 to the side length,
        for(int y2 = 0; y2 <= sideLength; y2++){
          // Make sure the points don't lie on the same line.
          if((x1 * y2 - x2 * y1) != 0){
            // Make sure there's no division by 0 errors.
            if((x1 != 0) && (y1 != 0)){
              // Compute the slope of the line from (x1,y1) to (x2,y2).
              slope1 = (((float)(y2 - y1)) / ((float)(x1)));
              
              // Compute the inverse of the slope of the line from (x1,y1) to
              // (x2,y2).
              slope2Inverse = (((float)(x2 - x1)) / ((float)y1));
              
              // If the inner product is equal to 0,
              if(((slope1 + slope2Inverse) == 0.0f)){
                // Increment the total number of right angle triangles by 1.
                totalRightTriangles++;
              }
            }
          }
        }
      }
    }
  }
  // Set the answer string to the total number of right triangles.
  self.answer = [NSString stringWithFormat:@"%d", totalRightTriangles];
  
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