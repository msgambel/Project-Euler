//  ViewController.h

#import <UIKit/UIKit.h>
#import "QuestionCell.h"

@class QuestionAndAnswer;
@class DetailViewController;

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, QuestionCellDelegate> {
  NSMutableArray       * _questionObjectsArray;
  QuestionAndAnswer    * _selectedQuestion;
  DetailViewController * __weak _detailViewController;
  IBOutlet UITableView * _tableView;
}

@property (nonatomic, weak) DetailViewController * detailViewController;

@end