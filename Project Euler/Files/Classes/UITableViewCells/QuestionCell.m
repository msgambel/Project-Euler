//  QuestionCell.m

#import "QuestionCell.h"
#import "Defines.h"

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
    
    // Mod the number by the number of buttons in a Question cell so that we are
    // only left with the index of the button.
    buttonNumber %= NumberOfButtonsInQuestionCell;
    
    // If the button number is 0 (i.e.: the last button),
    if(buttonNumber == 0){
      // Set the button number to 5, the last button.
      buttonNumber = NumberOfButtonsInQuestionCell;
    }
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