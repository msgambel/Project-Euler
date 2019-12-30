//  QuestionCell.m

#import "QuestionCell.h"
#import "UIImage+Colour.h"
#import "QuestionAndAnswer.h"

@implementation QuestionCell

@synthesize delegate = _delegate;

#pragma mark - Getters

- (NSMutableArray *)questionObjectsArray; {
  // Return the question objects array.
  return _questionObjectsArray;
}

- (QuestionAndAnswer *)selectedQuestionAndAnswer; {
  // Return the Selected Question And Answer object.
  return _selectedQuestionAndAnswer;
}

#pragma mark - Setters

- (void)setQuestionObjectsArray:(NSMutableArray *)questionObjectsArray; {
  // Set the question objects array.
  _questionObjectsArray = questionObjectsArray;
  
  // Variable to hold the solved question object for a given button.
  QuestionAndAnswer * questionAndAnswer = nil;
  
  // For all the UIButtons in the _buttonArrays array,
  for(UIButton * button in _buttonsArray){
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
      
      // Set the selected state of the current button if it is the User Selected
      // Question and Answer or not.
      button.selected = [_selectedQuestionAndAnswer isEqualToQuestionAndAnswer:questionAndAnswer];
    }
  }
}

- (void)setSelectedQuestionAndAnswer:(QuestionAndAnswer *)selectedQuestionAndAnswer; {
  // Set the SelectedQuestionAndAnswer object.
  _selectedQuestionAndAnswer = selectedQuestionAndAnswer;
  
  // Reload the state of the Questions Objects Array.
  self.questionObjectsArray = _questionObjectsArray;
}

#pragma mark - Init

- (void)awakeFromNib; {
  [super awakeFromNib];
  
  // For all the UIButtons in the _buttonArrays array,
  for(UIButton * button in _buttonsArray){
    // Ensure that the button clips anything outside its bounds.
    button.clipsToBounds = YES;
    button.layer.masksToBounds = YES;
    
    // Set the background image of the button to white for the normal state.
    [button setBackgroundImage:[UIImage imageWithColour:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    // Set the background image of the button to black for the selected state.
    [button setBackgroundImage:[UIImage imageWithColour:[UIColor blackColor]] forState:UIControlStateSelected];
    
    // Set the background image of the button to gray for the highlighted state.
    [button setBackgroundImage:[UIImage imageWithColour:[UIColor grayColor]] forState:UIControlStateHighlighted];
    
    // Set the content mode of the buttons subviews to stretch with autolayout.
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
  }
}

#pragma mark - Methods

- (void)layoutSubviews; {
  [super layoutSubviews];
  
  // For all the UIButtons in the _buttonArrays array,
  for(UIButton * button in _buttonsArray){
    // Set the Corner Radius of the button to 3.0f.
    button.layer.cornerRadius = 3.0f;
  }
}

- (IBAction)questionButtonPressed:(UIButton *)aButton; {
  // Tell the delegate that a question button has been pressed with a given
  // solved question object.
  [_delegate selectedQuestion:[_questionObjectsArray objectAtIndex:aButton.tag]];
}

@end