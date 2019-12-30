//  ViewController.h

#import <UIKit/UIKit.h>
#import "QuestionCell.h"

@class QuestionAndAnswer;
@class DetailViewController;

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, QuestionCellDelegate> {
  NSMutableArray       * _questionObjectsArray;
  NSMutableArray       * _currentQuestionObjectsArray;
  NSMutableArray       * _searchingQuestionObjectsArray;
  QuestionAndAnswer    * _selectedQuestionAndAnswer;
  DetailViewController * __weak _detailViewController;
  IBOutlet UITableView * _tableView;
}

@property (nonatomic, weak) DetailViewController * detailViewController;

@end