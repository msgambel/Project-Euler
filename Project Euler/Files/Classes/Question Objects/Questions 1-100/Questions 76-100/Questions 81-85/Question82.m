//  Question82.m

#import "Question82.h"

@implementation Question82

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"05 November 2004";
  self.hint = @"Store the values of each node in the matrix, and iterate backwards.";
  self.link = @"http://theory.stanford.edu/~amitp/GameProgramming/";
  self.text = @"NOTE: This problem is a more challenging version of Problem 81.\n\nThe minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column and finishing in any cell in the right column, and only moving up, down, and right, is indicated in red and bold; the sum is equal to 994.\n\n131	673	234	103	18\n201	96	342	965	150\n630	803	746	422	111\n537	699	497	121	956\n805	732	524	37	331\n\nFind the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the left column to the right column.";
  self.isFun = NO;
  self.title = @"Path sum: three ways";
  self.answer = @"260324";
  self.number = @"82";
  self.rating = @"3";
  self.category = @"Combinations";
  self.keywords = @"matrix,column,minimal,path,sum,import,file,right,left";
  self.solveTime = @"600";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.commentCount = @"31";
  self.attemptsCount = @"3";
  self.isChallenging = YES;
  self.startedOnDate = @"23/03/13";
  self.completedOnDate = @"23/03/13";
  self.solutionLineCount = @"23";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"7.9e-03";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"7.9e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply store the values of each node in a matrix. We then iterate
  // backwards, finding the shortest path from the current column to the column
  // to the right of it. We do this for each row in each column, as the start
  // point can be any row in the first column. We need to check if it is better
  // to move up and to the right, or down and to the right for each row in the
  // column, so we check for the minimum cost of moving up and then right, and
  // compare that with the minimum cost of moving down and right for each column
  // and row. Once that is found, we move to the next column to the left until
  // we reach the first column. This means we do not have to use an A* algorithm
  // like in Question 81!
  
  // Variable to hold the minimal path sum.
  uint minimalPathSum = 1000000000;
  
  // Variable to hold the minimal path sums for each row, as the starting point
  // could be any row of the first column.
  uint minimumColumnCost[80] = {0};
  
  // Variable array to hold the A* nodes constructed from the matrix in the file.
  uint matrix[80][80];
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion82" ofType:@"txt"];
  
  // Variable to hold the list of nodes as a string for parsing.
  NSString * nodesList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each node as a string in an array.
  NSArray * nodes = [nodesList componentsSeparatedByString:@"\n"];
  
  // Variable array to hold the node values in the rows array.
  NSArray * nodesInRow = nil;
  
  // For all the rows in in matrix in the file,
  for(int row = 0; row < 80; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(int column = 0; column < 80; column++){
      // Store the value of the node in the matrix.
      matrix[column][row] = [[nodesInRow objectAtIndex:column] intValue];
    }
  }
  // For each row in the first column,
  for(int row = 0; row < 80; row++){
    // Set the cost of moving right to the last column for the current row.
    minimumColumnCost[row] = matrix[79][row];
  }
  // For each column from right to left,
  for(int column = 78; column >= 0; column--){
    // Increment the cost of moving right to the last column for the first row.
    minimumColumnCost[0] += matrix[column][0];
    
    // For each row starting with the second row,
    for(int row = 1; row < 80; row++){
      // Store the cost of moving right to be the minimum of the previous row
      // and the current row.
      minimumColumnCost[row] = MIN(minimumColumnCost[row], minimumColumnCost[(row - 1)]);
      
      // Increment the cost of moving right by the current positions value.
      minimumColumnCost[row] +=  matrix[column][row];
    }
    // For each row from the bottom to the top,
    for(int row = 78; row >= 0; row--){
      // Store the cost of moving right to be the minimum of the next row and
      // its value, and the current row.
      minimumColumnCost[row] = MIN(minimumColumnCost[row], (minimumColumnCost[(row + 1)] + matrix[column][row]));
    }
  }
  // For all the rows in the matrix,
  for(int row = 0; row < 80; row++){
    // If the minimal path sum for this row is less than the minimal path sum
    // for the previous rows,
    if(minimumColumnCost[row] < minimalPathSum){
      // Set the minimal path sum to be the path sum of the current row.
      minimalPathSum = minimumColumnCost[row];
    }
  }
  // Set the answer string to the minimal path sum.
  self.answer = [NSString stringWithFormat:@"%d", minimalPathSum];
  
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
  
  // Here, we simply store the values of each node in a matrix. We then iterate
  // backwards, finding the shortest path from the current column to the column
  // to the right of it. We do this for each row in each column, as the start
  // point can be any row in the first column. We need to check if it is better
  // to move up and to the right, or down and to the right for each row in the
  // column, so we check for the minimum cost of moving up and then right, and
  // compare that with the minimum cost of moving down and right for each column
  // and row. Once that is found, we move to the next column to the left until
  // we reach the first column. This means we do not have to use an A* algorithm
  // like in Question 81!
  
  // Variable to hold the minimal path sum.
  uint minimalPathSum = 1000000000;
  
  // Variable to hold the minimal path sums for each row, as the starting point
  // could be any row of the first column.
  uint minimumColumnCost[80] = {0};
  
  // Variable array to hold the A* nodes constructed from the matrix in the file.
  uint matrix[80][80];
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion82" ofType:@"txt"];
  
  // Variable to hold the list of nodes as a string for parsing.
  NSString * nodesList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each node as a string in an array.
  NSArray * nodes = [nodesList componentsSeparatedByString:@"\n"];
  
  // Variable array to hold the node values in the rows array.
  NSArray * nodesInRow = nil;
  
  // For all the rows in in matrix in the file,
  for(int row = 0; row < 80; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(int column = 0; column < 80; column++){
      // Store the value of the node in the matrix.
      matrix[column][row] = [[nodesInRow objectAtIndex:column] intValue];
    }
  }
  // For each row in the first column,
  for(int row = 0; row < 80; row++){
    // Set the cost of moving right to the last column for the current row.
    minimumColumnCost[row] = matrix[79][row];
  }
  // For each column from right to left,
  for(int column = 78; column >= 0; column--){
    // Increment the cost of moving right to the last column for the first row.
    minimumColumnCost[0] += matrix[column][0];
    
    // For each row starting with the second row,
    for(int row = 1; row < 80; row++){
      // Store the cost of moving right to be the minimum of the previous row
      // and the current row.
      minimumColumnCost[row] = MIN(minimumColumnCost[row], minimumColumnCost[(row - 1)]);
      
      // Increment the cost of moving right by the current positions value.
      minimumColumnCost[row] +=  matrix[column][row];
    }
    // For each row from the bottom to the top,
    for(int row = 78; row >= 0; row--){
      // Store the cost of moving right to be the minimum of the next row and
      // its value, and the current row.
      minimumColumnCost[row] = MIN(minimumColumnCost[row], (minimumColumnCost[(row + 1)] + matrix[column][row]));
    }
  }
  // For all the rows in the matrix,
  for(int row = 0; row < 80; row++){
    // If the minimal path sum for this row is less than the minimal path sum
    // for the previous rows,
    if(minimumColumnCost[row] < minimalPathSum){
      // Set the minimal path sum to be the path sum of the current row.
      minimalPathSum = minimumColumnCost[row];
    }
  }
  // Set the answer string to the minimal path sum.
  self.answer = [NSString stringWithFormat:@"%d", minimalPathSum];
  
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