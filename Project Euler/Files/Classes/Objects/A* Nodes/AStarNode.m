//  AStarNode.m

#import "AStarNode.h"

@implementation AStarNode

@synthesize g = _g;
@synthesize h = _h;
@synthesize row = _row;
@synthesize isEnd = _isEnd;
@synthesize column = _column;
@synthesize parent = _parent;
@synthesize isStart = _isStart;
@synthesize moveCost = _moveCost;

#pragma mark - Getters

- (uint)f; {
  return _g + _h;
}

#pragma mark - Init

- (id)initWithRow:(uint)aRow column:(uint)aColumn value:(uint)aValue; {
  if((self = [super init])){
    _g = 0;
    _h = 0;
    _row = aRow;
    _column = aColumn;
    _moveCost = aValue;
    _isEnd = NO;
    _isStart = NO;
    _parent = nil;
  }
  return self;
}

#pragma mark - Methods

- (NSComparisonResult)compareNodes:(AStarNode *)aAStarNode; {
  if(self.f > aAStarNode.f){
    return NSOrderedAscending;
  }
  else if(self.f < aAStarNode.f){
    return NSOrderedDescending;
  }
  else{
    return NSOrderedSame;
  }
}

@end