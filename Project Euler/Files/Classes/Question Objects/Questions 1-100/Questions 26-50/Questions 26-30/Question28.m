//  Question28.m

#import "Question28.h"

@implementation Question28

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"11 October 2002";
  self.text = @"Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:\n\n21 22 23 24 25\n20  7  8  9 10\n19  6  1  2 11\n18  5  4  3 12\n17 16 15 14 13\n\nIt can be verified that the sum of the numbers on the diagonals is 101.\n\nWhat is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?";
  self.title = @"Number spiral diagonals";
  self.answer = @"669171001";
  self.number = @"28";
  self.keywords = @"corner,side,length,spiral,diagonals,clockwise,direction";
  self.estimatedComputationTime = @"2.9e-05";
  self.estimatedBruteForceComputationTime = @"3.1e-05";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute the top right hand corner number of each box,
  // starting from the box with side length 3, and add each of the corners values
  // to the sum. We simply compute the top right hand corner's value, and subtract
  // off the edge length's in order to compute the values in the other three
  // corners. Otherwise, this is the same algorithm as the brute force method.
  
  // Variable to hold sum of all the values along the diagonals in the box. Set
  // the sum to 1 (the centre) before we start iterating over all the numbers.
  long long int sum = 1;
  
  // Variable to hold the edge length of the numbers.
  uint edgeLength = 0;
  
  // Variable to hold the largest edge length of the box in question.
  uint maxSideLength = 1001;
  
  // Variable to hold the top right corner number in the box.
  uint topRightCornerNumber = 0;
  
  // For all the odd side lengths up to the maximum side length,
  for(uint sideLength = 3; sideLength <= maxSideLength; sideLength += 2){
    // Compute the top right corner numbers value. It's the square of the side length!
    topRightCornerNumber = sideLength * sideLength;
    
    // Compute the edge length of the box.
    edgeLength = sideLength - 1;
    
    // Add to the sum the top right hand corner number.
    sum += topRightCornerNumber;
    
    // Add to the sum the top left hand corner number.
    sum += (topRightCornerNumber - edgeLength);
    
    // Add to the sum the bottom left hand corner number.
    sum += (topRightCornerNumber - (2 * edgeLength));
    
    // Add to the sum the bottom right hand corner number.
    sum += (topRightCornerNumber - (3 * edgeLength));
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
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
  
  // Here, we simply compute the top right hand corner number of each box,
  // starting from the box with side length 3, and add each of the corners values
  // to the sum.
  
  // Variable to hold sum of all the values along the diagonals in the box. Set
  // the sum to 1 (the centre) before we start iterating over all the numbers.
  long long int sum = 1;
  
  // Variable to hold the edge length of the numbers.
  uint edgeLength = 0;
  
  // Variable to hold the largest edge length of the box in question.
  uint maxSideLength = 1001;
  
  // Variable to hold the top right corner number in the box.
  uint topRightCornerNumber = 0;
  
  // Variable to hold the first inner top right corner number in the box.
  uint innerTopRightCornerNumber = 0;
  
  // Variable to hold the total number of numbers on the perimeter of the box.
  uint totalCountOfNumbersOnEdges = 0;
  
  // For all the odd side lengths up to the maximum side length,
  for(uint sideLength = 3; sideLength <= maxSideLength; sideLength += 2){
    // Compute the top right corner numbers value. It's the square of the side length!
    topRightCornerNumber = sideLength * sideLength;
    
    // Compute the inner top right corner numbers value. It's the square of the
    // inner side length!
    innerTopRightCornerNumber = (sideLength - 2) * (sideLength - 2);
    
    // Compute the total number of numbers on the perimter of the box.
    totalCountOfNumbersOnEdges = topRightCornerNumber - innerTopRightCornerNumber;
    
    // Compute the edge length of the box.
    edgeLength = totalCountOfNumbersOnEdges / 4;
    
    // Add to the sum the top right hand corner number.
    sum += topRightCornerNumber;
    
    // Add to the sum the top left hand corner number.
    sum += (topRightCornerNumber - edgeLength);
    
    // Add to the sum the bottom left hand corner number.
    sum += (topRightCornerNumber - (2 * edgeLength));
    
    // Add to the sum the bottom right hand corner number.
    sum += (topRightCornerNumber - (3 * edgeLength));
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
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