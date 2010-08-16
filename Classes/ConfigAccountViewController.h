//
//  ConfigAccountViewController.h
//  Sabotter
//
//  Created by sugyan on 10/08/02.
//

#import <UIKit/UIKit.h>


@interface ConfigAccountViewController : UITableViewController {
    IBOutlet UISwitch *enableSwitch;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
}

- (IBAction)onUsernameFieldExit:(id)sender;
- (IBAction)onPasswordFieldExit:(id)sender;

@end
