#import <UIKit/UIKit.h>

#import "SBTabBarController.h"
#import "SBPostViewController.h"


@interface SabotterAppDelegate : NSObject <UIApplicationDelegate, SBPostViewControllerDelegate> {
    UIWindow *window;
    SBTabBarController *tabBarController;

    int httpConnectionNum;
}

@end

