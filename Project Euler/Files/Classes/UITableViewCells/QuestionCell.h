//  QuestionCell.h

#import <UIKit/UIKit.h>
#import "Global.h"

@protocol QuestionCellDelegate <NSObject>

- (void)selectQuestionNumber:(uint)aNumber;

@end

@interface QuestionCell : UITableViewCell {
  id <QuestionCellDelegate> __weak _delegate;
  
  uint                                   _row;
  IBOutletCollection(UIButton) NSArray * _buttons;
}

@property (nonatomic, weak)   id <QuestionCellDelegate> delegate;
@property (nonatomic, assign) uint                      row;

- (IBAction)questionButtonPressed:(UIButton *)aButton;

@end