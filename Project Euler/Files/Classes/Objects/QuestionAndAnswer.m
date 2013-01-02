//  QuestionAndAnswer.m

#import "QuestionAndAnswer.h"

@implementation QuestionAndAnswer

@synthesize date = _date;
@synthesize text = _text;
@synthesize title = _title;
@synthesize answer = _answer;
@synthesize number = _number;
@synthesize delegate = _delegate;
@synthesize isComputing = _isComputing;
@synthesize estimatedComputationTime = _estimatedComputationTime;
@synthesize estimatedBruteForceComputationTime = _estimatedBruteForceComputationTime;

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    // Always call initialize when the object is created.
    [self initialize];
    
    // Set that we are not computing by default.
    _isComputing = NO;
    
    // Note: We can set the _isComputing flag to NO as it is a propery. This
    //       allows us to cancel the computation if the user deems it is taking
    //       too long. This is all done with NSOperations. If the question is
    //       solved faster than the user can respond, we ignore using this flag.
    //       Otherwise, we will inject it throughout the computation methods so
    //       that it will terminate the computation.
  }
  return self;
}

#pragma mark - Setup

- (void)initialize; {
  // This method will hold all the precomputed values for the given question.
}

#pragma mark - Methods

- (void)computeAnswer; {
  // This method computes the answer with an optimized solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeButtonPressed:(UIButton *)aButton;
}

- (void)computeAnswerByBruteForce; {
  // This method computes the answer with a brute force solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton;
}

@end