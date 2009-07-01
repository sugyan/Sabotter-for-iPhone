#import "SBPostViewController.h"
#import "SBCommon.h"


@implementation SBPostViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initOnNavigation:(BOOL)_onNavigation {
    if (self = [super init]) {
        onNavigation = _onNavigation;
        
        twitterSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [twitterSwitch setOn:YES animated:NO];
        wassrSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [wassrSwitch setOn:YES animated:NO];
        
        textView = [[UITextView alloc] init];
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
*/
- (void)loadView {
    [self setView:[[[UIView alloc] init] autorelease]];
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];

    // NavigationBar
    [self setTitle:NSLocalizedString(@"Update", nil)];
    UIBarButtonItem *postButton = [[[UIBarButtonItem alloc]
                                         initWithTitle:NSLocalizedString(@"Post", nil)
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(post)] autorelease];
    [[self navigationItem] setRightBarButtonItem:postButton];
    
    if (!onNavigation) {
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                             target:self
                                             action:@selector(cancel)] autorelease];
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
    }

    // View
    CGSize twitterSwitchSize = [twitterSwitch frame].size;
    CGRect twitterSwitchFrame = CGRectMake(310 - twitterSwitchSize.width,
                                           10,
                                           twitterSwitchSize.width,
                                           twitterSwitchSize.height);
    [twitterSwitch setFrame:twitterSwitchFrame];
    [[self view] addSubview:twitterSwitch];
    CGRect twitterLabelFrame = CGRectMake(10,
                                          10,
                                          290 - twitterSwitchSize.width,
                                          twitterSwitchSize.height);
    UILabel *twitterLabel = [[[UILabel alloc] initWithFrame:twitterLabelFrame] autorelease];
    [twitterLabel setBackgroundColor:[UIColor clearColor]];
    [twitterLabel setTextAlignment:UITextAlignmentRight];
    [twitterLabel setText:@"Twitter :"];
    [[self view] addSubview:twitterLabel];
    
    CGSize wassrSwitchSize = [wassrSwitch frame].size;
    CGRect wassrSwitchFrame = CGRectMake(310 - wassrSwitchSize.width,
                                         10 + twitterSwitchSize.height + 10,
                                         wassrSwitchSize.width,
                                         wassrSwitchSize.height);
    [wassrSwitch setFrame:wassrSwitchFrame];
    [[self view] addSubview:wassrSwitch];
    CGRect wassrLabelFrame = CGRectMake(10,
                                        10 + twitterSwitchSize.height + 10,
                                        290 - wassrSwitchSize.width,
                                        wassrSwitchSize.height);
    UILabel *wassrLabel = [[[UILabel alloc] initWithFrame:wassrLabelFrame] autorelease];
    [wassrLabel setBackgroundColor:[UIColor clearColor]];
    [wassrLabel setTextAlignment:UITextAlignmentRight];
    [wassrLabel setText:@"Wassr :"];
    [[self view] addSubview:wassrLabel];
    
    // アカウントチェック
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [twitterSwitch setEnabled:[userDefaults boolForKey:USERDEFAULTS_TWITTER_ENABLE]];
    if (![twitterSwitch isEnabled]) {
        [twitterSwitch setOn:NO animated:NO];
    }
    [wassrSwitch setEnabled:[userDefaults boolForKey:USERDEFAULTS_WASSR_ENABLE]];
    if (![wassrSwitch isEnabled]) {
        [wassrSwitch setOn:NO animated:NO];
    }
    
    CGRect textFrame = CGRectMake(10,
                                  10 + twitterSwitchSize.height + 10 + wassrSwitchSize.height + 10,
                                  300,
                                  102);
    [textView setFrame:textFrame];
    [textView setDelegate:self];
    [textView setFont:[UIFont systemFontOfSize:18]];
    [[self view] addSubview:textView];
}

- (void)viewDidAppear:(BOOL)animated {
    [textView becomeFirstResponder];
}

- (void)setReplyId:(NSString *)_replyId withService:(SBService)_service {
    replyId = _replyId;
    service = _service;
    switch (service) {
    case SERVICE_TWITTER:
        [twitterSwitch setOn:YES animated:NO];
        [wassrSwitch setOn:NO animated:NO];
        break;
    case SERVICE_WASSR:
        [twitterSwitch setOn:NO animated:NO];
        [wassrSwitch setOn:YES animated:NO];
        break;
    default:
        break;
    }
}

- (void)setReplyText:(NSString *)str {
    [textView setText:str];
}

- (void)cancel {
    [[self navigationController] popViewControllerAnimated:NO];
}

- (void)post {
    NSMutableString *status = [NSMutableString stringWithString:[textView text]];
    [status replaceOccurrencesOfString:@"&" withString:@"%26" options:0 range:NSMakeRange(0, [status length])];
    [status replaceOccurrencesOfString:@"+" withString:@"%2B" options:0 range:NSMakeRange(0, [status length])];
    [status replaceOccurrencesOfString:@";" withString:@"%3B" options:0 range:NSMakeRange(0, [status length])];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id <SBPostViewControllerDelegate> target = (id <SBPostViewControllerDelegate>)[[UIApplication sharedApplication] delegate];

    // Twitter
    if ([twitterSwitch isOn]) {
        NSMutableString *dataStr = [NSMutableString stringWithFormat:@"status=%@", status];
        // TODO
        [dataStr appendString:@"&source="];
    
        if (service == SERVICE_TWITTER) {
            [dataStr appendFormat:@"&in_reply_to_status_id=%@", replyId];
        }
        NSLog(@"post string:%@", dataStr);
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
        SBHttpClient *twitter = [[[SBHttpClient alloc]
                                     initWithTarget:target
                                     withAction:@selector(postDidFinished:withData:)] autorelease];
        NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/update.json"];
        [twitter postWithAuthentication:url
                 username:[userDefaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]
                 password:[userDefaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD]
                 data:data];
    }
    // Wassr
    if ([wassrSwitch isOn]) {
        NSMutableString *dataStr = [NSMutableString stringWithFormat:@"status=%@", status];
        [dataStr appendString:@"&source=Sabotter for iPhone"];
    
        if (service == SERVICE_WASSR) {
            [dataStr appendFormat:@"&reply_status_rid=%@", replyId];
        }
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
        SBHttpClient *wassr = [[[SBHttpClient alloc]
                                   initWithTarget:target
                                   withAction:@selector(postDidFinished:withData:)] autorelease];
        NSURL *url = [NSURL URLWithString:@"http://api.wassr.jp/statuses/update.json"];
        [wassr postWithAuthentication:url
               username:[userDefaults stringForKey:USERDEFAULTS_WASSR_USERNAME]
               password:[userDefaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]
               data:data];
    }

    [self cancel];
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
  UITextViewDelegate
*/

- (void)textViewDidChange:(UITextView *)text {
    NSString *title = [NSString stringWithFormat:@"%@(%d)",
                                NSLocalizedString(@"Update", nil),
                                [[text text] length]];
    [self setTitle:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [twitterSwitch release];
    [wassrSwitch release];
    [textView release];
    [super dealloc];
}


@end
