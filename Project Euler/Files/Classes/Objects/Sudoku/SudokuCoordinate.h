//  SudokuCoordinate.h

#import <Foundation/Foundation.h>
#import "Defines.h"

@interface SudokuCoordinate : NSObject <NSCopying> {
  uint _row;
  uint _column;
  uint _number;
  uint _numberRemaining;
  BOOL _possibleValues[PotentialNumbers];
}

@property (nonatomic, readonly) uint row;
@property (nonatomic, readonly) uint column;
@property (nonatomic, assign)   uint number;
@property (nonatomic, assign)   uint numberRemaining;

- (id)initWithNumber:(uint)aNumber row:(uint)aRow column:(uint)aColumn;
- (void)checkNumbers;
- (void)setPossibleValues:(BOOL *)aPossibleValues;
- (void)removeFromPossibilitiesTheNumber:(uint)aNumber;
- (BOOL)isNumberPotential:(uint)aNumber;
- (BOOL)isPairWith:(SudokuCoordinate *)aSudokuCoordinate;

@end