//  Question67.m

#import "Question67.h"
#import "BinaryObject.h"

@implementation Question67

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"09 April 2004";
  self.hint = @"Don't go top to bottom, go bottom to top!";
  self.link = @"https://en.wikipedia.org/wiki/Binary_tree";
  self.text = @"By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.\n\n\n3\n7 4\n2 4 6\n8 5 9 3\n\n\nThat is, 3 + 7 + 4 + 9 = 23.\n\n\nFind the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file containing a triangle with one-hundred rows.\n\nNOTE: This is a much more difficult version of Problem 18. It is not possible to try every route to solve this problem, as there are 299 altogether! If you could check one trillion (10^12) routes every second it would take over twenty billion years to check them all. There is an efficient algorithm to solve it. ;o)";
  self.isFun = YES;
  self.title = @"Maximum path sum II";
  self.answer = @"7273";
  self.number = @"67";
  self.rating = @"4";
  self.category = @"Sums";
  self.keywords = @"path,sum,maximum,route,import,triangle,adjacent,pair,problem,100,one,hundred,rows,II,algorithm";
  self.solveTime = @"120";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.commentCount = @"41";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"08/03/13";
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"08/03/13";
  self.solutionLineCount = @"33";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"1.23e-02";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = YES;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.23e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We simply use a binary tree in order to find the answer. If every parent
  // knows which child has the largest path value, then we simply need to start
  // from the bottom parents and tell them to figure it out. Iterating backwords,
  // Each parent needs only make a simple comparison of it's children who already
  // know the maximum path value up to that point. Therefore, the top most parent
  // will automatically know what the value of the maximum path is!
  
  // Variable to hold the path to the file that holds the triangle data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"triangleQuestion67" ofType:@"txt"];
  
  // Variable to hold the triangle grid as a string for parsing.
  NSString * rowsOfNumbers = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
   // Variable to hold each row as a string in an array.
  NSArray * rowsArray = [rowsOfNumbers componentsSeparatedByString:@"\n"];
  
   // Variable to hold each number as a string in an array.
  NSArray * rowArray = nil;
  
  // Variable to hold the left child of the parent binary object.
  BinaryObject * leftChild = nil;
  
  // Variable to hold the right child of the parent binary object.
  BinaryObject * rightChild = nil;
  
  // Variable to hold the parent binary object.
  BinaryObject * parentObject = nil;
  
  // Variable array to create and then hold the current row of binary objects.
  NSMutableArray * rowOfBinaryObjectsArray = nil;
  
  // Variable array to hold the next row (i.e.: the row with the children) after
  // the current row of binary objects.
  NSMutableArray * nextRowOfBinaryObjectsArray = nil;
  
  // Variable array to hold all the rows of the binary objects.
  NSMutableArray * rowsOfBinaryObjectsArray = [[NSMutableArray alloc] initWithCapacity:[rowsArray count]];
  
  // For all the row strings in the rows array,
  for(NSString * rowString in rowsArray){
     // Grab each number as a string in an array.
    rowArray = [rowString componentsSeparatedByString:@" "];
    
    // Initialize a new array with the size of the number of strings in the row
    // array.
    rowOfBinaryObjectsArray = [[NSMutableArray alloc] initWithCapacity:[rowArray count]];
    
    // For all the strings in the row array,
    for(NSString * numberString in rowArray){
      // Initialize a new binary object with the starting value.
      parentObject = [[BinaryObject alloc] initWithValue:[numberString intValue]];
      
      // Add the binary object to the current row of binary objects array.
      [rowOfBinaryObjectsArray addObject:parentObject];
    }
    // When all the binary objects have been added to the row of binary objects
    // array, add the row of binary objects array to the rows of binary objects
    // array.
    [rowsOfBinaryObjectsArray addObject:rowOfBinaryObjectsArray];
  }
  // For all the rows of binary objects array, except for the last row,
  for(int i = 0; i < ([rowsOfBinaryObjectsArray count] - 1); i++){
    // Grab the parent row.
    rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:i];
    
    // Grab the children row.
    nextRowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:(i + 1)];
    
    // Set the first left child from the children row,
    leftChild = (BinaryObject *)[nextRowOfBinaryObjectsArray objectAtIndex:0];
    
    // For every parent in the parent row,
    for(int j = 0; j < [rowOfBinaryObjectsArray count]; j++){
      // Grab the parent binary object.
      parentObject = (BinaryObject *)[rowOfBinaryObjectsArray objectAtIndex:j];
      
      // Grab the right child object.
      rightChild = (BinaryObject *)[nextRowOfBinaryObjectsArray objectAtIndex:(j + 1)];
      
      // Set the left child of the parent binary object.
      parentObject.leftChild = leftChild;
      
      // Set the right child of the parent binary object.
      parentObject.rightChild = rightChild;
      
      // The right child is now the left child for the next parent, so set the
      // left child to be the right child.
      leftChild = rightChild;
    }
  }
  // For all the rows of binary objects array, except for the last row, starting
  // with the second last row (i.e.: the first parent row),
  for(int i = ((int)[rowsOfBinaryObjectsArray count] - 1); i >= 0; i--){
    // Grab the parent row.
    rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:i];
    
    // For all the binary objects in the parent row,
    for(BinaryObject * binaryObject in rowOfBinaryObjectsArray){
      // Tell the parent to get the largest value from its children.
      [binaryObject getTheLargestValueFromChild];
    }
  }
  // Grab the top most row of binary objects.
  rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:0];
  
  // Grab the top most parent.
  parentObject = (BinaryObject *)[rowOfBinaryObjectsArray objectAtIndex:0];
  
  // Set the answer string to the top most parents largest value.
  self.answer = [NSString stringWithFormat:@"%d", parentObject.largestValueFromChild];
  
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
  
  // We simply use a binary tree in order to find the answer. If every parent
  // knows which child has the largest path value, then we simply need to start
  // from the bottom parents and tell them to figure it out. Iterating backwords,
  // Each parent needs only make a simple comparison of it's children who already
  // know the maximum path value up to that point. Therefore, the top most parent
  // will automatically know what the value of the maximum path is!
  
  // Variable to hold the path to the file that holds the triangle data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"triangleQuestion67" ofType:@"txt"];
  
  // Variable to hold the triangle grid as a string for parsing.
  NSString * rowsOfNumbers = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each row as a string in an array.
  NSArray * rowsArray = [rowsOfNumbers componentsSeparatedByString:@"\n"];
  
  // Variable to hold each number as a string in an array.
  NSArray * rowArray = nil;
  
  // Variable to hold the left child of the parent binary object.
  BinaryObject * leftChild = nil;
  
  // Variable to hold the right child of the parent binary object.
  BinaryObject * rightChild = nil;
  
  // Variable to hold the parent binary object.
  BinaryObject * parentObject = nil;
  
  // Variable array to create and then hold the current row of binary objects.
  NSMutableArray * rowOfBinaryObjectsArray = nil;
  
  // Variable array to hold the next row (i.e.: the row with the children) after
  // the current row of binary objects.
  NSMutableArray * nextRowOfBinaryObjectsArray = nil;
  
  // Variable array to hold all the rows of the binary objects.
  NSMutableArray * rowsOfBinaryObjectsArray = [[NSMutableArray alloc] initWithCapacity:[rowsArray count]];
  
  // For all the row strings in the rows array,
  for(NSString * rowString in rowsArray){
    // Grab each number as a string in an array.
    rowArray = [rowString componentsSeparatedByString:@" "];
    
    // Initialize a new array with the size of the number of strings in the row
    // array.
    rowOfBinaryObjectsArray = [[NSMutableArray alloc] initWithCapacity:[rowArray count]];
    
    // For all the strings in the row array,
    for(NSString * numberString in rowArray){
      // Initialize a new binary object with the starting value.
      parentObject = [[BinaryObject alloc] initWithValue:[numberString intValue]];
      
      // Add the binary object to the current row of binary objects array.
      [rowOfBinaryObjectsArray addObject:parentObject];
    }
    // When all the binary objects have been added to the row of binary objects
    // array, add the row of binary objects array to the rows of binary objects
    // array.
    [rowsOfBinaryObjectsArray addObject:rowOfBinaryObjectsArray];
  }
  // For all the rows of binary objects array, except for the last row,
  for(int i = 0; i < ([rowsOfBinaryObjectsArray count] - 1); i++){
    // Grab the parent row.
    rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:i];
    
    // Grab the children row.
    nextRowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:(i + 1)];
    
    // Set the first left child from the children row,
    leftChild = (BinaryObject *)[nextRowOfBinaryObjectsArray objectAtIndex:0];
    
    // For every parent in the parent row,
    for(int j = 0; j < [rowOfBinaryObjectsArray count]; j++){
      // Grab the parent binary object.
      parentObject = (BinaryObject *)[rowOfBinaryObjectsArray objectAtIndex:j];
      
      // Grab the right child object.
      rightChild = (BinaryObject *)[nextRowOfBinaryObjectsArray objectAtIndex:(j + 1)];
      
      // Set the left child of the parent binary object.
      parentObject.leftChild = leftChild;
      
      // Set the right child of the parent binary object.
      parentObject.rightChild = rightChild;
      
      // The right child is now the left child for the next parent, so set the
      // left child to be the right child.
      leftChild = rightChild;
    }
  }
  // For all the rows of binary objects array, except for the last row, starting
  // with the second last row (i.e.: the first parent row),
  for(int i = ((int)[rowsOfBinaryObjectsArray count] - 1); i >= 0; i--){
    // Grab the parent row.
    rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:i];
    
    // For all the binary objects in the parent row,
    for(BinaryObject * binaryObject in rowOfBinaryObjectsArray){
      // Tell the parent to get the largest value from its children.
      [binaryObject getTheLargestValueFromChild];
    }
  }
  // Grab the top most row of binary objects.
  rowOfBinaryObjectsArray = [rowsOfBinaryObjectsArray objectAtIndex:0];
  
  // Grab the top most parent.
  parentObject = (BinaryObject *)[rowOfBinaryObjectsArray objectAtIndex:0];
  
  // Set the answer string to the top most parents largest value.
  self.answer = [NSString stringWithFormat:@"%d", parentObject.largestValueFromChild];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end