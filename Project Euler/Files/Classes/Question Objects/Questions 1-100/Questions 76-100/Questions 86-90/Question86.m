//  Question86.m

#import "Question86.h"
#import "Macros.h"

@implementation Question86

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"07 January 2005";
  self.hint = @"Unfold the cuboid into a 2D shape. Then use Pythagoras.";
  self.link = @"https://en.wikipedia.org/wiki/Pythagorean_theorem";
  self.text = @"A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly, F, sits in the opposite corner. By travelling on the surfaces of the room the shortest \"straight line\" distance from S to F is 10 and the path is shown on the diagram.\n\nMissing Image!\n\nHowever, there are up to three \"shortest\" path candidates for any given cuboid and the shortest route doesn't always have integer length.\n\nBy considering all cuboid rooms with integer dimensions, up to a maximum size of M by M by M, there are exactly 2060 cuboids for which the shortest route has integer length when M=100, and this is the least value of M for which the number of solutions first exceeds two thousand; the number of solutions is 1975 when M=99.\n\nFind the least value of M such that the number of solutions first exceeds one million.";
  self.isFun = YES;
  self.title = @"Cuboid route";
  self.answer = @"1818";
  self.number = @"86";
  self.rating = @"4";
  self.summary = @"Find the largest cube with side length M such that the set of cuboids with integer length shortest paths contained exceeds 1,000,000.";
  self.category = @"Optimization";
  self.isUseful = NO;
  self.keywords = @"spider,cuboid,shortest,route,path,pythagoras,side,length,one,million,1000000,surface,area,solutions,exceeds";
  self.loadsFile = NO;
  self.memorable = NO;
  self.solveTime = @"90";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"21";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"27/03/13";
  self.trickRequired = YES;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"27/03/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"17";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.129";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.129";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply notice that the shortest path traveled along the surface
  // area of the cuboid is:
  //
  //
  //                  (c)
  //        --------------------x
  //        |                /  |
  //     (a)|            /      |(a)
  // -----------------------------------
  // |      |       /           |      |
  // |   (b)|   /               |(b)   |
  // -------x---------------------------
  //        |         (c)       |
  //        |                   |
  //        ---------------------
  //        |                   |
  //        |                   |
  //        ---------------------
  //
  // Notice the (poorly drawn) line from x to x. It forms a right angle triangle
  // that we can use pythagoras on. Therefore, we have:
  //
  // (a + b)^2 + c^2 = (shortest path length)^2.
  //
  // Easy as pie!
  
  // Variable to hold the maximum side length of the cuboid.
  uint maximumSideLength = 1;
  
  // Variable to hold the maximum side length of the cuboid squared to save on
  // computation time.
  uint maximumSideLengthSquared = 0;
  
  // Variable to hold the number of integer solutions of the shortest path along
  // a cuboid of a given size.
  uint numberOfIntegerSolutions = 0;
  
  // Variable to hold the target number of integer solutions of the shortest
  // path along a cuboid of a given size.
  uint targetNumberOfIntegerSolutions = 1000000;
  
  // While the number of solutions of the shortest path along a cuboid of a
  // given size is less than the target number,
  while(numberOfIntegerSolutions < targetNumberOfIntegerSolutions){
    // Increment the maximum side length by 1.
    maximumSideLength++;
    
    // Compute the maximum side length squared.
    maximumSideLengthSquared = maximumSideLength * maximumSideLength;
    
    // For the sum of the two side lengths up to 2 times the maximum size,
    for(int sumSideLength = 2; sumSideLength < (2 * maximumSideLength); sumSideLength++){
      // If the shortest path is a perfect square,
      if([self isNumberAPerfectSquare:((sumSideLength * sumSideLength) + maximumSideLengthSquared)]){
        // If the sum of the two side lengths is greater than the maximum side
        // length,
        if(sumSideLength > maximumSideLength){
          // Add the number of ways we can add up the 2 side lengths together to
          // arrive at the same sum.
          numberOfIntegerSolutions += ((maximumSideLength - ((sumSideLength + 1) / 2)) + 1);
        }
        // If the sum of the two side lengths is less than or equal to the
        // maximum side length,
        else{
          // Add the number of ways we can add up the 2 side lengths together to
          // arrive at the same sum.
          numberOfIntegerSolutions += (sumSideLength / 2);
        }
      }
    }
  }
  // Set the answer string to the shortest path length.
  self.answer = [NSString stringWithFormat:@"%d", maximumSideLength];
  
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
  
  // Here, we simply notice that the shortest path traveled along the surface
  // area of the cuboid is:
  //
  //
  //                  (c)
  //        --------------------x
  //        |                /  |
  //     (a)|            /      |(a)
  // -----------------------------------
  // |      |       /           |      |
  // |   (b)|   /               |(b)   |
  // -------x---------------------------
  //        |         (c)       |
  //        |                   |
  //        ---------------------
  //        |                   |
  //        |                   |
  //        ---------------------
  //
  // Notice the (poorly drawn) line from x to x. It forms a right angle triangle
  // that we can use pythagoras on. Therefore, we have:
  //
  // (a + b)^2 + c^2 = (shortest path length)^2.
  //
  // Easy as pie!
  
  // Variable to hold the maximum side length of the cuboid.
  uint maximumSideLength = 1;
  
  // Variable to hold the maximum side length of the cuboid squared to save on
  // computation time.
  uint maximumSideLengthSquared = 0;
  
  // Variable to hold the number of integer solutions of the shortest path along
  // a cuboid of a given size.
  uint numberOfIntegerSolutions = 0;
  
  // Variable to hold the target number of integer solutions of the shortest
  // path along a cuboid of a given size.
  uint targetNumberOfIntegerSolutions = 1000000;
  
  // While the number of solutions of the shortest path along a cuboid of a
  // given size is less than the target number,
  while(numberOfIntegerSolutions < targetNumberOfIntegerSolutions){
    // Increment the maximum side length by 1.
    maximumSideLength++;
    
    // Compute the maximum side length squared.
    maximumSideLengthSquared = maximumSideLength * maximumSideLength;
    
    // For the sum of the two side lengths up to 2 times the maximum size,
    for(int sumSideLength = 2; sumSideLength < (2 * maximumSideLength); sumSideLength++){
      // If the shortest path is a perfect square,
      if([self isNumberAPerfectSquare:((sumSideLength * sumSideLength) + maximumSideLengthSquared)]){
        // If the sum of the two side lengths is greater than the maximum side
        // length,
        if(sumSideLength > maximumSideLength){
          // Add the number of ways we can add up the 2 side lengths together to
          // arrive at the same sum.
          numberOfIntegerSolutions += ((maximumSideLength - ((sumSideLength + 1) / 2)) + 1);
        }
        // If the sum of the two side lengths is less than or equal to the
        // maximum side length,
        else{
          // Add the number of ways we can add up the 2 side lengths together to
          // arrive at the same sum.
          numberOfIntegerSolutions += (sumSideLength / 2);
        }
      }
    }
  }
  // Set the answer string to the shortest path length.
  self.answer = [NSString stringWithFormat:@"%d", maximumSideLength];
  
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