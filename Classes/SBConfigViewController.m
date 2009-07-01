#import "SBConfigViewController.h"
#import "SBCommon.h"
#import "SBAboutViewController.h"


@implementation SBConfigViewController

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
    }

    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
*/
- (void)loadView {
    [self setView:[[[UIView alloc] init] autorelease]];
    UIColor *color = [UIColor colorWithRed:0.19215686 green:0.30980392 blue:0.52156863 alpha:1.0];
    
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    
    t_switch = [[UISwitch alloc] initWithFrame:CGRectMake(208, 9, 0, 0)];
    [t_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    w_switch = [[UISwitch alloc] initWithFrame:CGRectMake(208, 9, 0, 0)];
    [w_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    t_usernameField = [[UITextField alloc] initWithFrame:CGRectMake(112, 12, 190, 24)];
    [t_usernameField setDelegate:self];
    [t_usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [t_usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [t_usernameField setEnablesReturnKeyAutomatically:YES];
    [t_usernameField setKeyboardType:UIKeyboardTypeASCIICapable];
    [t_usernameField setReturnKeyType:UIReturnKeyDone];
    [t_usernameField setTextColor:color];
    
    w_usernameField = [[UITextField alloc] initWithFrame:CGRectMake(112, 12, 190, 24)];
    [w_usernameField setDelegate:self];
    [w_usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [w_usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [w_usernameField setEnablesReturnKeyAutomatically:YES];
    [w_usernameField setKeyboardType:UIKeyboardTypeASCIICapable];
    [w_usernameField setReturnKeyType:UIReturnKeyDone];
    [w_usernameField setTextColor:color];
    
    t_passwordField = [[UITextField alloc] initWithFrame:CGRectMake(112, 12, 190, 24)];
    [t_passwordField setDelegate:self];
    [t_passwordField setEnablesReturnKeyAutomatically:YES];
    [t_passwordField setReturnKeyType:UIReturnKeyDone];
    [t_passwordField setSecureTextEntry:YES];
    [t_passwordField setTextColor:color];
    
    w_passwordField = [[UITextField alloc] initWithFrame:CGRectMake(112, 12, 190, 24)];
    [w_passwordField setDelegate:self];
    [w_passwordField setEnablesReturnKeyAutomatically:YES];
    [w_passwordField setReturnKeyType:UIReturnKeyDone];
    [w_passwordField setSecureTextEntry:YES];
    [w_passwordField setTextColor:color];

    [t_usernameField setEnabled:NO];
    [w_usernameField setEnabled:NO];
    [t_passwordField setEnabled:NO];
    [w_passwordField setEnabled:NO];
    
    // 初期値
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [t_switch setOn:[userDefaults boolForKey:USERDEFAULTS_TWITTER_ENABLE] animated:NO];
    [w_switch setOn:[userDefaults boolForKey:USERDEFAULTS_WASSR_ENABLE] animated:NO];
    [t_usernameField setText:[userDefaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]];
    [w_usernameField setText:[userDefaults stringForKey:USERDEFAULTS_WASSR_USERNAME]];
    [t_passwordField setText:[userDefaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD]];
    [w_passwordField setText:[userDefaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]];

    [[self view] addSubview:tableView];
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 3;
    } else if (section == 2) {
        return 1;
    } else {
        return 0;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ConfigCell";

    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

    // Set up the cell...
    if ([indexPath section] < 2) {
        switch ([indexPath row]) {
        case 0: {
            [cell setText:NSLocalizedString(@"Enabled", nil)];
            switch ([indexPath section]) {
            case 0:
                [cell addSubview:t_switch];
                break;
            case 1:
                [cell addSubview:w_switch];
                break;
            default:
                break;
            }
            break;
        }
        case 1: {
            [cell setText:NSLocalizedString(@"Username", nil)];
            switch ([indexPath section]) {
            case 0:
                [cell addSubview:t_usernameField];
                break;
            case 1:
                [cell addSubview:w_usernameField];
                break;
            default:
                break;
            }
            break;
        }
        case 2: {
            [cell setText:NSLocalizedString(@"Password", nil)];
            switch ([indexPath section]) {
            case 0:
                [cell addSubview:t_passwordField];
                break;
            case 1:
                [cell addSubview:w_passwordField];
                break;
            default:
                break;
            }
            break;
        }
        default:
            break;
        }
    } else {
        [cell setText:@"About Sabotter for iPhone"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // UITextField編集時にもスクロールできるよう下側に余分なスペースを作っておく
    return 15;
}

// fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *retStr;
    switch (section) {
    case 0:
        retStr = NSLocalizedString(@"Twitter", nil);
        break;
    case 1:
        retStr = NSLocalizedString(@"Wassr", nil);
        break;
    default:
        retStr = @"";
        break;
    }
    return retStr;
}

/*
  UITableViewDelegate
*/

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 各TextFieldはセル選択により編集開始にする
    switch ([indexPath section]) {
    case 0:
        switch([indexPath row]) {
        case 1:
            [t_usernameField setEnabled:YES];
            [t_usernameField becomeFirstResponder];
            break;
        case 2:
            [t_passwordField setEnabled:YES];
            [t_passwordField becomeFirstResponder];
            break;
        default:
            break;
        }
        break;
    case 1:
        switch ([indexPath row]) {
        case 1:
            [w_usernameField setEnabled:YES];
            [w_usernameField becomeFirstResponder];
            break;
        case 2:
            [w_passwordField setEnabled:YES];
            [w_passwordField becomeFirstResponder];
            break;
        default:
            break;
        }
        break;
    case 2: {
        SBAboutViewController *aboutViewCon = [[[SBAboutViewController alloc] init] autorelease];
        [[self navigationController] pushViewController:aboutViewCon animated:YES];
    }
        break;
    default:
        break;
    }
}

/*
  UITextFieldDelegate
*/

// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 編集しやすいように適当にスクロールする
    if ([textField convertRect:[textField frame] toView:[self view]].origin.y < 22) {
        [tableView scrollToRowAtIndexPath:[tableView indexPathForSelectedRow] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    if ([textField convertRect:[textField frame] toView:[self view]].origin.y > 218) {
        [tableView scrollToRowAtIndexPath:[tableView indexPathForSelectedRow] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    return YES;
}

/*
// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing:%@", [textField text]);
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}
*/

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([textField isEqual:t_usernameField]) {
        [userDefaults setObject:[textField text] forKey:USERDEFAULTS_TWITTER_USERNAME];
    }
    if ([textField isEqual:w_usernameField]) {
        [userDefaults setObject:[textField text] forKey:USERDEFAULTS_WASSR_USERNAME];
    }
    if ([textField isEqual:t_passwordField]) {
        [userDefaults setObject:[textField text] forKey:USERDEFAULTS_TWITTER_PASSWORD];
    }
    if ([textField isEqual:w_passwordField]) {
        [userDefaults setObject:[textField text] forKey:USERDEFAULTS_WASSR_PASSWORD];
    }

    [textField setEnabled:NO];
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

/*
  Switch change
*/

- (void)switchChanged:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([sender isEqual:t_switch]) {
        [userDefaults setBool:[t_switch isOn] forKey:USERDEFAULTS_TWITTER_ENABLE];
    }
    if ([sender isEqual:w_switch]) {
        [userDefaults setBool:[w_switch isOn] forKey:USERDEFAULTS_WASSR_ENABLE];
    }
}

/*
  Others
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [tableView release];
    [t_switch release];
    [w_switch release];
    [t_usernameField release];
    [w_usernameField release];
    [t_passwordField release];
    [w_passwordField release];
    [super dealloc];
}


@end
