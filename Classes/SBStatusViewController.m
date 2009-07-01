#import "SBStatusViewController.h"
#import "SBCommon.h"
#import "SBIconRepository.h"
#import "SBIconContainer.h"
#import "SBPostViewController.h"
#import "SBTwitterApiUrl.h"
#import "SBWassrApiUrl.h"


@implementation SBStatusViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initWithStatus:(SBStatus *)_status {
    if (self = [super init]) {
        status = _status;
        actions = [[NSMutableArray alloc]
                      initWithObjects:[NSNull null],
                      NSLocalizedString(@"Reply", nil),
                      nil];
        // Data Update
        [[NSNotificationCenter defaultCenter]
            addObserver:self
            selector:@selector(dataUpdate:)
            name:NOTIFICATION_TIMELINE_DATA_UPDATE
            object:nil];
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
*/
- (void)loadView {

    CGRect viewFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat headerHeight = [[[self navigationController] rotatingHeaderView] frame].size.height;
    CGFloat footerHeight = [[[self tabBarController] rotatingFooterView] frame].size.height;
    CGFloat viewHeight = viewFrame.size.height - headerHeight - footerHeight;
    CGRect tableFrame = CGRectMake(0, 0, viewFrame.size.width, viewHeight);
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:tableFrame style:UITableViewStyleGrouped] autorelease];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self setTableView:tableView];

    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 280, 0)];
    [textLabel setFont:[UIFont systemFontOfSize:14]];
    [textLabel setNumberOfLines:0];
    [textLabel setText:[status text]];
    [textLabel sizeToFit];

    replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 280, 0)];
    [replyLabel setFont:[UIFont systemFontOfSize:13]];
    [replyLabel setTextColor:[UIColor blueColor]];
    [replyLabel setNumberOfLines:0];
    NSMutableString *replyString = [NSMutableString string];
    if ([[status replyMessage] length] > 0) {
        [replyString appendString:[status replyMessage]];
    } else {
        [replyString appendString:NSLocalizedString(@"private message", nil)];
    }
    [replyString appendFormat:@"\nby %@", [status replyName]];
    [replyLabel setText:[NSString stringWithFormat:replyString]];
    [replyLabel sizeToFit];
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

/*
  UITableViewDataSource
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger retValue;
    switch (section) {
    case 0:
        retValue = 1;
        break;
    case 1:
        if ([[status replyName] isEqualToString:@""]) {
            retValue = 1;
        }
        else {
            retValue = 2;
        }
        break;
    default:
        retValue = [actions count];
        break;
    }
    
    return retValue;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ProfileCellIdentifier = @"StatusProfileCell";
    static NSString *StatusCellIdentifier  = @"StatuTextCell";
    static NSString *ReplyCellIdentifier   = @"StatuReplyCell";
    static NSString *OtherCellIdentifier   = @"StatuOtherCell";

    UITableViewCell *cell;
    switch ([indexPath section]) {
    case 0:
        cell = [table dequeueReusableCellWithIdentifier:ProfileCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:ProfileCellIdentifier] autorelease];
            UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 64, 64)] autorelease];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            SBIconContainer *container = [[SBIconRepository instance] containerForUrl:[status iconUrl]];
            [imageView setImage:[container image]];
            [[cell contentView] addSubview:imageView];
            UILabel *idLabel = [[[UILabel alloc] initWithFrame:CGRectMake(80, 8, 210, 21)] autorelease];
            [idLabel setFont:[UIFont systemFontOfSize:15.0]];
            [idLabel setText:[status loginId]];
            [[cell contentView] addSubview:idLabel];
            UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(80, 30, 210, 42)] autorelease];
            [nameLabel setFont:[UIFont systemFontOfSize:15.0]];
            [nameLabel setNumberOfLines:2];
            [nameLabel setText:[status screenName]];
            [[cell contentView] addSubview:nameLabel];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        break;
    case 1:
        switch ([indexPath row]) {
        case 0:
            cell = [table dequeueReusableCellWithIdentifier:StatusCellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:StatusCellIdentifier] autorelease];
                [cell setFrame:CGRectMake(0, 0, 320, 0)];
                [[cell contentView] addSubview:textLabel];
            }
            break;
        case 1:
            cell = [table dequeueReusableCellWithIdentifier:ReplyCellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:ReplyCellIdentifier] autorelease];
                [cell setFrame:CGRectMake(0, 0, 320, 0)];
                [[cell contentView] addSubview:replyLabel];
            }
            break;
        default:
            break;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        break;
    default:
        cell = [table dequeueReusableCellWithIdentifier:OtherCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:OtherCellIdentifier] autorelease];
        }
        if ([indexPath row] == 0) {
            if ([status favorited]) {
                [cell setImage:[UIImage imageNamed:@"star_full.gif"]];
                if ([status service] == SERVICE_WASSR) {
                    [cell setText:NSLocalizedString(@"Remove IINE", nil)];
                } else {
                    [cell setText:NSLocalizedString(@"Remove Favorited", nil)];
                }
            } else {
                [cell setImage:[UIImage imageNamed:@"star_empty.gif"]];
                if ([status service] == SERVICE_WASSR) {
                    [cell setText:NSLocalizedString(@"Make IINE", nil)];
                } else {
                    [cell setText:NSLocalizedString(@"Make Favorited", nil)];
                }
            }                
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setText:[actions objectAtIndex:[indexPath row]]];
        }
        break;
    }        

    // Set up the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *retStr;
    switch (section) {
    case 0:
        retStr = NSLocalizedString(@"profile", nil);
        break;
    case 1:
        retStr = NSLocalizedString(@"status", nil);
        break;
    case 2:
        retStr = NSLocalizedString(@"action", nil);
        break;
    default:
        retStr = nil;
        break;
    }
    
    return retStr;
}

/*
  UITableViewDelegate
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] != 2) {
        return;
    }

    if ([indexPath row] == 0) {
        [self changeFavorited:![status favorited]];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    SBPostViewController *postCon = [[[SBPostViewController alloc] initOnNavigation:YES] autorelease];
    [postCon setReplyId:[status Id] withService:[status service]];
    if ([status service] == SERVICE_TWITTER) {
        [postCon setReplyText:[NSString stringWithFormat:@"@%@ ", [status loginId]]];
    }
    [[self navigationController] pushViewController:postCon animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//     NSLog(@"tableView:heightForRowAtIndexPath");
    CGFloat retValue;
    switch ([indexPath section]) {
    case 0:
        retValue = 80.0;
        break;
    case 1:
        switch ([indexPath row]) {
        case 0:
            retValue = [textLabel frame].size.height + 16.0;
            break;
        case 1:
            retValue = [replyLabel frame].size.height + 16.0;
            break;
        default:
            break;
        }
        break;
    default:
        retValue = 44.0;
        break;
    }

    return retValue;
}

/*
  Notification
*/

- (void)dataUpdate:(NSNotification *)notification {
    [[self tableView] reloadData];
}

/*
  Others
*/

- (void)changeFavorited:(BOOL)favorited {
//     NSLog(@"favorite");

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id <SBPostViewControllerDelegate> target = (id <SBPostViewControllerDelegate>)[[UIApplication sharedApplication] delegate];
    NSString *action;
    if (favorited) {
        action = @"create";
    } else {
        action = @"destroy";
    }
    
    switch ([status service]) {
    case SERVICE_TWITTER: {
        NSString *strUrl = [NSString stringWithFormat:@"%@%@/%@.json", [SBTwitterApiUrl favorite], action, [status Id]];
        NSURL *url = [NSURL URLWithString:strUrl];
        SBHttpClient *twitter = [[[SBHttpClient alloc]
                                     initWithTarget:target
                                     withAction:@selector(postDidFinished:withData:)] autorelease];
        [twitter postWithAuthentication:url
                 username:[userDefaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]
                 password:[userDefaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD]
                 data:nil];
    }
        break;
    case SERVICE_WASSR: {
        NSString *strUrl = [NSString stringWithFormat:@"%@%@/%@.json", [SBWassrApiUrl favorite], action, [status Id]];
        NSURL *url = [NSURL URLWithString:strUrl];
        SBHttpClient *wassr = [[[SBHttpClient alloc]
                                   initWithTarget:target
                                   withAction:@selector(postDidFinished:withData:)] autorelease];
        [wassr postWithAuthentication:url
               username:[userDefaults stringForKey:USERDEFAULTS_WASSR_USERNAME]
               password:[userDefaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]
               data:nil];
    }
        break;
    default:
        break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [textLabel release];
    [replyLabel release];
    [actions release];
    [super dealloc];
}


@end
