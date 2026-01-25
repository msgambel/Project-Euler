//  Question81.m

#import "Question81.h"
#import "AStarNode.h"

@implementation Question81

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"22 October 2004";
  self.hint = @"The A* algorithm works nicely here!";
  self.link = @"http://theory.stanford.edu/~amitp/GameProgramming/";
  self.text = @"In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in bold red and is equal to 2427.\n\n131	673	234	103	18\n201	96	342	965	150\n630	803	746	422	111\n537	699	497	121	956\n805	732	524	37	331\n\nFind the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.";
  self.isFun = YES;
  self.title = @"Path sum: two ways";
  self.answer = @"427337";
  self.number = @"81";
  self.rating = @"4";
  self.summary = @"Find the minimal path sum moving only right and down for the 80x80 grid.";
  self.category = @"Combinations";
  self.isUseful = YES;
  self.keywords = @"matrix,a*,a,star,minimal,path,sum,import,80,eighty,2,two,ways,files,matrix";
  self.loadsFile = YES;
  self.memorable = YES;
  self.solveTime = @"60";
  self.technique = @"OOP";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.isIntuitive = YES;
  self.recommended = YES;
  self.commentCount = @"77";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"22/03/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = YES;
  self.canBeSimplified = YES;
  self.completedOnDate = @"22/03/13";
  self.worthRevisiting = YES;
  self.solutionLineCount = @"69";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.solutionWorksInGeneral = YES;
  self.estimatedComputationTime = @"2.73e-02";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.73e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use an A* algorithm to find the best path. I'm not going to
  // claim this is the fastest implementation, or even the clearest. If you'd
  // like to learn more about the A* algorithm in general, visit:
  //
  // http://theory.stanford.edu/~amitp/GameProgramming/
  //
  // The only thing here that veers for the basic path is how we compute the
  // heuristic. Since we know that the path along the nodes can only move in the
  // right and down direction, we need only compare the adjacent nodes in those
  // directions, which is done BEFORE the A* algorithm is started. We iterate in
  // a diagonal pattern, from bottom left to top right of the matrix so as to
  // not miss any values.
  
  // Variable to hold the column when iterating diagonally when computing the
  // heuristics of each node.
  int newRow = 0;
  
  // Variable to hold the column when iterating diagonally when computing the
  // heuristics of each node.
  int newColumn = 0;
  
  // Variable to hold the movement cost from the current node to the next one in
  // the A* algorithm.
  int movementCost = 0;
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion81" ofType:@"txt"];
  
  // Variable to hold the list of nodes as a string for parsing.
  NSString * nodesList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each node as a string in an array.
  NSArray * nodes = [nodesList componentsSeparatedByString:@"\n"];
  
  // Variable array to hold the node values in the rows array.
  NSArray * nodesInRow = nil;
  
  // Variable array used in the A* algorithm to hold the adjacent open nodes
  // that the current node can travel to.
  NSMutableArray * openNodes = [[NSMutableArray alloc] init];
  
  // Variable array used in the A* algorithm to hold the adjacent closed nodes
  // that the current node CANNOT travel to.
  NSMutableArray * closedNodes = [[NSMutableArray alloc] init];
  
  // Variable array used in the A* algorithm to hold the adjacent nodes of the
  // current node.
  NSMutableArray * adjacentNodes = nil;
  
  // Variable to hold the current A* node while we are moving through the A*
  // algorithm.
  AStarNode * currentNode = nil;
  
  // Variable array to hold the A* nodes constructed from the matrix in the file.
  AStarNode * matrix[80][80];
  
  // For all the rows in in matrix in the file,
  for(int row = 0; row < 80; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(int column = 0; column < 80; column++){
      // Create a new A* node, and add it to the matrix.
      matrix[column][row] = [[AStarNode alloc] initWithRow:row column:column value:[[nodesInRow objectAtIndex:column] intValue]];
    }
  }
  // Mark that the top left hand corner A* node is the starting position.
  matrix[0][0].isStart = YES;
  
  // Mark that the bottom left hand corner A* node is the starting position.
  matrix[79][79].isEnd = YES;
  
  // Now, we compute the hueristics for this matrix. Since the A* nodes are only
  // allowed to move right or down, we only compare the A* nodes that are
  // adjacent to the current node in those directions.
  
  // For all the A* nodes on the bottom row,
  for(int column = 78; column >= 0; column--){
    // Set the h value as the adjacent node to the right's h value and movement
    // cost.
    matrix[column][79].h = matrix[(column + 1)][79].moveCost + matrix[(column + 1)][79].h;
  }
  // For all the A* nodes on the right-most column,
  for(int row = 78; row >= 0; row--){
    // Set the h value as the adjacent node underneath's h value and movement
    // cost.
    matrix[79][row].h = matrix[79][(row + 1)].moveCost + matrix[79][(row + 1)].h;
  }
  // For all the A* node columns from right to left,
  for(int column = 78; column >= 0; column--){
    // Set the initial column for iterating diagonally throughout the A* nodes
    // as the current column.
    newColumn = column;
    
    // For all the A* node rows from bottom to top,
    for(int row = 78; row >= 0; row--){
      // If the movement cost of moving right a column is less than the movement
      // cost of moving down a row,
      if((matrix[(newColumn + 1)][row].h + matrix[(newColumn + 1)][row].moveCost) < (matrix[newColumn][(row + 1)].h + matrix[newColumn][(row + 1)].moveCost)){
        // Store the movement cost as the cost of moving right a column.
        matrix[newColumn][row].h = (matrix[(newColumn + 1)][row].h + matrix[(newColumn + 1)][row].moveCost);
      }
      // Otherwise, if the movement cost of moving right a column is greater
      // than or equal to the movement cost of moving down a row,
      else{
        // Store the movement cost as the cost of moving down a row.
        matrix[newColumn][row].h = (matrix[newColumn][(row + 1)].h + matrix[newColumn][(row + 1)].moveCost);
      }
      // If we are in the right most column,
      if(newColumn == 78){
        // Break out of the loop.
        break;
      }
      // Increment the new column by 1 in order to continue to move diagonally.
      newColumn++;
    }
  }
  // For all the A* node rows from bottom to top,
  for(int row = 78; row >= 0; row--){
    // Set the initial row for iterating diagonally throughout the A* nodes as
    // the current row.
    newRow = row;
    
    // For all the A* node columns from left to right,
    for(int column = 0; column < 79; column++){
      // If the movement cost of moving right a column is less than the movement
      // cost of moving down a row,
      if((matrix[(column + 1)][newRow].h + matrix[(column + 1)][newRow].moveCost) < (matrix[column][(newRow + 1)].h + matrix[column][(newRow + 1)].moveCost)){
        // Store the movement cost as the cost of moving right a column.
        matrix[column][newRow].h = (matrix[(column + 1)][newRow].h + matrix[(column + 1)][newRow].moveCost);
      }
      // Otherwise, if the movement cost of moving right a column is greater
      // than or equal to the movement cost of moving down a row,
      else{
        // Store the movement cost as the cost of moving down a row.
        matrix[column][newRow].h = (matrix[column][(newRow + 1)].h + matrix[column][(newRow + 1)].moveCost);
      }
      // If we are in the top most row,
      if(newRow == 0){
        // Break out of the loop.
        break;
      }
      // Decrement the new row by 1 in order to continue to move diagonally.
      newRow--;
    }
  }
  
  // Here, we start the A* algorithm.
  
  // Add the starting point to the open nodes array.
  [openNodes addObject:matrix[0][0]];
  
  // While there are still nodes in the open nodes array,
  while([openNodes count] > 0){
    // Grab the node with the lowest f value. The first element will always be
    // the node with the lowest f score, as the array is ordered.
    currentNode = [openNodes objectAtIndex:0];
    
    // Add the current node to the closed nodes array.
    [closedNodes addObject:currentNode];
    
    // Remove the current node to the open nodes array.
    [openNodes removeObjectAtIndex:0];
    
    // If the current node is the end point,
    if(currentNode.isEnd){
      // Break out of the loop.
      break;
    }
    // Create a new array to hold the aajacent nodes to the current node.
    adjacentNodes = [[NSMutableArray alloc] initWithCapacity:2];
    
    // If the current node's row is not the last row,
    if(currentNode.row != 79){
      // Add the node beneath the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row + 1)]];
    }
    // If the current node's column is not the last column,
    if(currentNode.column != 79){
      // Add the node to the right of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column + 1)][currentNode.row]];
    }
    // For all the nodes adjacent to the current node,
    for(AStarNode * adjacentNode in adjacentNodes){
      // If the current adjacent node is NOT in the closed set,
      if([closedNodes containsObject:adjacentNode] == NO){
        // Compute the cost from the current step to that step
        movementCost = adjacentNode.moveCost;
        
        // Grab the index of the adjacent node in the open list.
        NSUInteger index = [openNodes indexOfObject:adjacentNode];
        
        // If the adjacent node is in the open list,
        if(index != NSNotFound){
          // If the g score of the current node is less than the adjacent nodes
          // current g score,
          if((currentNode.g + movementCost) < adjacentNode.g){
            // Recompute the g score of the current node to the adjacent node.
            adjacentNode.g = currentNode.g + movementCost;
            
            // Order the open nodes array.
            openNodes = [NSMutableArray arrayWithArray:[openNodes sortedArrayUsingSelector:@selector(compareNodes:)]];
          }
        }
        // If the adjacent node is NOT in the open list,
        else{
          // Set the current node as the parent of the adjacent node.
          adjacentNode.parent = currentNode;
          
          // Compute the g score of the current node to the adjacent node.
          adjacentNode.g = currentNode.g + movementCost;
          
          // Add the adjacent node to the open nodes array.
          [openNodes addObject:adjacentNode];
          
          // Order the open nodes array.
          openNodes = [NSMutableArray arrayWithArray:[openNodes sortedArrayUsingSelector:@selector(compareNodes:)]];
        }
      }
    }
  }
  // Set the answer string to the shortest path distance.
  self.answer = [NSString stringWithFormat:@"%d", (matrix[0][0].h + matrix[0][0].moveCost)];
  
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
  
  // Here, we simply use an A* algorithm to find the best path. I'm not going to
  // claim this is the fastest implementation, or even the clearest. If you'd
  // like to learn more about the A* algorithm in general, visit:
  //
  // http://theory.stanford.edu/~amitp/GameProgramming/
  //
  // The only thing here that veers for the basic path is how we compute the
  // heuristic. Since we know that the path along the nodes can only move in the
  // right and down direction, we need only compare the adjacent nodes in those
  // directions, which is done BEFORE the A* algorithm is started. We iterate in
  // a diagonal pattern, from bottom left to top right of the matrix so as to
  // not miss any values.
  
  // Variable to hold the column when iterating diagonally when computing the
  // heuristics of each node.
  int newRow = 0;
  
  // Variable to hold the column when iterating diagonally when computing the
  // heuristics of each node.
  int newColumn = 0;
  
  // Variable to hold the movement cost from the current node to the next one in
  // the A* algorithm.
  int movementCost = 0;
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion81" ofType:@"txt"];
  
  // Variable to hold the list of nodes as a string for parsing.
  NSString * nodesList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each node as a string in an array.
  NSArray * nodes = [nodesList componentsSeparatedByString:@"\n"];
  
  // Variable array to hold the node values in the rows array.
  NSArray * nodesInRow = nil;
  
  // Variable array used in the A* algorithm to hold the adjacent open nodes
  // that the current node can travel to.
  NSMutableArray * openNodes = [[NSMutableArray alloc] init];
  
  // Variable array used in the A* algorithm to hold the adjacent closed nodes
  // that the current node CANNOT travel to.
  NSMutableArray * closedNodes = [[NSMutableArray alloc] init];
  
  // Variable array used in the A* algorithm to hold the adjacent nodes of the
  // current node.
  NSMutableArray * adjacentNodes = nil;
  
  // Variable to hold the current A* node while we are moving through the A*
  // algorithm.
  AStarNode * currentNode = nil;
  
  // Variable array to hold the A* nodes constructed from the matrix in the file.
  AStarNode * matrix[80][80];
  
  // For all the rows in in matrix in the file,
  for(int row = 0; row < 80; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(int column = 0; column < 80; column++){
      // Create a new A* node, and add it to the matrix.
      matrix[column][row] = [[AStarNode alloc] initWithRow:row column:column value:[[nodesInRow objectAtIndex:column] intValue]];
    }
  }
  // Mark that the top left hand corner A* node is the starting position.
  matrix[0][0].isStart = YES;
  
  // Mark that the bottom left hand corner A* node is the starting position.
  matrix[79][79].isEnd = YES;
  
  // Now, we compute the hueristics for this matrix. Since the A* nodes are only
  // allowed to move right or down, we only compare the A* nodes that are
  // adjacent to the current node in those directions.
  
  // For all the A* nodes on the bottom row,
  for(int column = 78; column >= 0; column--){
    // Set the h value as the adjacent node to the right's h value and movement
    // cost.
    matrix[column][79].h = matrix[(column + 1)][79].moveCost + matrix[(column + 1)][79].h;
  }
  // For all the A* nodes on the right-most column,
  for(int row = 78; row >= 0; row--){
    // Set the h value as the adjacent node underneath's h value and movement
    // cost.
    matrix[79][row].h = matrix[79][(row + 1)].moveCost + matrix[79][(row + 1)].h;
  }
  // For all the A* node columns from right to left,
  for(int column = 78; column >= 0; column--){
    // Set the initial column for iterating diagonally throughout the A* nodes
    // as the current column.
    newColumn = column;
    
    // For all the A* node rows from bottom to top,
    for(int row = 78; row >= 0; row--){
      // If the movement cost of moving right a column is less than the movement
      // cost of moving down a row,
      if((matrix[(newColumn + 1)][row].h + matrix[(newColumn + 1)][row].moveCost) < (matrix[newColumn][(row + 1)].h + matrix[newColumn][(row + 1)].moveCost)){
        // Store the movement cost as the cost of moving right a column.
        matrix[newColumn][row].h = (matrix[(newColumn + 1)][row].h + matrix[(newColumn + 1)][row].moveCost);
      }
      // Otherwise, if the movement cost of moving right a column is greater
      // than or equal to the movement cost of moving down a row,
      else{
        // Store the movement cost as the cost of moving down a row.
        matrix[newColumn][row].h = (matrix[newColumn][(row + 1)].h + matrix[newColumn][(row + 1)].moveCost);
      }
      // If we are in the right most column,
      if(newColumn == 78){
        // Break out of the loop.
        break;
      }
      // Increment the new column by 1 in order to continue to move diagonally.
      newColumn++;
    }
  }
  // For all the A* node rows from bottom to top,
  for(int row = 78; row >= 0; row--){
    // Set the initial row for iterating diagonally throughout the A* nodes as
    // the current row.
    newRow = row;
    
    // For all the A* node columns from left to right,
    for(int column = 0; column < 79; column++){
      // If the movement cost of moving right a column is less than the movement
      // cost of moving down a row,
      if((matrix[(column + 1)][newRow].h + matrix[(column + 1)][newRow].moveCost) < (matrix[column][(newRow + 1)].h + matrix[column][(newRow + 1)].moveCost)){
        // Store the movement cost as the cost of moving right a column.
        matrix[column][newRow].h = (matrix[(column + 1)][newRow].h + matrix[(column + 1)][newRow].moveCost);
      }
      // Otherwise, if the movement cost of moving right a column is greater
      // than or equal to the movement cost of moving down a row,
      else{
        // Store the movement cost as the cost of moving down a row.
        matrix[column][newRow].h = (matrix[column][(newRow + 1)].h + matrix[column][(newRow + 1)].moveCost);
      }
      // If we are in the top most row,
      if(newRow == 0){
        // Break out of the loop.
        break;
      }
      // Decrement the new row by 1 in order to continue to move diagonally.
      newRow--;
    }
  }
  
  // Here, we start the A* algorithm.
  
  // Add the starting point to the open nodes array.
  [openNodes addObject:matrix[0][0]];
  
  // While there are still nodes in the open nodes array,
  while([openNodes count] > 0){
    // Grab the node with the lowest f value. The first element will always be
    // the node with the lowest f score, as the array is ordered.
    currentNode = [openNodes objectAtIndex:0];
    
    // Add the current node to the closed nodes array.
    [closedNodes addObject:currentNode];
    
    // Remove the current node to the open nodes array.
    [openNodes removeObjectAtIndex:0];
    
    // If the current node is the end point,
    if(currentNode.isEnd){
      // Break out of the loop.
      break;
    }
    // Create a new array to hold the aajacent nodes to the current node.
    adjacentNodes = [[NSMutableArray alloc] initWithCapacity:2];
    
    // If the current node's row is not the last row,
    if(currentNode.row != 79){
      // Add the node beneath the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row + 1)]];
    }
    // If the current node's column is not the last column,
    if(currentNode.column != 79){
      // Add the node to the right of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column + 1)][currentNode.row]];
    }
    // For all the nodes adjacent to the current node,
    for(AStarNode * adjacentNode in adjacentNodes){
      // If the current adjacent node is NOT in the closed set,
      if([closedNodes containsObject:adjacentNode] == NO){
        // Compute the cost from the current step to that step
        movementCost = adjacentNode.moveCost;
        
        // Grab the index of the adjacent node in the open list.
        NSUInteger index = [openNodes indexOfObject:adjacentNode];
        
        // If the adjacent node is in the open list,
        if(index != NSNotFound){
          // If the g score of the current node is less than the adjacent nodes
          // current g score,
          if((currentNode.g + movementCost) < adjacentNode.g){
            // Recompute the g score of the current node to the adjacent node.
            adjacentNode.g = currentNode.g + movementCost;
            
            // Order the open nodes array.
            openNodes = [NSMutableArray arrayWithArray:[openNodes sortedArrayUsingSelector:@selector(compareNodes:)]];
          }
        }
        // If the adjacent node is NOT in the open list,
        else{
          // Set the current node as the parent of the adjacent node.
          adjacentNode.parent = currentNode;
          
          // Compute the g score of the current node to the adjacent node.
          adjacentNode.g = currentNode.g + movementCost;
          
          // Add the adjacent node to the open nodes array.
          [openNodes addObject:adjacentNode];
          
          // Order the open nodes array.
          openNodes = [NSMutableArray arrayWithArray:[openNodes sortedArrayUsingSelector:@selector(compareNodes:)]];
        }
      }
    }
  }
  // Set the answer string to the shortest path distance.
  self.answer = [NSString stringWithFormat:@"%d", (matrix[0][0].h + matrix[0][0].moveCost)];
  
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