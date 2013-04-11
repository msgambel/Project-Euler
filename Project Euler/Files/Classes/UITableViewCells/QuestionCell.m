//  QuestionCell.m

#import "QuestionCell.h"
#import "QuestionAndAnswer.h"

@implementation QuestionCell

@synthesize delegate = _delegate;

#pragma mark - Getters

- (NSMutableArray *)questionObjectsArray; {
  // Return the question objects array.
  return _questionObjectsArray;
}

#pragma mark - Setters

- (void)setQuestionObjectsArray:(NSMutableArray *)questionObjectsArray; {
  // Set the question objects array.
  _questionObjectsArray = questionObjectsArray;
  
  // Variable to hold the solved question object for a given button.
  QuestionAndAnswer * questionAndAnswer = nil;
  
  // For all the UIButtons in the _buttons array,
  for(UIButton * button in _buttons){
    // If the buttons tag is greater than or equal to the number of solved
    // question objects in the array,
    if(button.tag >= [_questionObjectsArray count]){
      // Set the button to be hidden if there is no solved question attached to
      // it.
      button.hidden = YES;
    }
    // If the buttons tag is less than the number of solved question objects in
    // the array,
    else{
      // Set the button to be unhidden if there is solved question attached to
      // it.
      button.hidden = NO;
      
      // Grab the solved question object for the button.
      questionAndAnswer = [_questionObjectsArray objectAtIndex:button.tag];
      
      // Update the buttons title to hold the solved questions number.
      [button setTitle:questionAndAnswer.number forState:UIControlStateNormal];
    }
  }
}

#pragma mark - Methods

- (IBAction)questionButtonPressed:(UIButton *)aButton; {
  // Tell the delegate that a question button has been pressed with a given
  // solved question object.
  [_delegate selectedQuestion:[_questionObjectsArray objectAtIndex:aButton.tag]];
}

@end