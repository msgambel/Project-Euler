//  AStarNode.h

#import <Foundation/Foundation.h>

@interface AStarNode : NSObject {
  BOOL        _isEnd;
  BOOL        _isStart;
  uint        _g;
  uint        _h;
  uint        _row;
  uint        _column;
  uint        _moveCost;
  AStarNode * _parent;
}

@property (nonatomic, assign)   BOOL isEnd;
@property (nonatomic, assign)   BOOL isStart;
@property (nonatomic, readonly) uint f;
@property (nonatomic, assign)   uint g;
@property (nonatomic, assign)   uint h;
@property (nonatomic, readonly) uint row;
@property (nonatomic, readonly) uint column;
@property (nonatomic, readonly) uint moveCost;
@property (nonatomic, strong)   AStarNode * parent;

- (id)initWithRow:(uint)aRow column:(uint)aColumn value:(uint)aValue;
- (NSComparisonResult)compareNodes:(AStarNode *)aAStarNode;

@end