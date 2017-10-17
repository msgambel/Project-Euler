//  SudokuGroup.h

#import <Foundation/Foundation.h>
#import "Global.h"
#import "SudokuCoordinate.h"

@class SudokuBoard;

@interface SudokuGroup : NSObject <NSCopying> {
  BOOL                 _isComplete;
  uint                 _index;
  SudokuGroupType      _type;
  BOOL                 _isNumberRemaining[PotentialNumbers];
  NSMutableArray     * _sudokuCoordinates;
  __weak SudokuBoard * _sudokuBoard;
}

@property (nonatomic, readonly) BOOL              isComplete;
@property (nonatomic, readonly) uint              index;
@property (nonatomic, readonly) SudokuGroupType   type;
@property (nonatomic, readonly) NSMutableArray  * sudokuCoordinates;
@property (nonatomic, weak)     SudokuBoard     * sudokuBoard;

- (id)initWithSudokuCoordinates:(NSMutableArray *)sudokuCoordinates type:(SudokuGroupType)aType index:(uint)aIndex;
- (void)updateNumbers;
- (void)updatePotentials;
- (void)setRemainingNumbers:(BOOL *)aRemainingNumbers;
- (void)removePossibleValue:(uint)aPossibleValue notInRow:(uint)aRow;
- (void)removePossibleValue:(uint)aPossibleValue notInGroup:(uint)aGroup;
- (void)removePossibleValue:(uint)aPossibleValue notInColumn:(uint)aColumn;
- (void)removePossibleValue:(uint)aPossibleValue notInRow:(uint)aRow orRow:(uint)aSecondRow;
- (BOOL)groupIsValid;
- (BOOL)hasFoundAHiddenSingle;
- (void)hasFoundANakedPair;
- (void)hasFoundAHiddenPair;
- (void)hasFoundANakedTriple;
- (BOOL)hasUpdatedACoordinate;
- (void)hasRemovedLockedPotentials;
- (uint)remainingCount;
- (uint)remainingPotentialsCount;
- (NSArray *)pairOfCoordinatesWithPotentialNumber:(uint)aPotentialNumber;
- (NSString *)rowNumbers;

@end
