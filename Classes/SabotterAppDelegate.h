#import <UIKit/UIKit.h>

/* #import "SBTabBarController.h" */
/* #import "SBPostViewController.h" */
#import "SBNavigationController.h"


/* @interface SabotterAppDelegate : NSObject <UIApplicationDelegate, SBPostViewControllerDelegate> { */
@interface SabotterAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window;
    IBOutlet UITabBarController *tabBarController;

    IBOutlet SBNavigationController *friendsNavigationController;
    IBOutlet SBNavigationController *repliesNavigationController;
/*     SBTabBarController *tabBarController; */

/*     int httpConnectionNum; */
}

@end

