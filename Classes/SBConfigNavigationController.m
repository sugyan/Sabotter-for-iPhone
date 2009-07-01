#import "SBConfigNavigationController.h"
#import "SBConfigViewController.h"


@implementation SBConfigNavigationController

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
                                        image:[UIImage imageNamed:@"user.png"]
                                        tag:0] autorelease];
        [self setTabBarItem:tabBarItem];
        [self setTitle:NSLocalizedString(@"Config", nil)];
        SBConfigViewController *configViewCon =
            [[[SBConfigViewController alloc] init] autorelease];
        [self pushViewController:configViewCon animated:NO];
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
