//  ViewController.h

#import <UIKit/UIKit.h>
#import "QuestionCell.h"

@class DetailViewController;

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, QuestionCellDelegate> {
  int                    _selectedQuestionNumber;
  DetailViewController * __weak _detailViewController;
  IBOutlet UITableView * _tableView;
}

@property (nonatomic, weak) DetailViewController * detailViewController;

@end