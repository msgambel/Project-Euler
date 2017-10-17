//  SudokuCoordinate.m

#import "SudokuCoordinate.h"

@implementation SudokuCoordinate

@synthesize row = _row;
@synthesize column = _column;
@synthesize numberRemaining = _numberRemaining;

#pragma mark - Getters

- (uint)number; {
  return _number;
}

#pragma mark - Setters

- (void)setNumber:(uint)number; {
  if((_number == 0) && (number != 0) && (number < PotentialNumbers)){
    _number = number;
    
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = NO;
    }
    _numberRemaining = 0;
  }
}

#pragma mark - Init

- (id)initWithNumber:(uint)aNumber group:(uint)aGroup row:(uint)aRow column:(uint)aColumn; {
  if((self = [super init])){
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = YES;
    }
    _possibleValues[0] = NO;
    _row = aRow;
    _group = aGroup;
    _column = aColumn;
    _number = 0;
    self.number = aNumber;
    _numberRemaining = (PotentialNumbers - 1);
  }
  return self;
}

#pragma mark - Copy

- (id)copyWithZone:(NSZone *)zone; {
  SudokuCoordinate * copy = [[SudokuCoordinate alloc] initWithNumber:self.number group:self.group row:self.row column:self.column];
  
  if(copy){
    [copy setPossibleValues:_possibleValues];
  }
  return copy;
}

#pragma mark - Methods

- (void)print; {
  NSLog(@"SudokuCoordinate row: %d, col: %d, value: %d", _row, _column, _number);
}

- (void)checkNumbers; {
  uint actualNumber = 0;
  uint numberOfPotentials = 0;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_possibleValues[number]){
      numberOfPotentials++;
      actualNumber = number;
    }
    if(numberOfPotentials > 1){
      break;
    }
  }
  if(numberOfPotentials == 1){
    _number = actualNumber;
    
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = NO;
    }
    _numberRemaining = 0;
  }
}

- (void)setPossibleValues:(BOOL *)aPossibleValues; {
  uint numberRemaining = 0;
  
  for(int number = 1; number < PotentialNumbers; number++){
    _possibleValues[number] = aPossibleValues[number];
    
    if(_possibleValues[number]){
      numberRemaining++;
    }
  }
  _numberRemaining = numberRemaining;
}

- (void)removeFromPossibilitiesTheNumber:(uint)aNumber; {
  if(aNumber < PotentialNumbers){
    if(_possibleValues[aNumber]){
      _numberRemaining--;
      _possibleValues[aNumber] = NO;
    }
  }
}

- (BOOL)isNumberPotential:(uint)aNumber; {
  if(_number > 0){
    return NO;
  }
  else{
    if(aNumber < PotentialNumbers){
      return _possibleValues[aNumber];
    }
    else{
      return NO;
    }
  }
}

- (BOOL)isPairWith:(SudokuCoordinate *)aSudokuCoordinate; {
  BOOL isAPair = YES;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_possibleValues[number] != [aSudokuCoordinate isNumberPotential:number]){
      isAPair = NO;
      break;
    }
  }
  return (aSudokuCoordinate != self) && (_numberRemaining == 2) && isAPair;
}

- (BOOL)isATripleWithFirstCoordinage:(SudokuCoordinate *)aFirstSudokuCoordinate secondCoordinage:(SudokuCoordinate *)aSecondSudokuCoordinate; {
  uint firstDifferences = 0;
  uint secondDifferences = 0;
  uint thirdDifferences = 0;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_possibleValues[number] != [aFirstSudokuCoordinate isNumberPotential:number]){
      firstDifferences++;
    }
    if(_possibleValues[number] != [aSecondSudokuCoordinate isNumberPotential:number]){
      secondDifferences++;
    }
    if([aFirstSudokuCoordinate isNumberPotential:number] != [aSecondSudokuCoordinate isNumberPotential:number]){
      thirdDifferences++;
    }
  }
  return (aFirstSudokuCoordinate != self) && (aSecondSudokuCoordinate != self) && (aFirstSudokuCoordinate != aSecondSudokuCoordinate) && (_numberRemaining <= 3) && (_numberRemaining >= 2) && (aFirstSudokuCoordinate.numberRemaining <= 3) && (aFirstSudokuCoordinate.numberRemaining >= 2) && (aSecondSudokuCoordinate.numberRemaining <= 3)&& (aSecondSudokuCoordinate.numberRemaining >= 2)  && (firstDifferences < 2) && (secondDifferences < 2) && (thirdDifferences < 2);
}

@end
