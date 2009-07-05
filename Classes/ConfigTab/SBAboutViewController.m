#import "SBAboutViewController.h"


@implementation SBAboutViewController

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
        [self setTitle:NSLocalizedString(@"About", nil)];
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
*/
- (void)loadView {
    UIWebView *webView = [[[UIWebView alloc] init] autorelease];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self setView:webView];
}

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
