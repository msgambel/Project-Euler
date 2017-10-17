//  SudokuBoard.m

#import "SudokuBoard.h"
#import "Global.h"
#import "SudokuGroup.h"
#import "SudokuCoordinate.h"

@interface SudokuBoard (Private)

- (void)checkForXWing;
- (void)printSudokuBoard;
- (void)printOriginalSudokuBoard;
- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInRow:(uint)aRow orRow:(uint)aSecondRow;

@end

@implementation SudokuBoard

#pragma mark - Getters

- (BOOL)solvedAndValid; {
  BOOL isValid = YES;
  
  for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
    if([sudokuGroup groupIsValid] == NO){
      isValid = NO;
      break;
    }
  }
  return isValid;
}

- (uint)numberRemaining; {
  uint numberRemaining = 0;
  
  for(SudokuGroup * sudokuGroup in _sudokuGroupRowsArray){
    numberRemaining += sudokuGroup.remainingCount;
  }
  return numberRemaining;
}

- (uint)numberOfPotentialRemaining; {
  uint potentialsRemaining = 0;
  
  for(SudokuGroup * sudokuGroup in _sudokuGroupRowsArray){
    potentialsRemaining += sudokuGroup.remainingPotentialsCount;
  }
  return potentialsRemaining;
}

#pragma mark - Init

- (id)initWithBoardString:(NSString *)aBoardString; {
  if((self = [super init])){
    [self loadBoardString:aBoardString];
  }
  return self;
}

#pragma mark - Methods

- (void)solve; {
  uint lastPotentialsRemaining = self.numberOfPotentialRemaining;
  
  while(self.numberRemaining > 0){
    for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
      [sudokuGroup updatePotentials];
      [sudokuGroup updateNumbers];
    }
    if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
      BOOL foundAHiddenSingle = NO;
      
      for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
        if([sudokuGroup hasFoundAHiddenSingle]){
          foundAHiddenSingle = YES;
          break;
        }
      }
      if(foundAHiddenSingle == NO){
        for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
          [sudokuGroup hasFoundANakedPair];
        }
        if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
          for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
            [sudokuGroup hasFoundANakedTriple];
          }
          if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
            for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
              [sudokuGroup hasFoundAHiddenPair];
            }
            if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
              for(SudokuGroup * sudokuGroup in _sudokuGroupsArray){
                [sudokuGroup hasRemovedLockedPotentials];
              }
              if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
                [self checkForXWing];
                
                if(self.numberOfPotentialRemaining == lastPotentialsRemaining){
                  NSLog(@"Something went wrong!");
                  NSLog(@" ");
                  [self printOriginalSudokuBoard];
                  NSLog(@" ");
                  NSLog(@"Solved Board");
                  NSLog(@" ");
                  [self printSudokuBoard];
                  break;
                }
              }
            }
          }
        }
      }
    }
    lastPotentialsRemaining = self.numberOfPotentialRemaining;
  }
}

- (void)loadBoardString:(NSString *)aBoardString; {
  NSArray * sudokuRowsArray = [aBoardString componentsSeparatedByString:@","];
  
  if([sudokuRowsArray count] != NumberOfRowsColumnsAndGroups){
    NSLog(@"SudokuBoard (loadBoardString:): Could not initialize with board string: %@, as there where only %d elements separated by a \",\", and does not equal %d.", aBoardString, (uint)[sudokuRowsArray count], NumberOfRowsColumnsAndGroups);
  }
  else if([aBoardString rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789,"] invertedSet]].location != NSNotFound){
    NSLog(@"SudokuBoard (loadBoardString:): Could not initialize with board string: %@, as there where characters outside of the set \"0123456789,\".", aBoardString);
  }
  else{
    _originalBoard = aBoardString;
    _rowsArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    _groupsArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    _columnsArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    
    for(uint index = 0; index < NumberOfRowsColumnsAndGroups; index++){
      NSMutableArray * rowArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
      [_rowsArray addObject:rowArray];
      NSMutableArray * groupArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
      [_groupsArray addObject:groupArray];
      NSMutableArray * columnArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
      [_columnsArray addObject:columnArray];
    }
    for(uint row = 0; row < [sudokuRowsArray count]; row++){
      NSString * rowString = [sudokuRowsArray objectAtIndex:row];
      
      if([rowString rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]].location != NSNotFound){
        NSLog(@"SudokuBoard (loadBoardString:): Could not initialize with board string: %@, as there where characters outside of the set \"0123456789,\" in the row string: %@.", aBoardString, rowString);
        _rowsArray = nil;
        _groupsArray = nil;
        _columnsArray = nil;
        _originalBoard = nil;
        break;
      }
      else if(rowString.length != NumberOfRowsColumnsAndGroups){
        NSLog(@"SudokuBoard (loadBoardString:): Could not initialize with board string: %@, as there where not enough elements %d / %d in the row string: %@.", aBoardString, (uint)rowString.length, NumberOfRowsColumnsAndGroups, rowString);
        _rowsArray = nil;
        _groupsArray = nil;
        _columnsArray = nil;
        _originalBoard = nil;
        break;
      }
      else{
        uint column = 0;
        
        // While the character index is greater than 0,
        while(column < rowString.length){
          // Compute the range of the next index.
          NSRange subStringRange = NSMakeRange(column, 1);
          uint group = (row / 3) * 3 + (column / 3);
          uint coordinateNumber = [[rowString substringWithRange:subStringRange] intValue];
          SudokuCoordinate * sudokuCoordinate = [[SudokuCoordinate alloc] initWithNumber:coordinateNumber group:group row:row column:column];
          
          NSMutableArray * rowArray = [_rowsArray objectAtIndex:row];
          [rowArray addObject:sudokuCoordinate];
          
          NSMutableArray * columnArray = [_columnsArray objectAtIndex:column];
          [columnArray addObject:sudokuCoordinate];
          
          NSMutableArray * groupArray = [_groupsArray objectAtIndex:group];
          [groupArray addObject:sudokuCoordinate];
          
          column++;
        }
      }
    }
    _sudokuGroupsArray = [[NSMutableArray alloc] initWithCapacity:(SudokuGroupType_Total * NumberOfRowsColumnsAndGroups)];
    _sudokuGroupRowsArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    _sudokuGroupSquaresArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    _sudokuGroupColumnsArray = [[NSMutableArray alloc] initWithCapacity:NumberOfRowsColumnsAndGroups];
    
    for(uint index = 0; index < [_rowsArray count]; index++){
      NSMutableArray * rowArray = [_rowsArray objectAtIndex:index];
      SudokuGroup * sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:rowArray type:SudokuGroupType_Row index:index];
      sudokuGroup.sudokuBoard = self;
      [_sudokuGroupsArray addObject:sudokuGroup];
      [_sudokuGroupRowsArray addObject:sudokuGroup];
    }
    for(uint index = 0; index < [_groupsArray count]; index++){
      NSMutableArray * groupArray = [_groupsArray objectAtIndex:index];
      SudokuGroup * sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:groupArray type:SudokuGroupType_Square index:index];
      sudokuGroup.sudokuBoard = self;
      [_sudokuGroupsArray addObject:sudokuGroup];
      [_sudokuGroupSquaresArray addObject:sudokuGroup];
    }
    for(uint index = 0; index < [_columnsArray count]; index++){
      NSMutableArray * columnArray = [_columnsArray objectAtIndex:index];
      SudokuGroup * sudokuGroup = [[SudokuGroup alloc] initWithSudokuCoordinates:columnArray type:SudokuGroupType_Column index:index];
      sudokuGroup.sudokuBoard = self;
      [_sudokuGroupsArray addObject:sudokuGroup];
      [_sudokuGroupColumnsArray addObject:sudokuGroup];
    }
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromRow:(uint)aRow notInGroup:(uint)aGroup; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInGroup:): Could not remove possible value %d from row %d, not in group %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aRow, aGroup, (PotentialNumbers - 1));
  }
  else if(aRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInGroup:): Could not remove possible value %d from row %d, not in group %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aRow, aGroup, (uint)[_rowsArray count]);
  }
  else if(aGroup > [_groupsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInGroup:): Could not remove possible value %d from row %d, not in group %d, as the group index was larger than the possible number of groups: %d", aPossibleValue, aRow, aGroup, (uint)[_groupsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupRowsArray objectAtIndex:aRow];
    [sudokuGroup removePossibleValue:aPossibleValue notInGroup:aGroup];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInGroup:(uint)aGroup; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInGroup:): Could not remove possible value %d from column %d, not in group %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aColumn, aGroup, (PotentialNumbers - 1));
  }
  else if(aColumn > [_columnsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInGroup:): Could not remove possible value %d from column %d, not in group %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aColumn, aGroup, (uint)[_columnsArray count]);
  }
  else if(aGroup > [_groupsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInGroup:): Could not remove possible value %d from column %d, not in group %d, as the group index was larger than the possible number of groups: %d", aPossibleValue, aColumn, aGroup, (uint)[_groupsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupColumnsArray objectAtIndex:aColumn];
    [sudokuGroup removePossibleValue:aPossibleValue notInGroup:aGroup];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromGroup:(uint)aGroup notInRow:(uint)aRow; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInRow:): Could not remove possible value %d from group %d, not in row %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aGroup, aRow, (PotentialNumbers - 1));
  }
  else if(aGroup > [_groupsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInRow:): Could not remove possible value %d from group %d, not in row %d, as the group index was larger than the possible number of groups: %d", aPossibleValue, aGroup, aRow, (uint)[_groupsArray count]);
  }
  else if(aRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInRow:): Could not remove possible value %d from group %d, not in row %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aGroup, aRow, (uint)[_rowsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupSquaresArray objectAtIndex:aGroup];
    [sudokuGroup removePossibleValue:aPossibleValue notInRow:aRow];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInRow:(uint)aRow; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:): Could not remove possible value %d from column %d, not in row %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aColumn, aRow, (PotentialNumbers - 1));
  }
  else if(aColumn > [_columnsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:): Could not remove possible value %d from column %d, not in row %d, as the column index was larger than the possible number of columns: %d", aPossibleValue, aColumn, aRow, (uint)[_columnsArray count]);
  }
  else if(aRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:): Could not remove possible value %d from column %d, not in row %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aColumn, aRow, (uint)[_rowsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupColumnsArray objectAtIndex:aColumn];
    [sudokuGroup removePossibleValue:aPossibleValue notInRow:aRow];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromRow:(uint)aRow notInColumn:(uint)aColumn; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInColumn:): Could not remove possible value %d from row %d, not in column %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aRow, aColumn, (PotentialNumbers - 1));
  }
  else if(aRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInColumn:): Could not remove possible value %d from row %d, not in column %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aRow, aColumn, (uint)[_rowsArray count]);
  }
  else if(aColumn > [_columnsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromRow:notInColumn:): Could not remove possible value %d from row %d, not in column %d, as the column index was larger than the possible number of columns: %d", aPossibleValue, aRow, aColumn, (uint)[_columnsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupRowsArray objectAtIndex:aRow];
    [sudokuGroup removePossibleValue:aPossibleValue notInColumn:aColumn];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromGroup:(uint)aGroup notInColumn:(uint)aColumn; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInColumn:): Could not remove possible value %d from group %d, not in column %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aGroup, aColumn, (PotentialNumbers - 1));
  }
  else if(aGroup > [_groupsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInColumn:): Could not remove possible value %d from group %d, not in column %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aGroup, aColumn, (uint)[_groupsArray count]);
  }
  else if(aColumn > [_columnsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromGroup:notInColumn:): Could not remove possible value %d from group %d, not in column %d, as the column index was larger than the possible number of columns: %d", aPossibleValue, aGroup, aColumn, (uint)[_columnsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupSquaresArray objectAtIndex:aGroup];
    [sudokuGroup removePossibleValue:aPossibleValue notInColumn:aColumn];
  }
}

- (uint)numberForTopLeftSudokuCoordinate; {
  uint returnValue = 0;
  SudokuGroup * sudokuGroup = [_sudokuGroupSquaresArray firstObject];
  
  if([sudokuGroup groupIsValid]){
    for(SudokuCoordinate * sudokuCoordinate in sudokuGroup.sudokuCoordinates){
      if(sudokuCoordinate.row == 0){
        if(sudokuCoordinate.column == 0){
          returnValue += (sudokuCoordinate.number * 100);
        }
        else if(sudokuCoordinate.column == 1){
          returnValue += (sudokuCoordinate.number * 10);
        }
        else if(sudokuCoordinate.column == 2){
          returnValue += sudokuCoordinate.number;
        }
      }
    }
  }
  return returnValue;
}

@end

@implementation SudokuBoard (Private)

- (void)checkForXWing; {
  for(uint firstIndex = 0; firstIndex < [_sudokuGroupRowsArray count]; firstIndex++){
    SudokuGroup * firstSudokuGroup = [_sudokuGroupRowsArray objectAtIndex:firstIndex];
    
    for(int number = 1; number < PotentialNumbers; number++){
      NSArray * firstCoordinatesArray = [firstSudokuGroup pairOfCoordinatesWithPotentialNumber:number];
      
      if(firstCoordinatesArray != nil){
        for(uint secondIndex = (firstIndex + 1); secondIndex < [_sudokuGroupRowsArray count]; secondIndex++){
          SudokuGroup * secondSudokuGroup = [_sudokuGroupRowsArray objectAtIndex:secondIndex];
          NSArray * secondCoordinatesArray = [secondSudokuGroup pairOfCoordinatesWithPotentialNumber:number];
          
          if(secondCoordinatesArray != nil){
            uint numberOfColumnMatches = 0;
            
            for(SudokuCoordinate * firstCoordinate in firstCoordinatesArray){
              for(SudokuCoordinate * secondCoordinate in secondCoordinatesArray){
                if(firstCoordinate.column == secondCoordinate.column){
                  numberOfColumnMatches++;
                  break;
                }
              }
            }
            if(numberOfColumnMatches == 2){
              uint secondRow = ((SudokuCoordinate *)[secondCoordinatesArray firstObject]).row;
              
              for(SudokuCoordinate * firstCoordinate in firstCoordinatesArray){
                [self removePossibleValue:number fromColumn:firstCoordinate.column notInRow:firstCoordinate.row orRow:secondRow];
              }
              break;
            }
          }
        }
      }
    }
  }
}

- (void)printSudokuBoard; {
  for(SudokuGroup * sudokuGroup in _sudokuGroupRowsArray){
    NSLog(@"%@", [sudokuGroup rowNumbers]);
  }
}

- (void)printOriginalSudokuBoard; {
  NSArray * sudokuRowsArray = [_originalBoard componentsSeparatedByString:@","];
  
  if([sudokuRowsArray count] != 9){
    NSLog(@"SudokuBoard (printSudokuBoard:): Could not print board: %@, as there where only %d elements separated by a \",\".", _originalBoard, (uint)[sudokuRowsArray count]);
  }
  else if([_originalBoard rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789,"] invertedSet]].location != NSNotFound){
    NSLog(@"SudokuBoard (printSudokuBoard:): Could not print board: %@, as there where characters outside of the set \"0123456789,\".", _originalBoard);
  }
  else{
    for(NSString * row in sudokuRowsArray){
      NSLog(@"%@", row);
    }
  }
}

- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInRow:(uint)aRow orRow:(uint)aSecondRow; {
  if(aPossibleValue >= PotentialNumbers){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:orRow:): Could not remove possible value %d from column %d, not in row %d or row %d, as the possible value was larger than the maximum number: %d", aPossibleValue, aColumn, aRow, aSecondRow, (PotentialNumbers - 1));
  }
  else if(aColumn > [_columnsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:orRow:): Could not remove possible value %d from column %d, not in row %d or row %d, as the column index was larger than the possible number of columns: %d", aPossibleValue, aColumn, aRow, aSecondRow, (uint)[_columnsArray count]);
  }
  else if(aRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:orRow:): Could not remove possible value %d from column %d, not in row %d or row %d, as the row index was larger than the possible number of rows: %d", aPossibleValue, aColumn, aRow, aSecondRow, (uint)[_rowsArray count]);
  }
  else if(aSecondRow > [_rowsArray count]){
    NSLog(@"SudokuBoard (removePossibleValue:fromColumn:notInRow:orRow:): Could not remove possible value %d from column %d, not in row %d or row %d, as the second row index was larger than the possible number of rows: %d", aPossibleValue, aColumn, aRow, aSecondRow, (uint)[_rowsArray count]);
  }
  else{
    SudokuGroup * sudokuGroup = [_sudokuGroupColumnsArray objectAtIndex:aColumn];
    [sudokuGroup removePossibleValue:aPossibleValue notInRow:aRow orRow:aSecondRow];
  }
}

@end
