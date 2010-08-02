//
//  SabotterAppDelegate.h
//  Sabotter
//
//  Created by sugyan on 10/07/31.
//

#import <UIKit/UIKit.h>

@interface SabotterAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    IBOutlet UIBarButtonItem *configButton;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (IBAction)pushConfigButton:(id)sender;

@end
