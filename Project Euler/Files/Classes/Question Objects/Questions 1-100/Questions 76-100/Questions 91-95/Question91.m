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
  self.text = @"The points P (x1, y1) and Q (x2, y2) are plotted at integer co-ordinates and are joined to the origin, O(0,0), to form ΔOPQ.\n\nMissing Image!!!\n\nThere are exactly fourteen triangles containing a right angle that can be formed when each co-ordinate lies between 0 and 2 inclusive; that is,\n\n0 <= x1, y1, x2, y2 <= 2.\n\nMissing Images!!!\n\nGiven that 0 <= x1, y1, x2, y2 <= 50, how many right triangles can be formed?";
  self.title = @"Right triangles with integer coordinates";
  self.answer = @"14234";
  self.number = @"Problem 91";
  self.estimatedComputationTime = @"0.105";
  self.estimatedBruteForceComputationTime = @"0.105";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply
  
  // Variable to hold the sidelength of the grid we are looking at.
  uint sideLength = 50;
  
  // Variable to hold the total number of right triangles.
  uint totalRightTriangles = 3 * sideLength * sideLength;
  
  float slope1 = 0;
  
  float slope2Inverse = 0;
  
  for(int x1 = 0; x1 <= sideLength; x1++){
    for(int y1 = 0; y1 <= sideLength; y1++){
      for(int x2 = 0; x2 <= sideLength; x2++){
        for(int y2 = 0; y2 <= sideLength; y2++){
          // Make sure the points don't lie on the same line.
          if((x1 * y2 - x2 * y1) != 0){
            // Make sure there's no division by 0 errors.
            if((x1 != 0) && (y1 != 0)){
              slope1 = (((float)(y2 - y1)) / ((float)(x1)));
              
              slope2Inverse = (((float)(x2 - x1)) / ((float)y1));
              
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
  
  // Variable to hold the sidelength of the grid we are looking at.
  uint sideLength = 50;
  
  // Variable to hold the total number of right triangles.
  uint totalRightTriangles = 3 * sideLength * sideLength;
  
  float slope1 = 0;
  
  float slope2Inverse = 0;
  
  for(int x1 = 0; x1 <= sideLength; x1++){
    for(int y1 = 0; y1 <= sideLength; y1++){
      for(int x2 = 0; x2 <= sideLength; x2++){
        for(int y2 = 0; y2 <= sideLength; y2++){
          // Make sure the points don't lie on the same line.
          if((x1 * y2 - x2 * y1) != 0){
            // Make sure there's no division by 0 errors.
            if((x1 != 0) && (y1 != 0)){
              slope1 = (((float)(y2 - y1)) / ((float)(x1)));
              
              slope2Inverse = (((float)(x2 - x1)) / ((float)y1));
              
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