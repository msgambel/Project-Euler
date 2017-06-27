//  Question96.m

#import "Question96.h"
#import "SudokuGroup.h"
#import "SudokuCoordinate.h"

@interface Question96 (Private)

- (uint)topLeftCornerNumberForBoard:(NSString *)aBoard;

@end

@implementation Question96

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"27 May 2005";
  self.hint = @"This problem can be done recursively.";
  self.link = @"https://en.wikipedia.org/wiki/Sudoku";
  self.text = @"Su Doku (Japanese meaning number place) is the name given to a popular puzzle concept. Its origin is unclear, but credit must be attributed to Leonhard Euler who invented a similar, and much more difficult, puzzle idea called Latin Squares. The objective of Su Doku puzzles, however, is to replace the blanks (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3 box contains each of the digits 1 to 9. Below is an example of a typical starting puzzle grid and its solution grid.\n\nImages Missing!!!\n\nA well constructed Su Doku puzzle has a unique solution and can be solved by logic, although it may be necessary to employ \"guess and test\" methods in order to eliminate options (there is much contested opinion over this). The complexity of the search determines the difficulty of the puzzle; the example above is considered easy because it can be solved by straight forward direct deduction.\n\nThe 6K text file, sudoku.txt (right click and 'Save Link/Target As...'), contains fifty different Su Doku puzzles ranging in difficulty, but all with unique solutions (the first puzzle in the file is the example above).\n\nBy solving all fifty puzzles find the sum of the 3-digit numbers found in the top left corner of each solution grid; for example, 483 is the 3-digit number found in the top left corner of the solution grid above.";
  self.isFun = YES;
  self.title = @"Su Doku";
  self.answer = @"24702";
  self.number = @"96";
  self.rating = @"5";
  self.category = @"Combinations";
  self.keywords = @"sudoku,recursive,import,japanese,grid";
  self.solveTime = @"900";
  self.difficulty = @"Medium";
  self.isChallenging = YES;
  self.completedOnDate = @"06/04/13";
  self.solutionLineCount = @"103";
  self.estimatedComputationTime = @"0.338";
  self.estimatedBruteForceComputationTime = @"0.338";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
//  // Variable to hold the string data for each of the boards.
//  NSString * sudokuBoards = @"003020600,900305001,001806400,008102900,700000008,006708200,002609500,800203009,005010300,Grid,200080300,060070084,030500209,000105408,000000000,402706000,301007040,720040060,004010003,Grid,000000907,000420180,000705026,100904000,050000040,000507009,920108000,034059000,507000000,Grid,030050040,008010500,460000012,070502080,000603000,040109030,250000098,001020600,080060020,Grid,020810740,700003100,090002805,009040087,400208003,160030200,302700060,005600008,076051090,Grid,100920000,524010000,000000070,050008102,000000000,402700090,060000000,000030945,000071006,Grid,043080250,600000000,000001094,900004070,000608000,010200003,820500000,000000005,034090710,Grid,480006902,002008001,900370060,840010200,003704100,001060049,020085007,700900600,609200018,Grid,000900002,050123400,030000160,908000000,070000090,000000205,091000050,007439020,400007000,Grid,001900003,900700160,030005007,050000009,004302600,200000070,600100030,042007006,500006800,Grid,000125400,008400000,420800000,030000095,060902010,510000060,000003049,000007200,001298000,Grid,062340750,100005600,570000040,000094800,400000006,005830000,030000091,006400007,059083260,Grid,300000000,005009000,200504000,020000700,160000058,704310600,000890100,000067080,000005437,Grid,630000000,000500008,005674000,000020000,003401020,000000345,000007004,080300902,947100080,Grid,000020040,008035000,000070602,031046970,200000000,000501203,049000730,000000010,800004000,Grid,361025900,080960010,400000057,008000471,000603000,259000800,740000005,020018060,005470329,Grid,050807020,600010090,702540006,070020301,504000908,103080070,900076205,060090003,080103040,Grid,080005000,000003457,000070809,060400903,007010500,408007020,901020000,842300000,000100080,Grid,003502900,000040000,106000305,900251008,070408030,800763001,308000104,000020000,005104800,Grid,000000000,009805100,051907420,290401065,000000000,140508093,026709580,005103600,000000000,Grid,020030090,000907000,900208005,004806500,607000208,003102900,800605007,000309000,030020050,Grid,005000006,070009020,000500107,804150000,000803000,000092805,907006000,030400010,200000600,Grid,040000050,001943600,009000300,600050002,103000506,800020007,005000200,002436700,030000040,Grid,004000000,000030002,390700080,400009001,209801307,600200008,010008053,900040000,000000800,Grid,360020089,000361000,000000000,803000602,400603007,607000108,000000000,000418000,970030014,Grid,500400060,009000800,640020000,000001008,208000501,700500000,000090084,003000600,060003002,Grid,007256400,400000005,010030060,000508000,008060200,000107000,030070090,200000004,006312700,Grid,000000000,079050180,800000007,007306800,450708096,003502700,700000005,016030420,000000000,Grid,030000080,009000500,007509200,700105008,020090030,900402001,004207100,002000800,070000090,Grid,200170603,050000100,000006079,000040700,000801000,009050000,310400000,005000060,906037002,Grid,000000080,800701040,040020030,374000900,000030000,005000321,010060050,050802006,080000000,Grid,000000085,000210009,960080100,500800016,000000000,890006007,009070052,300054000,480000000,Grid,608070502,050608070,002000300,500090006,040302050,800050003,005000200,010704090,409060701,Grid,050010040,107000602,000905000,208030501,040070020,901080406,000401000,304000709,020060010,Grid,053000790,009753400,100000002,090080010,000907000,080030070,500000003,007641200,061000940,Grid,006080300,049070250,000405000,600317004,007000800,100826009,000702000,075040190,003090600,Grid,005080700,700204005,320000084,060105040,008000500,070803010,450000091,600508007,003010600,Grid,000900800,128006400,070800060,800430007,500000009,600079008,090004010,003600284,001007000,Grid,000080000,270000054,095000810,009806400,020403060,006905100,017000620,460000038,000090000,Grid,000602000,400050001,085010620,038206710,000000000,019407350,026040530,900020007,000809000,Grid,000900002,050123400,030000160,908000000,070000090,000000205,091000050,007439020,400007000,Grid,380000000,000400785,009020300,060090000,800302009,000040070,001070500,495006000,000000092,Grid,000158000,002060800,030000040,027030510,000000000,046080790,050000080,004070100,000325000,Grid,010500200,900001000,002008030,500030007,008000500,600080004,040100700,000700006,003004050,Grid,080000040,000469000,400000007,005904600,070608030,008502100,900000005,000781000,060000010,Grid,904200007,010000000,000706500,000800090,020904060,040002000,001607000,000000030,300005702,Grid,000700800,006000031,040002000,024070000,010030080,000060290,000800070,860000500,002006000,Grid,001007090,590080001,030000080,000005800,050060020,004100000,080000030,100020079,020700400,Grid,000003017,015009008,060000000,100007000,009000200,000500004,000000020,500600340,340200000,Grid,300200000,000107000,706030500,070009080,900020004,010800050,009040301,000702000,000008006";
//  
  // Variable to hold the string data for each of the boards.
  NSString * sudokuBoards = @"003020600,900305001,001806400,008102900,700000008,006708200,002609500,800203009,005010300,Grid,200080300,060070084,030500209,000105408,000000000,402706000,301007040,720040060,004010003,Grid,000000907,000420180,000705026,100904000,050000040,000507009,920108000,034059000,507000000,Grid,030050040,008010500,460000012,070502080,000603000,040109030,250000098,001020600,080060020,Grid,020810740,700003100,090002805,009040087,400208003,160030200,302700060,005600008,076051090,Grid,170920000,524010000,000000070,050008132,000000000,402700090,060000000,000030945,000071006,Grid,143080250,600000000,000001094,900004070,000608000,010200003,820500000,000000005,034090710,Grid,480006902,002008001,900370060,840010200,003704100,001060049,020085007,700900600,609200018,Grid,000900002,050123400,030000160,908000000,070000090,000000205,091000050,007439020,400007000,Grid,001900003,900700160,030005007,050000009,004302600,200000070,600100030,042007006,500006800,Grid,000125400,008400000,420800000,030000095,060902010,510000060,000003049,000007200,001298000,Grid,062340750,100005600,570000040,000094800,400000006,005830000,030000091,006400007,059083260,Grid,300000000,005009000,200504000,020000700,160000058,704310600,000890100,000067080,000005437,Grid,630000000,000500008,005674000,000020000,003401020,000000345,000007004,080300902,947100080,Grid,000020040,008035000,000070602,031046970,200000000,000501203,049000730,000000010,800004000,Grid,361025900,080960010,400000057,008000471,000603000,259000800,740000005,020018060,005470329,Grid,050807020,600010090,702540006,070020301,504000908,103080070,900076205,060090003,080103040,Grid,080005000,000003457,000070809,060400903,007010500,408007020,901020000,842300000,000100080,Grid,003502900,000040000,106000305,900251008,070408030,800763001,308000104,000020000,005104800,Grid,000000000,009805100,051907420,290401065,000000000,140508093,026709580,005103600,000000000,Grid,020030090,000907000,900208005,004806500,607000208,003102900,800605007,000309000,030020050,Grid,005000006,070009020,000500107,804150000,000803000,000092805,907006000,030400010,200000600,Grid,040000050,001943600,009000300,600050002,103000506,800020007,005000200,002436700,030000040,Grid,004000000,000030002,390700080,400009001,209801307,600200008,010008053,900040000,000000800,Grid,360020089,000361000,000000000,803000602,400603007,607000108,000000000,000418000,970030014,Grid,500400060,009000800,640020000,000001008,208000501,700500000,000090084,003000600,060003002,Grid,007256400,400000005,010030060,000508000,008060200,000107000,030070090,200000004,006312700,Grid,000000000,079050180,800000007,007306800,450708096,003502700,700000005,016030420,000000000,Grid,030000080,009000500,007509200,700105008,020090030,900402001,004207100,002000800,070000090,Grid,200170603,050000100,000006079,000040700,000801000,009050000,310400000,005000060,906037002,Grid,000000080,800701040,040020030,374000900,000030000,005000321,010060050,050802006,080000000,Grid,000000085,000210009,960080100,500800016,000000000,890006007,009070052,300054000,480000000,Grid,608070502,050608070,002000300,500090006,040302050,800050003,005000200,010704090,409060701,Grid,050010040,107000602,000905000,208030501,040070020,901080406,000401000,304000709,020060010,Grid,053000790,009753400,100000002,090080010,000907000,080030070,500000003,007641200,061000940,Grid,006080300,049070250,000405000,600317004,007000800,100826009,000702000,075040190,003090600,Grid,005080700,700204005,320000084,060105040,008000500,070803010,450000091,600508007,003010600,Grid,000900800,128006400,070800060,800430007,500000009,600079008,090004010,003600284,001007000,Grid,000080000,270000054,095000810,009806400,020403060,006905100,017000620,460000038,000090000,Grid,000602000,400050001,085010620,038206710,000000000,019407350,026040530,900020007,000809000,Grid,000900002,050123400,030000160,908000000,070000090,000000205,091000050,007439020,400007000,Grid,380000000,010400785,009020300,060090000,800302009,000040070,001070500,495006000,000000092,Grid,000158000,002060800,030000040,027030510,000000000,046080790,050000080,004070100,000325000,Grid,010500200,900001000,002008030,500030007,008000500,600080004,040100700,000700006,003004050,Grid,080000040,000469000,400000007,005904600,070608030,008502100,900000005,000781000,060000010,Grid,904200007,010000000,000706500,000800090,020904060,040002000,001607000,000000030,300005702,Grid,000700800,006000031,040002000,024070000,010030080,000060290,000800070,860000500,002006000,Grid,041007090,590080001,030000080,000005800,050060020,004100000,080000030,100020079,020700400,Grid,000803017,015009008,060000000,100007000,009000200,000500004,000000020,500600340,340200000,Grid,371200000,000107000,706030500,070009080,900020004,010800050,009040301,000702000,000008006";
  
  // Variable array to hold all the boards to search over.
  NSArray * boardsArray = [sudokuBoards componentsSeparatedByString:@",Grid,"];
  
  // Variable to hold the sum of the top left 3-digit numbers in the top left
  // hand corner from each board.
  uint sum = 0;
  
  uint index = 1;
  
  // For all the game boards as strings,
  for(NSString * gameBoard in boardsArray){
    // Add the value of the top left hand corner to the sum.
    sum += [self topLeftCornerNumberForBoard:gameBoard];
    
    NSLog(@" ");
    NSLog(@"Grid %d", index);
    NSLog(@" ");
    
    index++;
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%d", sum];
  
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
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
//    // Set the answer string to the number of paths.
//    self.answer = [NSString stringWithFormat:@"%llu", numberOfPaths];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated brute force computation time to the calculated value. We
    // use scientific notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question96 (Private)

- (uint)topLeftCornerNumberForBoard:(NSString *)aBoard; {
  // Variable array to hold all the rows for the board to search over.
  NSArray * boardsArray = [aBoard componentsSeparatedByString:@","];
  
  uint sum = 0;
  uint group = 0;
  uint column = 0;
  
  SudokuCoordinate * sudokuCoordinate = nil;
  
  NSMutableArray * rowArray = nil;
  NSMutableArray * rowsArray = [[NSMutableArray alloc] initWithCapacity:9];
  
  NSMutableArray * groupArray = nil;
  NSMutableArray * groupsArray = [[NSMutableArray alloc] initWithCapacity:9];
  
  NSMutableArray * columnArray = nil;
  NSMutableArray * columnsArray = [[NSMutableArray alloc] initWithCapacity:9];
  
  NSMutableArray * topLeftHandCornerElements = [[NSMutableArray alloc] initWithCapacity:3];
  
  // Variable to hold the current index range for the row string.
  NSRange subStringRange = NSMakeRange(0, 0);
  
  for(int i = 0; i < 9; i++){
    rowArray = [[NSMutableArray alloc] initWithCapacity:9];
    [rowsArray addObject:rowArray];
    
    groupArray = [[NSMutableArray alloc] initWithCapacity:9];
    [groupsArray addObject:groupArray];
    
    columnArray = [[NSMutableArray alloc] initWithCapacity:9];
    [columnsArray addObject:columnArray];
  }
  
  if([boardsArray count] != 9){
    NSLog(@"There isn't enough rows!");
    
    return 0;
  }
  
  NSString * rowString = nil;
  uint numberRemaining = 9*9;
  uint coordinateNumber = 0;
  
  for(int row = 0; row < [boardsArray count]; row++){
    rowString = [boardsArray objectAtIndex:row];
    
    if(rowString.length != 9){
      NSLog(@"There isn't enough elements in row: %d!", row);
      
      return 0;
    }
    else{
      column = 0;
      
      // While the character index is greater than 0,
      while(column < rowString.length){
        // Compute the range of the next index.
        subStringRange = NSMakeRange(column, 1);
        
        coordinateNumber = [[rowString substringWithRange:subStringRange] intValue];
        
        sudokuCoordinate = [[SudokuCoordinate alloc] initWithNumber:coordinateNumber row:row column:column];
        
        if(coordinateNumber > 0){
          numberRemaining--;
        }
        
        rowArray = [rowsArray objectAtIndex:row];
        [rowArray addObject:sudokuCoordinate];
        
        columnArray = [columnsArray objectAtIndex:column];
        [columnArray addObject:sudokuCoordinate];
        
        group = (row / 3) * 3 + (column / 3);
        
        groupArray = [groupsArray objectAtIndex:group];
        [groupArray addObject:sudokuCoordinate];
        
        if((row == 0) && (column < 3)){
          [topLeftHandCornerElements addObject:sudokuCoordinate];
        }
        column++;
      }
    }
  }
  SudokuGroup * sudokuGroup = nil;
  NSMutableArray * sudokuGroups = [[NSMutableArray alloc] initWithCapacity:3*9];
  
  for(NSMutableArray * row in rowsArray){
    sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:row type:SudokuGroupType_Row];
    [sudokuGroups addObject:sudokuGroup];
  }
  for(NSMutableArray * column in columnsArray){
    sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:column type:SudokuGroupType_Column];
    [sudokuGroups addObject:sudokuGroup];
  }
  for(NSMutableArray * group in groupsArray){
    sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:group type:SudokuGroupType_Square];
    [sudokuGroups addObject:sudokuGroup];
  }
  
  BOOL hasNumber = NO;
  BOOL hasCheckedForPairs = NO;
  BOOL addedANewNumberFromGroups = NO;
  
  uint lastNumberRemaining = 0;
  
  while(!hasNumber){
    for(SudokuGroup * sudokuGroup in sudokuGroups){
      [sudokuGroup updatePotentials];
    }
    for(SudokuGroup * sudokuGroup in sudokuGroups){
      if(sudokuGroup.type == SudokuGroupType_Row){
        [sudokuGroup updateNumbers];
      }
    }
    hasNumber = YES;
    
//    for(SudokuGroup * sudokuGroup in sudokuGroups){
//      if([sudokuGroup groupIsValid] == NO){
//        hasNumber = NO;
//        
//        break;
//      }
//    }
    
    for(SudokuCoordinate * coordinate in topLeftHandCornerElements){
      if(coordinate.number == 0){
        hasNumber = NO;
        break;
      }
    }
    if(hasNumber){
      for(int i = 0; i < [topLeftHandCornerElements count]; i++){
        sudokuCoordinate = [topLeftHandCornerElements objectAtIndex:i];
        sum += sudokuCoordinate.number * ((uint)pow(10, (2 - i)));
      }
      //NSLog(@"found");
    }
    else{
      numberRemaining = 0;
      
      for(SudokuGroup * sudokuGroup in sudokuGroups){
        if(sudokuGroup.type == SudokuGroupType_Row){
          numberRemaining += [sudokuGroup remaining];
        }
      }
      //NSLog(@"Remaining: %d", numberRemaining);
      
      if(lastNumberRemaining == numberRemaining){
        addedANewNumberFromGroups = YES;
        
        for(SudokuGroup * sudokuGroup in sudokuGroups){
          if([sudokuGroup hasUpdatedACoordinate]){
            addedANewNumberFromGroups = NO;
            break;
          }
        }
        if(addedANewNumberFromGroups){
          if(!hasCheckedForPairs){
            for(SudokuGroup * sudokuGroup in sudokuGroups){
              [sudokuGroup checkForPairsAndEliminate];
            }
            hasCheckedForPairs = YES;
          }
          else{
            // http://stackoverflow.com/questions/5766264/how-to-copy-a-nsmutablearray
            NSLog(@"Something went wrong!");
            NSLog(@" ");
            for(SudokuGroup * sudokuGroup in sudokuGroups){
              if(sudokuGroup.type == SudokuGroupType_Row){
                NSLog(@"%@", [sudokuGroup rowNumbers]);
              }
            }
            NSLog(@" ");
            
            for(SudokuGroup * sudokuGroup in sudokuGroups){
              if(sudokuGroup.type == SudokuGroupType_Row){
               NSLog(@"%@", [sudokuGroup indexAValuesOfPair]);
              }
            }
            
            break;
          }
        }
      }
      else{
        hasCheckedForPairs = NO;
        lastNumberRemaining = numberRemaining;
      }
    }
  }
  return sum;
}

@end