//  BinaryObject.h

#import <Foundation/Foundation.h>

@interface BinaryObject : NSObject {
  uint           _value;
  uint           _largestValueFromChild;
  BinaryObject * _leftChild;
  BinaryObject * _rightChild;
}

@property (nonatomic, readonly) uint           value;
@property (nonatomic, assign)   uint           largestValueFromChild;
@property (nonatomic, strong)   BinaryObject * leftChild;
@property (nonatomic, strong)   BinaryObject * rightChild;

- (id)initWithValue:(uint)aValue;
- (id)initWithValue:(uint)aValue leftChild:(BinaryObject *)aLeftChild rightChild:(BinaryObject *)aRightChild;
- (void)getTheLargestValueFromChild;

@end