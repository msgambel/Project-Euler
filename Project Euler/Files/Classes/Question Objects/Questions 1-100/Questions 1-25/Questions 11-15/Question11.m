//  Question11.m

#import "Question11.h"
#import "Structures.h"

@interface Question11 (Private)

- (MovingProduct4)array:(int *)aArray startIndex:(int)aStartIndex endIndex:(int)aEndIndex incrementAmount:(int)aIncrementAmount;

@end

@implementation Question11

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"22 February 2002";
  self.text = @"In the 2020 grid below, four numbers along a diagonal line have been marked in red.\n08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08\n49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00\n81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65\n52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91\n22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80\n24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50\n32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70\n67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21\n24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72\n21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95\n78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92\n16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57\n86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58\n19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40\n04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66\n88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69\n04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36\n20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16\n20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54\n01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48\n\nThe product of these numbers is 26x63x78x14 = 1788696.\n\nWhat is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20x20 grid?";
  self.title = @"Largest product in a grid";
  self.answer = @"70600674";
  self.number = @"Problem 11";
  self.estimatedComputationTime = @"4.85e-04";
  self.estimatedBruteForceComputationTime = @"4.92e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // The optimal method is to use a 1-dimensional array to store the data instead
  // of a 2-dimensional array. This is because there is less backend memory
  // management going on, as the only address needed is the start address.
  //
  // It is worth noting that in order to move in a specific direction, it is still
  // beneficial to think of the array as a 2 dimensional array, where moving
  // left and right is +/- 1, up and down is +/- numberOfRowsAndColumns, and in
  // order to move diagonally, +/- (numberOfRowsAndColumns +/- 1).
  //
  // We have a helper method similay to Question 8 which uses a moving product.
  // That way, we can eliminate the uneccessary multiplications, as well as
  // ignore the 0's.
  //
  // Also Note that we could make the helper method a strict C function instead
  // in order to speed up the computation.
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Variable to hold the grid of numbers as a string.
  NSString * gridOfNumbers = @"08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48";
  
  // Variable to hold the largest product of 4 numbers in the 2-dimensional array.
  uint largestProduct = 0;
  
  // Variable to hold each number as a string in an array.
  NSArray * parsedArray = [gridOfNumbers componentsSeparatedByString:@" "];
  
  // Variable to hold the number of rows and columns in the array. We know that
  // it is a square array, so just take the sqaure root of the count.
  int numberOfRowsAndColumns = (uint)(sqrt((double)[parsedArray count]));
  
  // Variable array to hold the numbers in a 1-dimensional array.
  int numbersArray[[parsedArray count]];
  
  // For all the strings in the array,
  for(int i = 0; i < [parsedArray count]; i++){
    // Grab the object at the index and enter it in the 1-dimensional array.
    numbersArray[i] = [[parsedArray objectAtIndex:i] intValue];
  }
  // Variable to hold the product of 4 adjacent numbers as we move in a direction.
  MovingProduct4 movingProduct = MovingProduct4One;
  
  // Variable to hold the integer value of the current digit.
  uint digitValue = 0;
  
  // Variable to hold the end index in the 1-dimensional array for the direction
  // we are moving in.
  int endIndex = 0;
  
  // Variable to hold the start index in the 1-dimensional array for the
  // direction we are moving in.
  int startIndex = 0;
  
  // Variable array to hold the end points for each direction we iterate over.
  int endPosition[Direction_End] = {numberOfRowsAndColumns, numberOfRowsAndColumns, 36, (4 - numberOfRowsAndColumns)};
  
  // Variable array to hold the start points for each direction we iterate over.
  int startPosition[Direction_End] = {0, 0, 3, (numberOfRowsAndColumns - 4)};
  
  // Variable array to hold the increment amount we use to move in the direction
  // we iterate over.
  int incrementAmount[Direction_End] = {1, numberOfRowsAndColumns, (1 - numberOfRowsAndColumns), (numberOfRowsAndColumns + 1)};
  
  // Variable array to hold the increment amount for the positions we use in the
  // direction we iterate over.
  int positionIncrementAmount[Direction_End] = {1, 1, 1, -1};
  
  // Here, we iterate over all 4 directions. The above arrays allow us to compact
  // the code, eliminate potential errors, and make understanding a bit easier.
  //
  // We essentially find the start and end locations of the lines we are iterating
  // over, and allow the moving product to continually check for the largest
  // potential product.
  
  // For all the directions we iterate over,
  for(Direction direction = Direction_LeftToRight; direction < Direction_End; direction++){
    // For all the different lines based on the direction (Note that the condition
    // to check is based on the direction. This could be simplified to 1 check
    // with a bit of clever reordering),
    for(int position = startPosition[direction]; ((direction == Direction_TopLeftToBottomRight) && (position >= endPosition[direction]))
                                              || ((direction != Direction_TopLeftToBottomRight) && (position < endPosition[direction]));
                                                 position += positionIncrementAmount[direction]){
      
      // Based on the direction, set the start and end index for the current line.
      switch(direction){
        case Direction_LeftToRight:
          // To find the start index, we add number of columns.
          startIndex = position * numberOfRowsAndColumns;
          
          // To find the end index, we simply take the start index and add the
          // number of columns.
          endIndex = startIndex + numberOfRowsAndColumns;
          break;
        case Direction_TopToBottom:
          // To find the column index, we just take the start position, as they
          // are all in the first row.
          startIndex = position;
          
          // To find the end index, we simply take the start index and add the
          // number of rows times the number of columns. The +1 is for bounding
          // issues in the helper method.
          endIndex = startIndex + (numberOfRowsAndColumns * (numberOfRowsAndColumns - 1)) + 1;
          break;
        case Direction_BottomLeftToTopRight:
          // Since we are finding the diagonals, there is an inflection point at
          // the 0 index. Therefore, we have to split the cases in order to get
          // the correct start and end points.
          
          // If the start position is the first column on the left,
          if(position < numberOfRowsAndColumns){
            // The start position is just the start position of each row.
            startIndex = position * numberOfRowsAndColumns;
            
            // The end position is in the first row, so setting the index to 0
            // makes it so that the array can't go to a negative index.
            endIndex = 0;
          }
          // If the start position is the last row on the bottom,
          else{
            // The start position is in the last row at the diagonal we are
            // iterating over.
            startIndex = numberOfRowsAndColumns * (numberOfRowsAndColumns - 1) + (position - numberOfRowsAndColumns) + 1;
            
            // The end position is in the right most column, so figure out the
            // row index and subtract 1.
            endIndex = (position - numberOfRowsAndColumns + 1) * numberOfRowsAndColumns + (numberOfRowsAndColumns - 1);
          }
          break;
        case Direction_TopLeftToBottomRight:
          // Since we are finding the diagonals, there is an inflection point at
          // the 0 index. Therefore, we have to split the cases in order to get
          // the correct start and end points.
          
          // If the start position is the first column on the left,
          if(position < 0){
            // The start position is just the start position of each row (The
            // negative is just an indexing issue with the position. This can be
            // removed with a bit of clever reordering).
            startIndex = -position * numberOfRowsAndColumns;
            
            // The end position is in the last row at the diagonal we are iterating
            // over.
            endIndex = (numberOfRowsAndColumns * numberOfRowsAndColumns) + position - 1;
          }
          // If the start position is the first row on the top,
          else{
            // To find the start position, we just take the start position, as they
            // are all in the first row.
            startIndex = position;
            
            // The end position is in the right most column, so figure out the
            // row index and subtract 1.
            endIndex = (numberOfRowsAndColumns - position) * numberOfRowsAndColumns - 1;
          }
          break;
        default:
          break;
      }
      // Using the helper method, find the first valid index and product of 4
      // adjacent numbers based on the direction.
      movingProduct = [self array:numbersArray startIndex:startIndex endIndex:endIndex incrementAmount:incrementAmount[direction]];
      
      // Set the start index to be the be the valid index.
      startIndex = movingProduct.index;
      
      // If the current product is larger than the last largest product,
      if(movingProduct.product > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = movingProduct.product;
      }
      
      // For all the points from the start index to the end index (Note that we
      // need to have the check condition based on the direction we are iterating
      // over. This could be simplified to 1 check with a bit of clever reordering),
      for(int index = startIndex; ((direction == Direction_LeftToRight) && (index < endIndex))
                               || ((direction == Direction_TopToBottom) && (index < endIndex))
                               || ((direction == Direction_BottomLeftToTopRight) && (index >= endIndex))
                               || ((direction == Direction_TopLeftToBottomRight) && (index <= endIndex));
                                  index += incrementAmount[direction]){
        
        // Grab the digit value from the array at the current index.
        digitValue = numbersArray[index];
        
        // If the digit value is 0,
        if(digitValue == 0){
          // Grab the next valid MovingProduct4.
          movingProduct = [self array:numbersArray startIndex:index endIndex:endIndex incrementAmount:incrementAmount[direction]];
          
          // Update the index.
          index = movingProduct.index;
          
          // If the product returned by the helper method is zero.
          if(movingProduct.product == 0){
            // A valid product has NOT been found, so exit the loop.
            break;
          }
        }
        // If the "digit" value is NOT 0,
        else{
          // Divide the product by the left most "digit" in the product.
          movingProduct.product /= movingProduct.numbersInProduct[0];
          
          // Multiply the product by the current "digit" value.
          movingProduct.product *= digitValue;
          
          // Move the numbers in the product to the left.
          movingProduct = MovingProduct4ShiftLeft(movingProduct);
          
          // Set the new value of the right most "digit" in the product to the
          // current "digit" value.
          movingProduct.numbersInProduct[3] = digitValue;
        }
        // If the current product is larger than the last largest product,
        if(movingProduct.product > largestProduct){
          // Set the largest product to be the current product.
          largestProduct = movingProduct.product;
        }
      }
    }
  }
  // Set the answer string to the largest product.
  self.answer = [NSString stringWithFormat:@"%d", largestProduct];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

- (void)computeAnswerByBruteForce; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Explain overall technique.
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Variable to hold the grid of numbers as a string.
  NSString * gridOfNumbers = @"08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48";
  
  // Variable to hold each number as a string in an array.
  NSArray * parsedArray = [gridOfNumbers componentsSeparatedByString:@" "];
  
  // Variable to hold the number of rows and columns in the array. We know that
  // it is a square array, so just take the sqaure root of the count.
  uint numberOfRowsAndColumns = (uint)(sqrt((double)[parsedArray count]));
  
  // Variable array to hold the numbers in a 2-dimensional array.
  uint numbersArray[numberOfRowsAndColumns][numberOfRowsAndColumns];
  
  // For all the rows in the array,
  for(uint row = 0; row < numberOfRowsAndColumns; row++){
    // For all the columns in the array,
    for(uint col = 0; col < numberOfRowsAndColumns; col++){
      // Grab the object at the index and enter it in the 2-dimensional array.
      numbersArray[row][col] = [[parsedArray objectAtIndex:((row * numberOfRowsAndColumns) + col)] intValue];
    }
  }
  // Variable to hold the current porduct of the 4 numbers.
  uint currentProduct = 1;
  
  // Variable to hold the largest product of 4 numbers in the 2-dimensional array.
  uint largestProduct = 0;
  
  // Check all the rows to find the maximum product of 4 horizontally adjacent
  // numbers. To do this, we move from left to right.
  
  // For all the rows in the array,
  for(int row = 0; row < numberOfRowsAndColumns; row++){
    // For all the start columns in the array. We need to make sure there are at
    // least 3 numbers to the left of the start index, so that is why we end the
    // loop 3 numbers before the end index.
    for(int startColumn = 0; startColumn < (numberOfRowsAndColumns - 3); startColumn++){
      // Start the default of the product to the unit 1.
      currentProduct = 1;
      
      // For the current column and the 3 adjacent columns,
      for(int column = startColumn; column < (startColumn + 4); column++){
        // Multiply the current product by the value in the 2-dimensional array.
        currentProduct *= numbersArray[row][column];
      }
      // If the current product is larger than the last largest product,
      if(currentProduct > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = currentProduct;
      }
    }
  }
  
  // Check all the columns to find the maximum product of 4 vertically adjacent
  // numbers. To do this, we move from top to bottom.
  
  // For all the columns in the array,
  for(int column = 0; column < numberOfRowsAndColumns; column++){
    // For all the start rows in the array. We need to make sure there are at
    // least 3 numbers to the below of the start index, so that is why we end the
    // loop 3 numbers before the end index.
    for(int startRow = 0; startRow <= (numberOfRowsAndColumns - 4); startRow++){
      // Start the default of the product to the unit 1.
      currentProduct = 1;
      
      // For the current row and the 3 adjacent rows,
      for(int row = startRow; row < (startRow + 4); row++){
        // Multiply the current product by the value in the 2-dimensional array.
        currentProduct *= numbersArray[row][column];
      }
      // If the current product is larger than the last largest product,
      if(currentProduct > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = currentProduct;
      }
    }
  }
  
  // Check all the diagonals to find the maximum product of 4 Bottom Left to Top
  // Right diagonally adjacent numbers. Note that to move from Bottom Left to Top
  // Right, we increase the row index by -1, while simultaneously moving the
  // column index by 1.
  
  // Variable to hold the start row.
  int row = 0;
  
  // Variable to hold the start column.
  int column = 0;
  
  // Variable to hold the increase amount for the row.
  int rowIncrease = -1;
  
  // Variable to hold the increase amount for the column.
  int columnIncrease = 1;
  
  // Variable to hold the current row index when computing the product.
  int currentRow = row;
  
  // Variable to hold the current colum index when computing the product.
  int currentColumn = column;
  
  // We will be doing each diagonal line form start to finish in order. We are
  // starting at row: 3, column:0, and ending at row: 19, column: 16
  
  // For all the diagonals that are valid. There are 40 - 4 - 4 = 32 valid
  // diagonals, with the first one starting at row: 3, column: 0.
  for(int diagonal = 3; diagonal < 36; diagonal++){
    // If the diagonal starts on a valid row,
    if(diagonal < numberOfRowsAndColumns){
      // Set the row to the value of the diagonal.
      row = diagonal;
      
      // Set the column to be 0.
      column = 0;
    }
    // If the diagonal is LARGER than a valid row,
    else{
      // Set the row to the last row.
      row = numberOfRowsAndColumns - 1;
      
      // Set the column to the remaining amount of the diagonal minus the row.
      // This is the first valid index of a column if there would be if there
      // was an infinite amount of rows.
      column = diagonal - row;
    }
    // Since a the 2-dimensional array is square, the the maximum length of a
    // diagonal is the same as the number of rows and columns (If it wasn't
    // square, we would need to choose the smaller number). Therefore, for all
    // the Bottom Left to Top Right diagonals in the array,
    for(int count = 0; count < numberOfRowsAndColumns; count++){
      // Set the current row to the start row.
      currentRow = row;
      
      // Set the current column to the start column.
      currentColumn = column;
      
      // Start the default of the product to the unit 1.
      currentProduct = 1;
      
      // For the current diagonal and the 3 adjacent diagonal numbers,
      for(int currentCount = 0; currentCount < 4; currentCount++){
        // Multiply the current product by the value in the 2-dimensional array.
        currentProduct *= numbersArray[currentRow][currentColumn];
        
        // Increase the row by the row increase amount.
        currentRow += rowIncrease;
        
        // Increase the current column by the column increase amount.
        currentColumn += columnIncrease;
      }
      // If the current product is larger than the last largest product,
      if(currentProduct > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = currentProduct;
      }
      // Increase the row by the row increase amount.
      row += rowIncrease;
      
      // If the row is smaller than the the smallest valid index,
      if(row < 3){
        // Break out of the loop.
        break;
      }
      // Increase the column by the column increase amount.
      column += columnIncrease;
      
      // If the column is larger than the the largest valid index,
      if(column > (numberOfRowsAndColumns - 4)){
        // Break out of the loop.
        break;
      }
    }
  }
  
  // Check all the diagonals to find the maximum product of 4 Top Left to Bottom
  // Right diagonally adjacent numbers. Note that to move from Top Left to Bottom
  // Right, we increase the row index by 1, while simultaneously moving the column
  // index by 1.
  
  // Set the row increase to +1.
  rowIncrease = 1;
  
  // Set the column increase to +1.
  columnIncrease = 1;
  
  // We will be doing each diagonal line form start to finish in order. We are
  // starting at row: 0, column: 16, and ending at row: 16, column: 0
  
  // For all the diagonals that are valid. There are 40 - 4 - 4 = 32 valid
  // diagonals, with the first one starting at row: 0, column: 16.
  for(int diagonal = (numberOfRowsAndColumns - 4); diagonal >= (int)(4 - numberOfRowsAndColumns); diagonal--){
    // If the diagonal starts on a valid row,
    if(diagonal < 0){
      // Set the row to the value of the diagonal (the negative is just because
      // of the way we are iterating).
      row = -diagonal;
      
      // Set the column to be 0.
      column = 0;
    }
    // If the diagonal is LARGER than a valid row,
    else{
      // Set the row to be 0.
      row = 0;
      
      // Set the column to the value of the diagonal.
      column = diagonal;
    }
    // Since a the 2-dimensional array is square, the the maximum length of a
    // diagonal is the same as the number of rows and columns (If it wasn't
    // square, we would need to choose the smaller number). Therefore, for all
    // the Top Left to Bottom Right diagonals in the array,
    for(int count = 0; count < numberOfRowsAndColumns; count++){
      // Set the current row to the start row.
      currentRow = row;
      
      // Set the current column to the start column.
      currentColumn = column;
      
      // Start the default of the product to the unit 1.
      currentProduct = 1;
      
      // For the current diagonal and the 3 adjacent diagonal numbers,
      for(int currentCount = 0; currentCount < 4; currentCount++){
        // Multiply the current product by the value in the 2-dimensional array.
        currentProduct *= numbersArray[currentRow][currentColumn];
        
        // Increase the current row by the row increase amount.
        currentRow += rowIncrease;
        
        // Increase the current column by the column increase amount.
        currentColumn += columnIncrease;
      }
      // If the current product is larger than the last largest product,
      if(currentProduct > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = currentProduct;
      }
      // Increase the row by the row increase amount.
      row += rowIncrease;
      
      // If the row is larger than the the largest valid index,
      if(row > (numberOfRowsAndColumns - 4)){
        // Break out of the loop.
        break;
      }
      // Increase the column by the column increase amount.
      column += columnIncrease;
      
      // If the column is larger than the the largest valid index,
      if(column > (numberOfRowsAndColumns - 4)){
        // Break out of the loop.
        break;
      }
    }
  }
  // Set the answer string to the largest product.
  self.answer = [NSString stringWithFormat:@"%d", largestProduct];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question11 (Private)

- (MovingProduct4)array:(int *)aArray startIndex:(int)aStartIndex endIndex:(int)aEndIndex incrementAmount:(int)aIncrementAmount; {
  // Variable to hold the newly computed MovingProduct4 based on the index. It is
  // defaulted to a MovingProduct4 that is filled with 0's.
  MovingProduct4 movingProduct = MovingProduct4Zero;
  
  // If the increment amount is not 0,
  if(aIncrementAmount != 0){
    BOOL shouldContinue = (aEndIndex >= (aStartIndex + (3 * aIncrementAmount)));
    
    if(aIncrementAmount < 0){
      shouldContinue = (aEndIndex <= (aStartIndex + (3 * aIncrementAmount)));
    }
    // If we should continue,
    if(shouldContinue){
      // Start the default of the product to the unit 1.
      movingProduct.product = 1;
      
      int index = aStartIndex;
      
      // Variable to hold the integer value of the current digit.
      uint digitValue = 0;
      
      // Set the index of the MovingProduct5 to new index after the multiplication
      // is complete. We do this now as if a 0 appears in the product, we recursively
      // call this method, which will overwrite this value. If we do it after the
      // following loop, this will overwrite the value of the returned MovingProduct5,
      // which will give the wrong starting index.
      movingProduct.index = (aStartIndex + (4 * aIncrementAmount));
      
      // For all the numbers from the starting index to the end index,
      for(int i = 0; i < 4; i++){
        // Grab the digit value from the array at the current index.
        digitValue = aArray[index];
        // If the "digit" value is 0,
        if(digitValue == 0){
          // Set the MovingProduct4 to the returned value of this method based on
          // the current index + 1 (i.e.: the "digit" to the right of the current
          // one).
          movingProduct = [self array:aArray startIndex:(aStartIndex + aIncrementAmount) endIndex:aEndIndex incrementAmount:aIncrementAmount];
          
          // Exit the loop.
          break;
        }
        // If the "digit" value is NOT 0,
        else{
          // Multiply the prodcut by the current "digit" value.
          movingProduct.product *= digitValue;
          
          // Set the current "digit" value to the number in the prodcut based on
          // the index.
          movingProduct.numbersInProduct[i] = digitValue;
        }
        index += aIncrementAmount;
      }
    }
  }
  // Return the MovingProduct4.
  return movingProduct;
}

@end