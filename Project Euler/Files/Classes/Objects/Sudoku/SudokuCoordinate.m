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
  if((_number == 0) && (number != 0)){
    _number = number;
    
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = NO;
    }
    _numberRemaining = 0;
    //NSLog(@"row: %d, col: %d, value: %d", _row, _column, _number);
  }
}

#pragma mark - Init

- (id)initWithNumber:(uint)aNumber row:(uint)aRow column:(uint)aColumn; {
  if((self = [super init])){
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = YES;
    }
    _possibleValues[0] = NO;
    _row = aRow;
    _column = aColumn;
    _number = 0;
    self.number = aNumber;
    _numberRemaining = (PotentialNumbers - 1);
  }
  return self;
}

#pragma mark - Copy

- (id)copyWithZone:(NSZone *)zone; {
  SudokuCoordinate * copy = [[SudokuCoordinate alloc] initWithNumber:self.number row:self.row column:self.column];
  
  if(copy){
    copy.numberRemaining = self.numberRemaining;
    [copy setPossibleValues:_possibleValues];
  }
  return copy;
}

#pragma mark - Methods

- (void)checkNumbers; {
  uint index = 0;
  uint numberOfPotentials = 0;
  
  for(int number = 1; number < PotentialNumbers; number++){
    if(_possibleValues[number]){
      numberOfPotentials++;
      index = number;
    }
    if(numberOfPotentials > 1){
      break;
    }
  }
  if(numberOfPotentials == 1){
    _number = index;
    
    for(int number = 1; number < PotentialNumbers; number++){
      _possibleValues[number] = NO;
    }
    _numberRemaining = 0;
  }
}

- (void)setPossibleValues:(BOOL *)aPossibleValues; {
  for(int number = 1; number < PotentialNumbers; number++){
    _possibleValues[number] = aPossibleValues[number];
  }
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
  return isAPair;
}

@end