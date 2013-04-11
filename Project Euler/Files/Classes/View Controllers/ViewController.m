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
  _selectedQuestion = [[_questionObjectsArray objectAtIndex:0] objectAtIndex:0];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Update the detail view controller to have the same default question number.
    _detailViewController.questionAndAnswer = _selectedQuestion;
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
    
    // Update the question for the DetailViewController.
    detailViewController.questionAndAnswer = _selectedQuestion;
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
  // Return the number of rows of solved questions.
  return [_questionObjectsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  // Grab the reuseable cell from the tableView
  QuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
  
  // Set the cells question objects array to be the question objects array for
  // the corresponding row.
  cell.questionObjectsArray = [_questionObjectsArray objectAtIndex:indexPath.row];
  
  // Set the cells delegate to be this view controller.
  cell.delegate = self;
  
  // Return the cell.
  return cell;
}

#pragma mark - QuestionCellDelegate Methods

- (void)selectedQuestion:(QuestionAndAnswer *)aQuestionAndAnswer; {
  // Set the selected question returned by a cell.
  _selectedQuestion = aQuestionAndAnswer;
  
   // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Set the DetailViewControllers question to be the selected question.
    _detailViewController.questionAndAnswer = _selectedQuestion;
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
  
  // Variable to hold the number of questions solved for each question cell.
  uint numberOfSolvedQuestions = 0;
  
  // Variable array to hold the question objects for each question cell.
  NSMutableArray * solvedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:5];
  
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
        solvedQuestionObjects = [[NSMutableArray alloc] initWithCapacity:5];
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