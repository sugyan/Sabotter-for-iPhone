#import "SabotterAppDelegate.h"
#import "SBConfigTableViewController.h"
// #import "SBCommon.h"
// #import "SBHttpClient.h"
// #import "SBTwitterApiUrl.h"
// #import "SBWassrApiUrl.h"


@implementation SabotterAppDelegate

// - (id)init {
//     if (self = [super init]) {
//         httpConnectionNum = 0;
//         [[NSNotificationCenter defaultCenter]
//             addObserver:self
//             selector:@selector(httpConnectionStart:)
//             name:NOTIFICATION_HTTP_CONNECTION_START
//             object:nil];
//         [[NSNotificationCenter defaultCenter]
//             addObserver:self
//             selector:@selector(httpConnectionEnd:)
//             name:NOTIFICATION_HTTP_CONNECTION_END
//             object:nil];
//     }

//     return self;
// }

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
//     window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

//     tabBarController = [[SBTabBarController alloc] init];
//     [window addSubview:[tabBarController view]];
    
//     // アカウント情報のチェック
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     if (!(([defaults stringForKey:USERDEFAULTS_TWITTER_USERNAME] && [defaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD])
//           || ([defaults stringForKey:USERDEFAULTS_WASSR_USERNAME] && [defaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]))) {
//         [tabBarController setSelectedIndex:3];
//     }
    [[friendsNavigationController timelineViewController] setArray:[NSArray arrayWithObjects:@"hoge", @"fuga", nil]];
    [[repliesNavigationController timelineViewController] setArray:[NSArray arrayWithObjects:@"fuga", @"piyo", nil]];
    
    [window addSubview:[tabBarController view]];
}

/*
  Notification
*/

// - (void)httpConnectionStart:(NSNotification *)notification {
//     httpConnectionNum++;
//     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
// //     NSLog(@"httpConnectionStart:%@", notification);
// }

// - (void)httpConnectionEnd:(NSNotification *)notification {
//     httpConnectionNum--;
//     if (httpConnectionNum < 1) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//     }
// //     NSLog(@"httpConnectionEnd:%@", notification);
// }

/*
  SBPostViewControllerDelegate
 */

// - (void)postDidFinished:(SBHttpClient *)sender withData:(NSData *)data {
// //     NSLog(@"postDidFinished!");
//     // favoriteのPOSTを検知する
//     NSURL *requestedURL = [[sender request] URL];
//     NSString *absoluteStr = [requestedURL absoluteString];
//     NSRange range;
//     // twitter
//     range = [absoluteStr rangeOfString:[SBTwitterApiUrl favorite]];
//     if (range.location != NSNotFound) {
// //         NSLog(@"twitter favorite!");
//         BOOL favorited;
//         NSString *action = [absoluteStr substringFromIndex:range.length];
//         NSRange separatorRange = [action rangeOfString:@"/"];
//         NSRange idRange        = { separatorRange.location + 1, [action length] - separatorRange.location - 6 };
//         if ([[action substringToIndex:separatorRange.location] isEqualToString:@"create"]) {
//             favorited = YES;
//         } else {
//             favorited = NO;
//         }

//         NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//         [userInfo setObject:[action substringWithRange:idRange] forKey:@"id"];
//         [userInfo setObject:[NSNumber numberWithInt:SERVICE_TWITTER] forKey:@"service"];
//         [userInfo setObject:[NSNumber numberWithBool:favorited] forKey:@"favorited"];
//         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIMELINE_DATA_UPDATE
//                                               object:self
//                                               userInfo:userInfo];
//     }
//     // wassr
//     range = [absoluteStr rangeOfString:[SBWassrApiUrl favorite]];
//     if (range.location != NSNotFound) {
// //         NSLog(@"wassr favorite!");
//         BOOL favorited;
//         NSString *action = [absoluteStr substringFromIndex:range.length];
//         NSRange separatorRange = [action rangeOfString:@"/"];
//         NSRange idRange        = { separatorRange.location + 1, [action length] - separatorRange.location - 6 };
//         if ([[action substringToIndex:separatorRange.location] isEqualToString:@"create"]) {
//             favorited = YES;
//         } else {
//             favorited = NO;
//         }
        
//         NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//         [userInfo setObject:[action substringWithRange:idRange] forKey:@"id"];
//         [userInfo setObject:[NSNumber numberWithInt:SERVICE_WASSR] forKey:@"service"];
//         [userInfo setObject:[NSNumber numberWithBool:favorited] forKey:@"favorited"];
//         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIMELINE_DATA_UPDATE
//                                               object:self
//                                               userInfo:userInfo];
//     }

// //     NSString *dataStr = [[[NSString alloc] initWithData:[data copy] encoding:NSUTF8StringEncoding] autorelease];
// //     NSLog(dataStr);
// }

/*
  Others
*/

- (void)dealloc {
//     [[NSNotificationCenter defaultCenter] removeObserver:self];
//     [tabBarController release];
//     [window release];
    [super dealloc];
}


- (IBAction)onPushConfigButton:(id)sender {
    [tabBarController presentModalViewController:configNavigationController animated:NO];
}


@end
