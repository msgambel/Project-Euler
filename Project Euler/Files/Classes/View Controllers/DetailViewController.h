//  DetailViewController.h

#import <UIKit/UIKit.h>
#import "QuestionAndAnswer.h"

@class ViewController;

@interface DetailViewController : UIViewController <UIAlertViewDelegate, UISplitViewControllerDelegate, QuestionAndAnswerDelegate> {
  BOOL                               _isComputing;
  NSOperationQueue                 * _operationQueue;
  UIPopoverController              * _uiPopoverController;
  ViewController                   * __weak _viewController;
  QuestionAndAnswer                * _questionAndAnswer;
  IBOutlet UILabel                 * _questionDateLabel;
  IBOutlet UILabel                 * _questionTitleLabel;
  IBOutlet UILabel                 * _startedOnDateLabel;
  IBOutlet UILabel                 * _questionAnswerLabel;
  IBOutlet UILabel                 * _questionNumberLabel;
  IBOutlet UILabel                 * _questionRatingLabel;
  IBOutlet UILabel                 * _completedOnDateLabel;
  IBOutlet UILabel                 * _computationTimeLabel;
  IBOutlet UILabel                 * _questionCategoryLabel;
  IBOutlet UILabel                 * _questionSolveTimeLabel;
  IBOutlet UILabel                 * _questionTechniqueLabel;
  IBOutlet UILabel                 * _solutionLineCountLabel;
  IBOutlet UILabel                 * _questionDifficultyLabel;
  IBOutlet UILabel                 * _questionCommentCountLabel;
  IBOutlet UILabel                 * _questionAttemptsCountLabel;
  IBOutlet UILabel                 * _questionRequiresMathematics;
  IBOutlet UILabel                 * _bruteForceComputationTimeLabel;
  IBOutlet UILabel                 * _questionUsesHelperMethodsLabel;
  IBOutlet UILabel                 * _questionHasMultipleSolutionsLabel;
  IBOutlet UILabel                 * _questionUsesFunctionalProgramming;
  IBOutlet UIButton                * _backButton;
  IBOutlet UIButton                * _cancelButton;
  IBOutlet UIButton                * _computeButton;
  IBOutlet UIButton                * _computeByBruteForceButton;
  IBOutlet UIButton                * _showQuestionsTableViewButton;
  IBOutlet UITextView              * _questionTextView;
  IBOutlet UIImageView             * _questionIsFunImageView;
  IBOutlet UIImageView             * _questionIsChallengingImageView;
  IBOutlet UIActivityIndicatorView * _activityIndicatorView;
}

@property (nonatomic, weak)   ViewController    * viewController;
@property (nonatomic, strong) QuestionAndAnswer * questionAndAnswer;

- (IBAction)backButtonPressed:(UIButton *)aButton;
- (IBAction)linkButtonPressed:(UIButton *)aButton;
- (IBAction)hintButtonPressed:(UIButton *)aButton;
- (IBAction)cancelButtonPressed:(UIButton *)aButton;
- (IBAction)computeButtonPressed:(UIButton *)aButton;
- (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton;
- (IBAction)showQuestionsTableViewButtonPressed:(UIButton *)aButton;

@end