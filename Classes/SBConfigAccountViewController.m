//
//  SBConfigAccountViewController.m
//  Sabotter
//
//  Created by sugyan on 10/01/02.
//

#import "SBConfigAccountViewController.h"
#import "SBCommon.h"


@implementation SBConfigAccountViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initWithService:(ConfigAccountService)configAccountService {
    if (self = [super init]) {
        service = configAccountService;
    }

    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/
- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (service) {
    case SERVICE_TWITTER:
        [titleLabel setText:@"Twitter"];
        [enableSwitch setOn:[defaults boolForKey:USERDEFAULTS_TWITTER_ENABLE]];
        [usernameField setText:[defaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]];
        [passwordField setText:[defaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD]];
        break;
    case SERVICE_WASSR:
        [titleLabel setText:@"Wassr"];
        [enableSwitch setOn:[defaults boolForKey:USERDEFAULTS_WASSR_ENABLE]];
        [usernameField setText:[defaults stringForKey:USERDEFAULTS_WASSR_USERNAME]];
        [passwordField setText:[defaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]];
        break;
    default:
        break;
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (IBAction)onPushCancelButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onPushSaveButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (service) {
    case SERVICE_TWITTER:
        [defaults setBool:[enableSwitch isOn] forKey:USERDEFAULTS_TWITTER_ENABLE];
        break;
    case SERVICE_WASSR:
        [defaults setBool:[enableSwitch isOn] forKey:USERDEFAULTS_WASSR_ENABLE];
        break;
    defalt:
        break;
    }
    
    if ([enableSwitch isOn]) {
        //TODO アカウント認証
        switch (service) {
        case SERVICE_TWITTER:
            [defaults setObject:[usernameField text] forKey:USERDEFAULTS_TWITTER_USERNAME];
            [defaults setObject:[passwordField text] forKey:USERDEFAULTS_TWITTER_PASSWORD];
            break;
        case SERVICE_WASSR:
            [defaults setObject:[usernameField text] forKey:USERDEFAULTS_WASSR_USERNAME];
            [defaults setObject:[passwordField text] forKey:USERDEFAULTS_WASSR_PASSWORD];
            break;
        default:
            break;
        }
    }

    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onEndEditingTextField:(id)sender {
    if ([sender isEqual:usernameField]) {
        [passwordField becomeFirstResponder];
    }
    if ([sender isEqual:passwordField]) {
        [usernameField becomeFirstResponder];
    }
}

- (IBAction)onChangeSwitch:(id)sender {
    [usernameField setEnabled:[enableSwitch isOn]];
    [passwordField setEnabled:[enableSwitch isOn]];
}


@end
