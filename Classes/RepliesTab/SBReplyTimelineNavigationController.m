#import "SBReplyTimelineNavigationController.h"
#import "SBTimelineViewController.h"


@implementation SBReplyTimelineNavigationController

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
        UITabBarItem *tabBarItem = [[[UITabBarItem alloc]
                                        initWithTitle:@""
                                        image:[UIImage imageNamed:@"arrow_left.png"]
                                        tag:0] autorelease];
        [self setTabBarItem:tabBarItem];
        SBTimelineViewController *replyViewCon =
            [[[SBTimelineViewController alloc] initWithType:TIMELINE_REPLY withUpdate:YES] autorelease];
        [replyViewCon setTitle:NSLocalizedString(@"Replies", nil)];
        [self pushViewController:replyViewCon animated:NO];
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
