//  AppDelegate.m

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize splitViewController = _splitViewController;

#pragma mark - Application LifeCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions; {
  // If the user is using an iPad,
  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    // Grab a reference to the splitViewController.
    _splitViewController = (UISplitViewController *)self.window.rootViewController;
    
    // Set the ViewController to the MasterViewController.
    _viewController = [_splitViewController.viewControllers objectAtIndex:0];
    
    // Set the DetailViewController to the DetailViewController.
    _detailViewController = [_splitViewController.viewControllers objectAtIndex:1];
    
    // Give the ViewController and DetailViewController references to each other.
    _viewController.detailViewController = _detailViewController;
    _detailViewController.viewController = _viewController;
    
    // Set the splitViewControllers delegate to be the DetailViewController.
    _splitViewController.delegate = _detailViewController;
  }
  // Return that the application did finish launching.
  return YES;
}

#pragma mark - Class Methods

+ (AppDelegate *)appDelegate; {
  // Return a reference to the AppDelegate.
  return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Methods

@end