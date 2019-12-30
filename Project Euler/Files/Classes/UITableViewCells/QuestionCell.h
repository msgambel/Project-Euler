//  QuestionCell.h

#import <UIKit/UIKit.h>

@class QuestionAndAnswer;

@protocol QuestionCellDelegate <NSObject>

- (void)selectedQuestion:(QuestionAndAnswer *)aQuestionAndAnswer;

@end

@interface QuestionCell : UITableViewCell {
  id <QuestionCellDelegate> __weak       _delegate;
  NSMutableArray                       * _questionObjectsArray;
  QuestionAndAnswer                    * _selectedQuestionAndAnswer;
  IBOutletCollection(UIButton) NSArray * _buttonsArray;
}

@property (nonatomic, weak)   id <QuestionCellDelegate>   delegate;
@property (nonatomic, strong) NSMutableArray            * questionObjectsArray;
@property (nonatomic, strong) QuestionAndAnswer         * selectedQuestionAndAnswer;

- (IBAction)questionButtonPressed:(UIButton *)aButton;

@end