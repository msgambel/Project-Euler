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
  // Return the sum of the distance to the next node, and the heuristic distance.
  return _g + _h;
}

#pragma mark - Init

- (id)initWithRow:(uint)aRow column:(uint)aColumn value:(uint)aValue; {
  // Initialize the A* Node.
  if((self = [super init])){
    // Set the default distance to the next A* Node to the movement cost.
    _g = aValue;
    
    // Set the default hueristic distance to the next A* Node to 0.
    _h = 0;
    
    // Set the row of the node.
    _row = aRow;
    
    // Set the column of the node.
    _column = aColumn;
    
    // Set the move cost of moving to this A* Node to the inputted value.
    _moveCost = aValue;
    
    // Set that this A* Node is NOT the end A* Node by default.
    _isEnd = NO;
    
    // Set that this A* Node is NOT the start A* Node by default.
    _isStart = NO;
    
    // Set the parent A* Node of this A* Node to be nil (or non-existent).
    _parent = nil;
  }
  // Return the A* Node instance.
  return self;
}

#pragma mark - Methods

- (NSComparisonResult)compareNodes:(AStarNode *)aAStarNode; {
  // If this A* Node has a shorter distance than the inputted A* Node,
  if(self.f < aAStarNode.f){
    // Return that this A* Node has a lower value than the inputted A* Node.
    return NSOrderedAscending;
  }
  // If this A* Node has a greater distance than the inputted A* Node,
  else if(self.f > aAStarNode.f){
    // Return that this A* Node has a higher value than the inputted A* Node.
    return NSOrderedDescending;
  }
  // If this A* Node has the same distance as the inputted A* Node,
  else{
    // Return that this A* Node has the same value than the inputted A* Node.
    return NSOrderedSame;
  }
}

@end