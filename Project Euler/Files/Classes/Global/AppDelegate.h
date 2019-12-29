//  AppDelegate.h

#import <UIKit/UIKit.h>

@class ViewController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
  UIWindow              * _window;
  UISplitViewController * _splitViewController;
  ViewController        * _viewController;
  DetailViewController  * _detailViewController;
}

@property (nonatomic, strong)   UIWindow              * window;
@property (nonatomic, readonly) UISplitViewController * splitViewController;

+ (AppDelegate *)appDelegate;

@end