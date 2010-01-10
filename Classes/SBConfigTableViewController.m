//
//  SBConfigTableViewController.m
//  Sabotter
//
//  Created by sugyan on 09/12/21.
//

#import "SBConfigTableViewController.h"
#import "SBConfigAccountViewController.h"
#import "SBCommon.h"


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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

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
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        if ([indexPath section] == 0) {
            style = UITableViewCellStyleValue2;
        }
        NSLog(@"%d", style);
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:CellIdentifier] autorelease];
    }

    // Set up the cell...
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSUInteger section = [indexPath section];
    if (section == 0) {
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        switch ([indexPath row]) {
        case 0:
            [[cell textLabel] setText:@"Twitter"];
            if ([defaults boolForKey:USERDEFAULTS_TWITTER_ENABLE]) {
                [[cell detailTextLabel] setTextColor:[UIColor blackColor]];
                [[cell detailTextLabel] setText:[defaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]];
            } else {
                [[cell detailTextLabel] setTextColor:[UIColor grayColor]];
                [[cell detailTextLabel] setText:NSLocalizedString(@"NOT USE", nil)];
            }
            break;
        case 1:
            [[cell textLabel] setText:@"Wassr"];
            if ([defaults boolForKey:USERDEFAULTS_WASSR_ENABLE]) {
                [[cell detailTextLabel] setTextColor:[UIColor blackColor]];
                [[cell detailTextLabel] setText:[defaults stringForKey:USERDEFAULTS_WASSR_USERNAME]];
            } else {
                [[cell detailTextLabel] setTextColor:[UIColor grayColor]];
                [[cell detailTextLabel] setText:NSLocalizedString(@"NOT USE", nil)];
            }
            break;
        default:
            break;
        }
    } else {
        [[cell textLabel] setText:NSLocalizedString(@"About Sabotter", nil)];
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


- (IBAction)onPushDoneButton:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
}


//////////////////////////////////////////////////
// UITableViewDelegate method

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"Account", nil);
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    ConfigAccountService service;
    switch ([indexPath row]) {
    case 0:
        service = SERVICE_TWITTER;
        break;
    case 1:
        service = SERVICE_WASSR;
        break;
    default:
        break;
    }
    SBConfigAccountViewController *accountViewController = [[[SBConfigAccountViewController alloc] initWithService:service] autorelease];
    [self presentModalViewController:accountViewController animated:YES];
}


@end

