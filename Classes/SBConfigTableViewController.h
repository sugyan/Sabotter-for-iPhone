//
//  SBConfigTableViewController.h
//  Sabotter
//
//  Created by sugyan on 09/12/21.
//

#import <UIKit/UIKit.h>


@interface SBConfigTableViewController : UITableViewController {
    IBOutlet UITextField *twitterUsernameField;
    IBOutlet UITextField *twitterPasswordField;
    IBOutlet UITextField *wassrUsernameField;
    IBOutlet UITextField *wassrPasswordField;
    IBOutlet UISwitch *twitterEnabledSwitch;
    IBOutlet UISwitch *wassrEnabledSwitch;
}

- (IBAction)editingTextFieldDone:(id)sender;
- (IBAction)switchChanged:(id)sender;

@end
