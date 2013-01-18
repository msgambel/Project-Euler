//  Question11.h

#import "QuestionAndAnswer.h"

// Enum to hold the 4 directions we iterate over for the product.
typedef enum {
  Direction_LeftToRight = 0,
  Direction_TopToBottom = 1,
  Direction_BottomLeftToTopRight = 2,
  Direction_TopLeftToBottomRight = 3,
  Direction_End = 4
}Direction;

@interface Question11 : QuestionAndAnswer {
  
}

@end