//  SudokuGroup.h

#import <Foundation/Foundation.h>
#import "SudokuCoordinate.h"

typedef enum {
  SudokuGroupType_Row,
  SudokuGroupType_Column,
  SudokuGroupType_Square
}SudokuGroupType;

@interface SudokuGroup : NSObject <NSCopying> {
  BOOL             _isComplete;
  SudokuGroupType  _type;
  BOOL             _isNumberRemaining[PotentialNumbers];
  NSMutableArray * _sudokuCoordinates;
}

@property (nonatomic, readonly) SudokuGroupType type;

- (id)initWithSudokuCoordinates:(NSMutableArray *)sudokuCoordinates type:(SudokuGroupType)aType;
- (void)updateNumbers;
- (void)updatePotentials;
- (void)checkForPairsAndEliminate;
- (void)setRemainingNumbers:(BOOL *)aRemainingNumbers;
- (BOOL)groupIsValid;
- (BOOL)hasUpdatedACoordinate;
- (uint)remaining;
- (NSString *)rowNumbers;
- (NSString *)indexAValuesOfPair;

@end