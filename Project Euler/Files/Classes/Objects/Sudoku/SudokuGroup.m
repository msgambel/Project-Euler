//  SudokuGroup.m

#import "SudokuGroup.h"

@implementation SudokuGroup

@synthesize type = _type;

#pragma mark - Init

- (id)initWithSudokuCoordinates:(NSMutableArray *)sudokuCoordinates type:(SudokuGroupType)aType; {
  if((self = [super init])){
    for(int i = 1; i < PotentialNumbers; i++){
      _isNumberRemaining[i] = YES;
    }
    _isNumberRemaining[0] = NO;
    _isComplete = NO;
    _type = aType;
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
    //[self updatePotentials];
  }
  return self;
}

#pragma mark - Copy

- (id)copyWithZone:(NSZone *)zone; {
  SudokuGroup * copy = [[SudokuGroup alloc] initWithSudokuCoordinates:_sudokuCoordinates type:_type];
  
  if(copy){
    [copy setRemainingNumbers:_isNumberRemaining];
    [copy updatePotentials];
  }
  return copy;
}

#pragma mark - Methods

- (void)updateNumbers; {
  if(!_isComplete){
//    uint numberOfPotentials = 0;
//    SudokuCoordinate * sudokuCoordinate = nil;
//    
//    for(int i = 1; i < PotentialNumbers; i++){
//      //if(_isNumberRemaining[i]){
//        numberOfPotentials = 0;
//        
//        for(SudokuCoordinate * coordinate in _sudokuCoordinates){
//          if([coordinate isNumberPotential:i]){
//            numberOfPotentials++;
//            sudokuCoordinate = coordinate;
//            
//            if(numberOfPotentials > 1){
//              break;
//            }
//          }
//        }
//        if(numberOfPotentials == 1){
//          sudokuCoordinate.number = i;
//          _isNumberRemaining[i] = NO;
//          
//          for(SudokuCoordinate * otherCoordinate in _sudokuCoordinates){
//            [otherCoordinate removeFromPossibilitiesTheNumber:i];
//          }
//          _isComplete = YES;
//          
//          for(int number = 1; number < PotentialNumbers; number++){
//            if(_isNumberRemaining[number]){
//              _isComplete = NO;
//              break;
//            }
//          }
//        }
//      //}
//    }
    
    
    for(SudokuCoordinate * sudokuCoordinate in _sudokuCoordinates){
      [sudokuCoordinate checkNumbers];
    }
    
    //[self updatePotentials];
  }
}

- (void)updatePotentials; {
  if(!_isComplete){
    uint coordinateNumber = 0;
    
    for(SudokuCoordinate * coordinate in _sudokuCoordinates){
      coordinateNumber = coordinate.number;
      // The coordinate number could be from another number!
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

- (void)checkForPairsAndEliminate; {
  uint numberOfCoordinatesWith2Remaining = 0;
  
  for(SudokuCoordinate * coordinate in _sudokuCoordinates){
    if(coordinate.numberRemaining == 2){
      numberOfCoordinatesWith2Remaining++;
    }
  }
  if(numberOfCoordinatesWith2Remaining >= 2){
    SudokuCoordinate * sudokuCoordinate1 = nil;
    SudokuCoordinate * sudokuCoordinate2 = nil;
    SudokuCoordinate * sudokuCoordinate3 = nil;
    
    for(int i = 0; i < [_sudokuCoordinates count]; i++){
      sudokuCoordinate1 = [_sudokuCoordinates objectAtIndex:i];
      
      if(sudokuCoordinate1.numberRemaining == 2){
        for(int j = 0; j < [_sudokuCoordinates count]; j++){
          if(j != i){
            sudokuCoordinate2 = [_sudokuCoordinates objectAtIndex:j];
            
            if([sudokuCoordinate1 isPairWith:sudokuCoordinate2]){
              //NSLog(@"Found a pair!");
              for(int number = 1; number < PotentialNumbers; number++){
                if([sudokuCoordinate1 isNumberPotential:number]){
                  //NSLog(@"num: %d", number);
                  for(int k = 0; k < [_sudokuCoordinates count]; k++){
                    if((k != i) && (k != j)){
                      sudokuCoordinate3 = [_sudokuCoordinates objectAtIndex:k];
                      [sudokuCoordinate3 removeFromPossibilitiesTheNumber:number];
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

- (void)setRemainingNumbers:(BOOL *)aRemainingNumbers; {
  for(int i = 1; i < PotentialNumbers; i++){
    _isNumberRemaining[i] = aRemainingNumbers[i];
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

- (uint)remaining; {
  uint remainingNumber = 0;
  
  if(!_isComplete){
    for(int number = 1; number < PotentialNumbers; number++){
      if(_isNumberRemaining[number]){
        remainingNumber++;
      }
    }
  }
  return remainingNumber;
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

- (NSString *)indexAValuesOfPair; {
  NSString * returnValue = nil;
  
  for(SudokuCoordinate * coordinate in _sudokuCoordinates){
    if(coordinate.numberRemaining == 2){
      returnValue = [NSString stringWithFormat:@"%d,%d", coordinate.row, coordinate.column];
      
      for(int number = 1; number < PotentialNumbers; number++){
        if([coordinate isNumberPotential:number]){
          returnValue = [NSString stringWithFormat:@"%@,%d", returnValue, number];
        }
      }
      // Break out of the loop.
      break;
    }
  }
  return returnValue;
}

@end