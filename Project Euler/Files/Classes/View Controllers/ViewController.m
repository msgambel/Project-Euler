//  ViewController.m

#import "ViewController.h"
#import "Global.h"
#import "DetailViewController.h"

@implementation ViewController

@synthesize detailViewController = _detailViewController;

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  // Set the default selected question number to 1.
  _selectedQuestionNumber = 1;
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Update the detail view controller to have the same default question number.
    _detailViewController.questionNumber = _selectedQuestionNumber;
  }
}

#pragma mark - iOS 5.1 and under Rotation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation; {
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
  }
  else{
    return YES;
  }
}

#pragma mark - iOS 6.0 and up Rotation Methods

- (BOOL)shouldAutorotate; {
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations; {
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
  }
  else{
    return UIInterfaceOrientationMaskAll;
  }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation; {
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    return UIInterfaceOrientationPortrait;
  }
  else{
    return UIInterfaceOrientationLandscapeLeft;
  }
}

#pragma mark - Methods

#pragma mark - UIStoryboard Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  // If the user is NOT using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Grab the destination view controller, which will be a DetailViewController.
    DetailViewController * detailViewController = (DetailViewController *)[segue destinationViewController];
    
    // Update the question number for the DetailViewController.
    detailViewController.questionNumber = _selectedQuestionNumber;
  }
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
  // In case we want to do something with the cell touches later.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
  // There is only 1 section.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
  // We want the number of solved questions divided by the number of question
  // buttons in each tableView cell floored (rounded down). We add 1 to the result
  // so that we always render the row with the last question solved.
  return (((int)(TotalNumberSolved / NumberOfButtonsInQuestionCell)) + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  // Grab the reuseable cell from the tableView
  QuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
  
  // Set the cells row to be the current row.
  cell.row = indexPath.row;
  
  // Set the cells delegate to be this view controller.
  cell.delegate = self;
  
  // Return the cell.
  return cell;
}

#pragma mark - QuestionCellDelegate Methods

- (void)selectQuestionNumber:(uint)aNumber; {
  // Set the selected question number returned by a cell.
  _selectedQuestionNumber = aNumber;
  
   // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Set the DetailViewControllers question number to be the selected number.
    _detailViewController.questionNumber = _selectedQuestionNumber;
  }
  else{ // If the user is NOT using an iPad,
    
    // Tell the storyBoard to move the the DetailViewController.
    [self performSegueWithIdentifier:@"DetailViewControllerSegue" sender:self];
  }
}

@end