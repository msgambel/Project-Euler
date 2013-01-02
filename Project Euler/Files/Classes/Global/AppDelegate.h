//  AppDelegate.h

#import <UIKit/UIKit.h>

@class ViewController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
  UIWindow             * _window;
  ViewController       * _viewController;
  DetailViewController * _detailViewController;
}

@property (strong, nonatomic) UIWindow * window;

+ (AppDelegate *)appDelegate;

@end