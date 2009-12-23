//
//  SBConfigTableViewController.m
//  Sabotter
//
//  Created by sugyan on 09/12/21.
//

#import "SBConfigTableViewController.h"


@implementation SBConfigTableViewController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return 3;
        break;
    case 1:
        return 3;
        break;
    case 2:
        return 1;
        break;
    default:
        return 0;
        break;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    } else {
        return cell;
    }

    // Set up the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSUInteger section = [indexPath section];
    if (section == 0 || section == 1) {
        CGRect cellFrame = [cell frame];
        CGRect textFieldFrame = CGRectMake(
            cellFrame.origin.x + 120.0,
            cellFrame.origin.y,
            cellFrame.size.width - 130.0,
            cellFrame.size.height);
        switch ([indexPath row]) {
        case 0: {
            CGRect switchFrame = CGRectMake(
                cellFrame.origin.x + 120.0,
                cellFrame.origin.y + 9.0,
                0.0,
                0.0);
            [[cell textLabel] setText:NSLocalizedString(@"Enabled", nil)];
            switch (section) {
            case 0:
                [twitterEnabledSwitch setFrame:switchFrame];
                [cell addSubview:twitterEnabledSwitch];
                break;
            case 1:
                [wassrEnabledSwitch setFrame:switchFrame];
                [cell addSubview:wassrEnabledSwitch];
                break;
            default:
                break;
            }
            break;
        }
        case 1:
            [[cell textLabel] setText:NSLocalizedString(@"Username", nil)];
            switch (section) {
            case 0:
                [twitterUsernameField setFrame:textFieldFrame];
                [cell addSubview:twitterUsernameField];
                break;
            case 1:
                [wassrUsernameField setFrame:textFieldFrame];
                [cell addSubview:wassrUsernameField];
                break;
            default:
                break;
            }
            break;
        case 2:
            [[cell textLabel] setText:NSLocalizedString(@"Password", nil)];
            switch (section) {
            case 0:
                [twitterPasswordField setFrame:textFieldFrame];
                [cell addSubview:twitterPasswordField];
                break;
            case 1:
                [wassrPasswordField setFrame:textFieldFrame];
                [cell addSubview:wassrPasswordField];
                break;
            default:
                break;
            }
            break;
        }
    }
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


- (IBAction)editingTextFieldDone:(id)sender {
    if (!sender) {
    } else if ([sender isEqual:twitterUsernameField]) {
        [twitterPasswordField becomeFirstResponder];
    } else if ([sender isEqual:twitterPasswordField]) {
        if ([wassrEnabledSwitch isOn]) {
            [wassrUsernameField becomeFirstResponder];
        } else {
            [twitterUsernameField becomeFirstResponder];
        }
    } else if ([sender isEqual:wassrUsernameField]) {
        [wassrPasswordField becomeFirstResponder];
    } else if ([sender isEqual:wassrPasswordField]) {
        if ([twitterEnabledSwitch isOn]) {
            [twitterUsernameField becomeFirstResponder];
        } else {
            [wassrUsernameField becomeFirstResponder];
        }
    }
}

- (IBAction)switchChanged:(id)sender {
    BOOL isOn = [(UISwitch *)sender isOn];
    if ([sender isEqual:twitterEnabledSwitch]) {
        [twitterUsernameField setEnabled:isOn];
        [twitterPasswordField setEnabled:isOn];
    } else {
        [wassrUsernameField setEnabled:isOn];
        [wassrPasswordField setEnabled:isOn];
    }
}


//////////////////////////////////////////////////
// UITableViewDelegate method

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return NSLocalizedString(@"Twitter account", nil);
        break;
    case 1:
        return NSLocalizedString(@"Wassr account", nil);
        break;
    default:
        return nil;
        break;
    }
}

@end

