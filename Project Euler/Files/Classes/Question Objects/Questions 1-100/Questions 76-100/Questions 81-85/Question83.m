//  Question83.m

#import "Question83.h"
#import "AStarNode.h"

@implementation Question83

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 November 2004";
  self.hint = @"The A* algorithm works nicely here!";
  self.link = @"http://theory.stanford.edu/~amitp/GameProgramming/";
  self.text = @"NOTE: This problem is a significantly more challenging version of Problem 81.\n\nIn the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left, right, up, and down, is indicated in bold red and is equal to 2297.\n\n131	673	234	103	18\n201	96	342	965	150\n630	803	746	422	111\n537	699	497	121	956\n805	732	524	37	331\n\nFind the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by moving left, right, up, and down.";
  self.isFun = NO;
  self.title = @"Path sum: four ways";
  self.answer = @"425185";
  self.number = @"83";
  self.rating = @"3";
  self.category = @"Combinations";
  self.keywords = @"matrix,a*,a,star,minimal,path,sum,import,moving,up,down";
  self.solveTime = @"900";
  self.technique = @"OOP";
  self.difficulty = @"Medium";
  self.commentCount = @"60";
  self.attemptsCount = @"5";
  self.isChallenging = YES;
  self.startedOnDate = @"24/03/13";
  self.completedOnDate = @"24/03/13";
  self.solutionLineCount = @"51";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.51";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.51";
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
  // heuristic. It's simply the Manhatten Distance times the minimal movement
  // cost.
  
  // Set the minimum movement cost to the maximum unsigned int.
  uint minimumMoveCost = UINT_MAX;
  
  // Variable to hold the movement cost from the current node to the next one in
  // the A* algorithm.
  int movementCost = 0;
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion83" ofType:@"txt"];
  
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
  for(uint row = 0; row < [nodes count]; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(uint column = 0; column < (uint)[nodesInRow count]; column++){
      // Create a new A* node, and add it to the matrix.
      matrix[column][row] = [[AStarNode alloc] initWithRow:row column:column value:(uint)[[nodesInRow objectAtIndex:column] intValue]];
      
      // If the current node has a value smaller than the previous minimum cost,
      if([[nodesInRow objectAtIndex:column] intValue] < minimumMoveCost){
        // Store the current nodes value as the minimum movement cost.
        minimumMoveCost = [[nodesInRow objectAtIndex:column] intValue];
      }
    }
  }
  // Mark that the top left hand corner A* node is the starting position.
  matrix[0][0].isStart = YES;
    
  // Mark that the bottom left hand corner A* node is the starting position.
  matrix[((uint)[nodesInRow count] - 1)][((uint)[nodes count] - 1)].isEnd = YES;
  
  // Here, we add the minimum distance heuristic.
  
  // For all the rows in in matrix in the file,
  for(uint row = 0; row < (uint)[nodes count]; row++){
    // For all the columns in the matrix in the file,
    for(uint column = 0; column < (uint)[nodesInRow count]; column++){
      // Set the heuristic distance to the Manhatten Distance times the minimum
      // movement cost.
      matrix[column][row].h = (((((uint)[nodes count] - 1) - row) + (((uint)[nodesInRow count] - 1) - column) + 1) * minimumMoveCost);
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
    adjacentNodes = [[NSMutableArray alloc] initWithCapacity:4];
    
    // If the current node's row is not the last row,
    if(currentNode.row != ((uint)[nodes count] - 1)){
      // Add the node beneath the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row + 1)]];
    }
    // If the current node's row is not the first row,
    if(currentNode.row != 0){
      // Add the node above the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row - 1)]];
    }
    // If the current node's column is not the last column,
    if(currentNode.column != ((uint)[nodesInRow count] - 1)){
      // Add the node to the right of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column + 1)][currentNode.row]];
    }
    // If the current node's column is not the first column,
    if(currentNode.column != 0){
      // Add the node to the left of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column - 1)][currentNode.row]];
    }
    // For all the nodes adjacent to the current node,
    for(AStarNode * adjacentNode in adjacentNodes){
      // If the current adjacent node is NOT in the closed set,
      if([closedNodes containsObject:adjacentNode] == NO){
        // Compute the cost from the current step to that step.
        movementCost = adjacentNode.moveCost;
        
        // If the adjacent node is in the open list,
        if([openNodes containsObject:adjacentNode]){
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
  self.answer = [NSString stringWithFormat:@"%d", matrix[((uint)[nodesInRow count] - 1)][((uint)[nodes count] - 1)].g];
  
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
  // heuristic. It's simply the Manhatten Distance times the minimal movement
  // cost.
  
  // Set the minimum movement cost to the maximum unsigned int.
  uint minimumMoveCost = UINT_MAX;
  
  // Variable to hold the movement cost from the current node to the next one in
  // the A* algorithm.
  int movementCost = 0;
  
  // Variable to hold the path to the file that holds the matrix data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"matrixQuestion83" ofType:@"txt"];
  
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
  for(uint row = 0; row < [nodes count]; row++){
    // Separate the elements of the row into columns.
    nodesInRow = [[nodes objectAtIndex:row] componentsSeparatedByString:@","];
    
    // For all the columns in the matrix in the file,
    for(uint column = 0; column < (uint)[nodesInRow count]; column++){
      // Create a new A* node, and add it to the matrix.
      matrix[column][row] = [[AStarNode alloc] initWithRow:row column:column value:(uint)[[nodesInRow objectAtIndex:column] intValue]];
      
      // If the current node has a value smaller than the previous minimum cost,
      if([[nodesInRow objectAtIndex:column] intValue] < minimumMoveCost){
        // Store the current nodes value as the minimum movement cost.
        minimumMoveCost = [[nodesInRow objectAtIndex:column] intValue];
      }
    }
  }
  // Mark that the top left hand corner A* node is the starting position.
  matrix[0][0].isStart = YES;
  
  // Mark that the bottom left hand corner A* node is the starting position.
  matrix[((uint)[nodesInRow count] - 1)][((uint)[nodes count] - 1)].isEnd = YES;
  
  // Here, we add the minimum distance heuristic.
  
  // For all the rows in in matrix in the file,
  for(uint row = 0; row < (uint)[nodes count]; row++){
    // For all the columns in the matrix in the file,
    for(uint column = 0; column < (uint)[nodesInRow count]; column++){
      // Set the heuristic distance to the Manhatten Distance times the minimum
      // movement cost.
      matrix[column][row].h = (((((uint)[nodes count] - 1) - row) + (((uint)[nodesInRow count] - 1) - column) + 1) * minimumMoveCost);
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
    adjacentNodes = [[NSMutableArray alloc] initWithCapacity:4];
    
    // If the current node's row is not the last row,
    if(currentNode.row != ((uint)[nodes count] - 1)){
      // Add the node beneath the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row + 1)]];
    }
    // If the current node's row is not the first row,
    if(currentNode.row != 0){
      // Add the node above the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[currentNode.column][(currentNode.row - 1)]];
    }
    // If the current node's column is not the last column,
    if(currentNode.column != ((uint)[nodesInRow count] - 1)){
      // Add the node to the right of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column + 1)][currentNode.row]];
    }
    // If the current node's column is not the first column,
    if(currentNode.column != 0){
      // Add the node to the left of the current node to the adjacent nodes array.
      [adjacentNodes addObject:matrix[(currentNode.column - 1)][currentNode.row]];
    }
    // For all the nodes adjacent to the current node,
    for(AStarNode * adjacentNode in adjacentNodes){
      // If the current adjacent node is NOT in the closed set,
      if([closedNodes containsObject:adjacentNode] == NO){
        // Compute the cost from the current step to that step.
        movementCost = adjacentNode.moveCost;
        
        // If the adjacent node is in the open list,
        if([openNodes containsObject:adjacentNode]){
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
  self.answer = [NSString stringWithFormat:@"%d", matrix[((uint)[nodesInRow count] - 1)][((uint)[nodes count] - 1)].g];
  
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