#import "SBTimelineViewController.h"
#import "SBCommon.h"
#import "SBIconContainer.h"
#import "SBPostViewController.h"
#import "SBStatus.h"
#import "SBStatusCell.h"
#import "SBStatusViewController.h"


@implementation SBTimelineViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initWithType:(TimelineType)type withUpdate:(BOOL)update {
    if (self = [super init]) {
        timeline = [[SBTimeline alloc] initWithType:type];
        // Data Update
        [[NSNotificationCenter defaultCenter]
            addObserver:self
            selector:@selector(dataUpdate:)
            name:NOTIFICATION_TIMELINE_DATA_UPDATE
            object:nil];

        if (update) {
            [timeline update];
        }
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
*/
- (void)loadView {
    [self setView:[[[UIView alloc] init] autorelease]];

    /* frame size */
    CGFloat headerHeight = [[[self navigationController] rotatingHeaderView] frame].size.height;
    CGFloat footerHeight = [[[self tabBarController] rotatingFooterView] frame].size.height;
    CGRect viewFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat viewHeight = viewFrame.size.height - headerHeight - footerHeight;
    CGRect frame = CGRectMake(0, 0, viewFrame.size.width, viewHeight);

    /* 更新ボタン */
    UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                          target:self
                                          action:@selector(refresh)] autorelease];
    [[self navigationItem] setLeftBarButtonItem:refreshButton animated:NO];
    /* 発言ボタン */
    UIBarButtonItem *postButton = [[[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                       target:self
                                       action:@selector(post)] autorelease];
    [[self navigationItem] setRightBarButtonItem:postButton animated:NO];

    /* table view */
    UITableView *table = [[[UITableView alloc] initWithFrame:frame] autorelease];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setRowHeight:84];
    [table setSeparatorColor:[UIColor darkGrayColor]];
    [self setTableView:table];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/
- (void)viewDidAppear:(BOOL)animated {
//     NSLog(@"viewDidAppear");
    if ([[timeline statuses] count] == 0) {
        [timeline update];
    }
    
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/*
  UITableViewDataSource
*/

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[timeline statuses] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TimeLineCell";

    SBStatusCell *cell = (SBStatusCell *)[table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SBStatusCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }

    // Set up the cell...
    SBStatus *status = [[timeline statuses] objectAtIndex:[indexPath row]];
    [cell updateWithStatus:status];

    return cell;
}

/*
  UITableViewDelegate
*/

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
    
    // DataSourceから選択されたデータを取得する
    SBStatus *status = [[timeline statuses] objectAtIndex:[indexPath row]];
    SBStatusViewController *viewCon = [[[SBStatusViewController alloc] initWithStatus:status] autorelease];
    [viewCon setTitle:NSLocalizedString(@"Detail", nil)];
    [[self navigationController] pushViewController:viewCon animated:YES];
}

/*
  Notification
*/

- (void)dataUpdate:(NSNotification *)notification {
    if ([notification userInfo]) {
        NSString *ID = [[notification userInfo] objectForKey:@"id"];
        SBService service = [[[notification userInfo] objectForKey:@"service"] intValue];
        SBStatus *status = [timeline statusWithId:ID forService:service];
        if (status) {
            [status setFavorited:[[[notification userInfo] objectForKey:@"favorited"] boolValue]];
        }
    }
    [[self tableView] reloadData];
}

/*
  Others
*/

- (void)refresh {
//     NSLog(@"refresh");
    [timeline update];
}

- (void)post {
//     NSLog(@"post");
    SBPostViewController *postViewCon = [[[SBPostViewController alloc] initOnNavigation:NO] autorelease];
    [[self navigationController] pushViewController:postViewCon animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [timeline release];
    [super dealloc];
}


@end
