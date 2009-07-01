#import "SBTabBarController.h"
#import "SBFriendsTimelineNavigationController.h"
#import "SBMyTimelineNavigationController.h"
#import "SBReplyTimelineNavigationController.h"
#import "SBConfigNavigationController.h"


@implementation SBTabBarController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)init {
    if (self = [super init]) {
        SBFriendsTimelineNavigationController *friendsNaviCon = [[[SBFriendsTimelineNavigationController alloc] init] autorelease];
        [[friendsNaviCon navigationBar] setBarStyle:UIBarStyleBlackOpaque];
        [friendsNaviCon setTitle:NSLocalizedString(@"Friends", nil)];
        SBReplyTimelineNavigationController *replyNaviCon = [[[SBReplyTimelineNavigationController alloc] init] autorelease];
        [[replyNaviCon navigationBar] setBarStyle:UIBarStyleBlackOpaque];
        [replyNaviCon setTitle:NSLocalizedString(@"Replies", nil)];
        SBMyTimelineNavigationController *myNaviCon = [[[SBMyTimelineNavigationController alloc] init] autorelease];
        [[myNaviCon navigationBar] setBarStyle:UIBarStyleBlackOpaque];
        [myNaviCon setTitle:NSLocalizedString(@"Sents", nil)];
        SBConfigNavigationController *configNaviCon = [[[SBConfigNavigationController alloc] init] autorelease];
        [[configNaviCon navigationBar] setBarStyle:UIBarStyleBlackOpaque];
        NSArray *tabArray = [NSArray
                                arrayWithObjects:friendsNaviCon, replyNaviCon, myNaviCon, configNaviCon, nil];
        [self setViewControllers:tabArray animated:NO];
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
