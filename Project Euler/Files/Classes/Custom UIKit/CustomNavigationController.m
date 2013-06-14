//  CustomNavigationController.m

#import "CustomNavigationController.h"

@implementation CustomNavigationController

// Note: In iOS 6.0 and up, the Rotation methods are given by the root view
//       controller, instead of the individual view controllers. As a result,
//       since the iPhone version of the app is embedded in a navigation
//       controller, the rotation calls the navigation controller for the
//       supported orientations.

//       The default is, all the orientations excluding portrait upside down
//       for the iPhone, and every orientation for the iPad. But since we
//       disabled auto rotation for landscape in the iPhone app (found in the
//       info.plist), only portrait is returned. This custom class overwrites
//       the default orientation methods to give the proper results. For more
//       detailed information, visit:
//
//       http://developer.apple.com/library/ios/#featuredarticles/ViewControllerPGforiPhoneOS/RespondingtoDeviceOrientationChanges/RespondingtoDeviceOrientationChanges.html

#pragma mark - iOS 5.1 and under Rotation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation; {
  // If the current device is NOT an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    // Return that we only accept Potrait orientations.
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
  }
  // If the current device is an iPad,
  else{
    // Return that we accept all orientations.
    return YES;
  }
}

#pragma mark - iOS 6.0 and up Rotation Methods

- (BOOL)shouldAutorotate; {
  // Return that the ViewController should auto-rotate.
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations; {
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

@end