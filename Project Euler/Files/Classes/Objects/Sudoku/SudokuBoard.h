//  SudokuBoard.h

#import <Foundation/Foundation.h>

@interface SudokuBoard : NSObject {
  NSString       * _originalBoard;
  NSMutableArray * _rowsArray;
  NSMutableArray * _groupsArray;
  NSMutableArray * _columnsArray;
  NSMutableArray * _sudokuGroupsArray;
  NSMutableArray * _sudokuGroupRowsArray;
  NSMutableArray * _sudokuGroupSquaresArray;
  NSMutableArray * _sudokuGroupColumnsArray;
}

@property (nonatomic, readonly) BOOL solvedAndValid;
@property (nonatomic, readonly) uint numberRemaining;
@property (nonatomic, readonly) uint numberOfPotentialRemaining;

- (id)initWithBoardString:(NSString *)aBoardString;
- (void)solve;
- (void)loadBoardString:(NSString *)aBoardString;
- (void)removePossibleValue:(uint)aPossibleValue fromRow:(uint)aRow notInGroup:(uint)aGroup;
- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInGroup:(uint)aGroup;
- (void)removePossibleValue:(uint)aPossibleValue fromGroup:(uint)aGroup notInRow:(uint)aRow;
- (void)removePossibleValue:(uint)aPossibleValue fromColumn:(uint)aColumn notInRow:(uint)aRow;
- (void)removePossibleValue:(uint)aPossibleValue fromRow:(uint)aRow notInColumn:(uint)aColumn;
- (void)removePossibleValue:(uint)aPossibleValue fromGroup:(uint)aGroup notInColumn:(uint)aColumn;
- (uint)numberForTopLeftSudokuCoordinate;

@end
