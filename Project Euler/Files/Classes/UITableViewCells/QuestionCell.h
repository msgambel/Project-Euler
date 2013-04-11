//  QuestionCell.h

#import <UIKit/UIKit.h>

@class QuestionAndAnswer;

@protocol QuestionCellDelegate <NSObject>

- (void)selectedQuestion:(QuestionAndAnswer *)aQuestionAndAnswer;

@end

@interface QuestionCell : UITableViewCell {
  id <QuestionCellDelegate> __weak _delegate;
  
  NSMutableArray                       * _questionObjectsArray;
  IBOutletCollection(UIButton) NSArray * _buttons;
}

@property (nonatomic, weak)   id <QuestionCellDelegate>   delegate;
@property (nonatomic, strong) NSMutableArray            * questionObjectsArray;

- (IBAction)questionButtonPressed:(UIButton *)aButton;

@end