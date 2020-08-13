//  DetailViewController.m

#import "DetailViewController.h"
#import "Defines.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "UISplitViewController+Toggle.h"

@interface DetailViewController (Private)

- (void)updateTheControls;
- (void)updateTheTextViewScrolling;
- (void)startComputationProgressIndicator;
- (void)didRotate:(NSNotification *)aNotification;
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)aTapGestureRecognizer;

@end

@implementation DetailViewController

@synthesize viewController = _viewController;

#pragma mark - Getters

- (QuestionAndAnswer *)questionAndAnswer; {
  // Return the question and answer object.
  return _questionAndAnswer;
}

#pragma mark - Setters

- (void)setQuestionAndAnswer:(QuestionAndAnswer *)questionAndAnswer; {
  // Set the question object.
  _questionAndAnswer = questionAndAnswer;
  
  // Set the delegate property to be this view controller.
  _questionAndAnswer.delegate = self;
  
  // Fill in the data of each of the labels.
  [self updateTheControls];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // If the Master View Controller is visible, dimiss it.
    [[AppDelegate appDelegate].splitViewController toggleMasterView];
    
    // Disable the Tap Gesture Recognizer.
    _tapGestureRecognizer.enabled = NO;
  }
}

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Set up an observer to detect an orientation change. This is used to dismiss
    // the popover controller if it is visible and the orientation changes to
    // landscape.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // Create a Tap Gesture Recognizer to handle dismissing the Master View
    // Controller when in Portrait Orientation.
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    
    // If the orientation is Landscape,
    if(UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
      // Enable the Tap Gesture Recognizer.
      _tapGestureRecognizer.enabled = NO;
    }
    // Add the Tap Gesture Recognizer to the Detail View Controllers View.
    [self.view addGestureRecognizer:_tapGestureRecognizer];
  }
  // Update the labels based on the curent question.
  [self updateTheControls];
}

- (void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
  // This is just here so that the text view which holds the text is only
  // scrollable if the text is larger than the frame. Otherwise, it is not. If
  // the view has not been rendered once, then the frame values are not set.
  // Therefore, we call this method once the view has appeared in order to make
  // sure the first time the view is shown that the scrolling is behaving properly.
  [self updateTheTextViewScrolling];
}

- (void)viewDidDisappear:(BOOL)animated; {
  [super viewDidDisappear:animated];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Remove the observer for the orientation detection.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
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

- (IBAction)backButtonPressed:(UIButton *)aButton; {
  // If the user is NOT using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Pop back to previous view controller if the back button is pressed.
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (IBAction)linkButtonPressed:(UIButton *)aButton; {
  // Open the link in Mobile Safari.
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_questionAndAnswer.link]];
}

- (IBAction)hintButtonPressed:(UIButton *)aButton; {
  // Grab the hint text.
  NSString * hint = _questionAndAnswer.hint;
  
  // If there is no hint added yet,
  if(hint.length == 0){
    // Put in filler text saying the hint is coming soon!
    hint = @"Hint soon to come...";
  }
  // Create an UIAlertController that displays a hint on how the current
  // question was solved.
  UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Hint" message:hint preferredStyle:UIAlertControllerStyleAlert];
  
  // Create a "Got It!" Action as a selectable option for the Alert Controller.
  UIAlertAction * gotItAction = [UIAlertAction actionWithTitle:@"Got it!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    // Log to the console that the user understood the hint for the current
    // Question.
    NSLog(@"Understood the hint for Question %@!", self->_questionAndAnswer.number);
  }];
  // Add the "Got It!" Action to the Alert Controller.
  [alertController addAction:gotItAction];
  
  // Create a "Got It!" Action as a selectable option for the Alert Controller.
  UIAlertAction * stillLostAction = [UIAlertAction actionWithTitle:@"Still lost..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
    // Log to the console that the user did NOT understand the hint for the
    // current Question.
    NSLog(@"Did not understand the hint for Question %@...", self->_questionAndAnswer.number);
  }];
  // Add the "Got It!" Action to the Alert Controller.
  [alertController addAction:stillLostAction];
  
  // Show the UIAlertController.
  [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(UIButton *)aButton; {
  // If we are computing,
  if(_isComputing){
    // Tell the NSOperationQueue to cancel all the operations.
    [_operationQueue cancelAllOperations];
    
    // Tell the question to no longer compute the answer.
    _questionAndAnswer.isComputing = NO;
    
    // Set the NSOperationQueue to nil as we are done with it.
    _operationQueue = nil;
  }
}

- (IBAction)computeButtonPressed:(UIButton *)aButton; {
  // Tell the QuestionAndAnswer object to compute the optimized answer.
  
  // Start the progress indicator, show the cancel button, and hide the compute
  // buttons.
  [self startComputationProgressIndicator];
  
  // Create a new NSOperationQueue to run the process on another Thread so that
  // the main thread does not lock if the computation run time is too long.
  _operationQueue = [[NSOperationQueue alloc] init];
  
  // Create an NSInvocationOperation to call the computeAnswer method.
  NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:_questionAndAnswer selector:@selector(computeAnswer) object:nil];
  
  // Add the NSInvocationOperation to the NSOperationQueue.
  [_operationQueue addOperation:operation];
}

- (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton; {
  // Tell the QuestionAndAnswer object to compute the brute force answer.
  
  // Start the progress indicator, show the cancel button, and hide the compute
  // buttons.
  [self startComputationProgressIndicator];
  
  // Create a new NSOperationQueue to run the process on another Thread so that
  // the main thread does not lock if the computation run time is too long.
  _operationQueue = [[NSOperationQueue alloc] init];
  
  // Create an NSInvocationOperation to call the computeAnswerByBruteForce method.
  NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:_questionAndAnswer selector:@selector(computeAnswerByBruteForce) object:nil];
  
  // Add the NSInvocationOperation to the NSOperationQueue.
  [_operationQueue addOperation:operation];
}

- (IBAction)showQuestionsTableViewButtonPressed:(UIButton *)aButton; {
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Show the Master View Controller that holds the questions tableView.
    [[AppDelegate appDelegate].splitViewController toggleMasterView];
    
    // Enable the Tap Gesture Recognizer.
    _tapGestureRecognizer.enabled = YES;
  }
}

#pragma mark - UISplitViewControllerDelegate Methods

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode; {
  if(displayMode == UISplitViewControllerDisplayModeAllVisible){
    // If the orientation moves to Lanscape (therefore showing the master view
    // controller on the left, hide the button that displays the view controller
    // in the popover controller.
    _showQuestionsTableViewButton.hidden = YES;
  }
  else{
    // If the orientation moves to Portrait (therefore hiding the master view
    // controller on the left, show the button that displays the view controller
    // in the popover controller.
    _showQuestionsTableViewButton.hidden = NO;
  }
}

#pragma mark - QuestionAndAnswerDelegate Methods

- (void)finishedComputing; {
  // Once the computation is done, update the labels. Make sure that we are
  // updating the labels on the Main Thread, as UIKit only works on the Main Thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self updateTheControls];
    
    // Set the NSOperationQueue to nil as we are done with it.
    self->_operationQueue = nil;
  });
}

@end

#pragma mark - Private Methods

@implementation DetailViewController (Private)

- (void)updateTheControls; {
  // Set that we are not computing the answer.
  _isComputing = NO;
  
  // Fill in the data of each of the labels.
  if(_questionAndAnswer.usesCustomObjects){
    _questionUsesCustomObjectsLabel.text = @"Uses Custom Objects";
  }
  else{
    _questionUsesCustomObjectsLabel.text = @"No Custom Objects";
  }
  if(_questionAndAnswer.usesCustomStructs){
    _questionUsesCustomStructsLabel.text = @"Uses Custom Structs";
  }
  else{
    _questionUsesCustomStructsLabel.text = @"No Custom Structs";
  }
  if(_questionAndAnswer.usesHelperMethods){
    _questionUsesHelperMethodsLabel.text = @"Uses Helpers";
  }
  else{
    _questionUsesHelperMethodsLabel.text = @"No Helpers";
  }
  if(_questionAndAnswer.requiresMathematics){
    _questionRequiresMathematicsLabel.text = @"Requires Mathematics";
  }
  else{
    _questionRequiresMathematicsLabel.text = @"No Mathematics Required";
  }
  if(_questionAndAnswer.hasMultipleSolutions){
    _questionHasMultipleSolutionsLabel.text = @"Has Multiple Solutions";
  }
  else{
    _questionHasMultipleSolutionsLabel.text = @"Has A Single Solution";
  }
  if(_questionAndAnswer.usesFunctionalProgramming){
    _questionUsesFunctionalProgrammingLabel.text = @"Uses Functional Programming";
  }
  else{
    _questionUsesFunctionalProgrammingLabel.text = @"No Functional Programming";
  }
  _questionTextView.text = _questionAndAnswer.text;
  _questionDateLabel.text = _questionAndAnswer.date;
  _questionTitleLabel.text = _questionAndAnswer.title;
  _startedOnDateLabel.text = _questionAndAnswer.startedOnDate;
  _questionAnswerLabel.text = _questionAndAnswer.answer;
  _questionNumberLabel.text = [NSString stringWithFormat:@"Problem %@", _questionAndAnswer.number];
  _questionRatingLabel.text = [NSString stringWithFormat:@"%@ / 5", _questionAndAnswer.rating];
  _completedOnDateLabel.text = _questionAndAnswer.completedOnDate;
  _computationTimeLabel.text = _questionAndAnswer.estimatedComputationTime;
  _questionCategoryLabel.text = _questionAndAnswer.category;
  _questionIsFunImageView.hidden = (_questionAndAnswer.isFun == NO);
  _questionSolveTimeLabel.text = [NSString stringWithFormat:@"Solve Time (s): %@", _questionAndAnswer.solveTime];
  _questionTechniqueLabel.text = _questionAndAnswer.technique;
  _solutionLineCountLabel.text = [NSString stringWithFormat:@"Solution Line Count: %@", _questionAndAnswer.solutionLineCount];
  _questionDifficultyLabel.text = _questionAndAnswer.difficulty;
  _questionCommentCountLabel.text = _questionAndAnswer.commentCount;
  _questionAttemptsCountLabel.text = _questionAndAnswer.attemptsCount;
  _bruteForceComputationTimeLabel.text = _questionAndAnswer.estimatedBruteForceComputationTime;
  _questionIsChallengingImageView.hidden = (_questionAndAnswer.isChallenging == NO);
  
  // Update the scrolling of the textView based on its new content.
  [self updateTheTextViewScrolling];
  
  // Hide and unhide all the buttons.
  _backButton.hidden = NO;
  _cancelButton.hidden = YES;
  _computeButton.hidden = NO;
  _computeByBruteForceButton.hidden = NO;
  
  // This show questions tableView button should only show itself if the device
  // is in portrait.
  _showQuestionsTableViewButton.hidden = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
  
  // Stop the activity indicator.
  [_activityIndicatorView stopAnimating];
}

- (void)updateTheTextViewScrolling; {
  // Grab the content height of the text in the question textView.
  float contentHeight = _questionTextView.contentSize.height;
  
  // If the device is using iOS 7.0 or above,
  if(SYSTEM_VERSION_LESS_THAN(@"7.0") == NO){
    // Compute the size required for the text in the question textView.
    CGSize textViewSize = [_questionTextView sizeThatFits:CGSizeMake(_questionTextView.frame.size.width, FLT_MAX)];
    
    // Grab the new content height of the text in the question textView.
    contentHeight = textViewSize.height;
  }
  // Scrolling is only enabled if the content height is greater than the frame height.
  _questionTextView.scrollEnabled = (contentHeight > _questionTextView.frame.size.height);
}

- (void)startComputationProgressIndicator; {
  // Set that we have started computing the answer.
  _isComputing = YES;
  
  // Hide and unhide all the buttons, and start the activity indicator.
  _backButton.hidden = YES;
  _cancelButton.hidden = NO;
  _computeButton.hidden = YES;
  _computeByBruteForceButton.hidden = YES;
  _showQuestionsTableViewButton.hidden = YES;
  [_activityIndicatorView startAnimating];
}

- (void)didRotate:(NSNotification *)aNotification; {
  // This method is just for the iPad. If the popover controller is visible
  // when the orientation changed to Landscape, we must dismiss it.
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Get the new orientation.
    UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
    
    // If the orientation is Landscape,
    if(UIDeviceOrientationIsLandscape(interfaceOrientation)){
      // Disable the Tap Gesture Recognizer.
      _tapGestureRecognizer.enabled = NO;
    }
  }
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)aTapGestureRecognizer; {
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // If the Master View Controller is visible, dimiss it.
    [[AppDelegate appDelegate].splitViewController toggleMasterView];
    
    // Disable the Tap Gesture Recognizer.
    _tapGestureRecognizer.enabled = NO;
  }
}

@end
