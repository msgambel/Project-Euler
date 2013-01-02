//  QuestionCell.m

#import "QuestionCell.h"
#import "Global.h"

@implementation QuestionCell

@synthesize delegate = _delegate;

#pragma mark - Getters

- (uint)row; {
  return _row;
}

#pragma mark - Setters

- (void)setRow:(uint)row; {
  // Set the row to the new value.
  _row = row;
  
  // Set the variable that holds the current buttons question number.
  int buttonNumber = 0;
  
  // Set the variable that holds the number of buttons.
  int numberOfButtons = [_buttons count];
  
  // Set the variable that holds the incremental value for each button.
  int addValue = numberOfButtons * _row;
  
  // For all the UIButtons in the _buttons array,
  for(UIButton * button in _buttons){
    // Grab the buttons number.
    buttonNumber = [[button titleForState:UIControlStateNormal] intValue];
    
    // Mod the number by 10 so we are only left with the units digit.
    buttonNumber %= 10;
    
    // Add the incremental value to the number.
    buttonNumber += addValue;
    
    // Update the buttons title to hold the new number.
    [button setTitle:[NSString stringWithFormat:@"%d", buttonNumber] forState:UIControlStateNormal];
  }
  // For all the UIButtons in the _buttons array,
  for(UIButton * button in _buttons){
    // Grab the buttons number.
    buttonNumber = [[button titleForState:UIControlStateNormal] intValue];
    
    // The button is hidden if it has not been solved yet.
    button.hidden = (buttonNumber > TotalNumberSolved);
  }
}

#pragma mark - Methods

- (IBAction)questionButtonPressed:(UIButton *)aButton; {
  // Tell the delegate that a question button has been pressed with a given number.
  [_delegate selectQuestionNumber:[[aButton titleForState:UIControlStateNormal] intValue]];
}

@end