//  UISplitViewController+Toggle.m

#import "UISplitViewController+Toggle.h"

@implementation UISplitViewController (Toggle)

#pragma mark - Methods

- (void)toggleMasterView; {
  // Intercept the Display Mode Bar Button Item that shows up in the Navbar,
  // and trigger it manually.
  [[UIApplication sharedApplication] sendAction:self.displayModeButtonItem.action to:self.displayModeButtonItem.target from:nil forEvent:nil];
 }

@end
