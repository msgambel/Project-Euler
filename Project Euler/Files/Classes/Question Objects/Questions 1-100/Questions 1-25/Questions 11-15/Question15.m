//  Question15.m

#import "Question15.h"

@interface Question15 (Private)

- (long long int)numberOfPathsFromX:(uint)aX andY:(uint)aY sideLength:(uint)aSideLength;
- (long long int)numberOfPathsFromX:(uint)aX andY:(uint)aY sideLength:(uint)aSideLength offset:(uint)aOffset array:(long long int *)aArray;

@end

@implementation Question15

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 April 2002";
  self.hint = @"Store the precomputed path lengths in a 2D array.";
  self.link = @"https://en.wikipedia.org/wiki/Functional_programming";
  self.text = @"Starting in the top left corner of a 2x2 grid, there are 6 routes (without backtracking) to the bottom right corner.\n\nImages missing!\n\nHow many routes are there through a 20x20 grid?";
  self.isFun = YES;
  self.title = @"Lattice paths";
  self.answer = @"137846528820";
  self.number = @"15";
  self.rating = @"4";
  self.category = @"Combinations";
  self.keywords = @"routes,grid,lattice,paths,20,twenty,corner,bottom,right,recursive,method";
  self.solveTime = @"90";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.commentCount = @"19";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"15/01/13";
  self.solvableByHand = YES;
  self.completedOnDate = @"15/01/13";
  self.solutionLineCount = @"21";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"5.4e-05";
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = YES;
  self.estimatedBruteForceComputationTime = @"2.65e+04";
}

#pragma mark - Methods

// Variable to hold the side length of the paths. It is 21 and not 20 because
// we are using a 0 based array, and not a 1 based array.
#define ArrayLength 21

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We use a recursive method similar to the brute force method. We note that
  // once your path takes you to a point, the number of paths from that point
  // to the end is fixed. Therefore, if we precompute the number of paths and
  // store them in an array, we need only look up the stored value!
  //
  // One other thing to note is that the number of paths from (a,b) -> (n,n)
  // is equal to the number of paths from (a+1,b)->(n,n) plus the number of
  // paths from (a,b+1)->(n,n).
  
  // Variable to hold the number of paths.
  long long int numberOfPaths = 0;
  
  // Variable to hold the number of paths from a given point. We use a 1-dimensional
  // array in order to pass it to the helper method, so a bit of indexing tricks
  // need to be implemented.
  long long int aArray[ArrayLength * ArrayLength];
  
  // For all the elements in the array,
  for(int i = 0; i < ArrayLength * ArrayLength; i++){
    // Default it's value to 0.
    aArray[i] = 0;
  }
  // For all the paths (i, (ArrayLength - 1)) = (i, 20) (the rightmost column),
  for(int i = (ArrayLength - 1) * ArrayLength; i < ArrayLength * ArrayLength; i++){
    // Set the number of paths to the end from this point to 1.
    aArray[i] = 1;
  }
  // For all the paths ((ArrayLength - 1), i) = (20, i) (the bottom most row),
  for(int i = (ArrayLength - 1); i < ArrayLength * ArrayLength; i += ArrayLength){
    // Set the number of paths to the end from this point to 1.
    aArray[i] = 1;
  }
  // For all the different paths up to the ArrayLength (Note: this is the step to
  // precompute the paths from a given point. The only number we car about is the
  // last path, so we can simply store the returned number in the number of paths
  // variable, which will be overwritten on each pass),
  for(int i = 2; i < ArrayLength; i++){
    // Set the number of paths to be the returned value of the helper method.
    numberOfPaths = [self numberOfPathsFromX:0 andY:0 sideLength:i offset:((ArrayLength - 1) - i) array:aArray];
  }
  // Set the answer string to the number of paths.
  self.answer = [NSString stringWithFormat:@"%llu", numberOfPaths];
  
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
  
  // We simply have a helper method which will recursively compute the number of
  // paths from a given point. No optimizations are implemented, so it is VERY,
  // VERY slow.
  //
  // One other thing to note is that the number of paths from (a,b) -> (n,n)
  // is equal to the number of paths from (a+1,b)->(n,n) plus the number of
  // oaths from (a,b+1)->(n,n).
  
  // Variable to hold the number of paths.
  long long int numberOfPaths = [self numberOfPathsFromX:0 andY:0 sideLength:20];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the number of paths.
    self.answer = [NSString stringWithFormat:@"%llu", numberOfPaths];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated brute force computation time to the calculated value. We
    // use scientific notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question15 (Private)

- (long long int)numberOfPathsFromX:(uint)aX andY:(uint)aY sideLength:(uint)aSideLength; {
  // This helper method simply takes in a point and returns the number of paths
  // from the point to end. We note that if the point is on an edge, or is the
  // (19, 19) point, a value is returned. Otherwise, we return the number of
  // paths from the point to the right of this point, plus the number of paths
  // from the point underneath this point.
  
  // If the point is not valid,
  if((aX > aSideLength) || (aY > aSideLength)){
    // Make a note of it in the log.
    NSLog(@"You gave a point outside of the side length!");
    
    // Return 0, which effectively breaks out of the recursive loop.
    return 0;
  }
  // If we are no longer computing,
  if(!_isComputing){
    // Return 0, which effectively breaks out of the recursive loop.
    return 0;
  }
  // If the point is on the far right,
  if(aX == aSideLength){
    // Return 1, as there is only 1 path from the point to the end point.
    return 1;
  }
  // If the point is on the bottom,
  else if(aY == aSideLength){
    // Return 1, as there is only 1 path from the point to the end point.
    return 1;
  }
  // If the point is the (19, 19) point,
  else if((aX == (aSideLength - 1)) && (aY == (aSideLength - 1))){
    // Return 2, as there is only 2 path from the point to the end point.
    return 2;
  }
  // Otherwise,
  else{
    // Return the number of paths from the point to the right of this point,
    // plus the number of paths from the point underneath this point.
    return [self numberOfPathsFromX:(aX + 1) andY:aY sideLength:aSideLength] + [self numberOfPathsFromX:aX andY:(aY + 1) sideLength:aSideLength];
  }
}

- (long long int)numberOfPathsFromX:(uint)aX andY:(uint)aY sideLength:(uint)aSideLength offset:(uint)aOffset array:(long long int *)aArray; {
  // This helper method simply takes in a point and returns the number of paths
  // from the point to end. The trick is to take the precomputed values stored
  // in the array in order to avoid redundent computations. It is still a
  // recursive method, which checks if there is a precomputed value, and if there
  // isn't, we return the number of paths from the point to the right of this
  // point, plus the number of paths from the point underneath this point.
  
  // If the point is not valid,
  if((aX > aSideLength) || (aY > aSideLength)){
    // Make a note of it in the log.
    NSLog(@"You gave a point outside of the side length!");
    
    // Return 0, which effectively breaks out of the recursive loop.
    return 0;
  }
  // Compute the index of the point in the array.
  uint index = (aOffset * ArrayLength + aOffset) + (aY * ArrayLength) + aX;
  
  // If there already is a precomputed number of paths for this point,
  if(aArray[index] > 0){
    // Return the number of precomputed paths from this point to the end.
    return aArray[index];
  }
  // If there isn't already a precomputed number of paths for this point,
  else{
    // Add the number of paths from the point to the right of this point.
    aArray[index] += [self numberOfPathsFromX:(aX + 1) andY:aY sideLength:aSideLength offset:aOffset array:aArray];
    
    // Add the number of paths from the point underneath this point.
    aArray[index] += [self numberOfPathsFromX:aX andY:(aY + 1) sideLength:aSideLength offset:aOffset array:aArray];
    
    // Return the computed number of paths from this point to the end point.
    return aArray[index];
  }
}

@end