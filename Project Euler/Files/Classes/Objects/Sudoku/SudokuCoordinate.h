//  SudokuCoordinate.h

#import <Foundation/Foundation.h>
#import "Global.h"

@interface SudokuCoordinate : NSObject <NSCopying> {
  uint _row;
  uint _group;
  uint _column;
  uint _number;
  uint _numberRemaining;
  BOOL _possibleValues[PotentialNumbers];
}

@property (nonatomic, readonly) uint row;
@property (nonatomic, readonly) uint group;
@property (nonatomic, readonly) uint column;
@property (nonatomic, assign)   uint number;
@property (nonatomic, readonly) uint numberRemaining;

- (id)initWithNumber:(uint)aNumber group:(uint)aGroup row:(uint)aRow column:(uint)aColumn;
- (void)print;
- (void)checkNumbers;
- (void)setPossibleValues:(BOOL *)aPossibleValues;
- (void)removeFromPossibilitiesTheNumber:(uint)aNumber;
- (BOOL)isNumberPotential:(uint)aNumber;
- (BOOL)isPairWith:(SudokuCoordinate *)aSudokuCoordinate;
- (BOOL)isATripleWithFirstCoordinage:(SudokuCoordinate *)aFirstSudokuCoordinate secondCoordinage:(SudokuCoordinate *)aSecondSudokuCoordinate;

@end
