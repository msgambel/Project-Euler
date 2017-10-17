//  SudokuGroup.m

#import "SudokuGroup.h"
#import "SudokuBoard.h"

@implementation SudokuGroup

@synthesize type = _type;
@synthesize index = _index;
@synthesize isComplete = _isComplete;
@synthesize sudokuBoard = _sudokuBoard;
@synthesize sudokuCoordinates = _sudokuCoordinates;

#pragma mark - Init

- (id)initWithSudokuCoordinates:(NSMutableArray *)sudokuCoordinates type:(SudokuGroupType)aType index:(uint)aIndex; {
  if((self = [super init])){
    for(int i = 1; i < PotentialNumbers; i++){
      _isNumberRemaining[i] = YES;
    }
    _isNumberRemaining[0] = NO;
    _isComplete = NO;
    _type = aType;
    _index = aIndex;
    _sudokuCoordinates = sudokuCoordinates;
    
    for(SudokuCoordinate * coordinate in _sudokuCoordinates){
      _isNumberRemaining[coordinate.number] = NO;
    }
    for(int i = 1; i < PotentialNumbers; i++){
      if(!_isNumberRemaining[i]){
        for(SudokuCoordinate * coordinate in _sudokuCoordinates){
          [coordinate removeFromPossibilitiesTheNumber:i];
        }
      }
    }
  }
  return self;
}

#pragma mark - Copy

- (id)copyWithZone:(NSZone *)zone; {
  SudokuGroup * copy = [[SudokuGroup alloc] initWithSudokuCoordinates:_sudokuCoordinates type:_type index:_index];
  
  if(copy){
    [copy setRemainingNumbers:_isNumberRemaining];
    [copy updatePotentials];
  }
  return copy;
}

#pragma mark - Methods

- (void)updateNumbers; {
  if(!_isComplete){
    for(SudokuCoordinate * sudokuCoordinate in _sudokuCoordinates){
      [sudokuCoordinate checkNumbers];
    }
  }
}

- (void)updatePotentials; {
  if(!_isComplete){
    uint coordinateNumber = 0;
    
    for(SudokuCoordinate * coordinate in _sudokuCoordinates){
      coordinateNumber = coordinate.number;
      
      if(coordinateNumber > 0){
        for(SudokuCoordinate * otherCoordinate in _sudokuCoordinates){
          [otherCoordinate removeFromPossibilitiesTheNumber:coordinateNumber];
        }
        _isNumberRemaining[coordinateNumber] = NO;
      }
    }
    _isComplete = YES;
    
    for(int number = 1; number < PotentialNumbers; number++){
      if(_isNumberRemaining[number]){
        _isComplete = NO;
        break;
      }
    }
  }
}

- (void)setRemainingNumbers:(BOOL *)aRemainingNumbers; {
  for(int index = 1; index < PotentialNumbers; index++){
    _isNumberRemaining[index] = aRemainingNumbers[index];
  }
}

- (void)removePossibleValue:(uint)aPossibleValue notInRow:(uint)aRow; {
  for(int index = 0; index < [_sudokuCoordinates count]; index++){
    SudokuCoordinate * sudokuCoordinate = [_sudokuCoordinates objectAtIndex:index];
    
    if(sudokuCoordinate.row != aRow){
      [sudokuCoordinate removeFromPossibilitiesTheNumber:aPossibleValue];
    }
  }
}

- (void)removePossibleValue:(uint)aPossibleValue notInGroup:(uint)aGroup; {
  for(int index = 0; index < [_sudokuCoordinates count]; index++){
    SudokuCoordinate * sudokuCoordinate = [_sudokuCoordinates objectAtIndex:index];
    
    if(sudokuCoordinate.group != aGroup){
      [sudokuCoordinate removeFromPossibilitiesTheNumber:aPossibleValue];
    }
  }
}

- (void)removePossibleValue:(uint)aPossibleValue notInColumn:(uint)aColumn; {
  for(int index = 0; index < [_sudokuCoordinates count]; index++){
    SudokuCoordinate * sudokuCoordinate = [_sudokuCoordinates objectAtIndex:index];
    
    if(sudokuCoordinate.column != aColumn){
      [sudokuCoordinate removeFromPossibilitiesTheNumber:aPossibleValue];
    }
  }
}

- (void)removePossibleValue:(uint)aPossibleValue notInRow:(uint)aRow orRow:(uint)aSecondRow; {
  for(int index = 0; index < [_sudokuCoordinates count]; index++){
    SudokuCoordinate * sudokuCoordinate = [_sudokuCoordinates objectAtIndex:index];
    
    if((sudokuCoordinate.row != aRow) && (sudokuCoordinate.row != aSecondRow)){
      [sudokuCoordinate removeFromPossibilitiesTheNumber:aPossibleValue];
    }
  }
}

- (BOOL)groupIsValid; {
  BOOL isValid = YES;
  BOOL coordinateValues[PotentialNumbers];
  
  for(int i = 1; i < PotentialNumbers; i++){
    coordinateValues[i] = NO;
  }
  for(SudokuCoordinate * coordinate in _sudokuCoordinates){
    if(coordinateValues[coordinate.number]){
      isValid = NO;
      break;
    }
    else{
      coordinateValues[coordinate.number] = YES;
    }
  }
  return isValid;
}

- (BOOL)hasFoundAHiddenSingle; {
  BOOL hasHiddenSingle = NO;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_isNumberRemaining[number]){
      hasHiddenSingle = YES;
      SudokuCoordinate * singleSudokuCoordinate = nil;
      
      for(SudokuCoordinate * coordinate in _sudokuCoordinates){
        if([coordinate isNumberPotential:number]){
          if(singleSudokuCoordinate != nil){
            hasHiddenSingle = NO;
            break;
          }
          else{
            singleSudokuCoordinate = coordinate;
          }
        }
      }
      if(hasHiddenSingle){
        singleSudokuCoordinate.number = number;
        break;
      }
    }
  }
  return hasHiddenSingle;
}

- (void)hasFoundANakedPair; {
  BOOL hasNakedPair = NO;
  
  for(uint firstIndex = 0; firstIndex < [_sudokuCoordinates count]; firstIndex++){
    SudokuCoordinate * firstCoordinate = [_sudokuCoordinates objectAtIndex:firstIndex];
    
    for(uint secondIndex = (firstIndex + 1); secondIndex < [_sudokuCoordinates count]; secondIndex++){
      SudokuCoordinate * secondCoordinate = [_sudokuCoordinates objectAtIndex:secondIndex];
      
      if([firstCoordinate isPairWith:secondCoordinate]){
        hasNakedPair = YES;
        uint firstNumber = 0;
        uint secondNumber = 0;
        
        for(int number = 1; number < PotentialNumbers; number++){
          if(_isNumberRemaining[number]){
            if([firstCoordinate isNumberPotential:number]){
              if(firstNumber > 0){
                secondNumber = number;
                break;
              }
              else{
                firstNumber = number;
              }
            }
          }
        }
        for(SudokuCoordinate * coordinate in _sudokuCoordinates){
          if((coordinate != firstCoordinate) && (coordinate != secondCoordinate)){
            [coordinate removeFromPossibilitiesTheNumber:firstNumber];
            [coordinate removeFromPossibilitiesTheNumber:secondNumber];
          }
        }
        break;
      }
    }
    if(hasNakedPair){
      break;
    }
  }
}

- (void)hasFoundAHiddenPair; {
  BOOL hasHiddenPair = NO;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_isNumberRemaining[number]){
      hasHiddenPair = YES;
      SudokuCoordinate * firstSudokuCoordinate = nil;
      SudokuCoordinate * secondSudokuCoordinate = nil;
      
      for(SudokuCoordinate * coordinate in _sudokuCoordinates){
        if([coordinate isNumberPotential:number]){
          if(firstSudokuCoordinate != nil){
            if(secondSudokuCoordinate != nil){
              hasHiddenPair = NO;
              break;
            }
            else{
              secondSudokuCoordinate = coordinate;
            }
          }
          else{
            firstSudokuCoordinate = coordinate;
          }
        }
      }
      if(hasHiddenPair){
        uint secondPairNumber = 0;
        
        for(int secondNumber = (number + 1); secondNumber < PotentialNumbers; secondNumber++){
          if(_isNumberRemaining[secondNumber]){
            if([firstSudokuCoordinate isNumberPotential:secondNumber] && [secondSudokuCoordinate isNumberPotential:secondNumber]){
              secondPairNumber = secondNumber;
              
              for(SudokuCoordinate * coordinate in _sudokuCoordinates){
                if((coordinate != firstSudokuCoordinate) && (coordinate != secondSudokuCoordinate)){
                  if([coordinate isNumberPotential:secondNumber]){
                    secondPairNumber = 0;
                    break;
                  }
                }
              }
              if(secondPairNumber > 0){
                break;
              }
            }
          }
        }
        if(secondPairNumber > 0){
          for(int removedNumber = 1; removedNumber < PotentialNumbers; removedNumber++){
            if(_isNumberRemaining[removedNumber] && (removedNumber != number) && (removedNumber != secondPairNumber)){
              [firstSudokuCoordinate removeFromPossibilitiesTheNumber:removedNumber];
              [secondSudokuCoordinate removeFromPossibilitiesTheNumber:removedNumber];
            }
          }
          break;
        }
      }
    }
  }
}

- (void)hasFoundANakedTriple; {
  BOOL hasNakedTriple = NO;
  
  for(uint firstIndex = 0; firstIndex < [_sudokuCoordinates count]; firstIndex++){
    SudokuCoordinate * firstCoordinate = [_sudokuCoordinates objectAtIndex:firstIndex];
    
    for(uint secondIndex = (firstIndex + 1); secondIndex < [_sudokuCoordinates count]; secondIndex++){
      SudokuCoordinate * secondCoordinate = [_sudokuCoordinates objectAtIndex:secondIndex];
      
      for(uint thirdIndex = (secondIndex + 1); thirdIndex < [_sudokuCoordinates count]; thirdIndex++){
        SudokuCoordinate * thirdCoordinate = [_sudokuCoordinates objectAtIndex:thirdIndex];
        
        if([firstCoordinate isATripleWithFirstCoordinage:secondCoordinate secondCoordinage:thirdCoordinate]){
          hasNakedTriple = YES;
          uint firstNumber = 0;
          uint secondNumber = 0;
          uint thirdNumber = 0;
          SudokuCoordinate * coordinateWith3Potentials = nil;
          
          if(firstCoordinate.numberRemaining == 3){
            coordinateWith3Potentials = firstCoordinate;
          }
          else if(secondCoordinate.numberRemaining == 3){
            coordinateWith3Potentials = secondCoordinate;
          }
          else if(thirdCoordinate.numberRemaining == 3){
            coordinateWith3Potentials = thirdCoordinate;
          }
          for(int number = 1; number < PotentialNumbers; number++){
            if(_isNumberRemaining[number]){
              if([coordinateWith3Potentials isNumberPotential:number]){
                if(firstNumber > 0){
                  if(secondNumber > 0){
                    thirdNumber = number;
                    break;
                  }
                  else{
                    secondNumber = number;
                  }
                }
                else{
                  firstNumber = number;
                }
              }
            }
          }
          for(SudokuCoordinate * coordinate in _sudokuCoordinates){
            if((coordinate != firstCoordinate) && (coordinate != secondCoordinate) && (coordinate != thirdCoordinate)){
              [coordinate removeFromPossibilitiesTheNumber:firstNumber];
              [coordinate removeFromPossibilitiesTheNumber:secondNumber];
              [coordinate removeFromPossibilitiesTheNumber:thirdNumber];
            }
          }
          break;
        }
      }
      if(hasNakedTriple){
        break;
      }
    }
    if(hasNakedTriple){
      break;
    }
  }
}

- (BOOL)hasUpdatedACoordinate; {
  if(_isComplete){
    return NO;
  }
  else{
    uint numberOfPotentials = 0;
    SudokuCoordinate * sudokuCoordinate = nil;
    
    for(int i = 1; i < PotentialNumbers; i++){
      if(_isNumberRemaining[i]){
        numberOfPotentials = 0;
        
        for(SudokuCoordinate * coordinate in _sudokuCoordinates){
          if([coordinate isNumberPotential:i]){
            numberOfPotentials++;
            sudokuCoordinate = coordinate;
            
            if(numberOfPotentials > 1){
              break;
            }
          }
        }
        if(numberOfPotentials == 1){
          sudokuCoordinate.number = i;
          _isNumberRemaining[i] = NO;
          
          for(SudokuCoordinate * otherCoordinate in _sudokuCoordinates){
            [otherCoordinate removeFromPossibilitiesTheNumber:i];
          }
          _isComplete = YES;
          
          for(int number = 1; number < PotentialNumbers; number++){
            if(_isNumberRemaining[number]){
              _isComplete = NO;
              break;
            }
          }
          break;
        }
      }
    }
    return (numberOfPotentials == 1);
  }
}

- (void)hasRemovedLockedPotentials; {
  for(int number = 1; number < PotentialNumbers; number++){
    uint row = PotentialNumbers;
    uint group = PotentialNumbers;
    uint column = PotentialNumbers;
    
    for(SudokuCoordinate * sudokuCoordinate in _sudokuCoordinates){
      if([sudokuCoordinate isNumberPotential:number]){
        if(row != (PotentialNumbers + 1)){
          if(row == PotentialNumbers){
            row = sudokuCoordinate.row;
          }
          else if(row != sudokuCoordinate.row){
            row = (PotentialNumbers + 1);
          }
        }
        if(group != (PotentialNumbers + 1)){
          if(group == PotentialNumbers){
            group = sudokuCoordinate.group;
          }
          else if(group != sudokuCoordinate.group){
            group = (PotentialNumbers + 1);
          }
        }
        if(column != (PotentialNumbers + 1)){
          if(column == PotentialNumbers){
            column = sudokuCoordinate.column;
          }
          else if(column != sudokuCoordinate.column){
            column = (PotentialNumbers + 1);
          }
        }
      }
    }
    if((_type != SudokuGroupType_Row) && (row < NumberOfRowsColumnsAndGroups)){
      if(_type == SudokuGroupType_Square){
        [self.sudokuBoard removePossibleValue:number fromRow:row notInGroup:_index];
      }
      else if(_type == SudokuGroupType_Column){
        [self.sudokuBoard removePossibleValue:number fromRow:row notInColumn:_index];
      }
    }
    if((_type != SudokuGroupType_Square) && (group < NumberOfRowsColumnsAndGroups)){
      if(_type == SudokuGroupType_Row){
        [self.sudokuBoard removePossibleValue:number fromGroup:group notInRow:_index];
      }
      else if(_type == SudokuGroupType_Column){
        [self.sudokuBoard removePossibleValue:number fromGroup:group notInColumn:_index];
      }
    }
    if((_type != SudokuGroupType_Column) && (column < NumberOfRowsColumnsAndGroups)){
      if(_type == SudokuGroupType_Row){
        [self.sudokuBoard removePossibleValue:number fromColumn:column notInRow:_index];
      }
      else if(_type == SudokuGroupType_Square){
        [self.sudokuBoard removePossibleValue:number fromColumn:column notInGroup:_index];
      }
    }
  }
}

- (uint)remainingCount; {
  uint remainingCount = 0;
  
  if(_isComplete == NO){
    for(int number = 1; number < PotentialNumbers; number++){
      if(_isNumberRemaining[number]){
        remainingCount++;
      }
    }
  }
  return remainingCount;
}

- (uint)remainingPotentialsCount; {
  uint remainingPotentialsCount = 0;
  
  if(_isComplete == NO){
    for(SudokuCoordinate * coordinate in _sudokuCoordinates){
      remainingPotentialsCount += coordinate.numberRemaining;
    }
  }
  return remainingPotentialsCount;
}

- (NSArray *)pairOfCoordinatesWithPotentialNumber:(uint)aPotentialNumber; {
  NSMutableArray * coordinatesArray = [[NSMutableArray alloc] initWithCapacity:2];
  
  if(_isNumberRemaining[aPotentialNumber]){
    for(SudokuCoordinate * coordinate in _sudokuCoordinates){
      if([coordinate isNumberPotential:aPotentialNumber]){
        [coordinatesArray addObject:coordinate];
        
        if([coordinatesArray count] > 2){
          break;
        }
      }
    }
  }
  if([coordinatesArray count] == 2){
    return [NSArray arrayWithArray:coordinatesArray];
  }
  else{
    return nil;
  }
}

- (NSString *)rowNumbers; {
  if(_type == SudokuGroupType_Row){
    NSString * inputString = @"";
    SudokuCoordinate * sudokuCoordinate = nil;
    
    for(int i = 0; i < [_sudokuCoordinates count]; i++){
      sudokuCoordinate = [_sudokuCoordinates objectAtIndex:i];
      inputString = [NSString stringWithFormat:@"%@%d", inputString, sudokuCoordinate.number];
    }
    return inputString;
  }
  else{
    return @"";
  }
}

@end
