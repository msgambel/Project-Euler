//  Question18.m

#import "Question18.h"
#import "BinaryObject.h"

@implementation Question18

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"31 May 2002";
  self.hint = @"Don't go top to bottom, go bottom to top!";
  self.link = @"https://en.wikipedia.org/wiki/Binary_tree";
  self.text = @"By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.\n\n\n3\n7 4\n2 4 6\n8 5 9 3\n\n\nThat is, 3 + 7 + 4 + 9 = 23.\n\n\nFind the maximum total from top to bottom of the triangle below:\n\n\n75\n95 64\n17 47 82\n18 35 87 10\n20 04 82 47 65\n19 01 23 75 03 34\n88 02 77 73 07 63 67\n99 65 04 28 06 16 70 92\n41 41 26 56 83 40 80 70 33\n41 48 72 33 47 32 37 16 94 29\n53 71 44 65 25 43 91 52 97 51 14\n70 11 33 28 77 73 17 78 39 68 17 57\n91 71 52 38 17 14 91 43 58 50 27 29 48\n63 66 04 68 89 53 67 30 73 16 69 87 40 31\n04 62 98 27 23 09 70 98 73 93 38 53 60 04 23\n\nNOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)";
  self.isFun = YES;
  self.title = @"Maximum path sum I";
  self.answer = @"1074";
  self.number = @"18";
  self.rating = @"5";
  self.category = @"Sums";
  self.keywords = @"path,sum,maximum,route,import,triangle,adjacent,pair,problem,15,fifteen,rows,simple,challenge,67,sixty,seven,top,bottom";
  self.solveTime = @"120";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.commentCount = @"41";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"18/01/13";
  self.completedOnDate = @"18/01/13";
  self.solutionLineCount = @"33";
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"5.25e-04";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"5.25e-04";
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
  NSString * path = [[NSBundle mainBundle] pathForResource:@"triangleQuestion18" ofType:@"txt"];
  
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
  NSString * path = [[NSBundle mainBundle] pathForResource:@"triangleQuestion18" ofType:@"txt"];
  
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