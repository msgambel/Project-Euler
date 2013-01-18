//  BinaryObject.m

#import "BinaryObject.h"

@implementation BinaryObject

@synthesize value = _value;
@synthesize leftChild = _leftChild;
@synthesize rightChild = _rightChild;
@synthesize largestValueFromChild = _largestValueFromChild;

#pragma mark - Init

- (id)initWithValue:(uint)aValue; {
  if((self = [super init])){
    _value = aValue;
    
    // We set the largest value from a child to default to this value, in order
    // to speed up the recursion with one less step. We also can use it to tell
    // if we've set the largest data from the children already, in order to
    // prevent extra work!
    _largestValueFromChild = _value;
    
    // Set the left and right children to nil for safety!
    _leftChild = nil;
    _rightChild = nil;
  }
  return self;
}

- (id)initWithValue:(uint)aValue leftChild:(BinaryObject *)aLeftChild rightChild:(BinaryObject *)aRightChild; {
  if((self = [super init])){
    _value = aValue;
    
    // We set the largest value from a child to default to this value, in order
    // to speed up the recursion with one less step. We also can use it to tell
    // if we've set the largest data from the children already, in order to
    // prevent extra work!
    _largestValueFromChild = _value;
    
    _leftChild = aLeftChild;
    _rightChild = aRightChild;
    
    // Since we started with children, we might as well calculate the largest
    // value from the children now.
    [self getTheLargestValueFromChild];
  }
  return self;
}

#pragma mark - Methods

- (void)getTheLargestValueFromChild; {
  // If we have not set the largest value already,
  if(_largestValueFromChild == _value){
    // If the largest value from the left child is greater than the largest
    // value from the right child,
    if(_leftChild.largestValueFromChild > _rightChild.largestValueFromChild){
      // Increment the largest value by the largest value from the left child.
      _largestValueFromChild += _leftChild.largestValueFromChild;
    }
    // If the largest value from the right child is greater than the largest
    // value from the left child,
    else{
      // Increment the largest value by the largest value from the right child.
      _largestValueFromChild += _rightChild.largestValueFromChild;
    }
  }
}

@end