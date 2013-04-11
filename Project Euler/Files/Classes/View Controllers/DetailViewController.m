//  DetailViewController.m

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController (Private)

- (void)updateTheControls;
- (void)updateTheTextViewScrolling;
- (void)startComputationProgressIndicator;
- (void)didRotate:(NSNotification *)aNotification;

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
    // If the popover controller is visible,
    if([_uiPopoverController isPopoverVisible]){
      // Dismiss it.
      [_uiPopoverController dismissPopoverAnimated:YES];
    }
  }
}

#pragma mark - Dealloc

- (void)dealloc; {
  // This application is ARC compliant, so no need to call [super dealloc];
  
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Remove the observer for the orientation detection.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
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
    
    // Set up the popover controller which will show the question numbers.
    _uiPopoverController = [[UIPopoverController alloc] initWithContentViewController:_viewController];
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

- (IBAction)backButtonPressed:(UIButton *)aButton; {
  // If the user is NOT using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Pop back to previous view controller if the back button is pressed.
    [self.navigationController popViewControllerAnimated:YES];
  }
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
  NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:_questionAndAnswer
                                                                          selector:@selector(computeAnswer)
                                                                            object:nil];
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
  NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:_questionAndAnswer
                                                                           selector:@selector(computeAnswerByBruteForce)
                                                                             object:nil];
  // Add the NSInvocationOperation to the NSOperationQueue.
  [_operationQueue addOperation:operation];
}

- (IBAction)showQuestionsTableViewButtonPressed:(UIButton *)aButton; {
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Show the view controller that holds the questions tableView inside the
    // popover controller.
    [_uiPopoverController presentPopoverFromRect:_showQuestionsTableViewButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
  }
}

#pragma mark - UISplitViewControllerDelegate Methods

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem; {
  // If the orientation moves to Lanscape (therefore showing the master view
  // controller on the left, hide the button that displays the view controller
  // in the popover controller.
  _showQuestionsTableViewButton.hidden = YES;
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc; {
  // If the orientation moves to Portrait (therefore hiding the master view
  // controller on the left, show the button that displays the view controller
  // in the popover controller.
  _showQuestionsTableViewButton.hidden = NO;
}

#pragma mark - QuestionAndAnswerDelegate Methods

- (void)finishedComputing; {
  // Once the computation is done, update the labels. Make sure that we are
  // updating the labels on the Main Thread, as UIKit only works on the Main Thread.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self updateTheControls];
    
    // Set the NSOperationQueue to nil as we are done with it.
    _operationQueue = nil;
  });
}

@end

#pragma mark - Private Methods

@implementation DetailViewController (Private)

- (void)updateTheControls; {
  // Set that we are not computing the answer.
  _isComputing = NO;
  
  // Fill in the data of each of the labels.
  _questionDateLabel.text = _questionAndAnswer.date;
  _questionTitleLabel.text = _questionAndAnswer.title;
  _questionAnswerLabel.text = _questionAndAnswer.answer;
  _questionNumberLabel.text = [NSString stringWithFormat:@"Problem %@", _questionAndAnswer.number];
  _computationTimeLabel.text = _questionAndAnswer.estimatedComputationTime;
  _bruteForceComputationTimeLabel.text = _questionAndAnswer.estimatedBruteForceComputationTime;
  _questionTextView.text = _questionAndAnswer.text;
  
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
  // Scrolling is only enabled if the content height is greater than the frame height.
  _questionTextView.scrollEnabled = (_questionTextView.contentSize.height > _questionTextView.frame.size.height);
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
    // If the popover controller is visible,
    if([_uiPopoverController isPopoverVisible]){
      // Get the new orientation.
      UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
      
      // If the orientation is Landscape,
      if(UIDeviceOrientationIsLandscape(interfaceOrientation)){
        // Dismiss the popover controller.
        [_uiPopoverController dismissPopoverAnimated:NO];
      }
    }
  }
}

@end