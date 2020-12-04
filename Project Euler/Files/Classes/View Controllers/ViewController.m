//  ViewController.m

#import "ViewController.h"
#import "Defines.h"
#import "QuestionAndAnswer.h"
#import "DetailViewController.h"

@interface ViewController (Private)

- (void)setupTheSolvedQuestionsArray;

@end

@implementation ViewController

@synthesize detailViewController = _detailViewController;

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  // Setup the solved questions array.
  [self setupTheSolvedQuestionsArray];
  
  // Set the selected question to be Question 1.
  _selectedQuestionAndAnswer = [[_questionObjectsArray objectAtIndex:0] objectAtIndex:0];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Update the Detail View Controller to have the same default question number.
    _detailViewController.questionAndAnswer = _selectedQuestionAndAnswer;
  }
  // Since we are NOT searching by default, set the current Question Objects
  // array to the array with all the solved Question Objects.
  _currentQuestionObjectsArray = _questionObjectsArray;
  
  // If the device is using iOS 7.0 or above,
  if(SYSTEM_VERSION_LESS_THAN(@"7.0") == NO){
    // Make sure that the view does not automatically adjust scroll view insets
    // because of the new way the status bar is handled.
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
}

#pragma mark - iOS 6.0 and up Rotation Methods

- (BOOL)shouldAutorotate; {
  // Return that the ViewController should auto-rotate.
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations; {
  // If the current device is NOT an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Return that we only accept Potrait orientations.
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
  }
  // If the current device is an iPad,
  else{
    // Return that we accept all orientations.
    return UIInterfaceOrientationMaskAll;
  }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation; {
  // If the current device is NOT an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Return that the preferred orientation is Portrait.
    return UIInterfaceOrientationPortrait;
  }
  // If the current device is an iPad,
  else{
    // Return that the preferred orientation is Landscape, with the Home Button
    // on the left.
    return UIInterfaceOrientationLandscapeLeft;
  }
}

#pragma mark - Methods

#pragma mark - UIStoryboard Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  // If the user is NOT using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Grab the Destination View Controller, which will be a DetailViewController.
    DetailViewController * detailViewController = (DetailViewController *)[segue destinationViewController];
    
    // Update the question for the DetailViewController.
    detailViewController.questionAndAnswer = _selectedQuestionAndAnswer;
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
  // Return the number of rows of solved questions in the current question
  // objects array.
  return [_currentQuestionObjectsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  // Grab the reuseable cell from the tableView
  QuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
  
  cell.selectedQuestionAndAnswer = _selectedQuestionAndAnswer;
  
  // Set the cells question objects array to be the current question objects
  // array for the corresponding row.
  cell.questionObjectsArray = [_currentQuestionObjectsArray objectAtIndex:indexPath.row];
  
  // Set the cells delegate to be this View Controller.
  cell.delegate = self;
  
  // Return the cell.
  return cell;
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar; {
  // Make sure that this UISearchBar no longer shows the "Cancel" button.
  searchBar.showsCancelButton = NO;
  
  // Tell the UISearchBar to resign as first responder, which dismissed the
  // keyboard.
  [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar; {
  // Set the current question objects array to be the array of all of the
  // question objects.
  _currentQuestionObjectsArray = _questionObjectsArray;
  
  // Tell the TableView to reload based on the latest data.
  [_tableView reloadData];
  
  // Reset the UISearchBar's text to the empty string.
  searchBar.text = @"";
  
  // Make sure that this UISearchBar no longer shows the "Cancel" button.
  searchBar.showsCancelButton = NO;
  
  // Tell the UISearchBar to resign as first responder, which dismissed the
  // keyboard.
  [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText; {
  // If the text in the UISearchBar has at least 1 character,
  if(searchBar.text.length > 0){
    // Set the current question objects array to be the array of question objects
    // that are relavent to the search text.
    _currentQuestionObjectsArray = _searchingQuestionObjectsArray;
  }
  // If the text in the UISearchBar has 0 characters,
  else{
    // Set the current question objects array to be the array of all of the
    // question objects.
    _currentQuestionObjectsArray = _questionObjectsArray;
  }
  // Variable to hold the number of questions relavent to the search text for
  // each question cell.
  uint numberOfSearchedQuestions = 0;
  
  // Variable array to hold all of the keywords for a given question.
  NSArray * keywords = nil;
  
  // Variable array to hold the searched question objects for each question cell.
  NSMutableArray * searchedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:NumberOfButtonsInQuestionCell];
  
  // Remove all of the objects already in the searching quetion objects array.
  [_searchingQuestionObjectsArray removeAllObjects];
  
  // For all of the arrays of 5 question objects in the array or all of the
  // question objects,
  for(NSMutableArray * arrayOf5Questions in _questionObjectsArray){
    // For all of the question objects in the array of 5 question objects,
    for(QuestionAndAnswer * question in arrayOf5Questions){
      // Grab the keywords for the specific question object.
      keywords = [question.keywords componentsSeparatedByString:@","];
      
      // For all the individual keywords for the current question object,
      for(NSString * keyword in keywords){
        // If the keyword contains the search text,
        if([keyword rangeOfString:searchText].location != NSNotFound){
          // Increment the number of relavent searched questions by 1.
          numberOfSearchedQuestions++;
          
          // Add the question object to the question cells searched questions
          // array.
          [searchedQuestionObjects addObject:question];
          
          // If the number of solved questions is equal to the number of buttons in
          // each question cell,
          if(numberOfSearchedQuestions == NumberOfButtonsInQuestionCell){
            // Reset the number of searched questions to 0.
            numberOfSearchedQuestions = 0;
            
            // Add the group of searched questions to the questions objects array.
            [_searchingQuestionObjectsArray addObject:searchedQuestionObjects];
            
            // Reset the searched questions array for a new cell.
            searchedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:NumberOfButtonsInQuestionCell];
          }
        }
      }
    }
  }
  // Tell the TableView to reload based on the latest data.
  [_tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar; {
  // Make sure that this UISearchBar shows the "Cancel" button.
  searchBar.showsCancelButton = YES;
  
  // Return that the UISearchBar should begin editing.
  return YES;
}

#pragma mark - QuestionCellDelegate Methods

- (void)selectedQuestion:(QuestionAndAnswer *)aQuestionAndAnswer; {
  // Set the selected question returned by a cell.
  _selectedQuestionAndAnswer = aQuestionAndAnswer;
  
  // Tell the TableView to reload based on the latest data.
  [_tableView reloadData];
  
   // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Set the DetailViewControllers question to be the selected question.
    _detailViewController.questionAndAnswer = _selectedQuestionAndAnswer;
  }
  // If the user is NOT using an iPad,
  else{
    // Tell the storyBoard to move the the DetailViewController.
    [self performSegueWithIdentifier:@"DetailViewControllerSegue" sender:self];
  }
}

@end

#pragma mark - Private Methods

@implementation ViewController (Private)

- (void)setupTheSolvedQuestionsArray; {
  // Array to hold all of the solved question objects in groups for each
  // question cell.
  _questionObjectsArray = [[NSMutableArray alloc] init];
  
  // Array to hold all of the questions relavent to the given search.
  _searchingQuestionObjectsArray = [[NSMutableArray alloc] init];
  
  // Variable to hold the number of questions solved for each question cell.
  uint numberOfSolvedQuestions = 0;
  
  // Variable array to hold the question objects for each question cell.
  NSMutableArray * solvedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:NumberOfButtonsInQuestionCell];
  
  // Variable to hold the current solved question object.
  QuestionAndAnswer * questionAndAnswer = nil;
  
  // For all the possible question that could be solved,
  for(uint questionNumber = 1; questionNumber < TotalNumberOfPossibleQuestions; questionNumber++){
    // Grab the Class name from the question number.
    Class class = NSClassFromString([NSString stringWithFormat:@"Question%d", questionNumber]);
    
    // If the class responds to the initialize method,
    if([class instancesRespondToSelector:@selector(initialize)]){
      // Increment the number of solved questions by 1.
      numberOfSolvedQuestions++;
      
      // Instantiate the question object.
      questionAndAnswer = [[class alloc] init];
      
      // Add the question object to the question cells solved questions array.
      [solvedQuestionObjects addObject:questionAndAnswer];
      
      // If the number of solved questions is equal to the number of buttons in
      // each question cell,
      if(numberOfSolvedQuestions == NumberOfButtonsInQuestionCell){
        // Reset the number of solved questions to 0.
        numberOfSolvedQuestions = 0;
        
        // Add the group of solved questions to the questions objects array.
        [_questionObjectsArray addObject:solvedQuestionObjects];
        
        // Reset the solved questions array for a new cell.
        solvedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:NumberOfButtonsInQuestionCell];
      }
    }
  }
  // If the number of solved questions remaining is greater than 0,
  if([solvedQuestionObjects count] > 0){
    // Add the group of solved questions to the questions objects array.
    [_questionObjectsArray addObject:solvedQuestionObjects];
  }
}

@end