//
//  SabotterAppDelegate.m
//  Sabotter
//
//  Created by sugyan on 10/07/31.
//

#import "SabotterAppDelegate.h"
#import "ConfigRootViewController.h"
#import "TimelineViewController.h"
#import "SBStatus.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "Common.h"


@implementation SabotterAppDelegate

@synthesize window;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the tab bar controller's view to the window and display.
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

    UINavigationController *nav0 = [tabBarController.viewControllers objectAtIndex:0];
    TimelineViewController *tvc0 = [[[TimelineViewController alloc] init] autorelease];
    [nav0 pushViewController:tvc0 animated:NO];
    nav0.navigationBar.topItem.leftBarButtonItem = configButton;
    UINavigationController *nav1 = [tabBarController.viewControllers objectAtIndex:1];
    TimelineViewController *tvc1 = [[[TimelineViewController alloc] init] autorelease];
    [nav1 pushViewController:tvc1 animated:NO];
    nav1.navigationBar.topItem.leftBarButtonItem = configButton;

    // TODO どこで処理を行う？
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSURL *url = [NSURL URLWithString:@"http://api.wassr.jp/statuses/friends_timeline.json"];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        NSString *base64 = [[[NSString stringWithFormat:@"%@:%@",
                                 [defaults stringForKey:USERDEFAULTS_WASSR_USERNAME],
                                 [defaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        [req setValue:[NSString stringWithFormat:@"Basic %@", base64] forHTTPHeaderField:@"Authorization"];
        NSURLResponse *res = nil;
        NSError       *err = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&res error:&err];
        if (err) {
            LOG(@"error: %@", err);
        }
        NSArray *timeline = [[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease] JSONValue];
        NSMutableArray *statuses = [NSMutableArray arrayWithCapacity:20];
        for (NSDictionary *dict in timeline) {
            SBStatus *status = [[[SBStatus alloc] init] autorelease];
            NSDictionary *userDict = [dict objectForKey:@"user"];
            status.text = [dict objectForKey:@"text"];
            status.user = [NSString stringWithFormat:@"%@(%@)",
                              [userDict objectForKey:@"screen_name"],
                                  [dict objectForKey:@"user_login_id"]];
            status.date = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"epoch"] doubleValue]];
            status.iconUrl = [userDict objectForKey:@"profile_image_url"];
            [statuses addObject:status];
        }
        tvc0.statuses = statuses;
        dispatch_async(dispatch_get_main_queue(), ^{
            [tvc0.tableView reloadData];
        });
    });
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark touch event

- (IBAction)pushConfigButton:(id)sender {
    ConfigRootViewController *configRoot = [[[ConfigRootViewController alloc] initWithNibName:@"ConfigRootView" bundle:nil] autorelease];
    configRoot.title = NSLocalizedString(@"Config", nil);
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:configRoot] autorelease];
    nav.navigationBar.topItem.leftBarButtonItem = configDoneButton;
    [tabBarController presentModalViewController:nav animated:YES];
}

- (IBAction)pushConfigDoneButton:(id)sender {
    [tabBarController.modalViewController dismissModalViewControllerAnimated:YES];
}


@end
